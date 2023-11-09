import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:weather_app/helpers/address_helper.dart';
import 'package:weather_app/routes/app_routes.dart';
import 'package:weather_app/utils/theme_utils.dart';
import 'package:weather_app/views/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AddressHelper()),
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FWeather App - Afthal',
          theme: themeData,
          home: const SplashScreen(),
          routes: AppRoutes.routes,
          initialRoute: AppRoutes.splashScreen,
        );
      }),
    );
  }
}
