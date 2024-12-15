import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:weather_flutter/core/resources/data_state.dart';
import 'package:weather_flutter/features/feature_weather/data/data_source/remote/api_provider.dart';
import 'package:weather_flutter/features/feature_weather/data/models/city_info_model.dart';
import 'package:weather_flutter/features/feature_weather/data/models/current_city_model.dart';
import 'package:weather_flutter/features/feature_weather/data/models/forcast_prams.dart';
import 'package:weather_flutter/features/feature_weather/domain/entites/city_info_entity.dart';
import 'package:weather_flutter/features/feature_weather/domain/entites/cureent_city_entity.dart';

import '../../../../core/widgets/logger_manager.dart';
import '../../domain/entites/forecast_day_entity.dart';
import '../../domain/repository/weather_repository.dart';
import '../models/forecast_day_model.dart';

/// کلاس WeatherRepositoryImpl که رابط WeatherRepository را پیاده‌سازی می‌کند
/// وظیفه این کلاس فراهم کردن داده‌های مرتبط با وضعیت آب و هوا از طریق API است.
class WeatherRepositoryImpl extends WeatherRepository {
  /// متغیر [apiProvider] از نوع ApiProvider برای مدیریت ارتباط با API
  final ApiProvider apiProvider;

  /// Logger برای ثبت لاگ‌ها.
  final Logger logger = Logger();

  /// سازنده کلاس [WeatherRepositoryImpl] که ApiProvider را دریافت می‌کند
  WeatherRepositoryImpl(this.apiProvider);

  /// متد کمکی [fetchData] برای ارسال درخواست به API و مدیریت پاسخ‌ها
  /// [request]: متد ارسال درخواست از نوع Future<Response>
  /// بازگشت: یک [DataState] که وضعیت موفق یا شکست را مشخص می‌کند
  Future<DataState<T>> fetchData<T>(Future<Response> Function() request) async {
    try {
      // ارسال درخواست به API
      logger.i('Sending API request... $T');
      Response response = await request();
      logger.i("Response Success $T: ${response.data}");

      // بررسی وضعیت کد پاسخ HTTP
      if (response.statusCode == 200) {
        // تبدیل داده‌های دریافتی به مدل مورد نظر
        T entity = _fromJson<T>(response.data);
        return DataSuccess(entity); // بازگشت وضعیت موفقیت با داده‌ها
      } else {
        logger.w("Received status code ${response.statusCode}");
        return DataFailed("Error: Received status code ${response.statusCode}");
      }
    } catch (e) {
      // مدیریت خطاهای پیش‌آمده هنگام ارسال درخواست
      if (e is DioException) {
        logger.w("DioError: ${e.message} $T");
        return DataFailed("DioError: ${e.message}");
      } else {
        logger.w("Unexpected Error: $e $T");
        return DataFailed("Unexpected Error: $e");
      }
    }
  }

  /// متد [fetchCurrentWeatherData] برای دریافت داده‌های وضعیت آب و هوای فعلی
  /// [cityName]: نام شهر برای دریافت اطلاعات
  /// بازگشت: وضعیت موفقیت یا شکست همراه با داده‌ها به صورت [DataState]
  @override
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(
      String cityName) async {
    return await fetchData<CurrentCityEntity>(
        () => apiProvider.callCurrentWeather(cityName));
  }

  /// متد [fetchForcastWeatherData] برای دریافت پیش‌بینی وضعیت آب و هوای ۷ روز آینده
  /// [params]: شامل پارامترهای عرض و طول جغرافیایی
  /// بازگشت: وضعیت موفقیت یا شکست همراه با داده‌ها به صورت [DataState]
  @override
  Future<DataState<ForecastDayEntity>> fetchForcastWeatherData(
      ForcastParams params) async {
    return await fetchData<ForecastDayEntity>(
        () => apiProvider.sendRequest7DayForecast(params));
  }

  @override
  Future<DataState<CityInfoEntity>> searchCities(String cityName) async {
    return await fetchData<CityInfoEntity>(
        () => apiProvider.searchCities(cityName));
  }

  /// متد [fromJson] برای تبدیل داده‌های JSON به مدل مربوطه
  /// [json]: داده‌های JSON دریافتی از API
  /// بازگشت: مدل تبدیل شده به نوع [T]
  T _fromJson<T>(Map<String, dynamic> json) {
    if (T == CurrentCityEntity) {
      return CurrentCityModel.fromJson(json) as T;
    } else if (T == ForecastDayEntity) {
      return ForecastDayModel.fromJson(json) as T;
    } else if (T == CityInfoEntity) {
      return CityInfoModel.fromJson(json) as T;
    }
    throw Exception(
        'Unknown model type: $T'); // مدیریت خطا در صورت نوع ناشناخته
  }
}
