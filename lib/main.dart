import 'package:device_preview/device_preview.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glint/Onboard/welcome.dart';

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => Glint(),
      ),
    );

class Glint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      locale: DevicePreview.of(context).locale,
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Glint',
      home: SplashScreen('assets/animations/splash.flr', WelcomeScreen(),
          startAnimation: 'Intro', backgroundColor: Colors.white),
    );
  }
}
