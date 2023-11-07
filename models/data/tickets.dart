class TicketsModel {
  String status;
  List<Tickets> data;

  TicketsModel({
    required this.status,
    required this.data,
  });

  factory TicketsModel.fromJson(Map<String, dynamic> json) => TicketsModel(
        status: json["status"],
        data: List<Tickets>.from(json["data"].map((x) => Tickets.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Tickets {
  String? notiket;
  String? tgl;
  String? nama;
  String? namabarang;
  String? keluhan;
  String? lokasi;
  String? pengirim;
  String? baca;
  String? statustiket;
  String? validasi;

  Tickets({
    this.notiket,
    this.tgl,
    this.nama,
    this.namabarang,
    this.keluhan,
    this.lokasi,
    this.pengirim,
    this.baca,
    this.statustiket,
    this.validasi,
  });

  factory Tickets.fromJson(Map<String, dynamic> json) => Tickets(
        notiket: json["notiket"],
        tgl: json["tgl"],
        nama: json["nama"],
        namabarang: json["namabarang"],
        keluhan: json["keluhan"],
        lokasi: json["lokasi"],
        pengirim: json["pengirim"],
        baca: json["baca"],
        statustiket: json["statustiket"],
        validasi: json["validasi"],
      );

  Map<String, dynamic> toJson() => {
        "notiket": notiket,
        "tgl": tgl,
        "nama": nama,
        "namabarang": namabarang,
        "keluhan": keluhan,
        "lokasi": lokasi,
        "pengirim": pengirim,
        "baca": baca,
        "statustiket": statustiket,
        "validasi": validasi,
      };
}
