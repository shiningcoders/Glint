import 'package:flutter/material.dart';

void main() => runApp(Glint());

class Glint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glint',
      home: StartingPoint(),
    );
  }
}

class StartingPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
