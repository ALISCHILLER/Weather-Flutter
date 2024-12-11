import 'package:flutter/cupertino.dart';

import 'package:weather_flutter/features/feature_weather/domain/entites/forcast_day_entites.dart';

import '../../../../core/bloc/BaseStatus.dart';

/// وضعیت‌های پیش‌بینی روزانه با استفاده از BaseStatus.
typedef FwStatus = BaseStatus<ForecastDaysEntity>;

/// وضعیت بارگذاری پیش‌بینی روزانه.
typedef FwLoading = Loading<ForecastDaysEntity>;

/// وضعیت تکمیل پیش‌بینی روزانه.
typedef FwCompleted = Completed<ForecastDaysEntity>;

/// وضعیت خطا در پیش‌بینی روزانه.
typedef FwError = Error<ForecastDaysEntity>;
