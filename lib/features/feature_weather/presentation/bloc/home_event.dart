part of 'home_bloc.dart';

/// کلاس انتزاعی `HomeEvent`
/// این کلاس رویدادهای مربوط به `HomeBloc` را مدیریت می‌کند.
/// با استفاده از `sealed` فقط کلاس‌های مشخصی می‌توانند از آن ارث‌بری کنند.
@immutable
sealed class HomeEvent {}

/// رویداد `LoadCwEvent`
/// این رویداد برای بارگذاری وضعیت آب و هوا برای یک شهر مشخص استفاده می‌شود.
class LoadCwEvent extends HomeEvent {
  /// نام شهر برای درخواست وضعیت آب و هوا
  final String cityName;

  /// سازنده `LoadCwEvent`
  /// مقدار `cityName` را دریافت می‌کند.
  LoadCwEvent(this.cityName);
}
