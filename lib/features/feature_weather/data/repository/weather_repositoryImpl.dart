import 'package:dio/dio.dart'; // وارد کردن پکیج Dio برای انجام درخواست‌های HTTP
import 'package:weather_flutter/core/resources/data_state.dart'; // وارد کردن DataState برای مدیریت وضعیت داده‌ها
import 'package:weather_flutter/features/feature_weather/data/data_source/remote/api_provider.dart'; // وارد کردن ApiProvider برای فراخوانی API
import 'package:weather_flutter/features/feature_weather/data/models/ForecastDaysModel.dart'; // مدل پیش‌بینی وضعیت آب و هوا
import 'package:weather_flutter/features/feature_weather/data/models/current_city_model.dart'; // مدل وضعیت آب و هوای شهر فعلی
import 'package:weather_flutter/features/feature_weather/data/models/forcast_prams.dart'; // مدل پارامترهای درخواست پیش‌بینی
import 'package:weather_flutter/features/feature_weather/domain/entites/cureent_city_entity.dart'; // موجودیت وضعیت آب و هوای شهر فعلی
import 'package:weather_flutter/features/feature_weather/domain/entites/forcast_day_entites.dart'; // موجودیت پیش‌بینی وضعیت آب و هوا

import '../../domain/repository/weather_repository.dart'; // رابط مخزن برای دریافت داده‌ها

// پیاده‌سازی کلاس WeatherRepositoryImpl که رابط WeatherRepository را پیاده‌سازی می‌کند.
class WeatherRepositoryImpl extends WeatherRepository {

  // ایجاد متغیر apiProvider از نوع ApiProvider برای دسترسی به داده‌ها از API
  final ApiProvider apiProvider;

  // سازنده کلاس WeatherRepositoryImpl که apiProvider را از بیرون دریافت می‌کند
  WeatherRepositoryImpl(this.apiProvider);

  /// متد کمکی [fetchData] برای ارسال درخواست به API و دریافت داده‌ها
  /// این متد یک درخواست از نوع Future<Response> را دریافت می‌کند و پاسخ را به مدل دلخواه تبدیل می‌کند.
  Future<DataState<T>> fetchData<T>(Future<Response> Function() request) async {
    try {
      // ارسال درخواست به API
      Response response = await request();

      // بررسی وضعیت کد پاسخ HTTP (200 برای موفقیت)
      if (response.statusCode == 200) {
        // تبدیل داده‌های دریافتی از JSON به مدل دلخواه
        T entity = _fromJson<T>(response.data);
        return DataSuccess(entity); // بازگشت DataSuccess با داده‌های صحیح
      } else {
        // اگر وضعیت کد پاسخ 200 نبود، بازگشت DataFailed با پیام خطا
        return DataFailed("Error: Received status code ${response.statusCode}");
      }
    } catch (e) {
      // در صورت بروز خطا در ارسال درخواست، بازگشت DataFailed با پیام خطا
      if (e is DioException) {
        return DataFailed("DioError: ${e.message}"); // خطای مربوط به Dio
      } else {
        return DataFailed("Unexpected Error: $e"); // سایر خطاهای غیرمنتظره
      }
    }
  }

  /// متد [fetchCurrentWeatherData] برای دریافت داده‌های وضعیت آب و هوا برای یک شهر خاص.
  /// پارامتر [cityName] نام شهر است که اطلاعات وضعیت آب و هوا برای آن درخواست می‌شود.
  @override
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(String cityName) async {
    // استفاده از متد کمکی fetchData برای دریافت داده‌ها
    return await fetchData<CurrentCityEntity>(() => apiProvider.callCurrentWeather(cityName));
  }

  /// متد [fetchForcastWeatherData] برای دریافت داده‌های پیش‌بینی وضعیت آب و هوا برای 7 روز آینده.
  /// پارامتر [params] شامل پارامترهای درخواست پیش‌بینی وضعیت آب و هوا است.
  @override
  Future<DataState<ForecastDaysEntity>> fetchForcastWeatherData(ForcastParams params) async {
    // استفاده از متد کمکی fetchData برای دریافت داده‌ها
    return await fetchData<ForecastDaysEntity>(() => apiProvider.sendRequest7DayForcast(params));
  }

  /// متد [fromJson] برای تبدیل داده‌های JSON به مدل دلخواه.
  /// این متد بر اساس نوع داده، مدل مربوطه را باز می‌گرداند.
  T _fromJson<T>(Map<String, dynamic> json) {
    if (T == CurrentCityEntity) {
      // اگر مدل درخواست شده از نوع CurrentCityEntity باشد، آن را از JSON به مدل تبدیل می‌کنیم
      return CurrentCityModel.fromJson(json) as T;
    } else if (T == ForecastDaysEntity) {
      // اگر مدل درخواست شده از نوع ForecastDaysEntity باشد، آن را از JSON به مدل تبدیل می‌کنیم
      return ForecastDaysModel.fromJson(json) as T;
    }
    // اگر مدل ناشناخته باشد، خطا می‌دهیم
    throw Exception('Unknown model type');
  }
}
