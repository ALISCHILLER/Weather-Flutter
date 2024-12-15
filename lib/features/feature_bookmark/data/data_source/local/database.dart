import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../../domain/entities/city_model.dart'; // مدل City
import 'city_dao.dart'; // DAO برای عملیات روی جدول City

// کدهای تولید شده توسط Floor در این فایل قرار می‌گیرد

/// کلاس پایگاه داده اصلی که از FloorDatabase ارث‌بری می‌کند.
///
/// این کلاس برای مدیریت اتصال به پایگاه داده و دسترسی به DAOها استفاده می‌شود.
@Database(version: 1, entities: [City]) // نسخه دیتابیس و جداول موجود در آن
abstract class AppDatabase extends FloorDatabase {
  /// دسترسی به DAO مربوط به `City` که عملیات CRUD روی جدول City را انجام می‌دهد.
  CityDao get cityDao;
}
