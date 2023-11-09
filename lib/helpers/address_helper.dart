import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../config/api_config.dart';
import '../../consts/app_consts.dart';
import '../../models/weather_model.dart';

class AddressHelper extends ChangeNotifier {
  final List<WeatherData> _weatherDatas = [];
  List<WeatherData> get weatherDatas => _weatherDatas;

  String _country = '';
  get country => _country;

  getLiveCoordinates() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) kDebugMode;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      _country = placemarks[0].country!;
      await getCurrentWeather(position.latitude, position.longitude);
    }

    if (permission == LocationPermission.denied) kDebugMode;

    if (permission == LocationPermission.deniedForever) kDebugMode;
  }

  getCurrentWeather(latitude, longitude) async {
    final dio = Dio();
    Response response = await dio.get(
        '${AppConfig.currentWeatherApi}?units=metric&lat=$latitude&lon=$longitude&appid=${AppConsts.apiKey}');

    _weatherDatas.clear();

    if (response.statusCode == 200) {
      final List<WeatherData> filteredWeatherData = [];
      final Set<String> uniqueDates = {};
      for (var weather in response.data['list']) {
        final weatherData = WeatherData.fromJson(weather);

        final forecastDate = DateTime.parse(weatherData.dtTxt);

        final formattedDate =
            '${forecastDate.year}-${forecastDate.month}-${forecastDate.day}';

        if (!uniqueDates.contains(formattedDate)) {
          filteredWeatherData.add(weatherData);
          uniqueDates.add(formattedDate);
        }
      }

      _weatherDatas.addAll(filteredWeatherData);

      notifyListeners();
    }
  }
}
