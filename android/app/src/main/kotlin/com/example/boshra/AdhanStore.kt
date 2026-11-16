package com.example.boshra

import android.content.Context
import org.json.JSONObject

/**
 * One natively-scheduled notification. kind = "adhan" (full Adhan via AdhanService) or
 * "alert" (normal/silent notification posted by AlertNotifier).
 * Persisted so it survives reboot / app update / killed Flutter engine.
 */
data class AdhanEntry(
    val id: Int,
    val at: Long,
    val slot: Int,
    val title: String,
    val body: String,
    val raw: String,
    val stop: String,
    val kind: String = "adhan",
    val ch: String = "",
    val chName: String = "",
    val silent: Boolean = false,
    val large: Boolean = false,
    /** optional notification action payload, e.g. "prayed:2:2026-11-14" (label = [stop]) */
    val act: String = "",
    /** in-app route opened when the notification is tapped, e.g. "azkar:morning" */
    val route: String = ""
)

object AdhanStore {
    private const val PREFS = "boshra_adhan_alarms"

    private fun prefs(c: Context) = c.getSharedPreferences(PREFS, Context.MODE_PRIVATE)

    fun fromJson(j: JSONObject) = AdhanEntry(
        j.getInt("id"), j.getLong("at"), j.optInt("slot", -1),
        j.optString("title"), j.optString("body"),
        j.optString("raw"), j.optString("stop"),
        j.optString("kind", "adhan"), j.optString("ch"), j.optString("chName"),
        j.optBoolean("silent", false), j.optBoolean("large", false),
        j.optString("act"),
        j.optString("route")
    )

    fun all(c: Context): List<AdhanEntry> =
        prefs(c).all.values.mapNotNull { v ->
            try { fromJson(JSONObject(v as String)) } catch (_: Exception) { null }
        }

    fun put(c: Context, e: AdhanEntry) {
        val j = JSONObject()
            .put("id", e.id).put("at", e.at).put("slot", e.slot)
            .put("title", e.title).put("body", e.body)
            .put("raw", e.raw).put("stop", e.stop)
            .put("kind", e.kind).put("ch", e.ch).put("chName", e.chName)
            .put("silent", e.silent).put("large", e.large).put("act", e.act).put("route", e.route)
        prefs(c).edit().putString("a_${e.id}", j.toString()).commit()
    }

    fun remove(c: Context, id: Int) {
        prefs(c).edit().remove("a_$id").commit()
    }
}
