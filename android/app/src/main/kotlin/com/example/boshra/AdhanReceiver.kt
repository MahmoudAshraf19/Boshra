package com.example.boshra

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import org.json.JSONObject

/**
 * Single owner of every Adhan alarm.
 *
 * Flutter talks to it ONLY through broadcasts (android_intent_plus), so it works from the UI
 * isolate AND from the WorkManager background isolate (a custom MethodChannel registered in
 * MainActivity does not exist in the background engine — that was why background refresh
 * could never schedule an Adhan).
 *
 *  ACTION_SYNC    : replace/upsert the whole Adhan set (idempotent).
 *  ACTION_TRIGGER : alarm fired (or "play now" for the test button).
 *  ACTION_STOP    : stop button.
 *  BOOT / UPDATE  : re-arm everything from [AdhanStore].
 */
class AdhanReceiver : BroadcastReceiver() {

    companion object {
        const val ACTION_TRIGGER_ADHAN = "com.example.boshra.ACTION_TRIGGER_ADHAN"
        const val ACTION_STOP_ADHAN = "com.example.boshra.ACTION_STOP_ADHAN"
        const val ACTION_SYNC_ADHAN = "com.example.boshra.ACTION_SYNC_ADHAN"
        const val ACTION_MARK_PRAYED = "com.example.boshra.ACTION_MARK_PRAYED"
        const val EXTRA_PLAN = "plan"
        private const val STALE_MS = 2 * 60 * 1000L

        private fun triggerIntent(ctx: Context, e: AdhanEntry) =
            Intent(ctx, AdhanReceiver::class.java).apply {
                action = ACTION_TRIGGER_ADHAN
                putExtra(AdhanService.EXTRA_NOTIFICATION_ID, e.id)
                putExtra(AdhanService.EXTRA_TITLE, e.title)
                putExtra(AdhanService.EXTRA_BODY, e.body)
                putExtra(AdhanService.EXTRA_RAW_SOUND, e.raw)
                putExtra(AdhanService.EXTRA_STOP_LABEL, e.stop)
                putExtra("extra_kind", e.kind)
                putExtra("extra_ch", e.ch)
                putExtra("extra_ch_name", e.chName)
                putExtra("extra_silent", e.silent)
                putExtra("extra_large", e.large)
                putExtra("extra_slot", e.slot)
                putExtra("extra_act", e.act)
                putExtra("extra_route", e.route)
            }

        private fun entryFromIntent(i: Intent) = AdhanEntry(
            i.getIntExtra(AdhanService.EXTRA_NOTIFICATION_ID, 10001), 0L, i.getIntExtra("extra_slot", -1),
            i.getStringExtra(AdhanService.EXTRA_TITLE) ?: "",
            i.getStringExtra(AdhanService.EXTRA_BODY) ?: "",
            i.getStringExtra(AdhanService.EXTRA_RAW_SOUND) ?: "azan_mohammed_refat",
            i.getStringExtra(AdhanService.EXTRA_STOP_LABEL) ?: "Stop",
            i.getStringExtra("extra_kind") ?: "adhan",
            i.getStringExtra("extra_ch") ?: "",
            i.getStringExtra("extra_ch_name") ?: "",
            i.getBooleanExtra("extra_silent", false),
            i.getBooleanExtra("extra_large", false),
            i.getStringExtra("extra_act") ?: "",
            i.getStringExtra("extra_route") ?: ""
        )

        /**
         * setAlarmClock = exact, never deferred by Doze / the 9-minute allow-while-idle throttle,
         * needs NO special permission and may start the foreground service from the background.
         * (Trade-off: Android shows the next Adhan as the "next alarm" icon.)
         */
        fun arm(ctx: Context, e: AdhanEntry) {
            val am = ctx.getSystemService(Context.ALARM_SERVICE) as? AlarmManager ?: return
            val pi = PendingIntent.getBroadcast(
                ctx, e.id, triggerIntent(ctx, e),
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            if (e.kind == "alert" || e.kind == "mode") {
                // Normal/silent notifications: exact when allowed, otherwise inexact (never throws).
                try {
                    val canExact = Build.VERSION.SDK_INT < Build.VERSION_CODES.S || am.canScheduleExactAlarms()
                    if (canExact) am.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, e.at, pi)
                    else am.setAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, e.at, pi)
                } catch (_: Exception) {
                    try { am.setAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, e.at, pi) } catch (_: Exception) {}
                }
                return
            }
            try {
                val show = PendingIntent.getActivity(
                    ctx, e.id, Intent(ctx, MainActivity::class.java),
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )
                am.setAlarmClock(AlarmManager.AlarmClockInfo(e.at, show), pi)
            } catch (_: Exception) {
                try {
                    am.setAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, e.at, pi)
                } catch (_: Exception) {
                }
            }
        }

        fun cancel(ctx: Context, id: Int) {
            val am = ctx.getSystemService(Context.ALARM_SERVICE) as? AlarmManager
            val probe = Intent(ctx, AdhanReceiver::class.java).apply { action = ACTION_TRIGGER_ADHAN }
            val pi = PendingIntent.getBroadcast(
                ctx, id, probe, PendingIntent.FLAG_NO_CREATE or PendingIntent.FLAG_IMMUTABLE
            )
            if (pi != null) {
                am?.cancel(pi)
                pi.cancel()
            }
            AdhanStore.remove(ctx, id)
        }

        /**
         * Makes the stored/armed entries of ONE kind equal to the Flutter plan.
         *  replace  : cancel every stored entry of this kind that is not in the plan.
         *  keepSlots: stored entries of this kind whose prayer slot is not listed are cancelled.
         *  cancel   : explicit ids to cancel (Flutter knows which ones became stale).
         */
        fun sync(ctx: Context, json: String) {
            val root = JSONObject(json)
            val kind = root.optString("kind", "adhan")
            val replace = root.optBoolean("replace", true)
            val useSlots = kind == "adhan"
            val keep = HashSet<Int>()
            root.optJSONArray("keepSlots")?.let { a -> for (i in 0 until a.length()) keep.add(a.getInt(i)) }
            val now = System.currentTimeMillis()

            val incoming = HashSet<Int>()
            val items = root.optJSONArray("items")
            if (items != null) {
                for (i in 0 until items.length()) {
                    val e = AdhanStore.fromJson(items.getJSONObject(i)).copy(kind = kind)
                    incoming.add(e.id)
                    if (e.at > now) {
                        AdhanStore.put(ctx, e)
                        arm(ctx, e)
                    }
                }
            }
            root.optJSONArray("cancel")?.let { a ->
                for (i in 0 until a.length()) {
                    val id = a.getInt(i)
                    if (id !in incoming) cancel(ctx, id)
                }
            }
            for (old in AdhanStore.all(ctx)) {
                if (old.kind != kind || old.id in incoming) continue
                val expired = old.at < now - STALE_MS
                if (expired || replace || (useSlots && old.slot !in keep)) cancel(ctx, old.id)
            }
            if (kind == "mode") PrayerMode.restoreIfNoPendingOff(ctx)
            NativeDiag.event(ctx, "sync_$kind", "items=${items?.length() ?: 0}")
            NativeDiag.snapshot(ctx)
        }

        /**
         * After reboot / update / clock change: re-arm what is still in the future and DROP
         * everything that is overdue. Firing missed items now is what produced the burst of
         * notifications right after the phone started.
         */
        fun rearmAll(ctx: Context) {
            val now = System.currentTimeMillis()
            var armed = 0
            for (e in AdhanStore.all(ctx)) {
                if (e.at > now) { arm(ctx, e); armed++ } else AdhanStore.remove(ctx, e.id)
            }
            PrayerMode.restoreIfExpired(ctx)
            NativeDiag.event(ctx, "rearm", "armed=$armed")
            NativeDiag.snapshot(ctx)
        }
    }

    override fun onReceive(context: Context, intent: Intent?) {
        if (intent == null) return
        try {
            when (intent.action) {
                ACTION_SYNC_ADHAN -> intent.getStringExtra(EXTRA_PLAN)?.let { sync(context, it) }
                ACTION_STOP_ADHAN -> AdhanService.stop(context)
                ACTION_MARK_PRAYED -> {
                    PrayerTrackerNative.mark(context, intent.getStringExtra("date") ?: "", intent.getIntExtra("idx", -1))
                    androidx.core.app.NotificationManagerCompat.from(context).cancel(intent.getIntExtra("nid", -1))
                }
                ACTION_TRIGGER_ADHAN -> {
                    val e = entryFromIntent(intent)
                    AdhanStore.remove(context, e.id) // one-shot
                    NativeDiag.event(context, "fired_${e.kind}", "id=${e.id} ${e.title}")
                    NativeDiag.snapshot(context)
                    PrayerMode.restoreIfExpired(context)
                    if (e.kind == "mode") {
                        PrayerMode.handle(context, e)
                    } else if (e.kind == "alert") {
                        AlertNotifier.show(context, e)
                    } else {
                        try {
                            AdhanService.start(context, e.id, e.title, e.body, e.raw, e.stop, e.route)
                        } catch (ex: Exception) {
                            // Android refused the foreground service (OEM restriction / background
                            // start limits): never stay silent → full-sound alarm notification.
                            ex.printStackTrace()
                            NativeDiag.event(context, "fgs_failed", ex.javaClass.simpleName)
                            AlertNotifier.showAdhanFallback(context, e)
                        }
                    }
                }
                Intent.ACTION_BOOT_COMPLETED,
                Intent.ACTION_MY_PACKAGE_REPLACED,
                Intent.ACTION_TIME_CHANGED,
                Intent.ACTION_TIMEZONE_CHANGED,
                "android.intent.action.QUICKBOOT_POWERON",
                "com.htc.intent.action.QUICKBOOT_POWERON" -> rearmAll(context)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}
