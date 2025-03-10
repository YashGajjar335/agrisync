import 'package:agrisync/model/weather_model.dart';
import 'package:agrisync/screens/weather/weather_detail_page.dart';
import 'package:agrisync/screens/weather/weather_items.dart';
import 'package:agrisync/services/location_service.dart';
import 'package:agrisync/services/weather_services.dart';
import 'package:agrisync/utils/globle.dart';
import 'package:agrisync/widget/agri_sync_icon.dart';
import 'package:agrisync/widget/text_lato.dart';
import 'package:flutter/material.dart';

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WeatherHomeScreenState createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  final LocationService _locationService = LocationService();
  final WeatherService _weatherService = WeatherService();
  bool _isLoading = true;
  WeatherData? _weatherData;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    String cityName = await _locationService.getCityName();
    try {
      WeatherData weatherData =
          await _weatherService.fetchWeatherData(cityName);
      setState(() {
        _weatherData = weatherData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load weather data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: primaryColor.withOpacity(0.4),
          title: AgriSyncIcon(
            title: "Weather",
            color: Colors.blue.shade900,
          )),
      body: _isLoading && _weatherData == null
          ? const Center(
              child: CircularProgressIndicator(color: primaryColor),
            )
          : SingleChildScrollView(
              child: Container(
                width: size.width,
                height: size.height,
                padding: const EdgeInsets.only(top: 40, left: 18, right: 18),
                color: primaryColor.withOpacity(.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      height: size.height * .7,
                      decoration: BoxDecoration(
                        gradient: linearGradientBlue,
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(.5),
                            spreadRadius: 6,
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/pin.png',
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Center(
                                    child: TextLato(
                                      text: _weatherData!.location.name,
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 160,
                            child: Center(
                              child: Image.network(
                                'https:${_weatherData!.current.condition.icon}',
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/cloud.png',
                                    // width: 2407,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  _weatherData!.current.tempC.toString(),
                                  style: TextStyle(
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()..shader = shader,
                                  ),
                                ),
                              ),
                              const TextLato(
                                text: '°',
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                color: secondaryColor,
                              ),
                            ],
                          ),
                          TextLato(
                            text: _weatherData!.current.condition.text,
                            color: Colors.white70,
                            fontSize: 20.0,
                          ),
                          TextLato(
                            text: _weatherData!.location.localtime,
                            color: Colors.white70,
                            fontSize: 20.0,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Divider(
                              color: Colors.white70,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                WeatherItem(
                                  value:
                                      _weatherData!.current.windKph.toString(),
                                  unit: ' km/h',
                                  imageUrl: 'assets/windspeed.png',
                                ),
                                WeatherItem(
                                  value:
                                      _weatherData!.current.humidity.toString(),
                                  unit: '%',
                                  imageUrl: 'assets/humidity.png',
                                ),
                                WeatherItem(
                                  value: _weatherData!.current.cloud.toString(),
                                  unit: '%',
                                  imageUrl: 'assets/cloud.png',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      height: size.height * .20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const TextLato(
                                text: 'Today',
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => WeatherDetailPage(
                                      dailyForecastWeather:
                                          _weatherData!.forecast.forecastday,
                                    ),
                                  ),
                                ),
                                child: TextLato(
                                  text: 'Forecast',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 110,
                            child: ListView.builder(
                              itemCount: _weatherData!
                                  .forecast.forecastday[0].hour.length,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                String currentTime =
                                    DateTime.now().toString().substring(11, 16);
                                String currentHour =
                                    currentTime.substring(0, 2);

                                String forecastTime = _weatherData!
                                    .forecast.forecastday[0].hour[index].time
                                    .substring(11, 16);
                                String forecastHour = _weatherData!
                                    .forecast.forecastday[0].hour[index].time
                                    .substring(11, 13);
                                String forecastWeatherIconUrl =
                                    'https:${_weatherData!.forecast.forecastday[0].hour[index].condition.icon}';
                                String forecastTemperature = _weatherData!
                                    .forecast.forecastday[0].hour[index].tempC
                                    .round()
                                    .toString();

                                return Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  margin: const EdgeInsets.only(right: 20),
                                  width: 65,
                                  decoration: BoxDecoration(
                                    color: currentHour == forecastHour
                                        ? Colors.white
                                        : primaryColor.withOpacity(.7),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50)),
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 4,
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                        color: primaryColor.withOpacity(.2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextLato(
                                        text: forecastTime,
                                        fontSize: 17,
                                        color: greyColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      Expanded(
                                        child: Image.network(
                                          forecastWeatherIconUrl,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextLato(
                                            text: forecastTemperature,
                                            color: greyColor,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          const TextLato(
                                            text: '°',
                                            color: greyColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17,
                                            fontFeatures: [
                                              FontFeature.enable('sups')
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
