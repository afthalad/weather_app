// ignore_for_file: must_be_immutable

import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../../widgets/widgets.dart';
import '../../utils/color_util.dart';
import '../../routes/app_routes.dart';
import '../../models/weather_model.dart';
import '../../helpers/address_helper.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String lastUpdateDateTime =
      "Update as of ${DateFormat('MM-dd-yyyy hh:mm a').format(DateTime.now())}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CommonAppBar(
          title: context.watch<AddressHelper>().country,
          leadingIcon: Icons.location_on,
          trailingIcon: Icons.keyboard_arrow_right_outlined,
          trailingIconOnTap: () {
            Navigator.pushNamed(context, AppRoutes.countriesScreen);
          },
        ),
        _buildTodayDateStatus(context),
        _buildTodayTemprature(),
        _buildWeatherProperties(),
        SizedBox(height: 10.h),
        _build4DaysWeather(),
      ],
    );
  }

  Widget _buildDegreeTextWidget(
    value,
    bool? isDay,
    double? fontSize,
    double? oSize,
    double? cSize,
  ) {
    return Wrap(
      children: [
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: fontSize, fontWeight: FontWeight.normal),
        ),
        const Text(
          '  ',
          style: TextStyle(
            color: ColorUtils.whiteColor,
            fontWeight: FontWeight.bold,
            fontFeatures: [FontFeature.subscripts()],
          ),
        ),
        Text(
          'o',
          style: TextStyle(
            color: ColorUtils.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: oSize,
            fontFeatures: const [FontFeature.subscripts()],
          ),
        ),
        Text(
          'c',
          style: TextStyle(
            color: ColorUtils.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: cSize,
            fontFeatures: const [FontFeature.subscripts()],
          ),
        ),
      ],
    );
  }

  Widget _buildBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(
            "assets/images/bg.png",
          ),
        ),
      ),
    );
  }

  Widget _buildDatWeatherStatsWidget(
      dayIndex, imageIndex, tempIndex, windSpeed) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 1.sp,
        ),
        Text(
          DateFormat('E').format(DateTime.parse(
              context.watch<AddressHelper>().weatherDatas[dayIndex].dtTxt)),
          style: const TextStyle(
            color: ColorUtils.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Image(
          image: NetworkImage(
            "https://openweathermap.org/img/w/${context.watch<AddressHelper>().weatherDatas[imageIndex].weather[0].icon}.png",
          ),
        ),
        _buildDegreeTextWidget(
          context
              .watch<AddressHelper>()
              .weatherDatas[tempIndex]
              .main
              .temp
              .toStringAsFixed(0),
          false,
          20,
          10.sp,
          13.sp,
        ),
        Text(
          context
              .watch<AddressHelper>()
              .weatherDatas[windSpeed]
              .wind
              .speed
              .toString(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(
          "Km/h",
          style: Theme.of(context).textTheme.titleSmall!.copyWith(height: 0.5),
        ),
        SizedBox(
          height: 1.sp,
        )
      ],
    );
  }

  Widget _buildTodayDateStatus(BuildContext context) {
    return ListTile(
      title: Center(
        child: Text(
          DateFormat('MMM dd').format(DateTime.now()),
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      subtitle: Center(
        child: Column(
          children: [
            Text(
              lastUpdateDateTime,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              "It feels like ${context.watch<AddressHelper>().weatherDatas[0].weather[0].description}",
              style: Theme.of(context).textTheme.titleSmall,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTodayTemprature() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image(
          fit: BoxFit.cover,
          image: NetworkImage(
            "https://openweathermap.org/img/wn/${context.watch<AddressHelper>().weatherDatas[0].weather[0].icon}@2x.png",
          ),
        ),
        _buildDegreeTextWidget(
          context.watch<AddressHelper>().weatherDatas[0].main.temp.toString(),
          false,
          41.sp,
          13.sp,
          20.sp,
        ),
      ],
    );
  }

  Widget _buildWeatherProperties() {
    WeatherData weather = context.watch<AddressHelper>().weatherDatas[0];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        WeatherProperty(
          icon: Icons.water_drop,
          property: "HUMIDITY",
          percentage: weather.main.humidity.toDouble(),
        ),
        WeatherProperty(
          icon: Icons.air,
          property: "WIND",
          percentage: weather.wind.speed.toDouble(),
        ),
        WeatherProperty(
          icon: Icons.device_thermostat,
          property: "FEELS LIKE",
          percentage: weather.main.feelsLike,
        ),
      ],
    );
  }

  Widget _build4DaysWeather() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GlassmorphicContainer(
        width: 94.w,
        height: 27.h,
        borderRadius: 20,
        blur: 20,
        alignment: Alignment.bottomCenter,
        border: 2,
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFffffff).withOpacity(0.1),
              const Color(0xFFFFFFFF).withOpacity(0.05),
            ],
            stops: const [
              0.1,
              1,
            ]),
        borderGradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.transparent,
            Colors.transparent,
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildDatWeatherStatsWidget(1, 0, 1, 1),
            _buildDatWeatherStatsWidget(2, 1, 2, 2),
            _buildDatWeatherStatsWidget(3, 2, 3, 3),
            _buildDatWeatherStatsWidget(4, 3, 4, 4),
          ],
        ),
      ),
    );
  }
}
