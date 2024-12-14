import '../../domain/entites/forecast_day_entity.dart';

/// cod : "200"
/// message : 0
/// cnt : 40
/// list : [{"dt":1734177600,"main":{"temp":279.5,"feels_like":279.5,"temp_min":278.51,"temp_max":279.5,"pressure":1021,"sea_level":1021,"grnd_level":944,"humidity":93,"temp_kf":0.99},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":{"all":93},"wind":{"speed":0.23,"deg":10,"gust":1.74},"visibility":10000,"pop":0,"sys":{"pod":"d"},"dt_txt":"2024-12-14 12:00:00"},{"dt":1734188400,"main":{"temp":278.77,"feels_like":278.77,"temp_min":277.32,"temp_max":278.77,"pressure":1021,"sea_level":1021,"grnd_level":943,"humidity":94,"temp_kf":1.45},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":{"all":95},"wind":{"speed":0.89,"deg":123,"gust":1.48},"visibility":10000,"pop":0,"sys":{"pod":"d"},"dt_txt":"2024-12-14 15:00:00"},{"dt":1734199200,"main":{"temp":277.39,"feels_like":277.39,"temp_min":276.33,"temp_max":277.39,"pressure":1021,"sea_level":1021,"grnd_level":943,"humidity":96,"temp_kf":1.06},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":98},"wind":{"speed":0.64,"deg":335,"gust":0.73},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-14 18:00:00"},{"dt":1734210000,"main":{"temp":276.24,"feels_like":276.24,"temp_min":276.24,"temp_max":276.24,"pressure":1021,"sea_level":1021,"grnd_level":944,"humidity":99,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":100},"wind":{"speed":0.62,"deg":11,"gust":0.77},"visibility":78,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-14 21:00:00"},{"dt":1734220800,"main":{"temp":276.18,"feels_like":276.18,"temp_min":276.18,"temp_max":276.18,"pressure":1021,"sea_level":1021,"grnd_level":944,"humidity":100,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":100},"wind":{"speed":0.77,"deg":14,"gust":1.05},"visibility":3036,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-15 00:00:00"},{"dt":1734231600,"main":{"temp":275.73,"feels_like":275.73,"temp_min":275.73,"temp_max":275.73,"pressure":1022,"sea_level":1022,"grnd_level":944,"humidity":99,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04n"}],"clouds":{"all":90},"wind":{"speed":0.21,"deg":299,"gust":0.74},"visibility":1333,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-15 03:00:00"},{"dt":1734242400,"main":{"temp":274.7,"feels_like":274.7,"temp_min":274.7,"temp_max":274.7,"pressure":1023,"sea_level":1023,"grnd_level":945,"humidity":95,"temp_kf":0},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"clouds":{"all":81},"wind":{"speed":0.96,"deg":284,"gust":1.1},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-15 06:00:00"},{"dt":1734253200,"main":{"temp":276.73,"feels_like":276.73,"temp_min":276.73,"temp_max":276.73,"pressure":1025,"sea_level":1025,"grnd_level":947,"humidity":84,"temp_kf":0},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02d"}],"clouds":{"all":17},"wind":{"speed":0.91,"deg":333,"gust":1.16},"visibility":10000,"pop":0,"sys":{"pod":"d"},"dt_txt":"2024-12-15 09:00:00"},{"dt":1734264000,"main":{"temp":278.59,"feels_like":277.13,"temp_min":278.59,"temp_max":278.59,"pressure":1026,"sea_level":1026,"grnd_level":949,"humidity":76,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":{"all":10},"wind":{"speed":1.9,"deg":350,"gust":2.38},"visibility":10000,"pop":0,"sys":{"pod":"d"},"dt_txt":"2024-12-15 12:00:00"},{"dt":1734274800,"main":{"temp":276.89,"feels_like":276.89,"temp_min":276.89,"temp_max":276.89,"pressure":1028,"sea_level":1028,"grnd_level":950,"humidity":86,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":{"all":0},"wind":{"speed":1.27,"deg":345,"gust":0.93},"visibility":10000,"pop":0,"sys":{"pod":"d"},"dt_txt":"2024-12-15 15:00:00"},{"dt":1734285600,"main":{"temp":274.54,"feels_like":272.72,"temp_min":274.54,"temp_max":274.54,"pressure":1031,"sea_level":1031,"grnd_level":952,"humidity":87,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"clouds":{"all":0},"wind":{"speed":1.68,"deg":230,"gust":0.8},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-15 18:00:00"},{"dt":1734296400,"main":{"temp":274.13,"feels_like":272.09,"temp_min":274.13,"temp_max":274.13,"pressure":1033,"sea_level":1033,"grnd_level":954,"humidity":81,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"clouds":{"all":1},"wind":{"speed":1.8,"deg":236,"gust":0.99},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-15 21:00:00"},{"dt":1734307200,"main":{"temp":273.98,"feels_like":271.93,"temp_min":273.98,"temp_max":273.98,"pressure":1034,"sea_level":1034,"grnd_level":955,"humidity":75,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"clouds":{"all":1},"wind":{"speed":1.79,"deg":235,"gust":1.14},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-16 00:00:00"},{"dt":1734318000,"main":{"temp":273.92,"feels_like":271.35,"temp_min":273.92,"temp_max":273.92,"pressure":1035,"sea_level":1035,"grnd_level":956,"humidity":72,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"clouds":{"all":7},"wind":{"speed":2.21,"deg":222,"gust":1.42},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-16 03:00:00"},{"dt":1734328800,"main":{"temp":274.06,"feels_like":271.49,"temp_min":274.06,"temp_max":274.06,"pressure":1036,"sea_level":1036,"grnd_level":957,"humidity":69,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"clouds":{"all":3},"wind":{"speed":2.23,"deg":224,"gust":1.52},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-16 06:00:00"},{"dt":1734339600,"main":{"temp":278.9,"feels_like":278.9,"temp_min":278.9,"temp_max":278.9,"pressure":1036,"sea_level":1036,"grnd_level":958,"humidity":61,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":{"all":0},"wind":{"speed":0.95,"deg":227,"gust":0.7},"visibility":10000,"pop":0,"sys":{"pod":"d"},"dt_txt":"2024-12-16 09:00:00"},{"dt":1734350400,"main":{"temp":281.2,"feels_like":281.2,"temp_min":281.2,"temp_max":281.2,"pressure":1035,"sea_level":1035,"grnd_level":958,"humidity":58,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":{"all":0},"wind":{"speed":0.82,"deg":28,"gust":0.28},"visibility":10000,"pop":0,"sys":{"pod":"d"},"dt_txt":"2024-12-16 12:00:00"},{"dt":1734361200,"main":{"temp":278.56,"feels_like":278.56,"temp_min":278.56,"temp_max":278.56,"pressure":1035,"sea_level":1035,"grnd_level":957,"humidity":78,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":{"all":0},"wind":{"speed":0.86,"deg":179,"gust":0.93},"visibility":10000,"pop":0,"sys":{"pod":"d"},"dt_txt":"2024-12-16 15:00:00"},{"dt":1734372000,"main":{"temp":276.42,"feels_like":274.07,"temp_min":276.42,"temp_max":276.42,"pressure":1036,"sea_level":1036,"grnd_level":957,"humidity":72,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"clouds":{"all":2},"wind":{"speed":2.43,"deg":212,"gust":1.79},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-16 18:00:00"},{"dt":1734382800,"main":{"temp":275.96,"feels_like":273.26,"temp_min":275.96,"temp_max":275.96,"pressure":1035,"sea_level":1035,"grnd_level":957,"humidity":66,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"clouds":{"all":0},"wind":{"speed":2.72,"deg":211,"gust":1.95},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-16 21:00:00"},{"dt":1734393600,"main":{"temp":275.95,"feels_like":273.22,"temp_min":275.95,"temp_max":275.95,"pressure":1034,"sea_level":1034,"grnd_level":956,"humidity":62,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"clouds":{"all":0},"wind":{"speed":2.75,"deg":209,"gust":2.02},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-17 00:00:00"},{"dt":1734404400,"main":{"temp":275.49,"feels_like":272.93,"temp_min":275.49,"temp_max":275.49,"pressure":1033,"sea_level":1033,"grnd_level":955,"humidity":59,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"clouds":{"all":0},"wind":{"speed":2.47,"deg":214,"gust":1.7},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-17 03:00:00"},{"dt":1734415200,"main":{"temp":275.24,"feels_like":272.24,"temp_min":275.24,"temp_max":275.24,"pressure":1033,"sea_level":1033,"grnd_level":954,"humidity":60,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"clouds":{"all":3},"wind":{"speed":2.9,"deg":205,"gust":2.06},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-17 06:00:00"},{"dt":1734426000,"main":{"temp":278.81,"feels_like":278.01,"temp_min":278.81,"temp_max":278.81,"pressure":1032,"sea_level":1032,"grnd_level":955,"humidity":65,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":{"all":8},"wind":{"speed":1.38,"deg":196,"gust":2.19},"visibility":10000,"pop":0,"sys":{"pod":"d"},"dt_txt":"2024-12-17 09:00:00"},{"dt":1734436800,"main":{"temp":281.78,"feels_like":281.78,"temp_min":281.78,"temp_max":281.78,"pressure":1030,"sea_level":1030,"grnd_level":953,"humidity":61,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":{"all":5},"wind":{"speed":0.45,"deg":138,"gust":1.88},"visibility":10000,"pop":0,"sys":{"pod":"d"},"dt_txt":"2024-12-17 12:00:00"},{"dt":1734447600,"main":{"temp":278.53,"feels_like":278.53,"temp_min":278.53,"temp_max":278.53,"pressure":1030,"sea_level":1030,"grnd_level":953,"humidity":84,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"clouds":{"all":0},"wind":{"speed":0.72,"deg":174,"gust":1.16},"visibility":10000,"pop":0,"sys":{"pod":"d"},"dt_txt":"2024-12-17 15:00:00"},{"dt":1734458400,"main":{"temp":276.33,"feels_like":274.08,"temp_min":276.33,"temp_max":276.33,"pressure":1031,"sea_level":1031,"grnd_level":953,"humidity":91,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"clouds":{"all":2},"wind":{"speed":2.31,"deg":212,"gust":2.43},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-17 18:00:00"},{"dt":1734469200,"main":{"temp":276.08,"feels_like":273.67,"temp_min":276.08,"temp_max":276.08,"pressure":1031,"sea_level":1031,"grnd_level":953,"humidity":90,"temp_kf":0},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"clouds":{"all":66},"wind":{"speed":2.42,"deg":211,"gust":2.23},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-17 21:00:00"},{"dt":1734480000,"main":{"temp":275.72,"feels_like":273.15,"temp_min":275.72,"temp_max":275.72,"pressure":1031,"sea_level":1031,"grnd_level":952,"humidity":82,"temp_kf":0},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"clouds":{"all":63},"wind":{"speed":2.52,"deg":213,"gust":1.81},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-18 00:00:00"},{"dt":1734490800,"main":{"temp":275.39,"feels_like":272.87,"temp_min":275.39,"temp_max":275.39,"pressure":1030,"sea_level":1030,"grnd_level":952,"humidity":83,"temp_kf":0},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"clouds":{"all":63},"wind":{"speed":2.41,"deg":213,"gust":1.82},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-18 03:00:00"},{"dt":1734501600,"main":{"temp":275.29,"feels_like":273.04,"temp_min":275.29,"temp_max":275.29,"pressure":1030,"sea_level":1030,"grnd_level":952,"humidity":84,"temp_kf":0},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"clouds":{"all":53},"wind":{"speed":2.13,"deg":215,"gust":1.55},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-18 06:00:00"},{"dt":1734512400,"main":{"temp":278.66,"feels_like":278.66,"temp_min":278.66,"temp_max":278.66,"pressure":1030,"sea_level":1030,"grnd_level":952,"humidity":80,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":{"all":100},"wind":{"speed":0.7,"deg":222,"gust":1.22},"visibility":10000,"pop":0,"sys":{"pod":"d"},"dt_txt":"2024-12-18 09:00:00"},{"dt":1734523200,"main":{"temp":280.8,"feels_like":280.8,"temp_min":280.8,"temp_max":280.8,"pressure":1027,"sea_level":1027,"grnd_level":951,"humidity":75,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":{"all":100},"wind":{"speed":0.78,"deg":40,"gust":0.81},"visibility":10000,"pop":0,"sys":{"pod":"d"},"dt_txt":"2024-12-18 12:00:00"},{"dt":1734534000,"main":{"temp":278.76,"feels_like":278.76,"temp_min":278.76,"temp_max":278.76,"pressure":1027,"sea_level":1027,"grnd_level":950,"humidity":87,"temp_kf":0},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"clouds":{"all":80},"wind":{"speed":0.59,"deg":107,"gust":0.68},"visibility":10000,"pop":0,"sys":{"pod":"d"},"dt_txt":"2024-12-18 15:00:00"},{"dt":1734544800,"main":{"temp":277.08,"feels_like":275.92,"temp_min":277.08,"temp_max":277.08,"pressure":1028,"sea_level":1028,"grnd_level":950,"humidity":90,"temp_kf":0},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"clouds":{"all":61},"wind":{"speed":1.47,"deg":211,"gust":1.04},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-18 18:00:00"},{"dt":1734555600,"main":{"temp":276.69,"feels_like":274.82,"temp_min":276.69,"temp_max":276.69,"pressure":1027,"sea_level":1027,"grnd_level":950,"humidity":89,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"clouds":{"all":7},"wind":{"speed":2,"deg":216,"gust":1.65},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-18 21:00:00"},{"dt":1734566400,"main":{"temp":276.41,"feels_like":274.4,"temp_min":276.41,"temp_max":276.41,"pressure":1026,"sea_level":1026,"grnd_level":949,"humidity":89,"temp_kf":0},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"clouds":{"all":7},"wind":{"speed":2.08,"deg":214,"gust":1.65},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-19 00:00:00"},{"dt":1734577200,"main":{"temp":276.17,"feels_like":274.03,"temp_min":276.17,"temp_max":276.17,"pressure":1025,"sea_level":1025,"grnd_level":948,"humidity":88,"temp_kf":0},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"clouds":{"all":52},"wind":{"speed":2.17,"deg":213,"gust":1.63},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-19 03:00:00"},{"dt":1734588000,"main":{"temp":276.05,"feels_like":273.75,"temp_min":276.05,"temp_max":276.05,"pressure":1024,"sea_level":1024,"grnd_level":946,"humidity":89,"temp_kf":0},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"clouds":{"all":70},"wind":{"speed":2.31,"deg":202,"gust":1.89},"visibility":10000,"pop":0,"sys":{"pod":"n"},"dt_txt":"2024-12-19 06:00:00"},{"dt":1734598800,"main":{"temp":278.93,"feels_like":278.93,"temp_min":278.93,"temp_max":278.93,"pressure":1023,"sea_level":1023,"grnd_level":946,"humidity":85,"temp_kf":0},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"clouds":{"all":95},"wind":{"speed":1.24,"deg":203,"gust":2.61},"visibility":10000,"pop":0,"sys":{"pod":"d"},"dt_txt":"2024-12-19 09:00:00"}]
/// city : {"id":3171355,"name":"Pavullo nel Frignano","coord":{"lat":44.34,"lon":10.9},"country":"IT","population":15119,"timezone":3600,"sunrise":1734158698,"sunset":1734190656}

