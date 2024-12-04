
// یک کلاس انتزاعی برای تعریف وضعیت کلی داده‌ها
abstract class DataState<T> {
  final T? data; // داده‌ای که ممکن است موفقیت‌آمیز دریافت شود
  final String? error; // پیام خطا در صورت بروز مشکل

  // سازنده برای مقداردهی داده و خطا
  const DataState(this.data, this.error);
}

// کلاسی برای حالت موفقیت‌آمیز داده
class DataSuccess<T> extends DataState<T> {
  // سازنده‌ای که داده را مقداردهی می‌کند و خطا را null قرار می‌دهد
  const DataSuccess(T? data) : super(data, null);
}

// کلاسی برای حالت شکست داده
class DataFailed<T> extends DataState<T> {
  // سازنده‌ای که خطا را مقداردهی می‌کند و داده را null قرار می‌دهد
  const DataFailed(String error) : super(null, error);
}

