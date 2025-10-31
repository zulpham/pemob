import 'dart:convert';

City CityFromJson(String str) => City.fromJson(json.decode(str));

String cityToJson(City data) => json.encode(data.toJson());

class City {
  City({
    required this.id,
    required this.idProvinsi,
    required this.name,
  });

  String id;
  String idProvinsi;
  String name;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    idProvinsi: json["id_provinsi"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_provinsi": idProvinsi,
    "name": name,
  };

  @override
  String toString() => name;
}
