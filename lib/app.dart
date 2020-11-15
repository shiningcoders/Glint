import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:glint/Screens/appsDrawerPage.dart';
import 'package:glint/Screens/homePage.dart';

// Main App with base wallpaper and PageView
class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Blocking Back Navigation from Home Sceen
      onWillPop: () => Future(
        () => false,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  // Wallpaper Image
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            BackdropFilter(
              // Defining blur index for wallpaper
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: PageView(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  // Page View for Home Screen and Drawer Pages
                  children: [
                    HomePage(),
                    HomePage(),
                    AppsDrawerPage(),
                  ],
                ),
              ),
            ),
            // Status Bar
            Positioned(
              top: 10,
              right: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                  child: Container(
                    width: 90,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white12,
                    ),
                    padding: EdgeInsets.all(5),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 12,
                          ),
                          Icon(
                            Icons.network_cell,
                            color: Colors.white,
                            size: 14,
                          ),
                          Container(
                            width: 25,
                            height: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.lightGreen,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
