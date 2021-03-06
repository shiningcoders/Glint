import 'package:device_preview/device_preview.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glint/app.dart';

// Main Function
void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => Glint(),
      ),
    );

// Main Material App with Splash Screen
class Glint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      locale: DevicePreview.of(context).locale,
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Glint',
      // Splash Screen
      home: SplashScreen(
        'assets/animations/splash.flr',
        App(),
        startAnimation: 'Intro',
        backgroundColor: Colors.white,
      ),
    );
  }
}
