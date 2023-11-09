import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../routes/app_routes.dart';
import '../../utils/color_util.dart';
import '../../widgets/widgets.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
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

  Widget _buildBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            "https://images.unsplash.com/photo-1613820070607-ef1d3ccc07f9?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CommonAppBar(
            title: "Search location",
            trailingIcon: Icons.search,
            trailingIconOnTap: () {
              Navigator.pushNamed(context, AppRoutes.countriesScreen);
            },
          ),
          _buildLocationsWeather("Paris", "Clear", 25),
          SizedBox(height: 3.h),
          _buildLocationsWeather("Srilanka", "Rainy", 18),
          SizedBox(height: 3.h),
          _buildLocationsWeather('Colombia', "Sunny", 28),
          SizedBox(height: 3.h),
          _buildAddNewButton(context)
        ],
      ),
    );
  }

  Widget _buildLocationsWeather(city, weather, temp) {
    return GlassContainer(
      height: 20.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ListTile(
            title: Text(
              city,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 20.sp,
                  ),
            ),
            subtitle: Text(
              weather,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 13.sp,
                  ),
            ),
            trailing: Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: const Image(
                image: NetworkImage(
                  "https://img.icons8.com/?id=ESeqfDjC5eVO&format=png",
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Humidity 54%",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 11.sp),
            ),
            subtitle: Text(
              "Wind 4.3 km/h",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 11.sp),
            ),
            trailing: _buildDegreeTextWidget(
              temp.toString(),
              false,
              30.sp,
              10.sp,
              13.sp,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAddNewButton(BuildContext context) {
    return GlassContainer(
        height: 7.h,
        child: TextButton.icon(
          onPressed: () {},
          icon: const Icon(
            Icons.add_circle_outline_rounded,
            color: Colors.white,
          ),
          label: Text(
            "Add new",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 12.sp),
          ),
        ));
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
}
