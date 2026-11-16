package com.example.boshra

import android.content.Context

/**
 * Tiny black box for the support / diagnostics screen.
 *
 * It writes into Flutter's own SharedPreferences file (keys prefixed "flutter.") so the Dart
 * side reads it with plain `prefs.getString('native_events')` — no MethodChannel needed
 * (a channel does not exist in the WorkManager background engine, see AdhanReceiver).
 */
object NativeDiag {
    private const val FILE = "FlutterSharedPreferences"
    private const val MAX_LINES = 40

    private fun p(c: Context) = c.getSharedPreferences(FILE, Context.MODE_PRIVATE)

    /** "epochMs|type|detail" lines, newest last, capped. */
    @Synchronized
    fun event(c: Context, type: String, detail: String = "") {
        try {
            val sp = p(c)
            val old = sp.getString("flutter.native_events", "") ?: ""
            val lines = old.split("\n").filter { it.isNotBlank() }.toMutableList()
            lines.add("${System.currentTimeMillis()}|$type|${detail.replace("\n", " ").take(120)}")
            val trimmed = if (lines.size > MAX_LINES) lines.takeLast(MAX_LINES) else lines
            sp.edit().putString("flutter.native_events", trimmed.joinToString("\n")).apply()
        } catch (_: Exception) {
        }
    }

    /** What is REALLY armed in AlarmManager right now (from the persisted store). */
    @Synchronized
    fun snapshot(c: Context) {
        try {
            val now = System.currentTimeMillis()
            val all = AdhanStore.all(c).filter { it.at > now }
            val adhan = all.filter { it.kind == "adhan" }.sortedBy { it.at }
            val ed = p(c).edit()
            ed.putLong("flutter.native_armed_adhan", adhan.size.toLong())
            ed.putLong("flutter.native_armed_alerts", (all.size - adhan.size).toLong())
            ed.putLong("flutter.native_next_adhan_ms", adhan.firstOrNull()?.at ?: 0L)
            ed.putString("flutter.native_next_adhan_title", adhan.firstOrNull()?.title ?: "")
            ed.putLong("flutter.native_snapshot_ms", now)
            ed.apply()
        } catch (_: Exception) {
        }
    }
}
