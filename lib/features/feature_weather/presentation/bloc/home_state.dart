part of 'home_bloc.dart';


/// کلاس `HomeState`
/// این کلاس برای مدیریت وضعیت صفحه خانه (Home) طراحی شده است.
/// از `CwStatus` برای نگهداری وضعیت داده‌های وضعیت آب و هوا استفاده می‌کند.
class HomeState {
  /// وضعیت فعلی آب و هوا.
  final CwStatus cwStatus;

  /// سازنده کلاس `HomeState`.
  /// این سازنده مقدار اولیه وضعیت را می‌گیرد.
  HomeState({required this.cwStatus});

  /// متد `copyWith` برای ایجاد نسخه‌ای جدید از `HomeState` با امکان تغییر مقادیر خاص.
  /// اگر مقدار جدیدی برای `newCwStatus` داده شود، جایگزین مقدار فعلی می‌شود.
  /// در غیر این صورت، مقدار فعلی حفظ می‌شود.
  HomeState copyWith({
    CwStatus? newCwStatus,
  }) {
    return HomeState(
      cwStatus: newCwStatus ?? this.cwStatus, // اگر مقدار جدید نباشد، از مقدار فعلی استفاده می‌شود.
    );
  }
}


