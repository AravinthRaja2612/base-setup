package com.example.flutter_learn

import android.content.ComponentName
import android.content.pm.PackageManager
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {

    private val CHANNEL = "com.example.flutter_learn/icon"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "setIcon" -> {
                        val alias = call.argument<String>("alias")
                        setAppIcon(alias)
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    /**
     * Safely switch launcher icon without killing or restarting the app.
     * Keeps at least one alias enabled at all times.
     */
    private fun setAppIcon(alias: String?) {
        val pm = packageManager
        val basePackage = applicationContext.packageName

        val defaultAlias = ComponentName(basePackage, "$basePackage.MainActivityDefaultAlias")
        val christmasAlias = ComponentName(basePackage, "$basePackage.MainActivityChristmasAlias")
        val newYearAlias = ComponentName(basePackage, "$basePackage.MainActivityNewYearAlias")

        // Identify target alias
        val target = when (alias) {
            "christmas" -> christmasAlias
            "newyear" -> newYearAlias
            else -> defaultAlias
        }

        // First enable target alias (so app always has one launcher)
        pm.setComponentEnabledSetting(
            target,
            PackageManager.COMPONENT_ENABLED_STATE_ENABLED,
            PackageManager.DONT_KILL_APP
        )

        // Then disable others
        val allAliases = listOf(defaultAlias, christmasAlias, newYearAlias)
        allAliases.filter { it != target }.forEach {
            pm.setComponentEnabledSetting(
                it,
                PackageManager.COMPONENT_ENABLED_STATE_DISABLED,
                PackageManager.DONT_KILL_APP
            )
        }
    }
}
