import 'package:dio/dio.dart'; // وارد کردن پکیج Dio برای انجام درخواست‌های HTTP
import 'package:weather_flutter/core/resources/data_state.dart'; // وارد کردن DataState برای مدیریت وضعیت داده‌ها
import 'package:weather_flutter/features/feature_weather/data/data_source/remote/api_provider.dart'; // وارد کردن ApiProvider برای فراخوانی API
import 'package:weather_flutter/features/feature_weather/data/models/current_city_model.dart'; // وارد کردن مدل داده‌ها برای تبدیل JSON به شیء
import 'package:weather_flutter/features/feature_weather/domain/entites/cureent_city_entity.dart'; // وارد کردن موجودیت برای داده‌های شهر فعلی
import 'package:weather_flutter/features/feature_weather/domain/repository/weather_repository.dart'; // وارد کردن رابط مخزن داده‌ها


// پیاده‌سازی کلاس WeatherRepositoryImpl که رابط WeatherRepository را پیاده‌سازی می‌کند.
class WeatherRepositoryImpl extends WeatherRepository {

  // ایجاد متغیر apiProvider از نوع ApiProvider برای دسترسی به داده‌ها از API
  final ApiProvider apiProvider;

  // سازنده کلاس WeatherRepositoryImpl که apiProvider را از بیرون دریافت می‌کند
  WeatherRepositoryImpl(this.apiProvider);

  /// متد [fetchCurrentWeatherData] برای دریافت داده‌های وضعیت آب و هوا برای یک شهر خاص.
  /// این متد داده‌ها را از API دریافت کرده و به صورت [DataState<CurrentCityEntity>] باز می‌گرداند.
  ///
  /// پارامتر [cityName] نام شهر است که اطلاعات وضعیت آب و هوا برای آن درخواست می‌شود.
  ///
  /// بازگشتی:
  /// یک شیء از نوع [DataState<CurrentCityEntity>] که می‌تواند شامل داده‌های موفقیت‌آمیز یا خطا باشد.
  @override
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherData(String cityName) async {
    try {
      // ارسال درخواست به API برای دریافت اطلاعات وضعیت آب و هوا
      Response response = await apiProvider.callCurrentWeather(cityName);

      // بررسی وضعیت کد پاسخ HTTP (200 برای موفقیت)
      if (response.statusCode == 200) {
        // تبدیل داده‌های دریافتی از JSON به شیء CurrentCityEntity
        CurrentCityEntity cityEntity = CurrentCityModel.fromJson(response.data);

        // بازگشت DataSuccess با داده‌های صحیح که شامل cityEntity است
        return DataSuccess(cityEntity);
      } else {
        // اگر وضعیت کد پاسخ 200 نبود، بازگشت DataFailed با پیام خطا
        // بهتر است اطلاعات دقیق‌تری از کد وضعیت HTTP و توضیحات اضافه کنید
        return DataFailed("Error: Received status code ${response.statusCode}");
      }
    } catch (e) {
      // در صورت بروز هرگونه خطا در طول فراخوانی API، بازگشت DataFailed با پیام خطا
      // بهتر است نوع دقیق خطا را گزارش دهید، به ویژه در صورتی که از DioError استفاده می‌کنید
      if (e is DioException) {
        // اگر خطا از نوع DioError باشد، پیام خطا و اطلاعات اضافی را گزارش می‌دهیم
        return DataFailed("DioError: ${e.message}");
      } else {
        // برای خطاهای دیگر (غیر از DioError) پیام خطای عمومی نمایش می‌دهیم
        return DataFailed("Unexpected Error: $e");
      }
    }
  }
}