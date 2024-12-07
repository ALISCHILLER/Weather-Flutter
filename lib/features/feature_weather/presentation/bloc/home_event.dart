part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class LoadSwEvent extends HomeEvent{
  final String cityName ;
  LoadSwEvent(this.cityName);


}
