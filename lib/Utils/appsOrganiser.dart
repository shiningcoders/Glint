import 'package:device_apps/device_apps.dart';

class AppsOrganiser {
  var applist;
  List<Application> aaap;
  List<Application> apps;
  Map<String, List<Application>> categories = {
    'system': [],
    'google': [],
    'other': [],
  };

  Future<Map<String, List<Application>>> getAllApps() async {
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
    print('\n\n\n${categories}');
    return categories;
  }

  printApp() async {
    await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeAppIcons: true,
      includeSystemApps: true,
    ).then((apps) => print(apps[0].category));
  }

  Future<List<Application>> getSaareApps() async {
    return await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeAppIcons: true,
      includeSystemApps: true,
    );
  }
}
