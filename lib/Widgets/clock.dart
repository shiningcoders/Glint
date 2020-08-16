import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';
import 'package:glint/Providers/clockProvider.dart';
import 'package:glint/Secrets/secret.dart';
import 'package:provider/provider.dart';
import 'package:weather/weather.dart';
import 'package:extension/string.dart';

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  WeatherFactory wf = WeatherFactory(weatherAPI);
  Weather weather;
  int count = 0;

  @override
  void initState() {
    var timeInfo = Provider.of<ClockNotifier>(context, listen: false);
    var t1 = Timer.periodic(Duration(seconds: 1), (t) {
      timeInfo.updateHours();
      timeInfo.updateDate();
      count++;
      print('Seconds calling');
    });
    Timer.periodic(Duration(minutes: 1), (t) {
      timeInfo.updateHours();
      timeInfo.updateDate();
      print('Minutes calling');
      count != 0 ? t1.cancel() : null;
    });
    getCurrentWeather();
    // updateTicker();
    super.initState();
  }

  // updateTicker() async {
  //   var timeInfo = Provider.of<ClockNotifier>(context, listen: false);
  //   timeInfo.updateDate();
  //   timeInfo.updateHours();
  //   Timer.periodic(Duration(minutes: 1), (t) {
  //     timeInfo.updateHours();
  //   });
  //   Timer.periodic(Duration(days: 1), (t) {
  //     timeInfo.updateDate();
  //   });
  // }

  void getCurrentWeather() async {
    weather = await wf.currentWeatherByCityName("Agra");
    print(weather.weatherDescription);
  }

  String formatTime(time) {
    if (time < 10) {
      return '0${time}';
    }
    return '${time}';
  }

  String formatWeekDay(day) {
    const days = {
      1: 'Monday',
      2: 'Tuesday',
      3: 'Wednesday',
      4: 'Thursday',
      5: 'Friday',
      6: 'Saturday',
      7: 'Sunday',
    };
    return days[day];
  }

  String formatMonths(month) {
    const months = {
      1: 'January',
      2: 'February',
      3: 'March',
      4: 'April',
      5: 'May',
      6: 'June',
      7: 'July',
      8: 'August',
      9: 'September',
      10: 'October',
      11: 'November',
      12: 'December',
    };
    return months[month];
  }

  Icon formatWeatherIcon(code) {
    const icons = {
      '01d': Icon(
        WeatherIcons.wiDaySunny,
        color: Colors.white,
        size: 18,
      ),
      '01n': Icon(
        WeatherIcons.wiNightClear,
        color: Colors.white,
        size: 18,
      ),
      '02d': Icon(
        WeatherIcons.wiDayCloudy,
        color: Colors.white,
        size: 18,
      ),
      '02n': Icon(
        WeatherIcons.wiNightCloudy,
        color: Colors.white,
        size: 18,
      ),
      '03d': Icon(
        WeatherIcons.wiCloud,
        color: Colors.white,
        size: 18,
      ),
      '03n': Icon(
        WeatherIcons.wiCloud,
        color: Colors.white,
        size: 18,
      ),
      '04d': Icon(
        WeatherIcons.wiCloudy,
        color: Colors.white,
        size: 18,
      ),
      '04n': Icon(
        WeatherIcons.wiCloudy,
        color: Colors.white,
        size: 18,
      ),
      '09d': Icon(
        WeatherIcons.wiShowers,
        color: Colors.white,
        size: 18,
      ),
      '09n': Icon(
        WeatherIcons.wiShowers,
        color: Colors.white,
        size: 18,
      ),
      '10d': Icon(
        WeatherIcons.wiDayRain,
        color: Colors.white,
        size: 18,
      ),
      '10n': Icon(
        WeatherIcons.wiNightRain,
        color: Colors.white,
        size: 18,
      ),
      '11d': Icon(
        WeatherIcons.wiDayThunderstorm,
        color: Colors.white,
        size: 18,
      ),
      '11n': Icon(
        WeatherIcons.wiNightThunderstorm,
        color: Colors.white,
        size: 18,
      ),
      '13d': Icon(
        WeatherIcons.wiDaySnow,
        color: Colors.white,
        size: 18,
      ),
      '13n': Icon(
        WeatherIcons.wiNightSnow,
        color: Colors.white,
        size: 18,
      ),
      '50d': Icon(
        WeatherIcons.wiDayFog,
        color: Colors.white,
        size: 18,
      ),
      '50n': Icon(
        WeatherIcons.wiNightFog,
        color: Colors.white,
        size: 18,
      ),
    };
    return icons[code];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Consumer<ClockNotifier>(
            builder: (context, value, child) {
              return Text(
                value.hour > 12
                    ? formatTime(value.hour - 12)
                    : formatTime(value.hour),
                style: TextStyle(fontSize: 50, color: Colors.white),
              );
            },
          ),
          Consumer<ClockNotifier>(
            builder: (context, value, child) {
              return Text(
                formatTime(value.minute),
                style: TextStyle(fontSize: 50, color: Colors.white),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          Consumer<ClockNotifier>(builder: (context, value, child) {
            return Text(
              value.day != null
                  ? formatWeekDay(value.day) +
                      ', ${value.date} ' +
                      formatMonths(value.month)
                  : '',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
            );
          }),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 60,
            height: 1,
            color: Colors.white.withOpacity(0.5),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: 190,
            child: Consumer<ClockNotifier>(builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      weather != null
                          ? formatWeatherIcon('${weather.weatherIcon}')
                          : Container(),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    weather != null
                        ? '${(weather.weatherDescription)}'
                            .capitalizeFirstLetter()
                        : '',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                  Spacer(),
                  Text(
                    weather != null
                        ? '${weather.temperature}'[0] +
                            '${weather.temperature}'[1] +
                            ' ℃'
                        : '',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              );
            }),
          )
        ],
      ),
    );
  }
}
