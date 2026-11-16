package com.example.boshra

import android.content.Context
import android.content.Intent
import android.os.Bundle
import com.ryanheise.audioservice.AudioServiceActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/**
 * Scheduling/stop go through [AdhanReceiver] broadcasts (work from any isolate).
 * This channel only carries native → Flutter events and a couple of queries for the UI isolate.
 */
class MainActivity : AudioServiceActivity() {

    companion object {
        const val CHANNEL = "com.app.boshra/adhan"
        private var methodChannel: MethodChannel? = null
        @Volatile private var pendingRoute: String? = null

        fun notifyAdhanStopped(context: Context) {
            try { methodChannel?.invokeMethod("onAdhanStopped", null) } catch (_: Exception) {}
        }

        fun notifyAdhanStarted(context: Context, id: Int) {
            try { methodChannel?.invokeMethod("onAdhanStarted", mapOf("id" to id)) } catch (_: Exception) {}
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        captureRoute(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        captureRoute(intent)
        // App already running: hand the route to Dart immediately.
        val r = pendingRoute
        if (r != null) {
            try { methodChannel?.invokeMethod("onRoute", r); pendingRoute = null } catch (_: Exception) {}
        }
    }

    private fun captureRoute(i: Intent?) {
        val r = i?.getStringExtra("route")
        if (!r.isNullOrEmpty()) {
            pendingRoute = r
            i?.removeExtra("route")
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).apply {
            setMethodCallHandler { call, result ->
                when (call.method) {
                    "isAdhanPlaying" -> result.success(AdhanService.isPlaying)
                    "getLaunchRoute" -> {
                        result.success(pendingRoute)
                        pendingRoute = null
                    }
                    "stopAdhan" -> {
                        AdhanService.stop(applicationContext)
                        result.success(true)
                    }
                    else -> result.notImplemented()
                }
            }
        }
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)
        methodChannel = null
    }
}
