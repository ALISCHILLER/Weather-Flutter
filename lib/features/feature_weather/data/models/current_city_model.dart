import '../../domain/entites/cureent_city_entity.dart';

/// coord : {"lon":7.367,"lat":45.133}
/// weather : [{"id":501,"main":"Rain","description":"moderate rain","icon":"10d"}]
/// base : "stations"
/// main : {"temp":284.2,"feels_like":282.93,"temp_min":283.06,"temp_max":286.82,"pressure":1021,"humidity":60,"sea_level":1021,"grnd_level":910}
/// visibility : 10000
/// wind : {"speed":4.09,"deg":121,"gust":3.47}
/// rain : {"1h":2.73}
/// clouds : {"all":83}
/// dt : 1726660758
/// sys : {"type":1,"id":6736,"country":"IT","sunrise":1726636384,"sunset":1726680975}
/// timezone : 7200
/// id : 3165523
/// name : "Province of Turin"
/// cod : 200

class CurrentCityModel extends CurrentCityEntity {
  CurrentCityModel({
    required Coord coord,
    required List<Weather> weather,
    required String base,
    required Main main,
    required num visibility,
    required Wind wind,
    required Rain rain,
    required Clouds clouds,
    required num dt,
    required Sys sys,
    required num timezone,
    required num id,
    required String name,
    required num cod,
  }) : super(
            coord: coord,
            weather: weather,
            base: base,
            main: main,
            visibility: visibility,
            wind: wind,
            rain: rain,
            clouds: clouds,
            dt: dt,
            sys: sys,
            timezone: timezone,
            id: id,
            name: name,
            cod: cod);

  // تبدیل JSON به مدل Dart
  factory CurrentCityModel.fromJson(dynamic json) {
    List<Weather> weather = [];

    if (json['weather'] != null) {
      json['weather'].forEach((v) {
        weather.add(Weather.fromJson(v));
      });
    }

    return CurrentCityModel(
        coord: json['coord'] != null ? Coord.fromJson(json['coord']) : Coord(lon: 0, lat: 0),
        weather: weather,
        base: json['base'] ?? 'stations',
        main: json['main'] != null ? Main.fromJson(json['main']) : Main(),
        visibility: json['visibility'] ?? 0,
        wind: json['wind'] != null ? Wind.fromJson(json['wind']) : Wind(),
        rain: json['rain'] != null ? Rain.fromJson(json['rain']) : Rain(),
        clouds: json['clouds'] != null ? Clouds.fromJson(json['clouds']) : Clouds(),
        dt: json['dt'] ?? 0,
        sys: json['sys'] != null ? Sys.fromJson(json['sys']) : Sys(),
        timezone: json['timezone'] ?? 0,
        id: json['id'] ?? 0,
        name: json['name'] ?? 'Unknown',
        cod: json['cod'] ?? 0);
  }
  // تبدیل مدل Dart به JSON
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coord'] = coord?.toJson();
    map['weather'] = weather?.map((v) => v.toJson()).toList();
    map['base'] = base;
    map['main'] = main?.toJson();
    map['visibility'] = visibility;
    map['wind'] = wind?.toJson();
    map['rain'] = rain?.toJson();
    map['clouds'] = clouds?.toJson();
    map['dt'] = dt;
    map['sys'] = sys?.toJson();
    map['timezone'] = timezone;
    map['id'] = id;
    map['name'] = name;
    map['cod'] = cod;
    return map;
  }
}

/// type : 1
/// id : 6736
/// country : "IT"
/// sunrise : 1726636384
/// sunset : 1726680975

class Sys {
  Sys({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });

