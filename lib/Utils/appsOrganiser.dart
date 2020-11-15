/*
  AppOrganiser fetches all installed apps and organises apps according to
  collection category.
*/

import 'dart:collection';
import 'dart:typed_data';
import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';

class AppsOrganiser {
  List<ApplicationWithIcon> applist;
  Map<String, List<ApplicationWithIcon>> categories = {
    'suggested': [],
    'essential': [],
    'google': [],
    'other': [],
  };

  var appsUsage;

  Future<Map> categorizeApps() async {
    await DeviceApps.getInstalledApplications(
            onlyAppsWithLaunchIntent: true,
            includeSystemApps: true,
            includeAppIcons: true)
        .then((apps) async {
      for (int i = 0; i < apps.length - 1; i++) {
        if (apps[i].packageName.startsWith('com.android')) {
          categories['essential'].add(apps[i]);
        } else if (apps[i].packageName.startsWith('com.google')) {
          categories['google'].add(apps[i]);
        } else if (apps[i].packageName == 'com.shiningcoders.glint') {
          continue;
        } else {
          categories['other'].add(apps[i]);
        }
      }
    });
  }

  getSuggestedApps() async {
    // Initialization
    AppUsage appUsage = new AppUsage();
    try {
      // Define a time interval
      DateTime endDate = new DateTime.now();
      DateTime startDate = DateTime(endDate.weekday);

      // Fetch the usage stats
      Map<String, double> usage = await appUsage.fetchUsage(startDate, endDate);

      // Remove entries for apps with 0 usage time
      usage.removeWhere((key, val) =>
          val == 0 ||
          key == 'com.shiningcoders.glint' ||
          key == 'com.miui.home' ||
          key == 'android');

      usage.forEach((key, value) async {
        if (value > 120) {
          if (await DeviceApps.isAppInstalled(key)) {
            categories['suggested'].add(await DeviceApps.getApp(key, true));
          } else {}
        }
      });
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  List<String> getCategoryList() {
    return categories.keys.toList();
  }

  List<ApplicationWithIcon> getAppsList(String key) {
    return categories[key];
  }

  Uint8List getAppIcon(String key, int index) {
    return categories[key][index].icon;
  }
}
