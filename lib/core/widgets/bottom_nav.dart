import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bottom_icon_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bottom_icon_cubit.dart';

class BottomNav extends StatelessWidget {
  // کنترلر صفحات برای تغییر صفحه‌ها
  final PageController controller;

  // سازنده ویجت با کنترلر الزامی
  BottomNav({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // رنگ اصلی برنامه را از تم دریافت می‌کند
    var primaryColor = Colors.blue;

    // متغیر برای دسترسی به Cubit مربوط به مدیریت وضعیت آیکون‌ها
    var cubit = BlocProvider.of<BottomIconCubit>(context);

    // وضعیت فعلی آیکون انتخاب‌شده (0 برای Home، 1 برای Bookmark)
    var state = cubit.state;

    return BottomAppBar(
      // تنظیم شکل نوار پایینی (دارای بخش بریده‌شده)
      shape: const CircularNotchedRectangle(),
      // فاصله برش از لبه نوار
      notchMargin: 5,
      // رنگ پس‌زمینه نوار
      color: primaryColor,
      child: SizedBox(
        height: 63, // ارتفاع نوار پایینی
        child: Row(
          // تنظیم آیکون‌ها در وسط نوار
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // دکمه آیکون Home
            _buildNavItem(
              context,
              icon: state == 0 ? Icons.home : Icons.home_outlined,
              selected: state == 0,
              onTap: () {
                // تغییر وضعیت به Home (انتخاب آیکون اول)
                cubit.gotoHome();
                // تغییر صفحه به صفحه اول با انیمیشن
                controller.animateToPage(
                  0, // شماره صفحه
                  duration: const Duration(milliseconds: 300), // مدت‌زمان انیمیشن
                  curve: Curves.easeInOut, // نوع حرکت انیمیشن
                );
              },
            ),
            // فضای خالی بین دو دکمه
            const SizedBox(width: 100), // فاصله کمی بین دو آیکون
            // دکمه آیکون Bookmark
            _buildNavItem(
              context,
              icon: state == 1 ? Icons.bookmark : Icons.bookmark_border_rounded,
              selected: state == 1,
              onTap: () {
                // تغییر وضعیت به Bookmark (انتخاب آیکون دوم)
                cubit.gotoBookMark();
                // تغییر صفحه به صفحه دوم با انیمیشن
                controller.animateToPage(
                  1, // شماره صفحه
                  duration: const Duration(milliseconds: 300), // مدت‌زمان انیمیشن
                  curve: Curves.easeInOut, // نوع حرکت انیمیشن
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ویجت سفارشی برای هر آیکون در نوار پایین
  Widget _buildNavItem(BuildContext context, {required IconData icon, required bool selected, required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        // تغییر سایز آیکون در حالت انتخاب
        width: selected ? 70 : 50,
        height: selected ? 70 : 50,
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent, // تغییر رنگ پس‌زمینه در حالت انتخاب
          borderRadius: BorderRadius.circular(50), // گرد کردن گوشه‌ها
          boxShadow: selected
              ? [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))]
              : [],
        ),
        child: Icon(
          icon,
          size: 30, // سایز آیکون
          color: selected ? Colors.blue : Colors.white, // تغییر رنگ آیکون در حالت انتخاب
        ),
      ),
    );
  }
}

