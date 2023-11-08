import 'dart:convert';

LokasiModel lokasiModelFromJson(String str) =>
    LokasiModel.fromJson(json.decode(str));
String lokasiModelToJson(LokasiModel data) => json.encode(data.toJson());

class LokasiModel {
  final String status;
  final List<Lokasi> data;

  LokasiModel({
    required this.status,
    required this.data,
  });

  factory LokasiModel.fromJson(Map<String, dynamic> json) => LokasiModel(
        status: json["status"],
        data: List<Lokasi>.from(json["data"].map((x) => Lokasi.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Lokasi {
  final String nama;

  Lokasi({
    required this.nama,
  });

  factory Lokasi.fromJson(Map<String, dynamic> json) => Lokasi(
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
      };
}
