import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

/// این ویجت به عنوان انیمیشن بارگذاری نقطه‌ای استفاده می‌شود.
/// به شما این امکان را می‌دهد که اندازه و رنگ انیمیشن را به دلخواه تغییر دهید.
class DotLoadingWidget extends StatelessWidget {
  /// پارامترهای قابل تنظیم برای سفارشی‌سازی انیمیشن
  final double size;
  final Color color;

  /// سازنده کلاس با پارامترهای اندازه و رنگ پیش‌فرض
  const DotLoadingWidget({
    Key? key,
    this.size = 50.0, // اندازه پیش‌فرض انیمیشن
    this.color = Colors.white, // رنگ پیش‌فرض انیمیشن
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // استفاده از ویجت انیمیشن بارگذاری با شکل مثلثی برای نمایش بارگذاری
    return Center(
      // قرار دادن انیمیشن در مرکز صفحه
      child: LoadingAnimationWidget.halfTriangleDot(
        size: size, // استفاده از اندازه ورودی
        color: color, // استفاده از رنگ ورودی
      ),
    );
  }
}
