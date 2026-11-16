package com.example.boshra

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.pm.ServiceInfo
import android.graphics.BitmapFactory
import android.media.AudioAttributes
import android.media.AudioFocusRequest
import android.media.AudioManager
import android.media.MediaPlayer
import android.media.RingtoneManager
import android.media.session.MediaSession
import android.media.session.PlaybackState
import android.os.Build
import android.os.IBinder
import android.os.PowerManager
import androidx.core.app.NotificationCompat
import androidx.core.content.ContextCompat

class AdhanService : Service() {

    companion object {
        const val CHANNEL_ID = "adhan_foreground_service_channel_v1"
        const val CHANNEL_NAME = "Adhan Playback"
        const val ACTION_START_ADHAN = "com.example.boshra.ACTION_START_ADHAN"
        const val ACTION_STOP_ADHAN = "com.example.boshra.ACTION_STOP_ADHAN"

        const val EXTRA_NOTIFICATION_ID = "extra_notification_id"
        const val EXTRA_TITLE = "extra_title"
        const val EXTRA_BODY = "extra_body"
        const val EXTRA_RAW_SOUND = "extra_raw_sound"
        const val EXTRA_STOP_LABEL = "extra_stop_label"
        const val EXTRA_ROUTE = "extra_route"

        @Volatile
        var isPlaying: Boolean = false
            private set

        /** true from onCreate to onDestroy: lets Stop work even while the file is still preparing. */
        @Volatile
        var running: Boolean = false
            private set

        private const val MAX_RECOVERIES = 3

        fun start(
            context: Context, notificationId: Int, title: String, body: String,
            rawSound: String, stopLabel: String, route: String = ""
        ) {
            val intent = Intent(context, AdhanService::class.java).apply {
                action = ACTION_START_ADHAN
                putExtra(EXTRA_NOTIFICATION_ID, notificationId)
                putExtra(EXTRA_TITLE, title)
                putExtra(EXTRA_BODY, body)
                putExtra(EXTRA_RAW_SOUND, rawSound)
                putExtra(EXTRA_STOP_LABEL, stopLabel)
                putExtra(EXTRA_ROUTE, route)
            }
            ContextCompat.startForegroundService(context, intent)
        }

        fun stop(context: Context) {
            // If the service is not running there is nothing to stop; starting it from the
            // background would throw on Android 8+, so never let that crash the receiver.
            if (!isPlaying && !running) return
            try {
                context.startService(Intent(context, AdhanService::class.java).apply {
                    action = ACTION_STOP_ADHAN
                })
            } catch (_: Exception) {
            }
        }
    }

    private var mediaPlayer: MediaPlayer? = null
    private var wakeLock: PowerManager.WakeLock? = null
    private var focusRequest: AudioFocusRequest? = null
    private var currentNotificationId: Int = 10001
    private var stopping = false
    private var session: MediaSession? = null
    private var pausedByCall = false
    private var recoveries = 0
    private var currentRaw: String = ""
    private var currentRoute: String = ""

