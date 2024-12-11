
import 'package:get_it/get_it.dart';
import 'package:weather_flutter/features/feature_weather/data/data_source/remote/api_provider.dart';
import 'package:weather_flutter/features/feature_weather/data/repository/weather_repositoryImpl.dart';
import 'package:weather_flutter/features/feature_weather/domain/repository/weather_repository.dart';
import 'package:weather_flutter/features/feature_weather/domain/use_cases/get_current_weather_usecase.dart';
import 'package:weather_flutter/features/feature_weather/domain/use_cases/get_forecast_day_usecase.dart';
import 'package:weather_flutter/features/feature_weather/presentation/bloc/home_bloc.dart';


/// مدیریت چرخه عمر وابستگی‌ها:
///
/// هنگامی که وابستگی‌هایی دارید که در تمامی بخش‌های برنامه موردنیاز نیستند و فقط در برخی مواقع خاص مورد استفاده قرار می‌گیرند،
/// می‌توانید از `registerLazySingleton` به‌جای `registerSingleton` استفاده کنید.
/// این روش باعث بهینه‌سازی مصرف منابع می‌شود زیرا شیء فقط زمانی ساخته می‌شود که اولین بار برای استفاده درخواست شود.
/// در نتیجه، اگر وابستگی‌ها در برخی حالات خاص فراخوانی شوند، دیگر در ابتدای برنامه لود نمی‌شوند و به‌طور پنهانی در زمان نیاز ساخته می‌شوند.
/// این روش به بهبود زمان بارگذاری و مدیریت حافظه کمک می‌کند.
///
/// در اینجا از `registerSingleton` استفاده شده است، زیرا این وابستگی‌ها برای مدت زمان طولانی در برنامه نیاز دارند.
/// در صورت نیاز به بهینه‌سازی حافظه، می‌توانید از `registerLazySingleton` استفاده کنید.
///
/// برای استفاده از `registerLazySingleton`:
/// locator.registerLazySingleton<ApiProvider>(() => ApiProvider());

final GetIt locator = GetIt.instance;

setup() {
  // ثبت وابستگی‌ها برای ApiProvider
  locator.registerSingleton<ApiProvider>(ApiProvider());

  // ثبت وابستگی‌ها برای Repository
  locator.registerSingleton<WeatherRepository>(
    WeatherRepositoryImpl(locator()), // تزریق ApiProvider
  );

  // ثبت وابستگی‌ها برای UseCase
  locator.registerSingleton<GetCurrentWeatherUseCase>(
    GetCurrentWeatherUseCase(locator()), // تزریق Repository
  );

  // ثبت وابستگی‌ها برای UseCase
  locator.registerSingleton<GetForecastDayUseCase>(
    GetForecastDayUseCase(locator()), // تزریق Repository
  );

  // ثبت وابستگی‌ها برای Bloc
  locator.registerSingleton<HomeBloc>(
    HomeBloc(locator(),locator()), // تزریق UseCase
  );
}