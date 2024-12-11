import 'package:flutter/cupertino.dart';
import 'package:weather_flutter/features/feature_weather/domain/entites/cureent_city_entity.dart';

import '../../../../core/bloc/BaseStatus.dart';

/// وضعیت‌های آب‌وهوای فعلی با استفاده از BaseStatus.
typedef CwStatus = BaseStatus<CurrentCityEntity>;

/// وضعیت بارگذاری آب‌وهوای فعلی.
typedef CwLoading = Loading<CurrentCityEntity>;

/// وضعیت تکمیل آب‌وهوای فعلی.
typedef CwCompleted = Completed<CurrentCityEntity>;

/// وضعیت خطا در آب‌وهوای فعلی.
typedef CwError = Error<CurrentCityEntity>;
