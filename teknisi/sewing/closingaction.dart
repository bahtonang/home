import 'package:flutter/material.dart';

class ClosingAction extends StatefulWidget {
  final String? kode, validasi;
  ClosingAction({super.key, this.kode, this.validasi});

  @override
  State<ClosingAction> createState() => _ClosingActionState();
}

class _ClosingActionState extends State<ClosingAction> {
  bool isValid = false;
  final loginFormkey = GlobalKey<FormState>();
  TextEditingController txtKet = TextEditingController();
  String? errorMsg;

  @override
  void initState() {
    super.initState();
    if (widget.kode == widget.validasi) {
      isValid = true;
    }
  }

  //   void _handleLoginButton() {
  //   if (loginFormkey.currentState!.validate()) {
  //     siapApiService?.login(txtPid.text, txtPass.text).then((value) {
  //       if (value == null) {
  //         setState(() {
  //           errorMsg = "PID atau Password Salah";
  //         });
  //       } else {
  //         // setState(() {});
  //         // nopid = value.user.pid;
  //         // namauser = value.user.nama;
  //         // namagedung = value.user.gedung;
  //         // kodebagian = value.user.kodebagian;
  //         // token = value.accessToken;
  //         // savePref();
  //         // context.pushNamed('menuutama');
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          padding: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
          color: Color.fromARGB(255, 255, 255, 255),
          child: isValid
              ? Column(
                  children: [
                    Text(
                      'Silakan Isi Keterangan utk closing Ticket',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color.fromARGB(255, 0, 17, 255)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: loginFormkey,
                      child: TextFormField(
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Keterangan harus di isi';
                          }
                          return null;
                        },
                        controller: txtKet,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: 'Keterangan',
                          errorText: errorMsg,
                          labelStyle: TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        ();
                      },
                      icon: const Icon(Icons.close),
                      label: const Text(
                        'Close Ticket',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(100, 50),
                      ),
                    ),
                  ],
                )
              : AlertDialog(
                  title: Text('Kode Validasi salah'),
                  content: Container(
                    child: Text('Silakan Scan ulang kode validasi yang benar'),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK')),
                  ],
                )),
    );
  }
}
