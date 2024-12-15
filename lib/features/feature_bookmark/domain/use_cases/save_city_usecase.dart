

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/city_repository.dart';

import '../entities/city_model.dart';

import '../entities/city_model.dart';

class SaveCityUseCase implements UseCase<DataState<City>, String>{
  final CityRepository _cityRepository;
  SaveCityUseCase(this._cityRepository);

  @override
  Future<DataState<City>> call(String params) {
    return _cityRepository.saveCityToDB(params);
  }

  @override
  Future<void> onError(Exception e) {
    // TODO: implement onError
    throw UnimplementedError();
  }
}