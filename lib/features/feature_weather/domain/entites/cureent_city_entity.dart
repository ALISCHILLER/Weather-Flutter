
import 'package:equatable/equatable.dart';

import '../../data/models/current_city_model.dart';

// تعریف کلاس CurrentCityEntity که یک entity برای نمایندگی داده‌های وضعیت فعلی شهر است
class CurrentCityEntity extends Equatable {
  // تعریف ویژگی‌های کلاس که تمام اطلاعات مربوط به وضعیت شهر را نگه می‌دارد
  final Coord? coord; // مختصات جغرافیایی شهر
  final List<Weather>? weather; // لیستی از وضعیت‌های جوی
  final String? base; // مبنای داده‌ها (مثلاً 'stations' یا 'openweathermap')
  final Main? main; // اطلاعات مربوط به وضعیت دما و فشار
  final num? visibility; // میزان دید
  final Wind? wind; // اطلاعات مربوط به وضعیت باد
  final Rain? rain; // اطلاعات بارش باران (در صورت وجود)
  final Clouds? clouds; // اطلاعات وضعیت ابرها
  final num? dt; // زمان داده‌ها (تاریخ/زمان UNIX)
  final Sys? sys; // اطلاعات مربوط به سیستم (کشور، تایم‌زون و غیره)
  final num? timezone; // منطقه زمانی
  final num? id; // شناسه‌ی منحصر به فرد شهر
  final String? name; // نام شهر
  final num? cod; // کد وضعیت پاسخ از API

  // سازنده برای کلاس CurrentCityEntity که تمامی ویژگی‌ها را مقداردهی می‌کند
  const CurrentCityEntity({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.rain,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  @override
  // متد `props` برای مقایسه ساختاری شیء با استفاده از `Equatable`
  // این متد باید تمام فیلدهای مهم را برگرداند تا بتوان به درستی مقایسه کرد
  List<Object?> get props => [
    coord,   // اضافه کردن مختصات به مقایسه
    weather, // وضعیت‌های جوی
    base,    // مبنای داده‌ها
    main,    // وضعیت اصلی (دما و فشار)
    visibility, // دید
    wind,    // باد
    rain,    // باران
    clouds,  // ابرها
    dt,      // زمان
    sys,     // سیستم
    timezone,// منطقه زمانی
    id,      // شناسه شهر
    name,    // نام شهر
    cod,     // کد وضعیت
  ];

  // // متد برای تبدیل این entity به یک مپ (Map) برای ارسال یا ذخیره‌سازی
  // Map<String, dynamic> toMap() {
  //   return {
  //     'coord': coord?.toMap(),
  //     'weather': weather?.map((e) => e.toMap()).toList(),
  //     'base': base,
  //     'main': main?.toMap(),
  //     'visibility': visibility,
  //     'wind': wind?.toMap(),
  //     'rain': rain?.toMap(),
  //     'clouds': clouds?.toMap(),
  //     'dt': dt,
  //     'sys': sys?.toMap(),
  //     'timezone': timezone,
  //     'id': id,
  //     'name': name,
  //     'cod': cod,
  //   };
  // }
  //
  // // متد برای ایجاد یک entity از مپ داده‌ها
  // factory CurrentCityEntity.fromMap(Map<String, dynamic> map) {
  //   return CurrentCityEntity(
  //     coord: map['coord'] != null ? Coord.fromMap(map['coord']) : null,
  //     weather: map['weather'] != null
  //         ? List<Weather>.from(map['weather'].map((x) => Weather.fromMap(x)))
  //         : null,
  //     base: map['base'],
  //     main: map['main'] != null ? Main.fromMap(map['main']) : null,
  //     visibility: map['visibility'],
  //     wind: map['wind'] != null ? Wind.fromMap(map['wind']) : null,
  //     rain: map['rain'] != null ? Rain.fromMap(map['rain']) : null,
  //     clouds: map['clouds'] != null ? Clouds.fromMap(map['clouds']) : null,
  //     dt: map['dt'],
  //     sys: map['sys'] != null ? Sys.fromMap(map['sys']) : null,
  //     timezone: map['timezone'],
  //     id: map['id'],
  //     name: map['name'],
  //     cod: map['cod'],
  //   );
  // }
}