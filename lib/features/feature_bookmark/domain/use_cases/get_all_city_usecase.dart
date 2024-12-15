

import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/city_repository.dart';

import '../entities/city_model.dart';


class GetAllCityUseCase implements UseCase<DataState<List<City>>, NoParams>{
  final CityRepository _cityRepository;
  GetAllCityUseCase(this._cityRepository);

  @override
  Future<DataState<List<City>>> call(NoParams params) {
    return _cityRepository.getAllCityFromDB();
  }

  @override
  Future<void> onError(Exception e) {
    // TODO: implement onError
    throw UnimplementedError();
  }
}