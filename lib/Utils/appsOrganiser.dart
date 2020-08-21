import 'dart:typed_data';

import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class AppsOrganiser {
  List<ApplicationWithIcon> applist;
  Map<String, List<ApplicationWithIcon>> categories = {
    'suggested': [],
    'system': [],
    'google': [],
    'other': [],
  };

  Future<Map> categorizeApps() async {
    await DeviceApps.getInstalledApplications(
            onlyAppsWithLaunchIntent: true,
            includeSystemApps: true,
            includeAppIcons: true)
        .then((apps) {
      for (int i = 0; i < apps.length - 1; i++) {
        if (apps[i].packageName.startsWith('com.android')) {
          categories['system'].add(apps[i]);
        } else if (apps[i].packageName.startsWith('com.google')) {
          categories['google'].add(apps[i]);
        } else if (apps[i].category != ApplicationCategory.undefined) {
          if (categories.containsKey('${apps[i].category}')) {
            categories['${apps[i].category}'].add(apps[i]);
          } else {
            categories.putIfAbsent('${apps[i].category}', () => [apps[i]]);
          }
        } else {
          categories['other'].add(apps[i]);
        }
      }
    });
    getUsageStats();
  }

  void getUsageStats() async {
    // Initialization
    AppUsage appUsage = new AppUsage();
    try {
      // Define a time interval
      DateTime endDate = new DateTime.now();
      DateTime startDate = DateTime(endDate.month);

      // Fetch the usage stats
      Map<String, double> usage = await appUsage.fetchUsage(startDate, endDate);

      // (Optional) Remove entries for apps with 0 usage time
      usage.removeWhere((key, val) => val == 0);
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
