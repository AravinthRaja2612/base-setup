package com.example.flutter_learn

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class HiddenLauncherActivity : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Launch the real Flutter MainActivity
        val intent = Intent(this, MainActivity::class.java)
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        startActivity(intent)

        finish()
    }
}
