import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

/// یک کلاس عمومی برای مدیریت وضعیت‌ها.
/// این کلاس به صورت Generic طراحی شده است تا بتواند داده‌های مختلفی را مدیریت کند.
@immutable
abstract class BaseStatus<T> extends Equatable {}

/// وضعیت بارگذاری
class Loading<T> extends BaseStatus<T> {
  @override
  List<Object?> get props => [];
}

/// وضعیت تکمیل
class Completed<T> extends BaseStatus<T> {
  final T data;

  Completed(this.data);

  @override
  List<Object?> get props => [data];
}

/// وضعیت خطا
class Error<T> extends BaseStatus<T> {
  final String message;

  Error(this.message);

  @override
  List<Object?> get props => [message];
}
