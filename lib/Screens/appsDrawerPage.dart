import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:launcher_assist/launcher_assist.dart';

class AppsDrawerPage extends StatefulWidget {
  @override
  _AppsDrawerPageState createState() => _AppsDrawerPageState();
}

class _AppsDrawerPageState extends State<AppsDrawerPage>
    with AutomaticKeepAliveClientMixin<AppsDrawerPage> {
  var installedApps;
  @override
  void initState() {
    LauncherAssist.getAllApps().then((apps) {
      setState(() {
        installedApps = apps;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ForegroundWidget(installedApps: installedApps);
  }

  @override
  bool get wantKeepAlive => true;
}

class ForegroundWidget extends StatefulWidget {
  const ForegroundWidget({
    Key key,
    @required this.installedApps,
  }) : super(key: key);

  final installedApps;

  @override
  _ForegroundWidgetState createState() => _ForegroundWidgetState();
}

class _ForegroundWidgetState extends State<ForegroundWidget>
    with SingleTickerProviderStateMixin {
  AnimationController opacityController;
  Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    opacityController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _opacity = Tween(begin: 0.0, end: 1.0).animate(opacityController);
  }

  @override
  Widget build(BuildContext context) {
    opacityController.forward();
    return FadeTransition(
      opacity: _opacity,
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 50, 30, 0),
        child: gridViewContainer(widget.installedApps),
      ),
    );
  }

  gridViewContainer(installedApps) {
    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 40,
      physics: BouncingScrollPhysics(),
      children: List.generate(
        installedApps != null ? installedApps.length : 0,
        (index) {
          return GestureDetector(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  iconContainer(index),
                  SizedBox(height: 10),
                  Text(
                    installedApps[index]["label"],
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            onTap: () =>
                LauncherAssist.launchApp(installedApps[index]["package"]),
          );
        },
      ),
    );
  }

  iconContainer(index) {
    try {
      return Image.memory(
        widget.installedApps[index]["icon"] != null
            ? widget.installedApps[index]["icon"]
            : Uint8List(0),
        height: 50,
        width: 50,
      );
    } catch (e) {
      return Container();
    }
  }
}
