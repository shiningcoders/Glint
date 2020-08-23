import 'dart:ui';
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
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          FutureBuilder(
            future: organize.categorizeApps(),
            builder: (context, snapshot) {
              return Expanded(
                child: StaggeredGridView.countBuilder(
                  padding: EdgeInsets.all(15),
                  crossAxisCount: 2,
                  scrollDirection: Axis.vertical,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  itemCount: organize.getCategoryList().length != 0
                      ? organize.getCategoryList().length
                      : 0,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                      future: organize.getUsageStats(),
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
                                    color: Colors.transparent,
                                    child: GridView.count(
                                      padding: EdgeInsets.all(10),
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 2,
                                      crossAxisSpacing: 2,
                                      children: List.generate(
                                        organize
                                                    .getAppsList(
                                                        '${organize.getCategoryList()[index]}')
                                                    .length >
                                                4
                                            ? 4
                                            : organize
                                                .getAppsList(
                                                    '${organize.getCategoryList()[index]}')
                                                .length,
                                        (index2) => Image.memory(
                                          organize.getAppIcon(
                                              organize.getCategoryList()[index],
                                              index2),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white30,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.count(1, index.isOdd ? 1.5 : 1.7);
                  },
                ),
              );
            },
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
