import 'dart:ui';

import 'package:device_apps/device_apps.dart';
import 'package:extension/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:glint/Utils/appsOrganiser.dart';

class AppsDrawerPage extends StatefulWidget {
  @override
  _AppsDrawerPageState createState() => _AppsDrawerPageState();
}

class _AppsDrawerPageState extends State<AppsDrawerPage>
    with AutomaticKeepAliveClientMixin<AppsDrawerPage> {
  var installedApps;
  var categories;
  AppsOrganiser organize = AppsOrganiser();

  @override
  void initState() {
    organize.categorizeApps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      builder: (context, snapshot) {
        return StaggeredGridView.countBuilder(
          padding: EdgeInsets.all(20),
          crossAxisCount: 2,
          scrollDirection: Axis.vertical,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          itemCount: organize.getCategoryList().length != 0
              ? organize.getCategoryList().length
              : 0,
          itemBuilder: (context, index) {
            return FutureBuilder(
              future: organize.categorizeApps(),
              builder: (context, snapshot) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          Text('${organize.getCategoryList()[index]}'
                              .toUpperCase()),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            height: 180,
                            color: Colors.transparent,
                            child: GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              children: List.generate(
                                organize
                                    .getAppsList(
                                        organize.getCategoryList()[index])
                                    .length,
                                (index2) => Image.memory(
                                  organize.getAppIcon(
                                      organize.getCategoryList()[index],
                                      index2),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // [
                              //   Image.memory(
                              //     organize.getAppIcon(
                              //         organize.getCategoryList()[index], 0),
                              //     fit: BoxFit.cover,
                              //   ),
                              //   Image.memory(
                              //     organize.getAppIcon(
                              //         organize.getCategoryList()[index], 1),
                              //     fit: BoxFit.cover,
                              //   ),
                              //   Image.memory(
                              //     organize.getAppIcon(
                              //         organize.getCategoryList()[index], 2),
                              //     fit: BoxFit.cover,
                              //   ),
                              //   Image.memory(
                              //     organize.getAppIcon(
                              //         organize.getCategoryList()[index], 3),
                              //     fit: BoxFit.cover,
                              //   ),
                              // ],
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white24,
                      ),
                    ),
                  ),
                );
              },
            );
          },
          staggeredTileBuilder: (index) {
            return StaggeredTile.count(1, index.isOdd ? 1.3 : 1.6);
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
