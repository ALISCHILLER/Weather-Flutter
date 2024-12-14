import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_flutter/core/resources/data_state.dart';
import 'package:weather_flutter/features/feature_weather/data/models/forcast_prams.dart';
import 'package:weather_flutter/features/feature_weather/domain/entites/cureent_city_entity.dart';
import 'package:weather_flutter/features/feature_weather/domain/use_cases/get_current_weather_usecase.dart';
import 'package:weather_flutter/features/feature_weather/domain/use_cases/get_forecast_day_usecase.dart';
import 'package:weather_flutter/features/feature_weather/presentation/bloc/cw_status.dart';
import 'package:weather_flutter/features/feature_weather/presentation/bloc/fw_status.dart';

import '../../domain/entites/forecast_day_entity.dart';



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
        fetchData: () => getCurrentWeatherUseCase(event.cityName),
        onSuccess: (data) => _onCwSuccess(emit, data),
        onError: (error) => _onCwError(emit, error),
        onLoading: () => _onCwLoading(emit),
      );
    });

    // مدیریت رویداد LoadFwEvent
    on<LoadFwEvent>((event, emit) async {
      await _handleWeatherEvent(
        fetchData: () => getForecastDayUseCase(event.forcastParams),
        onSuccess: (data) => _onFwSuccess(emit, data),
        onError: (error) => _onFwError(emit, error),
        onLoading: () => _onFwLoading(emit),
      );
    });
  }

  /// متد خصوصی برای مدیریت مشترک رویدادها
  Future<void> _handleWeatherEvent<T>({
    required Future<DataState<T>> Function() fetchData,
    required void Function(T data) onSuccess,
    required void Function(String error) onError,
    required void Function() onLoading,
  }) async {
    onLoading(); // ارسال وضعیت لودینگ
    DataState<T> dataState = await fetchData(); // فراخوانی داده‌ها
    if (dataState is DataSuccess) {
      onSuccess(dataState.data!); // موفقیت
    } else if (dataState is DataFailed) {
      onError(dataState.error!); // شکست
    }
  }

  // وضعیت‌های مختلف برای Cw (Current Weather)
  void _onCwSuccess(Emitter<HomeState> emit, CurrentCityEntity data) {
    emit(state.copyWith(newCwStatus: CwCompleted(data)));
  }

  void _onCwError(Emitter<HomeState> emit, String error) {
    emit(state.copyWith(newCwStatus: CwError(error)));
  }

  void _onCwLoading(Emitter<HomeState> emit) {
    emit(state.copyWith(newCwStatus: CwLoading()));
  }

  // وضعیت‌های مختلف برای Fw (Forecast Weather)
  void _onFwSuccess(Emitter<HomeState> emit, ForecastDayEntity data) {
    emit(state.copyWith(newFwStatus: FwCompleted(data)));
  }

  void _onFwError(Emitter<HomeState> emit, String error) {
    emit(state.copyWith(newFwStatus: FwError(error)));
  }

  void _onFwLoading(Emitter<HomeState> emit) {
    emit(state.copyWith(newFwStatus: FwLoading()));
  }
}
