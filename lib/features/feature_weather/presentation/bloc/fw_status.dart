import 'package:flutter/cupertino.dart';



import '../../../../core/bloc/BaseStatus.dart';
import '../../domain/entites/forecast_day_entity.dart';

/// وضعیت‌های پیش‌بینی روزانه با استفاده از BaseStatus.
typedef FwStatus = BaseStatus<ForecastDayEntity>;

/// وضعیت بارگذاری پیش‌بینی روزانه.
typedef FwLoading = Loading<ForecastDayEntity>;

/// وضعیت تکمیل پیش‌بینی روزانه.
typedef FwCompleted = Completed<ForecastDayEntity>;

/// وضعیت خطا در پیش‌بینی روزانه.
typedef FwError = Error<ForecastDayEntity>;
