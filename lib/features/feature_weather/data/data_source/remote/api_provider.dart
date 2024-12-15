import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:weather_flutter/core/utils/constants.dart';
import 'package:weather_flutter/core/widgets/logger_manager.dart';
import 'package:weather_flutter/features/feature_weather/data/models/forcast_prams.dart';

/// کلاس مدیریت ارتباطات API
/// این کلاس درخواست‌ها و پاسخ‌های API را مدیریت می‌کند،
/// لاگ‌های مربوطه را ثبت می‌کند و در صورت بروز خطا، آن‌ها را مدیریت می‌نماید.
class ApiProvider {
  // نمونه ثابت از Dio برای مدیریت درخواست‌های HTTP
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: Duration(milliseconds: 5000), // زمان اتصال (میلی‌ثانیه)
      receiveTimeout: Duration(milliseconds: 5000), // زمان دریافت پاسخ (میلی‌ثانیه)
      sendTimeout: Duration(milliseconds: 5000),    // زمان ارسال درخواست (میلی‌ثانیه)
    ),

  );

  /// Logger برای ثبت لاگ‌ها.
  final Logger logger = Logger();

  // کلید API برای احراز هویت درخواست‌ها
  final String apikey = Constants.apikey;

  /// متد ثبت لاگ برای درخواست‌های API
  /// [endpoint]: آدرس انتهایی درخواست
  /// [queryParams]: پارامترهای ارسالی به سرور
  void _logRequest(String endpoint, Map<String, dynamic>? queryParams) {
    logger.d('API Request - Endpoint: $endpoint, Params: $queryParams');
  }

  /// متد ثبت لاگ برای پاسخ‌های API
  /// [response]: پاسخ دریافتی از سرور
  void _logResponse(Response response) {
    logger.i(
        'API Response - Status: ${response.statusCode}, Data: ${response.data}');
  }

  /// متد ثبت لاگ برای خطاهای API
  /// [error]: خطای رخ داده در هنگام ارسال درخواست
  void _logError(dynamic error) {
    if (error is DioException) {
      // خطاهای خاص Dio را مدیریت می‌کند
      logger.e(
          'API Error - Message: ${error.message}, Response: ${error.response?.data}');
    } else {
      // سایر خطاها
      logger.e('Unexpected Error: $error');
    }
  }

  /// متد برای دریافت وضعیت آب و هوای فعلی
  /// [cityName]: نام شهر مورد نظر برای دریافت اطلاعات آب و هوا
  /// بازگشت: پاسخ دریافت شده از API به صورت [Response]
  Future<Response> callCurrentWeather(String cityName) async {
    const String endpoint = '/data/2.5/weather'; // مسیر API برای وضعیت فعلی هوا
    final queryParams = {
      'q': cityName, // نام شهر
      'appid': apikey, // کلید API
      'units': 'metric', // واحد اندازه‌گیری دما (سلسیوس)
    };

    // ثبت لاگ درخواست
    _logRequest(endpoint, queryParams);

    try {
      // ارسال درخواست به سرور
      final response = await _dio.get(
        '${Constants.baseUrl}$endpoint',
        queryParameters: queryParams,
      );

      // ثبت لاگ پاسخ
      _logResponse(response);

      return response;
    } catch (e) {
      // ثبت لاگ خطا
      _logError(e);
      rethrow; // پرتاب مجدد خطا برای مدیریت در سطوح بالاتر
    }
  }

  /// متد برای دریافت پیش‌بینی ۷ روزه آب و هوا
  /// [params]: پارامترهای عرض و طول جغرافیایی
  /// بازگشت: پاسخ دریافت شده از API به صورت [Response]
  Future<Response> sendRequest7DayForecast(ForcastParams params) async {
    const String endpoint =
        '/data/2.5/forecast'; // مسیر API برای پیش‌بینی ۷ روزه هوا
    final queryParams = {
      'lat': params.lat, // عرض جغرافیایی
      'lon': params.lon, // طول جغرافیایی
      'appid': apikey, // کلید API]
      'units': 'metric', // واحد اندازه‌گیری دما (سلسیوس)
    };

    // ثبت لاگ درخواست
    _logRequest(endpoint, queryParams);

    try {
      // ارسال درخواست به سرور
      final response = await _dio.get(
        '${Constants.baseUrl}$endpoint',
        queryParameters: queryParams,
      );

      // ثبت لاگ پاسخ
      _logResponse(response);

      return response;
    } catch (e) {
      // ثبت لاگ خطا
      _logError(e);
      rethrow; // پرتاب مجدد خطا برای مدیریت در سطوح بالاتر
    }
  }

  /// این تابع درخواست جستجو برای شهرها را با استفاده از query ارسال می‌کند.
  /// این درخواست به API برای دریافت لیستی از شهرها که با query وارد شده تطابق دارند ارسال می‌شود.
  Future<Response> searchCities(String query) async {
    // آدرس URL API برای جستجوی شهرها
    const String url =
        "http://geodb-free-service.wirefreethought.com/v1/geo/cities";

    // پارامترهای جستجو برای محدود کردن نتایج
    final queryParams = {'limit': 7, 'offset': 0, 'namePrefix': query};

    // ثبت لاگ برای درخواست ارسال شده
    _logRequest(url, queryParams);

    try {
      // ارسال درخواست به API با استفاده از Dio و دریافت پاسخ
      final response = await _dio.get(
        url,
        queryParameters: queryParams,
      );

      // ثبت لاگ پاسخ دریافتی
      _logResponse(response);

      return response; // بازگشت پاسخ از API
    } catch (e) {
      // در صورت بروز خطا، ثبت لاگ خطا
      _logError(e);
      rethrow; // دوباره پرتاب خطا برای مدیریت در سطح بالاتر
    }
  }
}
