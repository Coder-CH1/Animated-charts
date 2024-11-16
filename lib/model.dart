import 'dart:convert';
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

List<dynamic> welcomeFromJson(String str) => List<dynamic>.from(json.decode(str).map((x) => x));

String welcomeToJson(List<dynamic> data) => json.encode(List<dynamic>.from(data.map((x) => x)));

class WelcomeElement {
  String id;
  String iso2Code;
  String name;
  Adminregion region;
  Adminregion adminregion;
  Adminregion incomeLevel;
  Adminregion lendingType;
  String capitalCity;
  String longitude;
  String latitude;

  WelcomeElement({
    required this.id,
    required this.iso2Code,
    required this.name,
    required this.region,
    required this.adminregion,
    required this.incomeLevel,
    required this.lendingType,
    required this.capitalCity,
    required this.longitude,
    required this.latitude,
  });

  factory WelcomeElement.fromJson(Map<String, dynamic> json) => WelcomeElement(
    id: json["id"],
    iso2Code: json["iso2Code"],
    name: json["name"],
    region: Adminregion.fromJson(json["region"]),
    adminregion: Adminregion.fromJson(json["adminregion"]),
    incomeLevel: Adminregion.fromJson(json["incomeLevel"]),
    lendingType: Adminregion.fromJson(json["lendingType"]),
    capitalCity: json["capitalCity"],
    longitude: json["longitude"],
    latitude: json["latitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "iso2Code": iso2Code,
    "name": name,
    "region": region.toJson(),
    "adminregion": adminregion.toJson(),
    "incomeLevel": incomeLevel.toJson(),
    "lendingType": lendingType.toJson(),
    "capitalCity": capitalCity,
    "longitude": longitude,
    "latitude": latitude,
  };
}

class Adminregion {
  String id;
  String iso2Code;
  String value;

  Adminregion({
    required this.id,
    required this.iso2Code,
    required this.value,
  });

  factory Adminregion.fromJson(Map<String, dynamic> json) => Adminregion(
    id: json["id"],
    iso2Code: json["iso2code"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "iso2code": iso2Code,
    "value": value,
  };
}

class PurpleWelcome {
  int page;
  int pages;
  String perPage;
  int total;

  PurpleWelcome({
    required this.page,
    required this.pages,
    required this.perPage,
    required this.total,
  });

  factory PurpleWelcome.fromJson(Map<String, dynamic> json) => PurpleWelcome(
    page: json["page"],
    pages: json["pages"],
    perPage: json["per_page"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "pages": pages,
    "per_page": perPage,
    "total": total,
  };
}

class PlaceholderChartData {
  final String x;
  final double y;

  PlaceholderChartData(this.x, this.y);
}
