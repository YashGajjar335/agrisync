import 'package:agrisync/model/weather_model.dart';
import 'package:agrisync/screens/weather/weather_items.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';

class WeatherDetailPage extends StatefulWidget {
  final List<ForecastDay> dailyForecastWeather;

  const WeatherDetailPage({super.key, required this.dailyForecastWeather});

  @override
  WeatherDetailPageState createState() => WeatherDetailPageState();
}

class WeatherDetailPageState extends State<WeatherDetailPage> {
  String _getWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  String _getMonth(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Map getForecastWeather(int index) {
      int maxWindSpeed =
          widget.dailyForecastWeather[index].day.maxwindKph.toInt();
      int avgHumidity =
          widget.dailyForecastWeather[index].day.avghumidity.toInt();
      int chanceOfRain =
          widget.dailyForecastWeather[index].day.dailyChanceOfRain;

      var parsedDate = DateTime.parse(widget.dailyForecastWeather[index].date);
      String forecastDate =
          "${_getWeekday(parsedDate.weekday)}, ${parsedDate.day} ${_getMonth(parsedDate.month)}";

      String weatherName =
          widget.dailyForecastWeather[index].day.condition.text;
      String weatherIcon =
          "https:${widget.dailyForecastWeather[index].day.condition.icon}";

      int minTemperature =
          widget.dailyForecastWeather[index].day.mintempC.toInt();
      int maxTemperature =
          widget.dailyForecastWeather[index].day.maxtempC.toInt();

      var forecastData = {
        'maxWindSpeed': maxWindSpeed,
        'avgHumidity': avgHumidity,
        'chanceOfRain': chanceOfRain,
        'forecastDate': forecastDate,
        'weatherName': weatherName,
        'weatherIcon': weatherIcon,
        'minTemperature': minTemperature,
        'maxTemperature': maxTemperature
      };
      return forecastData;
    }

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const AgriSyncIcon(
          title: "Forecast",
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: size.height * .75,
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -50,
                    right: 20,
                    left: 20,
                    child: Container(
                      height: 300,
                      width: size.width * .7,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.center,
                          colors: [
                            Color(0xffa9c1f5),
                            Color(0xff6696f5),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(.1),
                            offset: const Offset(0, 25),
                            blurRadius: 3,
                            spreadRadius: -10,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            width: 150,
                            child: Image.network(
                              getForecastWeather(0)["weatherIcon"],
                              width: 30,
                              errorBuilder: (context, error, stackTrace) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(left: 12, top: 12),
                                  child: Image.asset('assets/clear.png',
                                      fit: BoxFit.cover),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            top: 150,
                            left: 30,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: TextLato(
                                text: getForecastWeather(0)["weatherName"],
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Container(
                              width: size.width * .8,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherItem(
                                    value: getForecastWeather(0)["maxWindSpeed"]
                                        .toString(),
                                    unit: "km/h",
                                    imageUrl: "assets/windspeed.png",
                                  ),
                                  WeatherItem(
                                    value: getForecastWeather(0)["avgHumidity"]
                                        .toString(),
                                    unit: "%",
                                    imageUrl: "assets/humidity.png",
                                  ),
                                  WeatherItem(
                                    value: getForecastWeather(0)["chanceOfRain"]
                                        .toString(),
                                    unit: "%",
                                    imageUrl: "assets/lightrain.png",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const TextLato(
                                  text: 'max',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextLato(
                                      text: getForecastWeather(
                                              0)["maxTemperature"]
                                          .toString(),
                                      fontSize: 80,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const TextLato(
                                      text: '°',
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 320,
                            left: 0,
                            child: SizedBox(
                              height: 400,
                              width: size.width * .9,
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  Card(
                                    elevation: 3.0,
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              TextLato(
                                                text: getForecastWeather(
                                                        0)["forecastDate"]
                                                    .toString(),
                                                color: const Color(0xff6696f5),
                                                fontWeight: FontWeight.w600,
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      const TextLato(
                                                        text: 'min ',
                                                        color: greyColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                      TextLato(
                                                        text: getForecastWeather(
                                                                    0)[
                                                                "minTemperature"]
                                                            .toString(),
                                                        color: greyColor,
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      const TextLato(
                                                        text: '°',
                                                        color: greyColor,
                                                        fontSize: 35,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFeatures: [
                                                          FontFeature.enable(
                                                              'sups')
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const TextLato(
                                                        text: 'max ',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      TextLato(
                                                        text: getForecastWeather(
                                                                    0)[
                                                                "maxTemperature"]
                                                            .toString(),
                                                        color: blackColor,
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      const TextLato(
                                                        text: '°',
                                                        color: blackColor,
                                                        fontSize: 35,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFeatures: [
                                                          FontFeature.enable(
                                                              'sups')
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.network(
                                                    getForecastWeather(
                                                        0)["weatherIcon"],
                                                    width: 30,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                        'assets/cloud.png',
                                                        width: 30,
                                                        fit: BoxFit.cover,
                                                      );
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  TextLato(
                                                    text: getForecastWeather(
                                                        0)["weatherName"],
                                                    fontSize: 16,
                                                    color: Colors.grey,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextLato(
                                                    text:
                                                        "${getForecastWeather(0)["chanceOfRain"]}%",
                                                    fontSize: 18,
                                                    color: Colors.grey,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Image.asset(
                                                    'assets/lightrain.png',
                                                    width: 30,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 3.0,
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              TextLato(
                                                text: getForecastWeather(
                                                        1)["forecastDate"]
                                                    .toString(),
                                                color: const Color(0xff6696f5),
                                                fontWeight: FontWeight.w600,
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      const TextLato(
                                                        text: 'min ',
                                                        color: greyColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                      TextLato(
                                                        text: getForecastWeather(
                                                                    1)[
                                                                "minTemperature"]
                                                            .toString(),
                                                        color: greyColor,
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      const TextLato(
                                                        text: '°',
                                                        color: greyColor,
                                                        fontSize: 35,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFeatures: [
                                                          FontFeature.enable(
                                                              'sups')
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const TextLato(
                                                        text: 'max ',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      TextLato(
                                                        text: getForecastWeather(
                                                                    1)[
                                                                "maxTemperature"]
                                                            .toString(),
                                                        color: blackColor,
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      const TextLato(
                                                        text: '°',
                                                        color: blackColor,
                                                        fontSize: 35,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFeatures: [
                                                          FontFeature.enable(
                                                              'sups')
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.network(
                                                    getForecastWeather(
                                                        1)["weatherIcon"],
                                                    width: 30,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                        'assets/cloud.png',
                                                        width: 30,
                                                        fit: BoxFit.cover,
                                                      );
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  TextLato(
                                                    text: getForecastWeather(
                                                        1)["weatherName"],
                                                    fontSize: 16,
                                                    color: Colors.grey,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextLato(
                                                    text:
                                                        "${getForecastWeather(1)["chanceOfRain"]}%",
                                                    fontSize: 18,
                                                    color: Colors.grey,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Image.asset(
                                                    'assets/lightrain.png',
                                                    width: 30,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 3.0,
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              TextLato(
                                                text: getForecastWeather(
                                                        2)["forecastDate"]
                                                    .toString(),
                                                color: const Color(0xff6696f5),
                                                fontWeight: FontWeight.w600,
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      const TextLato(
                                                        text: 'min ',
                                                        color: greyColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                      TextLato(
                                                        text: getForecastWeather(
                                                                    2)[
                                                                "minTemperature"]
                                                            .toString(),
                                                        color: greyColor,
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                      const TextLato(
                                                        text: '°',
                                                        color: greyColor,
                                                        fontSize: 35,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFeatures: [
                                                          FontFeature.enable(
                                                              'sups')
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      const TextLato(
                                                        text: 'max ',
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                      TextLato(
                                                        text: getForecastWeather(
                                                                    2)[
                                                                "maxTemperature"]
                                                            .toString(),
                                                        color: blackColor,
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                      const TextLato(
                                                        text: '°',
                                                        color: blackColor,
                                                        fontSize: 35,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFeatures: [
                                                          FontFeature.enable(
                                                              'sups')
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.network(
                                                    getForecastWeather(
                                                        2)["weatherIcon"],
                                                    width: 30,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                        'assets/cloud.png',
                                                        width: 30,
                                                        fit: BoxFit.cover,
                                                      );
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  TextLato(
                                                    text: getForecastWeather(
                                                        2)["weatherName"],
                                                    fontSize: 16,
                                                    color: Colors.grey,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextLato(
                                                    text:
                                                        "${getForecastWeather(2)["chanceOfRain"]}%",
                                                    fontSize: 18,
                                                    color: Colors.grey,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Image.asset(
                                                    'assets/lightrain.png',
                                                    width: 30,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
