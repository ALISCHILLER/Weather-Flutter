
import 'package:weather_flutter/core/resources/data_state.dart';
import 'package:weather_flutter/features/feature_weather/data/models/city_info_model.dart';
import 'package:weather_flutter/features/feature_weather/data/models/forcast_prams.dart';
import 'package:weather_flutter/features/feature_weather/domain/entites/city_info_entity.dart';
import 'package:weather_flutter/features/feature_weather/domain/entites/cureent_city_entity.dart';


import '../entites/forecast_day_entity.dart';

// کلاس انتزاعی برای repository که داده‌های مربوط به آب و هوا را از منابع مختلف (API یا دیتابیس) دریافت می‌کند
// این کلاس باید توسط پیاده‌سازی‌های مختلف از جمله API‌ها یا داده‌های محلی گسترش یابد.
abstract class WeatherRepository {

  /// متد برای دریافت اطلاعات وضعیت آب و هوای شهر بر اساس نام آن
  /// این متد باید به صورت آسنکرون داده‌ها را از سرویس‌ها یا منابع مختلف دریافت کند.
  ///
  /// پارامتر [cityName] نام شهر مورد نظر برای دریافت اطلاعات آب و هوا است.
  ///
  /// بازگشتی:
  /// یک شیء از نوع [DataState<CurrentCityEntity>] که می‌تواند شامل داده‌های موفقیت‌آمیز یا خطا باشد.
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(String cityName);



  Future<DataState<ForecastDayEntity>> fetchForcastWeatherData(ForcastParams params);


  Future<DataState<CityInfoEntity>> searchCities(String cityName);
}