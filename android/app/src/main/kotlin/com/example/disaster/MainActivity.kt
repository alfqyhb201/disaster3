package com.example.disaster

import io.flutter.embedding.android.FlutterActivity
import com.tekartik.sqflite.SqflitePlugin

class MainActivity: FlutterActivity() {
    fun registerWith(registry: PluginRegistry) {
        com.tekartik.sqflite.SqflitePlugin.registerWith(
                registry.registrarFor("com.tekartik.sqflite.SqflitePlugin"))
    }
}
