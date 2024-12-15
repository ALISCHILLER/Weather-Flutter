import 'package:flutter/cupertino.dart';
import 'package:weather_flutter/features/feature_weather/domain/entites/cureent_city_entity.dart';

import '../../../../core/bloc/BaseStatus.dart';

/// وضعیت‌های آب‌وهوای فعلی با استفاده از BaseStatus.
typedef CwStatus = BaseStatus<CurrentCityEntity>;

/// وضعیت بارگذاری آب‌وهوای فعلی.
typedef CwLoading = Loading<CurrentCityEntity>;

/// وضعیت تکمیل آب‌وهوای فعلی.
/// loaded state
class CwCompleted extends CwStatus{
  final CurrentCityEntity currentCityEntity;
  CwCompleted(this.currentCityEntity);

  @override
  // TODO: implement props
  List<Object?> get props => [
    currentCityEntity,
  ];
}

/// وضعیت خطا در آب‌وهوای فعلی.
typedef CwError = Error<CurrentCityEntity>;
