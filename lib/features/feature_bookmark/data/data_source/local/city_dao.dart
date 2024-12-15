import 'package:floor/floor.dart';

import '../../../domain/entities/city_model.dart';

@dao
abstract class CityDao {
  /// این متد تمام شهرها را از دیتابیس دریافت می‌کند.
  /// 
  /// خروجی این متد یک لیست از اشیاء `City` است.
  @Query('SELECT * FROM City')
  Future<List<City>> getAllCity();

  /// این متد یک شهر را بر اساس نام آن پیدا می‌کند.
  /// 
  /// [name]: نام شهری که می‌خواهید جستجو کنید.
  /// 
  /// خروجی این متد یک شیء `City` است که ممکن است `null` باشد در صورتی که شهری با آن نام وجود نداشته باشد.
  @Query('SELECT * FROM City WHERE name = :name')
  Future<City?> findCityByName(String name);

  /// این متد یک شهر جدید را به دیتابیس اضافه می‌کند.
  /// 
  /// [city]: شیء `City` که می‌خواهید به دیتابیس اضافه کنید.
  /// 
  /// این متد هیچ مقداری را بازنمی‌گرداند.
  @insert
  Future<void> insertCity(City city);

  /// این متد یک شهر را بر اساس نام آن از دیتابیس حذف می‌کند.
  /// 
  /// [name]: نام شهری که می‌خواهید حذف کنید.
  /// 
  /// این متد هیچ مقداری را بازنمی‌گرداند.
  @Query('DELETE FROM City WHERE name = :name')
  Future<void> deleteCityByName(String name);
}
