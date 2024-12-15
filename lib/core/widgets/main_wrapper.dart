import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_flutter/core/widgets/app_background.dart';
import 'package:weather_flutter/features/feature_bookmark/presentation/screens/bookmark_screen.dart';
import 'package:weather_flutter/features/feature_weather/domain/entites/cureent_city_entity.dart';
import 'package:weather_flutter/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:weather_flutter/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:weather_flutter/features/feature_weather/presentation/screens/home_screen.dart';

import '../bloc/bottom_icon_cubit.dart';
import 'bottom_nav.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});

  // کنترلر برای مدیریت صفحات در PageView
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    // لیستی از صفحات برای نمایش در PageView
    List<Widget> pageViewWidget = [
      HomeScreen(), // صفحه اصلی
      BookMarkScreen(pageController: pageController), // صفحه نشان‌شده‌ها
    ];

    // دریافت ارتفاع دستگاه
    var height = MediaQuery.of(context).size.height;

    return BlocProvider<BottomIconCubit>(  // استفاده از BlocProvider برای دسترسی به BottomIconCubit
      create: (context) => BottomIconCubit(),  // ایجاد نمونه جدید از BottomIconCubit
      child: Scaffold(
        extendBody: true,
        // افزودن نوار ناوبری پایین
        bottomNavigationBar: BottomNav(controller: pageController),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AppBackground.getBackgroundImage(),
              fit: BoxFit.cover,  // تنظیم تصویر پس‌زمینه
            ),
          ),
          height: height, // تنظیم ارتفاع به اندازه ارتفاع دستگاه
          child: PageView(
            // تنظیم کنترلر برای مدیریت تغییر صفحات
            controller: pageController,
            // ویجت‌های نمایش داده شده در هر صفحه
            children: pageViewWidget,
          ),
        ),
      ),
    );
  }
}

