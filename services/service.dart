import 'package:siap/models/auth/user.dart';
import 'package:siap/models/data/lokasi.dart';
import 'package:siap/models/data/persons.dart';
import 'package:siap/models/data/ticket.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:siap/models/data/tickets.dart';
import 'package:siap/models/sender/one.dart';

class SiapApiService {
  Client client = Client();
  static const String url = "http://192.168.32.1/apisiap/public/";

  Future<LoginModel?> login(String pid, String pass) async {
    try {
      Map<String, String> header = {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      };
      var respond = await client.post(Uri.parse("$url/otentikasi/login"),
          headers: header, body: json.encode({"pid": pid, "pass": pass}));
      if (respond.statusCode == 200) {
        final data = loginModelFromJson(respond.body);
        return data;
      }
    } catch (e) {
      throw e;
    }
    return null;
  }

  Future<OnesendModel?> getOnesend(String token) async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      var respond =
          await client.get(Uri.parse("$url/onesend"), headers: header);
      if (respond.statusCode == 200) {
        final data = onesendModelFromJson(respond.body);
        return data;
      }
    } catch (e) {
      throw e;
    }
    return null;
  }

//mksewing dart Call Teknisi
//dropdown item

  Future<List<Persons>> getTeknisi(
      String gedung, String kodebagian, String token) async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var respond = await client
        .get(Uri.parse("$url/teknisi/$gedung/$kodebagian"), headers: header);
    if (respond.statusCode == 200) {
      List<dynamic> body = jsonDecode(respond.body)['data'];
      List<Persons> persons =
          body.map((dynamic item) => Persons.fromJson(item)).toList();
      return persons;
    }
    return [];
  }

//mksewing dart Call Teknisi
//dropdown item

  Future<List<Lokasi>> getLokasi(String gedung, String token) async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      var respond =
          await client.get(Uri.parse("$url/lokasi/$gedung"), headers: header);
      if (respond.statusCode == 200) {
        List<dynamic> body = jsonDecode(respond.body)['data'];
        List<Lokasi> lokasi =
            body.map((dynamic item) => Lokasi.fromJson(item)).toList();
        return lokasi;
      }
    } catch (e) {
      throw e;
    }
    return [];
  }

  Future<bool> kirimticket(
      String kodebarang,
      String namabarang,
      String keluhan,
      String lokasi,
      String gedung,
      String pengirim,
      String teknisi,
      String statuskirim) async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      final respond = await client.post(Uri.parse("$url/kirimtiket"),
          headers: header,
          body: json.encode({
            "kodebarang": kodebarang,
            "namabarang": namabarang,
            "keluhan": keluhan,
            "lokasi": lokasi,
            "gedung": gedung,
            "pengirim": pengirim,
            "teknisi": teknisi,
            "statuskirim": statuskirim
          }));
      if (respond.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw e;
    }
    return false;
  }

  //tampilkan tikets berdasarkan PID teknisi
  //mytiket.dart

  Future<List<Tickets?>> getTickets(String pid, String token) async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final respond =
          await client.get(Uri.parse("$url/mytiket/$pid"), headers: header);
      if (respond.statusCode == 200) {
        List<dynamic> body = jsonDecode(respond.body)['data'];
        List<Tickets> tickets =
            body.map((dynamic item) => Tickets.fromJson(item)).toList();
        return tickets;
      } else {
        return [];
      }
    } catch (e) {
      throw e;
    }
  }

  Future<int?> kirimPesan(
      String alamat, String rahasia, String hp, String pesan) async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$rahasia'
    };
    int hasil = 0;
    final request = await client.post(Uri.parse("$alamat"),
        headers: header,
        body: json.encode(
          {
            "recipient_type": "individual",
            "to": "$hp",
            "type": "text",
            "text": {"body": "$pesan"}
          },
        ));
    if (request.statusCode == 200) {
      var result = jsonDecode(request.body);
      hasil = result['code'];
      if (hasil == 200) {
        return 1;
      }
    } else {
      return 0;
    }
    return 0;
  }

//tampilan tiket berdasarkan nomor tiket

  // Future<Notiket?> tiketAction(String no) async {
  //   try {
  //     var respond = await client.get(Uri.parse("$url/tiketaction/$no"));
  //     if (respond.statusCode == 200) {
  //       final data = notiketFromJson(respond.body);

  //       return data;
  //     }
  //   } catch (e) {
  //     throw e;
  //   }
  //   return null;
  // }

  Future<TicketModel?> tiketAction(String no) async {
    try {
      var respond = await client.get(Uri.parse("$url/tiketaction/$no"));
      if (respond.statusCode == 200) {
        final data = ticketModelFromJson(respond.body);
        return data;
      }
    } catch (e) {
      throw e;
    }
    return null;
  }

  Future<bool> tiketStart(String no) async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
    final respond = await client.put(Uri.parse("$url/tiketstart"),
        headers: header, body: json.encode({"nomor": no}));
    if (respond.statusCode == 200) {
      var data = jsonDecode(respond.body)["error"];
      if (data == false) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  //hapus tiket

  Future<bool> tiketDelete(String no) async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json'
    };
    final respond = await client.delete(Uri.parse("$url/tiketdelete"),
        headers: header, body: json.encode({"nomor": no}));
    if (respond.statusCode == 200) {
      var data = jsonDecode(respond.body)["error"];
      if (data == false) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

//menampilkan no, validasi di page validasi SPV

  Future<TicketModel?> tiketClosing(String no) async {
    try {
      var respond = await client.get(Uri.parse("$url/tiketclosing/$no"));
      if (respond.statusCode == 200) {
        final data = ticketModelFromJson(respond.body);
        return data;
      }
    } catch (e) {
      throw e;
    }
    return null;
  }

  //tampilkan open tiket di halaman SPV

  Future<List<Tickets?>> getOpenticket(String pid, String token) async {
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      var respond =
          await client.get(Uri.parse("$url/tiketopen/$pid"), headers: header);
      if (respond.statusCode == 200) {
        List<dynamic> body = jsonDecode(respond.body)['data'];
        List<Tickets> tickets =
            body.map((dynamic item) => Tickets.fromJson(item)).toList();
        return tickets;
      }
    } catch (e) {
      throw e;
    }
    return [];
  }
}
