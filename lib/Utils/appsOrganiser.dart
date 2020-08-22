import 'dart:collection';
import 'dart:typed_data';
import 'package:app_usage/app_usage.dart';
import 'package:device_apps/device_apps.dart';

class AppsOrganiser {
  List<ApplicationWithIcon> applist;
  Map<String, List<ApplicationWithIcon>> categories = {
    'suggested': [],
    'system': [],
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
          categories['system'].add(apps[i]);
        } else if (apps[i].packageName.startsWith('com.google')) {
          categories['google'].add(apps[i]);
        } else if (apps[i].packageName == 'com.shiningcoders.glint') {
          continue;
        } else {
          categories['other'].add(apps[i]);
        }
      }
      await getUsageStats();
    });
  }

  getUsageStats() async {
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
          key == 'com.miui.home');

      //=======================================
      var sortedKeys = usage.keys.toList(growable: false)
        ..sort((k2, k1) => usage[k1].compareTo(usage[k2]));
      LinkedHashMap sortedMap = LinkedHashMap.fromIterable(sortedKeys,
          key: (k) => k, value: (k) => usage[k]);
      var pink = sortedKeys.sublist(0, 10);
      for (int i = 0; i < 10; i++) {
        categories['suggested']
            .add(await DeviceApps.getApp('${pink[i]}', true));
      }
      //========================================
      pink.clear();
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
