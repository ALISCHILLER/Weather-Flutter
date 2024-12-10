import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:weather_flutter/core/usecase/use_case.dart';
import 'package:weather_flutter/features/feature_weather/data/models/forcast_prams.dart';
import 'package:weather_flutter/features/feature_weather/domain/entites/forcast_day_entites.dart';
import '../../../../core/resources/data_state.dart';
import '../repository/weather_repository.dart';

/// [GetForecastDayUseCase] یک کلاس مورد استفاده برای دریافت داده‌های پیش‌بینی آب و هوا.
/// این کلاس از [UseCase] ارث‌بری می‌کند تا معماری لایه‌ای و تست‌پذیری را تضمین کند.
class GetForecastDayUseCase
    extends UseCase<DataState<ForecastDaysEntity>, ForcastParams> {
  /// ریپازیتوری که داده‌ها را از منبع داده (API یا دیتابیس) دریافت می‌کند.
  final WeatherRepository weatherRepository;

  /// Logger برای مدیریت لاگ‌ها.
  final Logger logger = Logger(
    filter: CustomLogFilter(), // نمایش لاگ‌های warning و بالاتر
    printer: PrettyPrinter(), // قالب‌بندی لاگ‌ها برای خوانایی بهتر
  );

  /// سازنده که ریپازیتوری [WeatherRepository] را برای عملیات فراهم می‌کند.
  GetForecastDayUseCase(this.weatherRepository);

  /// این متد داده‌های مربوط به پیش‌بینی آب و هوا را با استفاده از [params] از ریپازیتوری دریافت می‌کند.
  @override
  Future<DataState<ForecastDaysEntity>> call(ForcastParams params) async {
    try {
      // فراخوانی ریپازیتوری برای دریافت داده‌های پیش‌بینی آب و هوا.
      return await weatherRepository.fetchForcastWeatherData(params);
    } catch (e) {
      // مدیریت خطا و ارسال آن به متد [onError].
      if (e is Exception) {
        await onError(e);
      } else {
        await onError(Exception('Unknown error occurred'));
      }
      // پرتاب مجدد خطا به بیرون از متد.
      rethrow;
    }
  }

  /// مدیریت خطاهایی که در متد [call] رخ می‌دهند.
  @override
  Future<void> onError(Exception e) async {
    if (e is DioException) {
      // لاگ‌گذاری خطاهای Dio با سطح warning
      logger.w('Dio Error: ${e.message}');
      if (e.response != null) {
        logger.w('Response Data: ${e.response!.data}');
      } else {
        logger.w('No response received from the server.');
      }
    } else {
      // لاگ‌گذاری خطاهای عمومی با سطح warning
      logger.w('General Error: ${e.toString()}');
    }

    // پرتاب یک استثنای عمومی برای نمایش پیام خطا.
    throw WeatherFetchException('Failed to fetch weather data.');
  }
}

/// یک کلاس سفارشی برای مدیریت خطاهای خاص دریافت داده‌های پیش‌بینی آب و هوا.
class WeatherFetchException implements Exception {
  final String message;

  WeatherFetchException(this.message);

  @override
  String toString() => message;
}

/// فیلتر سفارشی برای نمایش لاگ‌های بالاتر از Level.warning
class CustomLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    // نمایش لاگ‌ها از سطح warning و بالاتر
    return event.level.index >= Level.warning.index;
  }
}
