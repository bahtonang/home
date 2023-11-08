import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siap/models/data/ticket.dart';
// import 'package:go_router/go_router.dart';
import 'package:siap/services/service.dart';

class MktiketDetail extends StatefulWidget {
  final String? notiket;

  const MktiketDetail({super.key, this.notiket});

  @override
  State<MktiketDetail> createState() => _MktiketDetailState();
}

class _MktiketDetailState extends State<MktiketDetail> {
  SiapApiService? siapApiService;
  TicketModel? apiResult;
  String? tiketno,
      barang,
      keluhan,
      lokasi,
      pengirim,
      statustiket,
      bagian,
      validasi;
  bool loading = true;
  bool berhasil = false;

  @override
  void initState() {
    siapApiService = SiapApiService();
    super.initState();
    _getData();
  }

  Future _getData() async {
    var respond = await siapApiService?.tiketAction(widget.notiket.toString());

    setState(() {
      loading = false;
      apiResult = respond;
      // tiketno = respond!.datanotiket.notiket;
      // barang = respond.datanotiket.namabarang;
      // keluhan = respond.datanotiket.keluhan;
      // lokasi = respond.datanotiket.lokasi;
      // pengirim = respond.datanotiket.nama;
      // bagian = respond.datanotiket.bagian;
      // statustiket = respond.datanotiket.statustiket;
      // validasi = respond.datanotiket.validasi;
    });
  }

  Future _startTicket() async {
    await siapApiService?.tiketStart(widget.notiket.toString()).then((value) {
      setState(() {
        if (value = true) {
          berhasil = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket Detail'),
      ),
      body: Center(
        child: loading
            ? CircularProgressIndicator()
            : Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Column(
                        children: [
                          ListTile(
                            title: Text('No Tiket :'),
                            subtitle: Text(
                              apiResult!.data.notiket,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 4, 1, 167)),
                            ),
                          ),
                          ListTile(
                            title: Text('Nama Barang :'),
                            subtitle: Text(
                              apiResult!.data.namabarang,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 4, 1, 167)),
                            ),
                          ),
                          ListTile(
                            title: Text('Lokasi :'),
                            subtitle: Text(
                              apiResult!.data.lokasi,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 4, 1, 167)),
                            ),
                          ),
                          ListTile(
                            title: Text('Kerusakan :'),
                            subtitle: Text(
                              apiResult!.data.keluhan,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 4, 1, 167)),
                            ),
                          ),
                          ListTile(
                            title: Text('Pengirim :'),
                            subtitle: Text(
                              apiResult!.data.nama,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 4, 1, 167)),
                            ),
                          ),
                          ListTile(
                            title: Text('Status :'),
                            subtitle: Text(
                              apiResult!.data.statustiket,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 4, 1, 167)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(200, 50),
                        ),
                        onPressed: () {
                          if (apiResult!.data.statustiket == 'OPEN') {
                            _startTicket();
                            if (berhasil = true) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext ctx) => AlertDialog(
                                        title: const Text('Tiket Start...'),
                                        content:
                                            Text('Memulai Pekerjaan Sekarang'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                              },
                                              child: Text('OK'))
                                        ],
                                      ));
                            }
                          } else if (apiResult!.data.statustiket == 'CLOSE' ||
                              apiResult!.data.statustiket == 'START') {
                            showDialog(
                                context: context,
                                builder: (BuildContext ctx) => AlertDialog(
                                      title: const Text('Error...'),
                                      content: Text('Ticket Sedang di Proses '),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Text('OK'))
                                      ],
                                    ));
                          }
                        },
                        icon: Icon(Icons.start_rounded),
                        label: Text(
                          'Mulai',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 40),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(200, 50),
                        ),
                        onPressed: () {
                          if (apiResult!.data.statustiket == 'START') {
                            context.goNamed('closing', params: {
                              'no': apiResult!.data.notiket,
                              'validasi': apiResult!.data.validasi
                            });
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext ctx) => AlertDialog(
                                      title: const Text('Tiket Closed...'),
                                      content: Text('Tiket sudah di close'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Text('OK'))
                                      ],
                                    ));
                          }
                        },
                        icon: Icon(Icons.close_rounded),
                        label: Text(
                          'Selesai',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
