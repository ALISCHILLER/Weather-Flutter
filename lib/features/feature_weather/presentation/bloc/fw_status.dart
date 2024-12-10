

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_flutter/features/feature_weather/domain/entites/forcast_day_entites.dart';


@immutable
abstract class FwStatus extends Equatable {

}

class FwLoading extends FwStatus{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
/// وضعیت تکمیل.
/// این کلاس برای زمانی که داده‌های وضعیت آب و هوا با موفقیت دریافت شده‌اند استفاده می‌شود.
class FwCompleted extends FwStatus {
  final ForecastDaysEntity forecastDaysEntity;

  FwCompleted(this.forecastDaysEntity);
  @override
  // TODO: implement props
  List<Object?> get props =>[forecastDaysEntity];
}

class FwError extends FwStatus{
  final String message;
  FwError(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}