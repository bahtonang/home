import 'dart:convert';

PersonsModel personsModelFromJson(String str) =>
    PersonsModel.fromJson(json.decode(str));
String personsModelToJson(PersonsModel data) => json.encode(data.toJson());

class PersonsModel {
  final String status;
  final List<Persons> data;

  PersonsModel({
    required this.status,
    required this.data,
  });

  factory PersonsModel.fromJson(Map<String, dynamic> json) => PersonsModel(
        status: json["status"],
        data: List<Persons>.from(json["data"].map((x) => Persons.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Persons {
  final String pid;
  final String nama;
  final String hp;

  Persons({
    required this.pid,
    required this.nama,
    required this.hp,
  });

  factory Persons.fromJson(Map<String, dynamic> json) => Persons(
        pid: json["pid"],
        nama: json["nama"],
        hp: json["hp"],
      );

  Map<String, dynamic> toJson() => {
        "pid": pid,
        "nama": nama,
        "hp": hp,
      };
}
