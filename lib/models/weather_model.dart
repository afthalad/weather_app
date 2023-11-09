class WeatherData {
  int dt;
  Main main;
  List<Weather> weather;
  Wind wind;
  String dtTxt;

  WeatherData({
    required this.dt,
    required this.main,
    required this.weather,
    required this.wind,
    required this.dtTxt,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      dt: json['dt'],
      main: Main.fromJson(json['main']),
      weather:
          (json['weather'] as List).map((w) => Weather.fromJson(w)).toList(),
      wind: Wind.fromJson(json['wind']),
      dtTxt: json['dt_txt'],
    );
  }
}

class Main {
  double temp;
  double feelsLike;

  int humidity;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.humidity,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      humidity: json['humidity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temp': temp,
      'feels_like': feelsLike,
      'humidity': humidity,
    };
  }
}

class Weather {
  String main;
  String description;
  String icon;

  Weather({
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'main': main,
      'description': description,
      'icon': icon,
    };
  }
}

class Wind {
  double speed;

  Wind({
    required this.speed,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'speed': speed,
    };
  }
}
