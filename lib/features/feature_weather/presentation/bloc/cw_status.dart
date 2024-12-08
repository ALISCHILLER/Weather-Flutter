import 'package:flutter/cupertino.dart';
import 'package:weather_flutter/features/feature_weather/domain/entites/cureent_city_entity.dart';

/// یک کلاس انتزاعی برای مدیریت وضعیت‌ها (States) در جریان داده‌های وضعیت آب و هوا.
/// این کلاس از @immutable استفاده می‌کند تا همه فیلدهای کلاس‌ها تغییرناپذیر باشند.
@immutable
abstract class CwStatus {}

/// وضعیت بارگذاری.
/// این کلاس برای زمانی که داده‌های وضعیت آب و هوا در حال بارگذاری هستند استفاده می‌شود.
class CwLoading extends CwStatus {}

/// وضعیت تکمیل.
/// این کلاس برای زمانی که داده‌های وضعیت آب و هوا با موفقیت دریافت شده‌اند استفاده می‌شود.
class CwCompleted extends CwStatus {
  /// داده‌های وضعیت آب و هوای شهر فعلی.
  final CurrentCityEntity currentCityEntity;

  /// سازنده برای مقداردهی فیلد `currentCityEntity`.
  CwCompleted(this.currentCityEntity);
}

/// وضعیت خطا.
/// این کلاس برای زمانی که خطایی در دریافت داده‌های وضعیت آب و هوا رخ می‌دهد استفاده می‌شود.
class CwError extends CwStatus {
  /// پیام خطا.
  final String message;

  /// سازنده برای مقداردهی فیلد `message`.
  CwError(this.message);
}