class ForecastDayModel extends ForecastDayEntity {
  ForecastDayModel({
    required String cod,
    required num message,
    required num cnt,
    required List<Collection> list,
    required City city,
  }) : super(cod: cod, message: message, cnt: cnt, list: list, city: city);

  factory ForecastDayModel.fromJson(Map<String, dynamic> json) {
    return ForecastDayModel(
      cod: json['cod'] as String,
      message: json['message'] as num,
      cnt: json['cnt'] as num,
      list: json['list'] != null
          ? List<Collection>.from(
              json['list'].map((v) => Collection.fromJson(v)))
          : [],
      city: json['city'] != null ? City.fromJson(json['city']) : City(),
    );
  }

}

class City {
  num? id;
  String? name;
  Coord? coord;
  String? country;
  num? population;
  num? timezone;
  num? sunrise;
  num? sunset;

  City({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] as num?,
      name: json['name'] as String?,
      coord: json['coord'] != null ? Coord.fromJson(json['coord']) : null,
      country: json['country'] as String?,
      population: json['population'] as num?,
      timezone: json['timezone'] as num?,
      sunrise: json['sunrise'] as num?,
      sunset: json['sunset'] as num?,
    );
  }

}

class Coord {
  num? lat;
  num? lon;

  Coord({
    this.lat,
    this.lon,
  });

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: json['lat'] as num?,
      lon: json['lon'] as num?,
    );
  }

}

