import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_flutter/core/resources/data_state.dart';
import 'package:weather_flutter/features/feature_weather/data/models/forcast_prams.dart';
import 'package:weather_flutter/features/feature_weather/domain/use_cases/get_current_weather_usecase.dart';
import 'package:weather_flutter/features/feature_weather/domain/use_cases/get_forecast_day_usecase.dart';
import 'package:weather_flutter/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:weather_flutter/features/feature_weather/presentation/bloc/fw_status.dart';

part 'home_event.dart';
part 'home_state.dart';

/// کلاس HomeBloc برای مدیریت رویدادها و وضعیت‌ها
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  final GetForecastDayUseCase getForecastDayUseCase;

  HomeBloc(this.getCurrentWeatherUseCase, this.getForecastDayUseCase)
      : super(HomeState(cwStatus: CwLoading(), fwStatus: FwLoading())) {
    // مدیریت رویداد LoadCwEvent
    on<LoadCwEvent>((event, emit) async {
      await _handleWeatherEvent(
            () => getCurrentWeatherUseCase(event.cityName),
            (data) => emit(state.copyWith(newCwStatus: CwCompleted(data))),
            (error) => emit(state.copyWith(newCwStatus: CwError(error))),
            () => emit(state.copyWith(newCwStatus: CwLoading())),
      );
    });

    // مدیریت رویداد LoadFwEvent
    on<LoadFwEvent>((event, emit) async {
      await _handleWeatherEvent(
            () => getForecastDayUseCase(event.forcastParams),
            (data) => emit(state.copyWith(newFwStatus: FwCompleted(data))),
            (error) => emit(state.copyWith(newFwStatus: FwError(error))),
            () => emit(state.copyWith(newFwStatus: FwLoading())),
      );
    });
  }

  /// متد خصوصی برای مدیریت مشترک رویدادها
  Future<void> _handleWeatherEvent<T>(
      Future<DataState<T>> Function() fetchData,
      void Function(T data) onSuccess,
      void Function(String error) onError,
      void Function() onLoading,
      ) async {
    onLoading(); // ارسال وضعیت لودینگ
    DataState<T> dataState = await fetchData(); // فراخوانی داده‌ها
    if (dataState is DataSuccess) {
      onSuccess(dataState.data!); // موفقیت
    } else if (dataState is DataFailed) {
      onError(dataState.error!); // شکست
    }
  }
}
