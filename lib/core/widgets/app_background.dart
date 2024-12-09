import 'package:flutter/material.dart';
import '../../features/feature_weather/data/models/current_city_model.dart';

/// Enum برای دسته‌بندی وضعیت‌های مختلف آب‌وهوا
enum WeatherCondition {
  clearSky,       // آسمان صاف
  fewClouds,      // ابرهای پراکنده
  clouds,         // ابری
  thunderstorm,   // طوفان و رعد و برق
  drizzle,        // باران نم‌نم
  rain,           // باران
  snow,           // برف
  windy,          // باد
  haze,          // مه
  unknown         // وضعیت ناشناخته
}

class AppBackground {
  /// متد خصوصی برای دریافت ساعت فعلی از سیستم
  ///
  /// بازگشت: ساعت فعلی به صورت عدد صحیح بین 0 تا 23
  static int _getCurrentHour() {
    return DateTime.now().hour; // دریافت ساعت فعلی از سیستم
  }

  /// متد برای تعیین تصویر پس‌زمینه بر اساس ساعت فعلی
  ///
  /// بازگشت: یک تصویر پس‌زمینه مناسب برای روز یا شب
  static AssetImage getBackgroundImage() {
    int currentHour = _getCurrentHour(); // دریافت ساعت فعلی

    // تعیین تصویر پس‌زمینه بر اساس ساعت
    return currentHour >= 6 && currentHour < 18
        ? const AssetImage('assets/images/morrning_bg.jpg') // پس‌زمینه روز
        : const AssetImage('assets/images/nightpic.jpg');   // پس‌زمینه شب
  }

  /// متد برای تبدیل توضیحات آب‌وهوا به یک وضعیت Enum
  ///
  /// [description] توضیحات آب‌وهوا که معمولاً از API دریافت می‌شود
  /// بازگشت: یک وضعیت از نوع WeatherCondition
  static WeatherCondition getWeatherCondition(String description) {
    // بررسی توضیحات و تعیین وضعیت
    if (description == "clear sky") return WeatherCondition.clearSky;
    if (description == "few clouds") return WeatherCondition.fewClouds;
    if (description.contains("clouds")) return WeatherCondition.clouds;
    if (description.contains("thunderstorm")) return WeatherCondition.thunderstorm;
    if (description.contains("drizzle")) return WeatherCondition.drizzle;
    if (description.contains("rain")) return WeatherCondition.rain;
    if (description.contains("snow")) return WeatherCondition.snow;
    if (description.contains("windy")) return WeatherCondition.windy;
    if (description.contains("haze")) return WeatherCondition.windy;

    return WeatherCondition.unknown; // وضعیت ناشناخته
  }

  /// متد برای دریافت آیکون مناسب بر اساس وضعیت آب‌وهوا
  ///
  /// [condition] وضعیت آب‌وهوا از نوع WeatherCondition
  /// [height] ارتفاع آیکون مورد نظر، مقدار پیش‌فرض: 50.0
  /// بازگشت: یک ویجت Image شامل آیکون مناسب
  static Image getWeatherIcon(WeatherCondition condition, [double height = 50.0]) {
    // Map برای نگهداری مسیر آیکون‌ها بر اساس وضعیت آب‌وهوا
    const Map<WeatherCondition, String> iconMap = {
      WeatherCondition.clearSky: 'assets/images/icons8-sun-96.png',
      WeatherCondition.fewClouds: 'assets/images/icons8-partly-cloudy-day-80.png',
      WeatherCondition.clouds: 'assets/images/icons8-clouds-80.png',
      WeatherCondition.thunderstorm: 'assets/images/icons8-storm-80.png',
      WeatherCondition.drizzle: 'assets/images/icons8-rain-cloud-80.png',
      WeatherCondition.rain: 'assets/images/icons8-heavy-rain-80.png',
      WeatherCondition.snow: 'assets/images/icons8-snow-80.png',
      WeatherCondition.windy: 'assets/images/icons8-windy-weather-80.png',
    };

    // مسیر آیکون پیش‌فرض برای وضعیت ناشناخته
    const String defaultIconPath = 'assets/images/icons8-windy-weather-80.png';

    // دریافت مسیر آیکون بر اساس وضعیت
    String iconPath = iconMap[condition] ?? defaultIconPath;

    return Image.asset(iconPath, height: height); // ایجاد ویجت Image
  }

  /// متد برای دریافت آیکون آب‌وهوا از طریق URL
  ///
  /// [weather] مدل شامل اطلاعات آب‌وهوا
  /// بازگشت: ویجت Image برای نمایش آیکون
  static Image getWeatherIconUrl(Weather weather) {
    return Image.network(
      setWeatherIconUrl(weather.icon ?? ''), // ایجاد URL
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.error); // نمایش آیکون خطا در صورت بروز مشکل
      },
    );
  }

  /// متد برای تولید URL آیکون آب‌وهوا
  ///
  /// [weatherCode] کد آیکون آب‌وهوا
  /// بازگشت: URL کامل آیکون
  static String setWeatherIconUrl(String weatherCode) {
    return "https://openweathermap.org/img/wn/$weatherCode@2x.png";
  }
}
