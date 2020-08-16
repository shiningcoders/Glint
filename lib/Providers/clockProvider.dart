import 'package:flutter/cupertino.dart';

class ClockNotifier extends ChangeNotifier {
  var hour = 0;
  var minute = 0;
  var day;
  var month;
  var date;

  getTime() {
    hour;
    minute;
  }

  getDate() {
    month;
    date;
    day;
  }

  updateHours() {
    hour = DateTime.now().hour;
    minute = DateTime.now().minute;
    notifyListeners();
  }

  updateDate() {
    day = DateTime.now().weekday;
    month = DateTime.now().month;
    date = DateTime.now().day;
    notifyListeners();
  }
}