class Collection {
  num? dt;
  Main? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind;
  num? visibility;
  num? pop;
  Sys? sys;
  String? dtTxt;

  Collection({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.sys,
    this.dtTxt,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      dt: json['dt'] as num?,
      main: json['main'] != null ? Main.fromJson(json['main']) : null,
      weather: json['weather'] != null
          ? List<Weather>.from(json['weather'].map((v) => Weather.fromJson(v)))
          : [],
      clouds: json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null,
      wind: json['wind'] != null ? Wind.fromJson(json['wind']) : null,
      visibility: json['visibility'] as num?,
      pop: json['pop'] as num?,
      sys: json['sys'] != null ? Sys.fromJson(json['sys']) : null,
      dtTxt: json['dt_txt'] as String?,
    );
  }

}

class Sys {
  String? pod;

  Sys({this.pod});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      pod: json['pod'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pod': pod,
    };
  }

  Sys copyWith({String? pod}) {
    return Sys(pod: pod ?? this.pod);
  }
}

class Wind {
  num? speed;
  num? deg;
  num? gust;

  Wind({
    this.speed,
    this.deg,
    this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'] as num?,
      deg: json['deg'] as num?,
      gust: json['gust'] as num?,
    );
  }


}

class Clouds {
  num? all;

  Clouds({this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'] as num?,
    );
  }
}

class Weather {
  num? id;
  String? main;
  String? description;
  String? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'] as num?,
      main: json['main'] as String?,
      description: json['description'] as String?,
      icon: json['icon'] as String?,
    );
  }

}

class Main {
  num? temp;
  num? feelsLike;
  num? tempMin;
  num? tempMax;
  num? pressure;
  num? seaLevel;
  num? grndLevel;
  num? humidity;
  num? tempKf;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'] as num?,
      feelsLike: json['feels_like'] as num?,
      tempMin: json['temp_min'] as num?,
      tempMax: json['temp_max'] as num?,
      pressure: json['pressure'] as num?,
      seaLevel: json['sea_level'] as num?,
      grndLevel: json['grnd_level'] as num?,
      humidity: json['humidity'] as num?,
      tempKf: json['temp_kf'] as num?,
    );
  }

}
