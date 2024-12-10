import 'package:equatable/equatable.dart';

import '../../data/models/ForecastDaysModel.dart';

class ForecastDaysEntity extends Equatable {
  final double? lat;
  final double? lon;
  final String? timezone;
  final int? timezoneOffset;
  final Current? current;
  final List<Daily>? daily;
  final List<Alerts>? alerts;

  // سازنده با پارامترهای نام‌گذاری شده
  ForecastDaysEntity({
    this.lat,
    this.lon,
    this.timezone,
    this.timezoneOffset,
    this.current,
    this.daily,
    this.alerts,
  });

  @override
  List<Object?> get props => [
    lat,
    lon,
    timezone,
    timezoneOffset,
    current,
    daily,
    alerts,
  ];

  @override
  bool get stringify => true;
}
