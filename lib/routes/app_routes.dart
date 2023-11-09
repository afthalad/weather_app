import '../views/main_screen.dart';
import '../views/splash_screen.dart';
import '../views/countries_weather_screen.dart';

class AppRoutes {
  static const mainScreen = 'main_screen';
  static const splashScreen = 'splash_screen';
  static const countriesScreen = 'countries_weather_screen';

  static final routes = {
    mainScreen: (context) => const MainScreen(),
    splashScreen: (context) => const SplashScreen(),
    countriesScreen: (context) => const CountriesScreen(),
  };
}
