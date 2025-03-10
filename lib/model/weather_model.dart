class WeatherData {
  final Location location;
  final Current current;
  final Forecast forecast;

  WeatherData({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      location: Location.fromJson(json['location'] ?? {}),
      current: Current.fromJson(json['current'] ?? {}),
      forecast: Forecast.fromJson(json['forecast'] ?? {}),
    );
  }
}

class Location {
  final String name;
  final String localtime;

  Location({required this.name, required this.localtime});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'] ?? "Ahmedabad", // Default value
      localtime: json['localtime'] ?? "", // Default value
    );
  }
}

class Current {
  final double tempC;
  final double windKph;
  final int humidity;
  final int cloud;
  final Condition condition;

  Current({
    required this.tempC,
    required this.windKph,
    required this.humidity,
    required this.cloud,
    required this.condition,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      tempC: (json['temp_c'] as num?)?.toDouble() ?? 0.0, // Default value
      windKph: (json['wind_kph'] as num?)?.toDouble() ?? 0.0, // Default value
      humidity: json['humidity'] ?? 0, // Default value
      cloud: json['cloud'] ?? 0, // Default value
      condition: Condition.fromJson(json['condition'] ?? {}),
    );
  }
}

class Condition {
  final String text;
  final String icon;

  Condition({required this.text, required this.icon});

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'] ?? "Unknown", // Default value
      icon: json['icon'] ?? "", // Default value
    );
  }
}

class Forecast {
  final List<ForecastDay> forecastday;

  Forecast({required this.forecastday});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    var list = json['forecastday'] as List? ?? []; // Default empty list
    List<ForecastDay> forecastList =
        list.map((i) => ForecastDay.fromJson(i)).toList();
    return Forecast(forecastday: forecastList);
  }
}

class ForecastDay {
  final String date;
  final Day day;
  final List<Hour> hour;

  ForecastDay({required this.date, required this.day, required this.hour});

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    var hourList = json['hour'] as List? ?? []; // Default empty list
    List<Hour> hours = hourList.map((i) => Hour.fromJson(i)).toList();
    return ForecastDay(
      date: json['date'] ?? "", // Default value
      day: Day.fromJson(json['day'] ?? {}),
      hour: hours,
    );
  }
}

class Day {
  final double maxtempC;
  final double mintempC;
  final double avghumidity;
  final double maxwindKph;
  final int dailyChanceOfRain;
  final Condition condition;

  Day({
    required this.maxtempC,
    required this.mintempC,
    required this.avghumidity,
    required this.maxwindKph,
    required this.dailyChanceOfRain,
    required this.condition,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      maxtempC: (json['maxtemp_c'] as num?)?.toDouble() ?? 0.0, // Default value
      mintempC: (json['mintemp_c'] as num?)?.toDouble() ?? 0.0, // Default value
      avghumidity:
          (json['avghumidity'] as num?)?.toDouble() ?? 0.0, // Default value
      maxwindKph:
          (json['maxwind_kph'] as num?)?.toDouble() ?? 0.0, // Default value
      dailyChanceOfRain: json['daily_chance_of_rain'] ?? 0, // Default value
      condition: Condition.fromJson(json['condition'] ?? {}),
    );
  }
}

class Hour {
  final String time;
  final double tempC;
  final Condition condition;

  Hour({required this.time, required this.tempC, required this.condition});

  factory Hour.fromJson(Map<String, dynamic> json) {
    return Hour(
      time: json['time'] ?? "", // Default value
      tempC: (json['temp_c'] as num?)?.toDouble() ?? 0.0, // Default value
      condition: Condition.fromJson(json['condition'] ?? {}),
    );
  }
}
