import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:siap/services/service.dart';

class ValidasiTicket extends StatefulWidget {
  final String? nomor;
  ValidasiTicket({super.key, this.nomor});

  @override
  State<ValidasiTicket> createState() => _ValidasiTicketState();
}

class _ValidasiTicketState extends State<ValidasiTicket> {
  bool loading = true;
  SiapApiService? siapApiService;
  String? kode, nama;

  @override
  void initState() {
    siapApiService = SiapApiService();
    getValidasi();
    super.initState();
  }

  Future getValidasi() async {
    var data = await siapApiService?.tiketClosing(widget.nomor.toString());
    kode = data!.datanotiket.validasi;
    nama = data.datanotiket.nama;
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Scan QR Untuk Validasi Closing Ticket'),
        ),
        body: Center(
          child: loading
              ? CircularProgressIndicator()
              : Container(
                  child: LayoutBuilder(
                    builder: (BuildContext context,
                        BoxConstraints viewportConstraints) {
                      return SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: viewportConstraints.maxHeight),
                          child: Container(
                            child: IntrinsicHeight(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    //  color: Colors.blue[300],
                                    height: MediaQuery.of(context).size.height *
                                        0.40,
                                    child: Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            QrImageView(
                                              data: kode ?? '',
                                              size: 200,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(30),
                                      decoration: BoxDecoration(
                                        color: Colors.blue[300],
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          topRight: Radius.circular(50),
                                        ),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(height: 10.0),
                                          Center(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "No Ticket :",
                                                  style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255)),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  widget.nomor ?? "",
                                                  overflow: TextOverflow.fade,
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Text(
                                                  "Nama Teknisi :",
                                                  style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255)),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  nama ?? "",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ));
  }
}