    override fun onCreate() {
        super.onCreate()
        running = true
    }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if (intent == null || intent.action == ACTION_STOP_ADHAN) {
            stopAdhan()
            return START_NOT_STICKY
        }
        if (intent.action == ACTION_START_ADHAN) {
            val id = intent.getIntExtra(EXTRA_NOTIFICATION_ID, 10001)
            val title = intent.getStringExtra(EXTRA_TITLE) ?: ""
            val body = intent.getStringExtra(EXTRA_BODY) ?: ""
            val raw = intent.getStringExtra(EXTRA_RAW_SOUND) ?: "azan_mohammed_refat"
            val stopLabel = intent.getStringExtra(EXTRA_STOP_LABEL) ?: "Stop"
            currentRoute = intent.getStringExtra(EXTRA_ROUTE) ?: ""
            // Duplicate trigger for the same prayer while it is already playing → ignore (no double Adhan).
            if (isPlaying && id == currentNotificationId) {
                try { startForeground(id, buildNotification(id, title, body, stopLabel)) } catch (_: Exception) {}
                return START_NOT_STICKY
            }
            stopping = false
            recoveries = 0
            startAdhan(id, title, body, raw, stopLabel)
        }
        return START_NOT_STICKY
    }

    private fun startAdhan(id: Int, title: String, body: String, rawSound: String, stopLabel: String) {
        currentNotificationId = id
        createNotificationChannel()
        val notification = buildNotification(id, title, body, stopLabel)
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                startForeground(id, notification, ServiceInfo.FOREGROUND_SERVICE_TYPE_MEDIA_PLAYBACK)
            } else {
                startForeground(id, notification)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
        acquireWakeLock()
        playAudio(rawSound)
    }

    private val attrs: AudioAttributes = AudioAttributes.Builder()
        .setUsage(AudioAttributes.USAGE_ALARM)
        .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
        .build()

    /**
     * Focus policy: the Adhan must NEVER be cut by something else (another app, a notification
     * sound, the volume panel). Only a real phone call pauses it, and it resumes afterwards.
     */
    private val focusListener = AudioManager.OnAudioFocusChangeListener { change ->
        when (change) {
            AudioManager.AUDIOFOCUS_LOSS_TRANSIENT -> {
                val am = getSystemService(Context.AUDIO_SERVICE) as? AudioManager
                val mode = am?.mode ?: AudioManager.MODE_NORMAL
                if (mode == AudioManager.MODE_IN_CALL || mode == AudioManager.MODE_IN_COMMUNICATION ||
                    mode == AudioManager.MODE_RINGTONE) {
                    try {
                        mediaPlayer?.let { if (it.isPlaying) { it.pause(); pausedByCall = true } }
                    } catch (_: Exception) {}
                }
            }
            AudioManager.AUDIOFOCUS_GAIN -> {
                if (pausedByCall) {
                    pausedByCall = false
                    try { mediaPlayer?.start() } catch (_: Exception) {}
                }
                try { mediaPlayer?.setVolume(1f, 1f) } catch (_: Exception) {}
            }
            // LOSS / LOSS_TRANSIENT_CAN_DUCK: ignored on purpose → keep playing at full volume.
        }
    }

    private fun requestFocus() {
        try {
            val am = getSystemService(Context.AUDIO_SERVICE) as? AudioManager ?: return
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                val req = AudioFocusRequest.Builder(AudioManager.AUDIOFOCUS_GAIN_TRANSIENT_EXCLUSIVE)
                    .setAudioAttributes(attrs)
                    .setWillPauseWhenDucked(false)
                    .setAcceptsDelayedFocusGain(false)
                    .setOnAudioFocusChangeListener(focusListener)
                    .build()
                focusRequest = req
                am.requestAudioFocus(req) // pauses the Quran player / radio while the Adhan plays
            } else {
                @Suppress("DEPRECATION")
                am.requestAudioFocus(focusListener, AudioManager.STREAM_ALARM, AudioManager.AUDIOFOCUS_GAIN_TRANSIENT_EXCLUSIVE)
            }
        } catch (_: Exception) {
        }
    }

    private fun abandonFocus() {
        try {
            val am = getSystemService(Context.AUDIO_SERVICE) as? AudioManager ?: return
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                focusRequest?.let { am.abandonAudioFocusRequest(it) }
            } else {
                @Suppress("DEPRECATION")
                am.abandonAudioFocus(focusListener)
            }
        } catch (_: Exception) {
        }
        focusRequest = null
    }

    /**
     * An active MediaSession tied to the ALARM stream makes the hardware volume keys control
     * the Adhan's own volume (up/down) instead of an unrelated stream, so pressing them can
     * never be confused with / lead to cancelling the Adhan. Stop from a headset = stop Adhan.
     */
    private fun startSession() {
        try {
            if (session != null) return
            val s = MediaSession(this, "BoshraAdhan")
            s.setCallback(object : MediaSession.Callback() {
                override fun onStop() { stopAdhan() }
            })
            s.setPlaybackToLocal(attrs)
            s.setPlaybackState(
                PlaybackState.Builder()
                    .setActions(PlaybackState.ACTION_STOP)
                    .setState(PlaybackState.STATE_PLAYING, 0L, 1f)
                    .build()
            )
            s.isActive = true
            session = s
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun stopSession() {
        try {
            session?.isActive = false
            session?.release()
        } catch (_: Exception) {}
        session = null
    }

    private fun playAudio(rawSound: String, fromRecovery: Boolean = false) {
        currentRaw = rawSound
        try {
            try { mediaPlayer?.release() } catch (_: Exception) {}
            mediaPlayer = null
            if (!fromRecovery) requestFocus()
            startSession()

            // MediaPlayer() + setAudioAttributes BEFORE prepare (MediaPlayer.create() prepares
            // immediately, so setting attributes afterwards can throw → silent Adhan).
            val mp = MediaPlayer()
            mp.setAudioAttributes(attrs)
            // Keeps the CPU awake for the whole file even if the wake lock was denied.
            mp.setWakeMode(applicationContext, PowerManager.PARTIAL_WAKE_LOCK)
            val resId = resources.getIdentifier(rawSound, "raw", packageName)
            if (resId != 0) {
                resources.openRawResourceFd(resId).use { afd ->
                    mp.setDataSource(afd.fileDescriptor, afd.startOffset, afd.length)
                }
            } else {
                // Missing file → never fail silently: fall back to the default alarm tone.
                mp.setDataSource(this, RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM))
            }
            mp.isLooping = false
            mp.setVolume(1f, 1f)
            mp.setOnCompletionListener { stopAdhan() }
            mp.setOnErrorListener { _, what, extra ->
                // A transient player error must not silently kill the Adhan: rebuild the player.
                android.util.Log.w("AdhanService", "MediaPlayer error what=$what extra=$extra")
                NativeDiag.event(this, "player_error", "what=$what extra=$extra n=$recoveries")
                if (!stopping && recoveries < MAX_RECOVERIES) {
                    recoveries++
                    android.os.Handler(android.os.Looper.getMainLooper())
                        .postDelayed({ if (!stopping) playAudio(currentRaw, true) }, 300)
                } else {
                    stopAdhan()
                }
                true
            }
            mp.prepare()
            mp.start()
            mediaPlayer = mp
            isPlaying = true
            NativeDiag.event(this, "adhan_playing", "id=$currentNotificationId raw=$currentRaw")
            MainActivity.notifyAdhanStarted(this, currentNotificationId)
        } catch (e: Exception) {
            e.printStackTrace()
            if (!stopping && recoveries < MAX_RECOVERIES) {
                recoveries++
                // last resort on the 2nd failure: the default alarm tone instead of silence
                val next = if (recoveries >= 2) "" else rawSound
                android.os.Handler(android.os.Looper.getMainLooper())
                    .postDelayed({ if (!stopping) playAudio(next, true) }, 300)
            } else {
                stopAdhan()
            }
        }
    }

    private fun stopAdhan() {
        if (stopping) return
        stopping = true
        isPlaying = false
        pausedByCall = false
        try {
            mediaPlayer?.apply {
                try { if (isPlaying) stop() } catch (_: Exception) {}
                release()
            }
        } catch (_: Exception) {
        }
        mediaPlayer = null
        stopSession()
        abandonFocus()
        releaseWakeLock()
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                stopForeground(STOP_FOREGROUND_REMOVE)
            } else {
                @Suppress("DEPRECATION")
                stopForeground(true)
            }
            (getSystemService(Context.NOTIFICATION_SERVICE) as? NotificationManager)
                ?.cancel(currentNotificationId)
        } catch (_: Exception) {
        }
        NativeDiag.event(this, "adhan_stopped")
        MainActivity.notifyAdhanStopped(this)
        stopSelf()
    }

    private fun acquireWakeLock() {
        try {
            val pm = getSystemService(Context.POWER_SERVICE) as? PowerManager
            wakeLock = pm?.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, "Boshra:AdhanWakeLock")?.apply {
                setReferenceCounted(false)
                acquire(6 * 60 * 1000L)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun releaseWakeLock() {
        try {
            if (wakeLock?.isHeld == true) wakeLock?.release()
        } catch (_: Exception) {
        }
        wakeLock = null
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(CHANNEL_ID, CHANNEL_NAME, NotificationManager.IMPORTANCE_HIGH).apply {
                description = "Channel for Adhan playback"
                setSound(null, null) // MediaPlayer owns the sound → the shade/touches never cut it
                enableVibration(false)
                lockscreenVisibility = Notification.VISIBILITY_PUBLIC
            }
            (getSystemService(Context.NOTIFICATION_SERVICE) as? NotificationManager)
                ?.createNotificationChannel(channel)
        }
    }

    private fun buildNotification(id: Int, title: String, body: String, stopLabel: String): Notification {
        val contentIntent = PendingIntent.getActivity(
            this, id,
            Intent(this, MainActivity::class.java).apply {
                flags = Intent.FLAG_ACTIVITY_SINGLE_TOP or Intent.FLAG_ACTIVITY_CLEAR_TOP
                if (currentRoute.isNotEmpty()) putExtra("route", currentRoute)
            },
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
        val stopIntent = PendingIntent.getBroadcast(
            this, id + 100000,
            Intent(this, AdhanReceiver::class.java).apply { action = AdhanReceiver.ACTION_STOP_ADHAN },
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
        val largeIcon = try {
            BitmapFactory.decodeResource(resources, R.drawable.adhan_large_icon)
        } catch (_: Exception) {
            null
        }
        val builder = NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle(title)
            .setContentText(body)
            .setStyle(NotificationCompat.BigTextStyle().bigText(body)) // shows the dhikr hint line too
            .setSmallIcon(R.drawable.ic_stat_adhan)
            .setColor(0xFF606C38.toInt())
            .setContentIntent(contentIntent)
            .setPriority(NotificationCompat.PRIORITY_MAX)
            .setCategory(NotificationCompat.CATEGORY_ALARM)
            .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
            .setOngoing(true)
            .setAutoCancel(false)
            .addAction(0, stopLabel, stopIntent)
        if (largeIcon != null) builder.setLargeIcon(largeIcon)
        return builder.build()
    }

    override fun onDestroy() {
        stopAdhan()
        running = false
        super.onDestroy()
    }
}
