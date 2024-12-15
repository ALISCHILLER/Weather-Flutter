import '../../domain/entites/city_info_entity.dart';

/// مدل اطلاعات شهرها که شامل داده‌ها، لینک‌ها و متادیتا می‌باشد
class CityInfoModel extends CityInfoEntity {
  // سازنده اصلی که داده‌ها، لینک‌ها و متادیتا را از ورودی می‌گیرد
  CityInfoModel({
    required List<Data>? data,
    required List<Links> links,
    required Metadata metadata,
  }) : super(
    data: data,
    links: links,
    metadata: metadata,
  );

  // متد برای ساخت شیء از داده‌های JSON
  CityInfoModel.fromJson(dynamic json) {
    // اگر داده‌ها موجود باشد، آن‌ها را تبدیل به لیست 'Data' می‌کنیم
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    // اگر لینک‌ها موجود باشد، آن‌ها را تبدیل به لیست 'Links' می‌کنیم
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links?.add(Links.fromJson(v));
      });
    }
    // اگر متادیتا موجود باشد، آن را از JSON استخراج می‌کنیم
    metadata = json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
  }

  // فیلدهای مدل
  List<Data>? data;
  List<Links>? links;
  Metadata? metadata;

  // متد کپی کردن شیء و ایجاد نسخه جدید با داده‌های تغییر یافته
  // CityInfoModel copyWith({
  //   List<Data>? data,
  //   List<Links>? links,
  //   Metadata? metadata,
  // }) =>
  //     CityInfoModel(
  //       data: data ?? this.data,
  //       links: links ?? this.links,
  //       metadata: metadata ?? this.metadata,
  //     );

  // تبدیل شیء به فرمت JSON برای ارسال به API یا ذخیره‌سازی
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList(); // تبدیل داده‌ها به فرمت JSON
    }
    if (links != null) {
      map['links'] = links?.map((v) => v.toJson()).toList(); // تبدیل لینک‌ها به فرمت JSON
    }
    if (metadata != null) {
      map['metadata'] = metadata?.toJson(); // تبدیل متادیتا به فرمت JSON
    }
    return map;
  }
}

/// مدل متادیتا که شامل 'currentOffset' و 'totalCount' می‌باشد
class Metadata {
  Metadata({
    this.currentOffset,
    this.totalCount,
  });

  // ساخت شیء از داده‌های JSON
  Metadata.fromJson(dynamic json) {
    currentOffset = json['currentOffset'];
    totalCount = json['totalCount'];
  }

  int? currentOffset; // شماره‌ای که نشان‌دهنده موقعیت فعلی در داده‌ها است
  int? totalCount; // تعداد کل موارد در داده‌ها

  // متد کپی کردن شیء و ایجاد نسخه جدید با داده‌های تغییر یافته
  Metadata copyWith({
    int? currentOffset,
    int? totalCount,
  }) =>
      Metadata(
        currentOffset: currentOffset ?? this.currentOffset,
        totalCount: totalCount ?? this.totalCount,
      );

  // تبدیل شیء به فرمت JSON برای ارسال به API یا ذخیره‌سازی
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentOffset'] = currentOffset;
    map['totalCount'] = totalCount;
    return map;
  }
}

/// مدل لینک‌ها که شامل 'rel' و 'href' است
class Links {
  Links({
    this.rel,
    this.href,
  });

  // ساخت شیء از داده‌های JSON
  Links.fromJson(dynamic json) {
    rel = json['rel'];
    href = json['href'];
  }

  String? rel; // نوع ارتباط (مثلاً "first", "next", "last")
  String? href; // URL مربوط به لینک

  // متد کپی کردن شیء و ایجاد نسخه جدید با داده‌های تغییر یافته
  Links copyWith({
    String? rel,
    String? href,
  }) =>
      Links(
        rel: rel ?? this.rel,
        href: href ?? this.href,
      );

  // تبدیل شیء به فرمت JSON برای ارسال به API یا ذخیره‌سازی
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rel'] = rel;
    map['href'] = href;
    return map;
  }
}

/// مدل داده‌های مربوط به شهر که شامل اطلاعات مختلفی از جمله 'id', 'city', 'name' و ... است
class Data {
  Data({
    this.id,
    this.wikiDataId,
    this.type,
    this.city,
    this.name,
    this.country,
    this.countryCode,
    this.region,
    this.regionCode,
    this.regionWdId,
    this.latitude,
    this.longitude,
    this.population,
  });

  // ساخت شیء از داده‌های JSON
  Data.fromJson(dynamic json) {
    id = json['id'];
    wikiDataId = json['wikiDataId'];
    type = json['type'];
    city = json['city'];
    name = json['name'];
    country = json['country'];
    countryCode = json['countryCode'];
    region = json['region'];
    regionCode = json['regionCode'];
    regionWdId = json['regionWdId'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    population = json['population'];
  }

  int? id; // شناسه شهر
  String? wikiDataId; // شناسه در ویکی‌دیتا
  String? type; // نوع داده (برای مثال CITY)
  String? city; // نام شهر
  String? name; // نام دیگر شهر
  String? country; // کشور
  String? countryCode; // کد کشور
  String? region; // منطقه
  String? regionCode; // کد منطقه
  String? regionWdId; // شناسه ویکی‌دیتا منطقه
  double? latitude; // عرض جغرافیایی
  double? longitude; // طول جغرافیایی
  int? population; // جمعیت

  // متد کپی کردن شیء و ایجاد نسخه جدید با داده‌های تغییر یافته
  Data copyWith({
    int? id,
    String? wikiDataId,
    String? type,
    String? city,
    String? name,
    String? country,
    String? countryCode,
    String? region,
    String? regionCode,
    String? regionWdId,
    double? latitude,
    double? longitude,
    int? population,
  }) =>
      Data(
        id: id ?? this.id,
        wikiDataId: wikiDataId ?? this.wikiDataId,
        type: type ?? this.type,
        city: city ?? this.city,
        name: name ?? this.name,
        country: country ?? this.country,
        countryCode: countryCode ?? this.countryCode,
        region: region ?? this.region,
        regionCode: regionCode ?? this.regionCode,
        regionWdId: regionWdId ?? this.regionWdId,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        population: population ?? this.population,
      );

  // تبدیل شیء به فرمت JSON برای ارسال به API یا ذخیره‌سازی
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['wikiDataId'] = wikiDataId;
    map['type'] = type;
    map['city'] = city;
    map['name'] = name;
    map['country'] = country;
    map['countryCode'] = countryCode;
    map['region'] = region;
    map['regionCode'] = regionCode;
    map['regionWdId'] = regionWdId;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['population'] = population;
    return map;
  }
}
