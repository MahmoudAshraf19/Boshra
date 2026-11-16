package com.example.boshra

import android.app.NotificationManager
import android.content.Context
import android.media.AudioManager
import android.os.Build

/**
 * "Prayer mode": silences the phone for a few minutes around the prayer and restores it
 * automatically.  Driven by two natively-armed entries per prayer (kind = "mode", title "on" /
 * "off") so it works with the app closed and survives reboots.
 *
 * Safety rules (never leave the phone muted, never override the user):
 *  * If the user is ALREADY in DND / silent / vibrate, we do nothing and remember nothing.
 *  * With "Do Not Disturb access" we use ALARMS-ONLY (calls & notifications silenced, alarms —
 *    including our own Adhan — still ring). Without it we fall back to VIBRATE ringer mode.
 *  * On "off" we restore ONLY if the state is still the one we set (if the user changed it by
 *    hand meanwhile, we leave their choice alone).
 *  * Failsafes: restore when the stored end time passed (boot / any alarm) and when Flutter
 *    removes the pending "off" (feature disabled while active).
 */
object PrayerMode {
    private const val PREFS = "boshra_prayer_mode"

    private fun p(c: Context) = c.getSharedPreferences(PREFS, Context.MODE_PRIVATE)

    fun handle(ctx: Context, e: AdhanEntry) {
        when (e.title) {
            "on" -> on(ctx)
            "off" -> off(ctx, "off")
        }
    }

    private fun policyGranted(nm: NotificationManager?): Boolean =
        Build.VERSION.SDK_INT >= Build.VERSION_CODES.M && nm?.isNotificationPolicyAccessGranted == true

    @Synchronized
    fun on(ctx: Context) {
        try {
            val sp = p(ctx)
            if (sp.getBoolean("active", false)) return
            val nm = ctx.getSystemService(Context.NOTIFICATION_SERVICE) as? NotificationManager
            val am = ctx.getSystemService(Context.AUDIO_SERVICE) as? AudioManager

            // when must it end? = the next stored "off" entry
            val now = System.currentTimeMillis()
            val end = AdhanStore.all(ctx)
                .filter { it.kind == "mode" && it.title == "off" && it.at > now }
                .minOfOrNull { it.at } ?: (now + 15 * 60_000L)

            if (policyGranted(nm) && nm != null) {
                val prev = nm.currentInterruptionFilter
                if (prev != NotificationManager.INTERRUPTION_FILTER_ALL &&
                    prev != NotificationManager.INTERRUPTION_FILTER_UNKNOWN) {
                    NativeDiag.event(ctx, "prayer_mode_skip", "user already in DND")
                    return
                }
                nm.setInterruptionFilter(NotificationManager.INTERRUPTION_FILTER_ALARMS)
                sp.edit().putBoolean("active", true).putString("how", "dnd")
                    .putInt("prev", prev).putLong("end", end).commit()
                NativeDiag.event(ctx, "prayer_mode_on", "dnd")
                return
            }
            if (am != null) {
                val prev = am.ringerMode
                if (prev != AudioManager.RINGER_MODE_NORMAL) {
                    NativeDiag.event(ctx, "prayer_mode_skip", "already silent/vibrate")
                    return
                }
                am.ringerMode = AudioManager.RINGER_MODE_VIBRATE
                sp.edit().putBoolean("active", true).putString("how", "ringer")
                    .putInt("prev", prev).putLong("end", end).commit()
                NativeDiag.event(ctx, "prayer_mode_on", "vibrate")
            }
        } catch (ex: Exception) {
            NativeDiag.event(ctx, "prayer_mode_error", ex.javaClass.simpleName)
        }
    }

    @Synchronized
    fun off(ctx: Context, why: String) {
        try {
            val sp = p(ctx)
            if (!sp.getBoolean("active", false)) return
            val how = sp.getString("how", "") ?: ""
            val prev = sp.getInt("prev", 0)
            if (how == "dnd") {
                val nm = ctx.getSystemService(Context.NOTIFICATION_SERVICE) as? NotificationManager
                if (nm != null && policyGranted(nm) &&
                    nm.currentInterruptionFilter == NotificationManager.INTERRUPTION_FILTER_ALARMS) {
                    nm.setInterruptionFilter(
                        if (prev == NotificationManager.INTERRUPTION_FILTER_UNKNOWN)
                            NotificationManager.INTERRUPTION_FILTER_ALL else prev
                    )
                }
            } else {
                val am = ctx.getSystemService(Context.AUDIO_SERVICE) as? AudioManager
                if (am != null && am.ringerMode == AudioManager.RINGER_MODE_VIBRATE) am.ringerMode = prev
            }
            sp.edit().clear().commit()
            NativeDiag.event(ctx, "prayer_mode_off", why)
        } catch (ex: Exception) {
            p(ctx).edit().clear().commit()
            NativeDiag.event(ctx, "prayer_mode_error", "off ${ex.javaClass.simpleName}")
        }
    }

    /** Failsafe: end time passed (reboot, missed alarm) → restore now. */
    fun restoreIfExpired(ctx: Context) {
        val sp = p(ctx)
        if (sp.getBoolean("active", false) && sp.getLong("end", 0L) <= System.currentTimeMillis() + 1000) {
            off(ctx, "expired")
        }
    }

    /** Failsafe: the session is active but no future "off" is armed any more (feature disabled). */
    fun restoreIfNoPendingOff(ctx: Context) {
        if (!p(ctx).getBoolean("active", false)) return
        val now = System.currentTimeMillis()
        val has = AdhanStore.all(ctx).any { it.kind == "mode" && it.title == "off" && it.at > now }
        if (!has) off(ctx, "disabled")
    }
}
