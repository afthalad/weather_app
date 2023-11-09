// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../routes/app_routes.dart';
import '../../widgets/widgets.dart';
import '../../helpers/address_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    inistate();
    super.initState();
  }

  inistate() async {
    await context.read<AddressHelper>().getLiveCoordinates();
    // Navigator.pushReplacementNamed(context, AppRoutes.mainScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(fit: BoxFit.fill, 'assets/images/ani.gif'),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 55.h,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'WeatherWise🌤️',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Navigating Your Day with Confidence through the Ever-changing Skies',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        AppRoutes.mainScreen,
                      );
                    },
                    child: GlassContainer(
                      height: 7.h,
                      child: Center(
                        child: Text(
                          "GET START",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 12.sp),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
