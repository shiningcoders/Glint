import 'dart:typed_data';
import 'package:device_apps/device_apps.dart';
import 'package:extension/string.dart';
import 'package:flutter/material.dart';
import 'package:glint/Utils/appsOrganiser.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:launcher_assist/launcher_assist.dart';

class AppsDrawerPage extends StatefulWidget {
  @override
  _AppsDrawerPageState createState() => _AppsDrawerPageState();
}

class _AppsDrawerPageState extends State<AppsDrawerPage>
    with AutomaticKeepAliveClientMixin<AppsDrawerPage> {
  var installedApps;
  var systemAppsLength;
  AppsOrganiser organize = AppsOrganiser();
  @override
  void initState() {
    callMeMan();
    super.initState();
  }

  Future<void> callMeMan() async {
    AppsOrganiser organize = AppsOrganiser();
    await organize.getAllApps().then((apps) {
      setState(() {
        installedApps = apps;
      });
    });
  }

  Future<void> getMe() async {
    AppsOrganiser organiser = AppsOrganiser();
    await organize.getSaareApps().then((value) {
      organiser.printApp();
      setState(() {
        installedApps = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: organize.getAllApps(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.all(40),
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 15,
              mainAxisSpacing: 40,
              children: List.generate(
                installedApps.length != 0 ? installedApps.length : 0,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      DeviceApps.openApp(installedApps[index].packageName);
                    },
                    child: SizedBox(
                      width: 10,
                      height: 10,
                      child: Image.memory(installedApps[index].icon),
                    ),
                  );
                },
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