  Sys.fromJson(dynamic json) {
    type = json['type'];
    id = json['id'];
    country = json['country'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  int? type;
  int? id;
  String? country;
  int? sunrise;
  int? sunset;

  Sys copyWith({
    int? type,
    int? id,
    String? country,
    int? sunrise,
    int? sunset,
  }) =>
      Sys(
        type: type ?? this.type,
        id: id ?? this.id,
        country: country ?? this.country,
        sunrise: sunrise ?? this.sunrise,
        sunset: sunset ?? this.sunset,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['id'] = id;
    map['country'] = country;
    map['sunrise'] = sunrise;
    map['sunset'] = sunset;
    return map;
  }
}

/// all : 83

class Clouds {
  Clouds({
    this.all,
  });

  Clouds.fromJson(dynamic json) {
    all = json['all'];
  }

  int? all;

  Clouds copyWith({
    int? all,
  }) =>
      Clouds(
        all: all ?? this.all,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['all'] = all;
    return map;
  }
}

/// 1h : 2.73

class Rain {
  Rain({
    this.h,
  });

  Rain.fromJson(dynamic json) {
    h = json['1h'];
  }

  double? h;

  Rain copyWith({
    double? h,
  }) =>
      Rain(
        h: h ?? this.h,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['1h'] = h;
    return map;
  }
}

/// speed : 4.09
/// deg : 121
/// gust : 3.47

class Wind {
  Wind({
    this.speed,
    this.deg,
    this.gust,
  });

  Wind.fromJson(dynamic json) {
    speed = json['speed'];
    deg = json['deg'];
    gust = json['gust'];
  }

  double? speed;
  int? deg;
  double? gust;

  Wind copyWith({
    double? speed,
    int? deg,
    double? gust,
  }) =>
      Wind(
        speed: speed ?? this.speed,
        deg: deg ?? this.deg,
        gust: gust ?? this.gust,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['speed'] = speed;
    map['deg'] = deg;
    map['gust'] = gust;
    return map;
  }
}

/// temp : 284.2
/// feels_like : 282.93
/// temp_min : 283.06
/// temp_max : 286.82
/// pressure : 1021
/// humidity : 60
/// sea_level : 1021
/// grnd_level : 910

class Main {
  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  Main.fromJson(dynamic json) {
    temp = json['temp'];
    feelsLike = json['feels_like'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    seaLevel = json['sea_level'];
    grndLevel = json['grnd_level'];
  }

  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  int? seaLevel;
  int? grndLevel;

  Main copyWith({
    double? temp,
    double? feelsLike,
    double? tempMin,
    double? tempMax,
    int? pressure,
    int? humidity,
    int? seaLevel,
    int? grndLevel,
  }) =>
      Main(
        temp: temp ?? this.temp,
        feelsLike: feelsLike ?? this.feelsLike,
        tempMin: tempMin ?? this.tempMin,
        tempMax: tempMax ?? this.tempMax,
        pressure: pressure ?? this.pressure,
        humidity: humidity ?? this.humidity,
        seaLevel: seaLevel ?? this.seaLevel,
        grndLevel: grndLevel ?? this.grndLevel,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['temp'] = temp;
    map['feels_like'] = feelsLike;
    map['temp_min'] = tempMin;
    map['temp_max'] = tempMax;
    map['pressure'] = pressure;
    map['humidity'] = humidity;
    map['sea_level'] = seaLevel;
    map['grnd_level'] = grndLevel;
    return map;
  }
}

/// id : 501
/// main : "Rain"
/// description : "moderate rain"
/// icon : "10d"

class Weather {
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  Weather.fromJson(dynamic json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  int? id;
  String? main;
  String? description;
  String? icon;

  Weather copyWith({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) =>
      Weather(
        id: id ?? this.id,
        main: main ?? this.main,
        description: description ?? this.description,
        icon: icon ?? this.icon,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['main'] = main;
    map['description'] = description;
    map['icon'] = icon;
    return map;
  }
}

/// lon : 7.367
/// lat : 45.133

class Coord {
  Coord({
    this.lon,
    this.lat,
  });

  Coord.fromJson(dynamic json) {
    lon = json['lon'];
    lat = json['lat'];
  }

  double? lon;
  double? lat;

  Coord copyWith({
    double? lon,
    double? lat,
  }) =>
      Coord(
        lon: lon ?? this.lon,
        lat: lat ?? this.lat,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lon'] = lon;
    map['lat'] = lat;
    return map;
  }
}
