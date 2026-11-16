package com.example.boshra

import android.content.Context
import org.json.JSONObject

/**
 * Lets the "I prayed ✓" notification button record the prayer while the app is closed.
 * Writes into Flutter's SharedPreferences (key "flutter.tracker_v1", JSON {"yyyy-MM-dd": bitmask}),
 * which the Dart tracker reads with `prefs.reload()`.
 */
object PrayerTrackerNative {
    private const val FILE = "FlutterSharedPreferences"
    private const val KEY = "flutter.tracker_v1"
    private const val TIMES = "flutter.tracker_times_v1"

    @Synchronized
    fun mark(ctx: Context, date: String, idx: Int) {
        try {
            if (idx !in 0..4 || !Regex("\\d{4}-\\d{2}-\\d{2}").matches(date)) return
            val sp = ctx.getSharedPreferences(FILE, Context.MODE_PRIVATE)
            val j = try { JSONObject(sp.getString(KEY, "{}") ?: "{}") } catch (_: Exception) { JSONObject() }
            j.put(date, j.optInt(date, 0) or (1 shl idx))
            // minute of day when it was marked (for the "learn my patterns" feature)
            val t = try { JSONObject(sp.getString(TIMES, "{}") ?: "{}") } catch (_: Exception) { JSONObject() }
            val arr = t.optJSONArray(date) ?: org.json.JSONArray(listOf(-1, -1, -1, -1, -1))
            val cal = java.util.Calendar.getInstance()
            arr.put(idx, cal.get(java.util.Calendar.HOUR_OF_DAY) * 60 + cal.get(java.util.Calendar.MINUTE))
            t.put(date, arr)
            sp.edit().putString(KEY, j.toString()).putString(TIMES, t.toString())
                .putLong("flutter.tracker_native_ms", System.currentTimeMillis()).commit()
            NativeDiag.event(ctx, "prayer_marked", "$date#$idx")
        } catch (_: Exception) {
        }
    }
}
