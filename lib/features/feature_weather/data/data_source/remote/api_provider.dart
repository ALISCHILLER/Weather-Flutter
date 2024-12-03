import 'package:dio/dio.dart';
import 'package:weather_flutter/core/utils/constants.dart';

class ApiProvider {
  final Dio _dio = Dio();

  var apikey = Constants.apikey;
  /// current aeather api call
  Future<dynamic> callCurrentWeather(cityName) async {
    var response = await _dio.get('${Constants.baseUrl}/data/2.5/weather',
        queryParameters: {'q': cityName, 'appid': apikey, 'units': 'metric'}
    );
    print(response.data);
    return response;
  }
}
