import 'package:equatable/equatable.dart';

import '../../data/models/city_info_model.dart';

// مدل نمایشی (Entity) برای اطلاعات شهرها
class CityInfoEntity extends Equatable {
  final List<Data>? data; // لیستی از داده‌های مربوط به شهرها
  final List<Links>? links; // لیستی از لینک‌ها برای پیمایش صفحات
  final Metadata? metadata; // اطلاعات متادیتا برای دیتا

  // سازنده کلاس CityInfoEntity با مقداردهی اختیاری به فیلدها
  const CityInfoEntity({this.data, this.links, this.metadata});

  @override
  // این متد باید برای مقایسه شیء‌ها استفاده شود.
  // در اینجا، باید لیستی از ویژگی‌ها که برای مقایسه استفاده می‌شود برگردانده شود.
  // در صورت نیاز به پیاده‌سازی، فهرست ویژگی‌های قابل مقایسه را به‌روزرسانی کنید.
  List<Object?> get props => [data ?? [], links ?? [], metadata ?? []];
// TODO: در صورت نیاز به بهینه‌سازی یا اضافه کردن مقایسه، ویژگی‌های اضافی را در لیست props وارد کنید.
}
