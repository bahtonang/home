import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siap/models/data/tickets.dart';
import 'package:siap/services/service.dart';

class MyTiket extends StatefulWidget {
  final String? nopid;
  final String? token;
  MyTiket({super.key, this.nopid, this.token});

  @override
  State<MyTiket> createState() => _MyTiketState();
}

class _MyTiketState extends State<MyTiket> {
  SiapApiService? siapApiService;

  @override
  void initState() {
    super.initState();
    siapApiService = SiapApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Tickets'),
      ),
      body: Container(
        color: Colors.lime[50],
        child: FutureBuilder(
            future: siapApiService?.getTickets(
                widget.nopid.toString(), widget.token.toString()),
            builder: (BuildContext context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Container(
                    child: Center(
                      child: Text('No Connection'),
                    ),
                  );
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                case ConnectionState.done:
                  if (snapshot.data!.isEmpty) {
                    return Container(
                      child: Center(
                        child: Text('Tidak Ada Data'),
                      ),
                    );
                  } else {
                    List<Tickets?> tiket = snapshot.data ?? [];
                    return snapshot.hasData
                        ? _dataTiket(tiket)
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  }
              }
            }),
      ),
    );
  }

  Widget _dataTiket(List<Tickets?> list) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int i) =>
                Divider(color: Colors.black54),
            itemCount: list.length,
            itemBuilder: (context, index) {
              Tickets? tikets = list[index]!;
              return Container(
                color: Colors.lime[50],
                child: ListTile(
                  title: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            tikets.notiket ?? '',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  subtitle: Column(
                    children: [
                      Row(
                        children: [
                          Text(tikets.lokasi ?? '',
                              style: TextStyle(fontSize: 16.0)),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(tikets.keluhan ?? '',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color:
                                        const Color.fromARGB(255, 247, 1, 1))),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(tikets.statustiket ?? '',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.blue)),
                        ],
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_rounded,
                    color: Color.fromARGB(255, 20, 5, 241),
                    size: 30,
                  ),
                  onTap: () {
                    context.goNamed('tiketaction',
                        params: {'nomor': tikets.notiket ?? ''});
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
