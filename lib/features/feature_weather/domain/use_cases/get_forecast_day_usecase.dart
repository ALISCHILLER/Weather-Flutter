import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:weather_flutter/core/usecase/use_case.dart';
import 'package:weather_flutter/features/feature_weather/data/models/forcast_prams.dart';
import '../../../../core/resources/data_state.dart';
import '../entites/forecast_day_entity.dart';
import '../repository/weather_repository.dart';

/// [GetForecastDayUseCase] یک کلاس برای دریافت داده‌های پیش‌بینی آب و هوا.
/// این کلاس از [UseCase] ارث‌بری می‌کند تا معماری لایه‌ای و تست‌پذیری را تضمین کند.
class GetForecastDayUseCase
    extends UseCase<DataState<ForecastDayEntity>, ForcastParams> {
  /// ریپازیتوری که داده‌ها را از منبع داده (API یا دیتابیس) دریافت می‌کند.
  final WeatherRepository weatherRepository;


  /// Logger برای ثبت لاگ‌ها.
  final Logger logger = Logger();

  /// سازنده که ریپازیتوری [WeatherRepository] را برای عملیات فراهم می‌کند.
  GetForecastDayUseCase(this.weatherRepository);

  /// این متد داده‌های پیش‌بینی آب و هوا را با استفاده از [params] از ریپازیتوری دریافت می‌کند.
  ///
  /// - [params]: پارامترهایی که برای دریافت داده‌های پیش‌بینی به ریپازیتوری ارسال می‌شود.
  /// - بازگشت: یک [DataState] که داده‌های پیش‌بینی وضعیت آب و هوا را شامل می‌شود.
  @override
  Future<DataState<ForecastDayEntity>> call(ForcastParams params) async {
    try {
      logger.i('Fetching weather forecast data for lat lon : ${params.lat} ${params.lon}');

      // فراخوانی ریپازیتوری برای دریافت داده‌های پیش‌بینی آب و هوا.
      final result = await weatherRepository.fetchForcastWeatherData(params);

      // ثبت موفقیت در دریافت داده‌ها
      logger.i('Successfully fetched forecast data for lat lon: ${result.data}');
      return result;
    } catch (e) {
      logger.e('Error occurred while fetching forecast weather data', error: e);
      // مدیریت خطا و ارسال آن به متد [onError].
      if (e is Exception) {
        await onError(e);
      } else {
        await onError(Exception('Unknown error occurred'));
      }
      // پرتاب مجدد خطا به بیرون از متد برای مدیریت بیشتر در جاهای دیگر
      rethrow;
    }
  }

  /// مدیریت خطاهایی که در متد [call] رخ می‌دهند.
  ///
  /// - [e]: استثنای رخ داده که باید مدیریت شود.
  @override
  Future<void> onError(Exception e) async {
    // بررسی نوع خطا و مدیریت آن
    if (e is DioException) {
      // لاگ‌گذاری خطاهای Dio (مثلاً مشکلات شبکه)
      logger.w('Dio Error: ${e.message}');
      if (e.response != null) {
        logger.w('Response Data: ${e.response!.data}');
      } else {
        logger.w('No response received from the server.');
      }
    } else {
      // لاگ‌گذاری خطاهای عمومی
      logger.w('General Error: ${e.toString()}');
    }

    // پرتاب یک استثنای عمومی برای اعلام شکست عملیات
    throw WeatherFetchException('Failed to fetch forecast data.');
  }
}

/// یک استثنای سفارشی برای مدیریت خطاهای دریافت داده‌های پیش‌بینی آب و هوا.
class WeatherFetchException implements Exception {
  final String message;

  WeatherFetchException(this.message);

  @override
  String toString() => message;
}

