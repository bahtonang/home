import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siap/services/service.dart';

class ChiefAction extends StatefulWidget {
  final String? notiket;

  const ChiefAction({super.key, this.notiket});

  @override
  State<ChiefAction> createState() => _ChiefActionState();
}

class _ChiefActionState extends State<ChiefAction> {
  SiapApiService? siapApiService;
  String? tiketno,
      barang,
      keluhan,
      lokasi,
      nama,
      statustiket,
      noValidasi,
      teknisi,
      bagian;
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
      tiketno = respond!.datanotiket.notiket;
      barang = respond.datanotiket.namabarang;
      keluhan = respond.datanotiket.keluhan;
      lokasi = respond.datanotiket.lokasi;
      nama = respond.datanotiket.nama;
      bagian = respond.datanotiket.bagian;
      statustiket = respond.datanotiket.statustiket;
      noValidasi = respond.datanotiket.validasi;
      teknisi = respond.datanotiket.teknisi;
    });
  }

  _hapusTicket() async {
    await siapApiService?.tiketDelete(tiketno ?? '').then((value) {
      setState(() {
        if (value = true) {
          context.goNamed('menuutama');
        }
      });
    });
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text('Cancel'),
    );
    Widget deleteButton = TextButton(
      onPressed: () {
        _hapusTicket();
      },
      child: Text('Hapus'),
    );
    AlertDialog alert = AlertDialog(
      title: Text('Hapus Ticket'),
      content: Text(
          'Apakah yakin Ticket di hapus..? \n Tekan Hapus Untuk hapus Ticket'),
      actions: [cancelButton, deleteButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
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
                              tiketno ?? '',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 4, 1, 167)),
                            ),
                          ),
                          ListTile(
                            title: Text('Nama Barang :'),
                            subtitle: Text(
                              barang ?? '',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 4, 1, 167)),
                            ),
                          ),
                          ListTile(
                            title: Text('Lokasi :'),
                            subtitle: Text(
                              lokasi ?? '',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 4, 1, 167)),
                            ),
                          ),
                          ListTile(
                            title: Text('Kerusakan :'),
                            subtitle: Text(
                              keluhan ?? '',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 4, 1, 167)),
                            ),
                          ),
                          ListTile(
                            title: Text('Pengirim :'),
                            subtitle: Text(
                              nama ?? '',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 4, 1, 167)),
                            ),
                          ),
                          ListTile(
                            title: Text('Status :'),
                            subtitle: Text(
                              statustiket ?? '',
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
                          context.goNamed('validasi', params: {
                            'no': tiketno ?? '',
                          });
                        },
                        icon: Icon(Icons.start_rounded),
                        label: Text(
                          'Close',
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
                          showAlertDialog(context);
                        },
                        icon: Icon(Icons.close_rounded),
                        label: Text(
                          'Hapus',
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
