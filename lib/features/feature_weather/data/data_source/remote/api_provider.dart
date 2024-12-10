import 'package:ansicolor/ansicolor.dart';
import 'package:dio/dio.dart';
import 'package:weather_flutter/core/utils/constants.dart';
import 'package:weather_flutter/features/feature_weather/data/models/forcast_prams.dart';

class ApiProvider {
  // ایجاد یک نمونه از Dio برای مدیریت درخواست‌های HTTP
  final Dio _dio = Dio();

  // کلید API که از فایل Constants دریافت می‌شود
  var apikey = Constants.apikey;

  /// متد برای فراخوانی API وضعیت آب و هوای فعلی
  /// [cityName] نام شهری که اطلاعات وضعیت آب و هوا برای آن دریافت می‌شود
  Future<Response> callCurrentWeather(String cityName) async {
    try {
      // ارسال درخواست GET به URL مشخص‌شده
      var response = await _dio.get(
        '${Constants.baseUrl}/data/2.5/weather',
        queryParameters: {
          'q': cityName, // نام شهر
          'appid': apikey, // کلید API
          'units': 'metric' // واحد اندازه‌گیری دما (سلسیوس)
        },
      );
      var pen = AnsiPen()..green();
      // چاپ داده‌های دریافتی در کنسول برای دیباگ با رنگ سبز
      print(pen('Response data: ${response.data}'));

      // بازگشت پاسخ از API
      return response;
    } catch (e) {
      // مدیریت خطاها در صورت بروز مشکل در درخواست
      var penError = AnsiPen()..red(); // رنگ قرمز برای خطا
      print(penError('API Error: $e'));

      rethrow; // پرتاب مجدد خطا به خارج از متد
    }
  }

  Future<Response> sendRequest7DayForcast(ForcastParams params) async {
    try {
      var response = await _dio
          .get('${Constants.baseUrl}/data/2.5/onecall', queryParameters: {
        'lat': params.lat,
        'lon': params.lon,
        'exclude': 'minutely,hourly',
        'appid': apikey,
        'units': 'metric'
      });

      var pen = AnsiPen()..green();
      // چاپ داده‌های دریافتی در کنسول برای دیباگ با رنگ سبز
      print(pen('Response data: ${response.data}'));

      // بازگشت پاسخ از API
      return response;
    } catch (e) {
      // مدیریت خطاها در صورت بروز مشکل در درخواست
      var penError = AnsiPen()..red(); // رنگ قرمز برای خطا
      print(penError('API Error: $e'));

      rethrow; // پرتاب مجدد خطا به خارج از متد
    }
  }
}
