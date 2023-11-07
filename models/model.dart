import 'dart:convert';

Person personFromJson(String str) => Person.fromJson(json.decode(str));
String personToJson(Person data) => json.encode(data.toJson());

class Person {
  Person({
    required this.error,
    required this.message,
    required this.user,
    required this.accessToken,
  });

  bool error;
  String message;
  User user;
  String accessToken;

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        error: json["error"],
        message: json["message"],
        user: User.fromJson(json["user"]),
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "user": user.toJson(),
        "access_token": accessToken,
      };
}

class User {
  User({
    required this.pid,
    required this.nama,
    required this.gedung,
    required this.kodebagian,
  });

  String pid;
  String nama;
  String gedung;
  String kodebagian;

  factory User.fromJson(Map<String, dynamic> json) => User(
        pid: json["pid"],
        nama: json["nama"],
        gedung: json["gedung"],
        kodebagian: json['kodebagian'],
      );

  Map<String, dynamic> toJson() =>
      {"pid": pid, "nama": nama, "gedung": gedung, "kodebagian": kodebagian};
}

class Personal {
  Personal({required this.pid, required this.nama, required this.gedung});
  String pid;
  String nama;
  String gedung;
}

class Lokasi {
  Lokasi({required this.nama});
  String nama;
}

class Teknisi {
  Teknisi({required this.nama, required this.hp, required this.pid});
  String nama;
  String pid;
  String hp;

  factory Teknisi.fromJson(Map<String, dynamic> json) => Teknisi(
        nama: json["nama"],
        hp: json['hp'],
        pid: json['pid'],
      );

  Map<String, dynamic> toJson() => {"nama": nama, "hp": hp, "pid": pid};
}

Onesend onesendFromJson(String str) => Onesend.fromJson(json.decode(str));
String onesendToJson(Onesend data) => json.encode(data.toJson());

class Onesend {
  final String status;
  final Dataonesend data;

  Onesend({
    required this.status,
    required this.data,
  });

  factory Onesend.fromJson(Map<String, dynamic> json) => Onesend(
        status: json["status"],
        data: Dataonesend.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Dataonesend {
  final String alamat;
  final String rahasia;

  Dataonesend({
    required this.alamat,
    required this.rahasia,
  });

  factory Dataonesend.fromJson(Map<String, dynamic> json) => Dataonesend(
        alamat: json["alamat"],
        rahasia: json["rahasia"],
      );

  Map<String, dynamic> toJson() => {
        "alamat": alamat,
        "rahasia": rahasia,
      };
}

class Tiket {
  final String? notiket;
  final String? tgl;
  final String? kodebarang;
  final String? namabarang;
  final String? keluhan;
  final String? lokasi;
  final String? gedung;
  final String? pengirim;
  final String? teknisi;
  final String? mulai;
  final String? selesai;
  final String? statustiket;
  final String? validasi;
  final String? baca;
  final String? tutup;
  final String? keterangan;

  Tiket({
    required this.notiket,
    required this.tgl,
    required this.kodebarang,
    required this.namabarang,
    required this.keluhan,
    required this.lokasi,
    required this.gedung,
    required this.pengirim,
    required this.teknisi,
    required this.mulai,
    required this.selesai,
    required this.statustiket,
    required this.validasi,
    required this.baca,
    required this.tutup,
    required this.keterangan,
  });

  factory Tiket.fromJson(Map<String, dynamic> json) => Tiket(
        notiket: json["notiket"],
        tgl: json["tgl"],
        kodebarang: json["kodebarang"],
        namabarang: json["namabarang"],
        keluhan: json["keluhan"],
        lokasi: json["lokasi"],
        gedung: json["gedung"],
        pengirim: json["pengirim"],
        teknisi: json["teknisi"],
        mulai: json["mulai"],
        selesai: json["selesai"],
        statustiket: json["statustiket"],
        validasi: json["validasi"],
        baca: json["baca"],
        tutup: json["tutup"],
        keterangan: json["keterangan"],
      );

  Map<String, dynamic> toJson() => {
        "notiket": notiket,
        "tgl": tgl,
        "kodebarang": kodebarang,
        "namabarang": namabarang,
        "keluhan": keluhan,
        "lokasi": lokasi,
        "gedung": gedung,
        "pengirim": pengirim,
        "teknisi": teknisi,
        "mulai": mulai,
        "selesai": selesai,
        "statustiket": statustiket,
        "baca": baca,
        "tutup": tutup,
        "keterangan": keterangan,
      };
}

Notiket notiketFromJson(String str) => Notiket.fromJson(json.decode(str));
String notiketToJson(Notiket datanotiket) => json.encode(datanotiket.toJson());

class Notiket {
  String status;
  Datanotiket datanotiket;

  Notiket({
    required this.status,
    required this.datanotiket,
  });

  factory Notiket.fromJson(Map<String, dynamic> json) => Notiket(
        status: json["status"],
        datanotiket: Datanotiket.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": datanotiket.toJson(),
      };
}

class Datanotiket {
  String? notiket;
  String? namabarang;
  String? lokasi;
  String? keluhan;
  String? nama;
  String? bagian;
  String? statustiket;
  String? validasi;
  String? teknisi;

  Datanotiket({
    this.notiket,
    this.namabarang,
    this.lokasi,
    this.keluhan,
    this.nama,
    this.bagian,
    this.statustiket,
    this.validasi,
    this.teknisi,
  });

  factory Datanotiket.fromJson(Map<String, dynamic> json) => Datanotiket(
        notiket: json["notiket"],
        namabarang: json["namabarang"],
        lokasi: json["lokasi"],
        keluhan: json["keluhan"],
        nama: json["nama"],
        bagian: json["bagian"],
        statustiket: json["statustiket"],
        validasi: json["validasi"],
        teknisi: json["teknisi"],
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
        "teknisi": teknisi,
      };
}
