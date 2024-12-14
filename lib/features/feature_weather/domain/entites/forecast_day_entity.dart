import 'package:equatable/equatable.dart';

import '../../data/models/forecast_day_model.dart';

class ForecastDayEntity extends Equatable {
  final String? cod;
  final num? message;
  final num? cnt;
  final List<Collection>? list;
  final City? city;

  const ForecastDayEntity({this.cod, this.message, this.cnt, this.list, this.city});

  @override
  List<Object?> get props => [
    cod,
    message,
    cnt,
    list ?? [],
    city,
  ];
}
