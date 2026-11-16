package com.example.boshra

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.graphics.BitmapFactory
import android.media.AudioAttributes
import android.net.Uri
import android.os.Build
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat

/** Posts the normal / silent notifications (Azkar, Ayah, pre-prayer, short/silent prayer alerts). */
object AlertNotifier {

    private fun ensureChannel(ctx: Context, e: AdhanEntry) {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) return
        val nm = ctx.getSystemService(Context.NOTIFICATION_SERVICE) as? NotificationManager ?: return
        if (nm.getNotificationChannel(e.ch) != null) return // Flutter already created it → keep user's choices
        val c = NotificationChannel(e.ch, e.chName.ifEmpty { e.ch }, NotificationManager.IMPORTANCE_HIGH)
        if (e.silent) {
            c.setSound(null, null)
            c.enableVibration(false)
        } else {
            c.setSound(
                Uri.parse("android.resource://${ctx.packageName}/raw/" +
                    (if (e.ch.startsWith("friday_")) "friday_chime" else "notification")),
                AudioAttributes.Builder().setUsage(AudioAttributes.USAGE_NOTIFICATION).build()
            )
        }
        nm.createNotificationChannel(c)
    }

    fun show(ctx: Context, e: AdhanEntry) {
        try {
            if (e.ch.isEmpty()) return
            ensureChannel(ctx, e)
            val open = PendingIntent.getActivity(
                ctx, e.id,
                Intent(ctx, MainActivity::class.java).apply {
                    flags = Intent.FLAG_ACTIVITY_SINGLE_TOP or Intent.FLAG_ACTIVITY_CLEAR_TOP
                    if (e.route.isNotEmpty()) putExtra("route", e.route)
                },
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            val b = NotificationCompat.Builder(ctx, e.ch)
                .setContentTitle(e.title)
                .setContentText(e.body)
                .setStyle(NotificationCompat.BigTextStyle().bigText(e.body))
                .setSmallIcon(R.drawable.ic_stat_adhan)
                // Friday (Salawat / Al-Kahf) reminders get their own GOLD accent + chime.
                .setColor(if (e.ch.startsWith("friday_")) 0xFFC9A227.toInt() else 0xFF606C38.toInt())
                .setContentIntent(open)
                .setAutoCancel(true)
                .setPriority(if (e.silent) NotificationCompat.PRIORITY_HIGH else NotificationCompat.PRIORITY_MAX)
                .setCategory(NotificationCompat.CATEGORY_REMINDER)
                .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
            // "I prayed ✓" button (prayer tracker nudge): records the prayer even with the app closed.
            if (e.act.startsWith("prayed:") && e.stop.isNotEmpty()) {
                val parts = e.act.split(":")
                if (parts.size == 3) {
                    val mark = Intent(ctx, AdhanReceiver::class.java).apply {
                        action = AdhanReceiver.ACTION_MARK_PRAYED
                        putExtra("idx", parts[1].toIntOrNull() ?: -1)
                        putExtra("date", parts[2])
                        putExtra("nid", e.id)
                    }
                    b.addAction(
                        0, e.stop,
                        PendingIntent.getBroadcast(ctx, e.id + 7, mark, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
                    )
                }
            }
            if (e.large) {
                try { b.setLargeIcon(BitmapFactory.decodeResource(ctx.resources, R.drawable.adhan_large_icon)) } catch (_: Exception) {}
            }
            NotificationManagerCompat.from(ctx).notify(e.id, b.build())
        } catch (_: Exception) {
            // notifications disabled / no permission → nothing to do
        }
    }

    /**
     * Fallback used only when the Adhan foreground service could not start: a max-priority
     * notification whose channel plays the chosen Muadhin with ALARM audio attributes.
     */
    fun showAdhanFallback(ctx: Context, e: AdhanEntry) {
        try {
            val raw = if (e.raw.isEmpty()) "adhan" else e.raw
            val chId = "adhan_fb_${raw}_v1"
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                val nm = ctx.getSystemService(Context.NOTIFICATION_SERVICE) as? NotificationManager ?: return
                if (nm.getNotificationChannel(chId) == null) {
                    val c = NotificationChannel(chId, "Adhan (backup)", NotificationManager.IMPORTANCE_HIGH)
                    c.setSound(
                        Uri.parse("android.resource://${ctx.packageName}/raw/$raw"),
                        AudioAttributes.Builder().setUsage(AudioAttributes.USAGE_ALARM).build()
                    )
                    c.lockscreenVisibility = android.app.Notification.VISIBILITY_PUBLIC
                    nm.createNotificationChannel(c)
                }
            }
            val open = PendingIntent.getActivity(
                ctx, e.id, Intent(ctx, MainActivity::class.java),
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            val b = NotificationCompat.Builder(ctx, chId)
                .setContentTitle(e.title)
                .setContentText(e.body)
                .setSmallIcon(R.drawable.ic_stat_adhan)
                .setColor(0xFF606C38.toInt())
                .setContentIntent(open)
                .setAutoCancel(true)
                .setPriority(NotificationCompat.PRIORITY_MAX)
                .setCategory(NotificationCompat.CATEGORY_ALARM)
                .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
                .setTimeoutAfter(240000)
            NotificationManagerCompat.from(ctx).notify(e.id, b.build())
        } catch (_: Exception) {
        }
    }
}
