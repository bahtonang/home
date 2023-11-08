import 'dart:convert';

TicketModel ticketModelFromJson(String str) =>
    TicketModel.fromJson(json.decode(str));

String ticketModelToJson(TicketModel data) => json.encode(data.toJson());

class TicketModel {
  final String status;
  final Ticket data;

  TicketModel({
    required this.status,
    required this.data,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        status: json["status"],
        data: Ticket.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Ticket {
  final String notiket;
  final String namabarang;
  final String lokasi;
  final String keluhan;
  final String nama;
  final String bagian;
  final String statustiket;
  final String validasi;

  Ticket({
    required this.notiket,
    required this.namabarang,
    required this.lokasi,
    required this.keluhan,
    required this.nama,
    required this.bagian,
    required this.statustiket,
    required this.validasi,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        notiket: json["notiket"],
        namabarang: json["namabarang"],
        lokasi: json["lokasi"],
        keluhan: json["keluhan"],
        nama: json["nama"],
        bagian: json["bagian"],
        statustiket: json["statustiket"],
        validasi: json["validasi"],
      );

  Map<String, dynamic> toJson() => {
        "notiket": notiket,
        "namabarang": namabarang,
        "lokasi": lokasi,
        "keluhan": keluhan,
        "nama": nama,
        "bagian": bagian,
        "statustiket": statustiket,
        "validasi": validasi,
      };
}
