import 'package:flutter/material.dart';
import 'package:siap/clients/chiefs/chiefaction.dart';
import 'package:siap/clients/chiefs/tiketopen.dart';
import 'package:siap/clients/chiefs/validasi.dart';
import 'package:siap/landingpage/landingpage.dart';
import 'package:siap/constans.dart';
import 'package:siap/login.dart';
import 'package:go_router/go_router.dart';
import 'package:siap/form/sewing/mksewing.dart';
import 'package:siap/teknisi/sewing/closingaction.dart';
import 'package:siap/teknisi/sewing/closingticket.dart';
import 'package:siap/teknisi/sewing/myticketdetail.dart';
import 'package:siap/teknisi/sewing/mytiket.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final GoRouter router = GoRouter(routes: [
    GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          return LoginPage();
        }),
    GoRoute(
      path: '/',
      name: 'menuutama',
      builder: (context, state) {
        return LandingPage();
      },
      routes: [
        GoRoute(
          path: 'mksewing/:gedung/:kodebagian/:pid/:token',
          name: 'mksewing',
          builder: (context, state) {
            return MekanikSewing(
              gedung: state.params['gedung'],
              kodebagian: state.params['kodebagian'],
              pid: state.params['pid'],
              token: state.params['token'],
            );
          },
        ),
        GoRoute(
          path: 'mytiket/:pid/:token',
          name: 'mytiket',
          builder: (context, state) {
            return MyTiket(
              nopid: state.params['pid'],
              token: state.params['token'],
            );
          },
        ),
        GoRoute(
            path: 'tiketaction/:nomor',
            name: 'tiketaction',
            builder: (context, state) {
              return MktiketDetail(notiket: state.params['nomor']);
            }),
        GoRoute(
          path: 'opentiket/:pid',
          name: 'opentiket',
          builder: (context, state) {
            return TicketOpen(nopid: state.params['pid']);
          },
        ),
        GoRoute(
            path: 'chiefaction/:nomor',
            name: 'chiefaction',
            builder: (context, state) {
              return ChiefAction(notiket: state.params['nomor']);
            }),
        GoRoute(
          path: 'validasi/:no',
          name: 'validasi',
          pageBuilder: (context, state) => MaterialPage(
              fullscreenDialog: true,
              child: ValidasiTicket(nomor: state.params['no'])),
        ),
        GoRoute(
          path: 'closing/:no/:validasi',
          name: 'closing',
          pageBuilder: (context, state) {
            return MaterialPage(
                fullscreenDialog: true,
                child: CloseTicket(
                  no: state.params['no'],
                  kodevalid: state.params['validasi'],
                ));
          },
        ),
        GoRoute(
          path: 'closingact/:kode/:validasi',
          name: 'closingact',
          pageBuilder: (context, state) {
            return MaterialPage(
                fullscreenDialog: true,
                child: ClosingAction(
                  kode: state.params['kode'],
                  validasi: state.params['validasi'],
                ));
          },
        ),
      ],
    ),
  ], initialLocation: '/login', debugLogDiagnostics: true, routerNeglect: true);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Siap',
      theme: new ThemeData(
        fontFamily: 'NeoSans',
        primaryColor: GojekPalette.green,
      ),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
