
import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/city_repository.dart';

import '../entities/city_model.dart';

class GetCityUseCase implements UseCase<DataState<City?>, String>{
  final CityRepository _cityRepository;
  GetCityUseCase(this._cityRepository);

  @override
  Future<DataState<City?>> call(String params) {
      return _cityRepository.findCityByName(params);
  }

  @override
  Future<void> onError(Exception e) {
    // TODO: implement onError
    throw UnimplementedError();
  }
}