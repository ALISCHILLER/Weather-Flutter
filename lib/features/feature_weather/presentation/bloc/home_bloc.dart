import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_flutter/core/resources/data_state.dart';
import 'package:weather_flutter/features/feature_weather/domain/use_cases/get_current_weather_usecase.dart';
import 'package:weather_flutter/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:weather_flutter/features/feature_weather/presentation/bloc/fw_status.dart';

part 'home_event.dart'; // بخش تعریف شده برای رویدادها
part 'home_state.dart'; // بخش تعریف شده برای وضعیت‌ها

/// کلاس `HomeBloc`
/// این کلاس مدیریت وضعیت صفحه خانه را بر عهده دارد و از الگوی BLoC برای مدیریت رویدادها و وضعیت‌ها استفاده می‌کند.
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  /// وابستگی `GetCurrentWeatherUseCase` برای دریافت اطلاعات آب و هوا
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;

  /// سازنده `HomeBloc`
  /// مقدار اولیه وضعیت صفحه را به `CwLoading` تنظیم می‌کند.
  HomeBloc(this.getCurrentWeatherUseCase)
      : super(HomeState(cwStatus: CwLoading(), fwStatus: FwLoading())) {
    /// هندلر برای رویداد `LoadCwEvent`
    /// وظیفه این هندلر، لود کردن وضعیت آب و هوا برای یک شهر مشخص است.
    on<LoadCwEvent>((event, emit) async {
      // ارسال وضعیت لودینگ به UI
      emit(state.copyWith(newCwStatus: CwLoading()));

      // فراخوانی UseCase برای دریافت اطلاعات آب و هوا
      DataState dataState = await getCurrentWeatherUseCase(event.cityName);

      // اگر داده‌ها با موفقیت دریافت شوند
      if (dataState is DataSuccess) {
        emit(state.copyWith(newCwStatus: CwCompleted(dataState.data)));
      }

      // اگر دریافت داده‌ها با خطا مواجه شود
      if (dataState is DataFailed) {
        emit(state.copyWith(newCwStatus: CwError(dataState.error!)));
      }
    });
  }
}
