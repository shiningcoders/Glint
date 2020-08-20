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
  List<String> cat;
  Map<String, List<Application>> categories;
  AppsOrganiser organize = AppsOrganiser();
  @override
  void initState() {
    getAllCategories();
    super.initState();
  }

  Future<void> getAllCategories() async {
    await organize.getAllApps().then((map) {
      setState(() {
        categories = map;
        categories.forEach((key, value) {
          cat.add(key);
        });
      });
    });
  }

  // Future<void> callMeMan() async {
  //   AppsOrganiser organize = AppsOrganiser();
  //   await organize.getAllApps().then((apps) {
  //     setState(() {
  //       installedApps = apps;
  //     });
  //   });
  // }

  // Future<void> getMe() async {
  //   AppsOrganiser organiser = AppsOrganiser();
  //   await organize.getSaareApps().then((value) {
  //     organiser.printApp();
  //     setState(() {
  //       installedApps = value;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: getAllCategories(),
      builder: (context, snapshot) {
        return GridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 40,
          padding: EdgeInsets.all(20),
          children: List.generate(
              categories.length != 0 ? categories.length : 0, (index) {
            return Container(
              width: 40,
              height: 120,
              child: Center(
                child: Text(cat[index]),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
