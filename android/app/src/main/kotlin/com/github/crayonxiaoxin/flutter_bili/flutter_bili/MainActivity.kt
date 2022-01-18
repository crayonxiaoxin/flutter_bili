package com.github.crayonxiaoxin.flutter_bili.flutter_bili

import android.graphics.Color
import android.os.Build
import android.os.Bundle
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // Aligns the Flutter view vertically with the window.
        WindowCompat.setDecorFitsSystemWindows(window, false)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            window.statusBarColor = Color.TRANSPARENT
        }

//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
//            // Disable the Android splash screen fade out animation to avoid
//            // a flicker before the similar frame is drawn in Flutter.
//            splashScreen.setOnExitAnimationListener { splashScreenView -> splashScreenView.remove() }
//        }

        super.onCreate(savedInstanceState)
    }
}
