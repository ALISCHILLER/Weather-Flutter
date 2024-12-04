import 'package:dio/dio.dart';
import 'package:weather_flutter/core/usecase/use_case.dart';
import 'package:weather_flutter/features/feature_weather/domain/repository/weather_repository.dart';
import '../../../../core/resources/data_state.dart';
import '../entites/cureent_city_entity.dart';

// پیاده‌سازی UseCase برای دریافت وضعیت آب و هوای فعلی
// این کلاس از کلاس انتزاعی UseCase ارث‌بری می‌کند و به منظور دریافت وضعیت آب و هوای یک شهر استفاده می‌شود.
// این عملیات با استفاده از یک پارامتر ورودی (نام شهر) انجام می‌شود و نتیجه آن یک وضعیت داده (DataState) از نوع CurrentCityEntity است.
class GetCurrentWeatherUseCase
    extends UseCase<DataState<CurrentCityEntity>, String> {
  // مخزن (Repository) که داده‌ها را از منبع داده (مثلاً API) می‌گیرد
  final WeatherRepository weatherRepository;

  // سازنده که به آن مخزن WeatherRepository داده می‌شود تا بتواند عملیات دریافت وضعیت آب و هوا را انجام دهد
  GetCurrentWeatherUseCase(this.weatherRepository);

  // پیاده‌سازی متد call که عملیات اصلی را انجام می‌دهد
  // این متد پارامتر ورودی (نام شهر) را دریافت کرده و آن را به مخزن ارسال می‌کند
  // نتیجه این عملیات یک DataState از نوع CurrentCityEntity است که نشان‌دهنده وضعیت آب و هوا می‌باشد.
  @override
  Future<DataState<CurrentCityEntity>> call(String cityName) async {
    try {
      // فراخوانی متد fetchCurrentWeatherData از weatherRepository که وضعیت آب و هوا را برای cityName برمی‌گرداند
      return await weatherRepository.fetchCurrentWeatherData(cityName);
    } catch (e) {
      // بررسی اینکه آیا استثنا از نوع Exception است
      if (e is Exception) {
        // اگر استثنا از نوع Exception بود، آن را به متد onError ارسال می‌کنیم
        await onError(e);
      } else {
        // اگر استثنا از نوع Exception نبود، یک استثنا جدید از نوع Exception ایجاد می‌کنیم
        await onError(Exception('Unknown error occurred'));
      }

      // پرتاب مجدد خطا به بیرون از متد
      rethrow;
    }
  }

  // پیاده‌سازی متد onError برای مدیریت خطاها
  // این متد در صورت بروز خطا در اجرای عملیات فراخوانی می‌شود
  // در اینجا، خطاها به گونه‌ای مدیریت می‌شوند که به راحتی قابل شناسایی و پیگیری باشند.
  // پیاده‌سازی متد onError برای مدیریت خطاها
  @override
  Future<void> onError(Exception e) async {
    // ابتدا بررسی می‌کنیم که آیا خطای دریافت شده از نوع DioError است یا خیر
    // DioError خطاهایی است که از بسته Dio برای درخواست‌های HTTP به وجود می‌آید
    if (e is DioError) {
      // در صورت بروز خطای DioError، پیام خطا را در کنسول چاپ می‌کنیم
      print('Dio Error: ${e.message}');

      // در اینجا می‌توانید کدهای اضافی برای مدیریت خطای Dio اضافه کنید
      if (e.response != null) {
        print('Dio Error Response: ${e.response!.data}');
      } else {
        // در صورتی که پاسخ از سرور وجود نداشته باشد، خطای شبکه چاپ می‌شود
        print('Dio Error: No response received from server');
      }
    } else {
      // در صورت بروز هر نوع خطای دیگر، می‌توان آن را به صورت عمومی مدیریت کرد
      // در اینجا، اطلاعات خطای عمومی را چاپ می‌کنیم
      print('General Error: ${e.toString()}');
    }

    // اگر خطا به هر دلیلی اتفاق افتاد، باید یک خطای عمومی به کاربر نشان داده شود
    // در اینجا یک استثنای عمومی با پیام خاص ایجاد می‌کنیم تا نشان دهیم که عملیات با شکست مواجه شده است
    throw Exception('Failed to fetch weather data');
  }

// Future<DataState<CurrentCityEntity>> call(String cityName){
//   return weatherRepository.fetchCurrentWeatherData(cityName);
// }
}

// ایجاد یک کلاس استثنا (Custom Exception) برای مدیریت خطاهای خاص در هنگام دریافت وضعیت آب و هوا
class WeatherFetchException implements Exception {
  final String message;

  WeatherFetchException(this.message);

  @override
  String toString() => message;
}
