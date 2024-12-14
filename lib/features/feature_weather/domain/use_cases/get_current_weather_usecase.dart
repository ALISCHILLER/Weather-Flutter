import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'package:weather_flutter/core/usecase/use_case.dart';
import 'package:weather_flutter/features/feature_weather/domain/repository/weather_repository.dart';
import '../../../../core/resources/data_state.dart';
import '../entites/cureent_city_entity.dart';

/// [GetCurrentWeatherUseCase] یک کلاس برای دریافت وضعیت آب و هوای فعلی.
/// این کلاس از [UseCase] ارث‌بری کرده و عملیات اصلی را انجام می‌دهد.
class GetCurrentWeatherUseCase
    extends UseCase<DataState<CurrentCityEntity>, String> {

  /// ریپازیتوری که برای دریافت داده‌های آب و هوا استفاده می‌شود.
  final WeatherRepository weatherRepository;

  /// Logger برای ثبت لاگ‌ها.
  final Logger logger = Logger();

  /// سازنده‌ای که ریپازیتوری [WeatherRepository] را مقداردهی می‌کند.
  GetCurrentWeatherUseCase(this.weatherRepository);

  /// متدی که برای دریافت وضعیت آب و هوای فعلی بر اساس نام شهر فراخوانی می‌شود.
  ///
  /// - [cityName]: نام شهری که وضعیت آب و هوای آن باید دریافت شود.
  /// - بازگشت: یک [DataState] که داده‌های وضعیت آب و هوای فعلی را شامل می‌شود.
  @override
  Future<DataState<CurrentCityEntity>> call(String cityName) async {
    try {
      // ثبت درخواست برای دریافت وضعیت آب و هوا
      logger.i('Fetching weather data for city: $cityName');

      // فراخوانی متد fetchCurrentWeatherData برای دریافت داده‌های وضعیت آب و هوا.
      final result = await weatherRepository.fetchCurrentWeatherData(cityName);

      // ثبت موفقیت در دریافت داده‌ها
      logger.i('Successfully fetched weather data for city: $cityName');
      return result;
    } catch (e) {
      // مدیریت خطا و ارسال آن به متد onError.
      logger.e('Error occurred while fetching weather data for city: $cityName', error: e);

      if (e is Exception) {
        await onError(e);
      } else {
        await onError(Exception('Unknown error occurred'));
      }

      // پرتاب مجدد خطا به بیرون برای مدیریت بیشتر در جاهای دیگر
      rethrow;
    }
  }

  /// متدی برای مدیریت خطاهایی که در حین اجرای عملیات رخ می‌دهند.
  @override
  Future<void> onError(Exception e) async {
    // بررسی نوع خطا و مدیریت آن
    if (e is DioException) {
      // مدیریت خطاهای Dio (مثلاً مشکلات شبکه)
      logger.w('Dio Error: ${e.message}');
      if (e.response != null) {
        logger.w('Response Data: ${e.response!.data}');
      } else {
        logger.w('No response received from server.');
      }
    } else {
      // مدیریت خطاهای عمومی
      logger.e('General Error: ${e.toString()}');
    }

    // پرتاب یک استثنای عمومی برای اعلام شکست عملیات
    throw WeatherFetchException('Failed to fetch weather data.');
  }
}

/// [WeatherFetchException] یک استثنای سفارشی برای مدیریت خطاهای دریافت داده‌های آب و هوا.
class WeatherFetchException implements Exception {
  final String message;

  WeatherFetchException(this.message);

  @override
  String toString() => message;
}
