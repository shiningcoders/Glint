import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(Glint());

class Glint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'Glint',
      home: SplashScreen('assets/animations/splash.flr', StartingPoint(),
          startAnimation: 'Intro', backgroundColor: Colors.white),
    );
  }
}

class StartingPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
