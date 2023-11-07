import 'package:flutter/material.dart';
import 'package:siap/clients/chiefs/home_chief.dart';
import 'package:siap/constans.dart';
import 'package:siap/teknisi/sewing/home_mksewing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => new _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late String bagian = '';
  late SharedPreferences _preferences;

  Future<void> _initSharedPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    _loadStoredValue();
  }

  Future<void> _loadStoredValue() async {
    setState(() {
      bagian = _preferences.getString("sp_kodebag") ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  pilihWidget() {
    if (bagian == 'SPV') {
      return ChiefHome();
    } else if (bagian == 'MKS') {
      return HomeMksewing();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: pilihWidget(), bottomNavigationBar: buildBottomNavigation());
  }

  Widget buildBottomNavigation() {
    return new BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      // onTap: (index) {
      //   setState(() {
      //     _bottomNavCurrentIndex = index;
      //   });
      // },
      onTap: null,

      // currentIndex: _bottomNavCurrentIndex,
      items: [
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.home,
            color: GojekPalette.green,
          ),
          icon: new Icon(
            Icons.home,
            color: Colors.grey,
          ),
          // title: new Text(
          //   'Beranda',
          // ),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.mail,
            color: GojekPalette.green,
          ),
          icon: new Icon(
            Icons.mail,
            color: Colors.grey,
          ),
          label: 'Inbox',

          // title: new Text('Inbox'),
        ),
        BottomNavigationBarItem(
            activeIcon: new Icon(
              Icons.person,
              color: GojekPalette.green,
            ),
            icon: new Icon(
              Icons.person,
              color: Colors.grey,
            ),
            // title: new Text('Akun'),
            label: 'Profile'),
      ],
    );
  }
}
