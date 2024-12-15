import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:weather_flutter/core/resources/data_state.dart';
import 'package:weather_flutter/core/usecase/use_case.dart';
import 'package:weather_flutter/features/feature_weather/domain/entites/city_info_entity.dart';

import '../repository/weather_repository.dart';

/// کلاس GetSearchCityCase که برای جستجوی اطلاعات شهری استفاده می‌شود.
/// این کلاس از UseCase ارث‌بری می‌کند که داده‌ها را از ریپازیتوری دریافت می‌کند.
class GetSearchCityCase extends UseCase<DataState<CityInfoEntity>, String> {
  /// ریپازیتوری که مسئول جستجو و دریافت اطلاعات از منبع داده است (API یا دیتابیس).
  final WeatherRepository weatherRepository;

  /// Logger برای ثبت لاگ‌ها، نمایش اطلاعات و خطاها.
  final Logger logger = Logger();

  // سازنده برای دریافت وابستگی‌ها.
  GetSearchCityCase(this.weatherRepository);

  /// متد call برای جستجوی اطلاعات شهری با استفاده از پارامتر [params] (نام شهر).
  @override
  Future<DataState<CityInfoEntity>> call(String params) async {
    try {
      // ثبت درخواست جستجو در لاگ.
      logger.i('Searching City Info for: $params');

      // ارسال درخواست به ریپازیتوری برای دریافت اطلاعات شهری.
      final result = await weatherRepository.searchCities(params);

      // ثبت موفقیت‌آمیز دریافت اطلاعات در لاگ.
      logger.i('Successfully fetched City Info for: ${result.data}');
      return result;
    } catch (e) {
      // در صورت بروز خطا، ثبت آن در لاگ.
      logger.e('Error occurred while fetching City Info', error: e);

      // مدیریت خطا و ارسال آن به متد [onError].
      if (e is Exception) {
        await onError(e);
      } else {
        await onError(Exception('Unknown error occurred'));
      }

      // پرتاب مجدد خطا برای مدیریت بیشتر در جاهای دیگر.
      rethrow;
    }
  }

  /// متد onError برای مدیریت و ثبت خطاها.
  @override
  Future<void> onError(Exception e) {
    // بررسی نوع خطا و مدیریت آن.
    if (e is DioException) {
      // لاگ‌گذاری خطاهای Dio (مثلاً مشکلات شبکه یا سرور).
      logger.w('Dio Error: ${e.message}');
      if (e.response != null) {
        // اگر پاسخی از سرور دریافت شده باشد، آن را در لاگ ثبت می‌کنیم.
        logger.w('Response Data: ${e.response!.data}');
      } else {
        // اگر پاسخی از سرور دریافت نشد.
        logger.w('No response received from the server.');
      }
    } else {
      // لاگ‌گذاری خطاهای عمومی که نوع آن‌ها مشخص نیست.
      logger.w('General Error: ${e.toString()}');
    }

    // پرتاب استثنای عمومی برای اعلام شکست عملیات.
    throw FetchException('Failed to fetch weather data.');
  }
}

/// کلاس استثنای مربوط به شکست در دریافت داده‌های .
class FetchException implements Exception {
  final String message;

  // سازنده برای دریافت پیام خطا.
  FetchException(this.message);

  @override
  String toString() => message;
}
