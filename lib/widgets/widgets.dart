// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:sizer/sizer.dart';
import '../../utils/color_util.dart';

class WeatherProperty extends StatelessWidget {
  String property;
  double percentage;
  IconData icon;
  WeatherProperty({
    this.property = "Property name",
    this.percentage = 56,
    this.icon = Icons.abc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96,
      height: 50,
      child: ListTile(
        title: Center(
          child: Icon(icon, color: ColorUtils.whiteColor),
        ),
        subtitle: Column(
          children: [
            Center(
              child: Text(property,
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            Center(
              child: Text("$percentage %",
                  style: Theme.of(context).textTheme.titleMedium),
            ),
          ],
        ),
      ),
    );
  }
}

class CommonAppBar extends StatelessWidget {
  String title;
  IconData? leadingIcon;
  IconData trailingIcon;
  VoidCallback? trailingIconOnTap;
  CommonAppBar({
    super.key,
    this.title = "title",
    this.trailingIconOnTap,
    this.leadingIcon,
    this.trailingIcon = Icons.menu,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTile(
        horizontalTitleGap: leadingIcon == null ? -30 : 10,
        leading: leadingIcon == null
            ? const SizedBox()
            : Icon(
                leadingIcon,
                color: ColorUtils.whiteColor,
              ),
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontSize: 13.sp),
        ),
        trailing: InkWell(
          onTap: trailingIconOnTap,
          child: Icon(
            trailingIcon,
            color: ColorUtils.whiteColor,
          ),
        ),
      ),
    );
  }
}

class GlassContainer extends StatelessWidget {
  double? height;
  Widget? child;
  GlassContainer({
    super.key,
    this.height,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: 94.w,
      height: height ?? 0,
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
      child: child,
    );
  }
}
