import 'package:flutter/material.dart';
import 'package:siap/models/menus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';

class HomeMksewing extends StatefulWidget {
  @override
  _HomeMksewingState createState() => new _HomeMksewingState();
}

class _HomeMksewingState extends State<HomeMksewing> {
  int _jumlahPesan = 0;
  //late bool _showPesan;
  Color color = Colors.red;
  late SharedPreferences _preferences;
  late String nama = '';
  late String nopid = '';
  late String? token = '';
  late String photo = "putih.jpg";

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    _loadStoredValue();
  }

  Future<void> _loadStoredValue() async {
    nopid = _preferences.getString("sp_pid") ?? '';
    token = _preferences.getString("sp_token");
    nama = _preferences.getString("sp_nama") ?? '';
    photo = nopid + '.jpg';
    setState(() {});
  }

  Future<void> _loGout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Menghapus semua data shared preferences
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
        appBar: AppBar(
          elevation: 0.25,
          backgroundColor: Colors.white,
          flexibleSpace: Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 50,
                  width: 100,
                ),
                Container(
                  child: Row(
                    children: [
                      badges.Badge(
                        position: badges.BadgePosition.topEnd(top: 0, end: 3),
                        badgeAnimation: badges.BadgeAnimation.slide(),
                        badgeStyle: badges.BadgeStyle(badgeColor: Colors.red),
                        showBadge: _jumlahPesan == 0 ? false : true,
                        badgeContent: Text(
                          _jumlahPesan.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.email_outlined,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: new Container(
          child: new ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              new Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0),
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      _topMenu(),
                      SizedBox(
                        height: 20.0,
                      ),
                      _buildMenu(),
                    ],
                  )),
              new Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: 16.0),
                child: new Column(
                  children: <Widget>[
                    //     _buildGoFoodFeatured(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

//header warna biru
  Widget _topMenu() {
    return new Container(
      height: 120.0,
      decoration: new BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xff3164bd), const Color(0xff295cb5)],
          ),
          borderRadius: new BorderRadius.all(new Radius.circular(3.0))),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Welcome :",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontFamily: "NeoSans"),
                  ),
                  Text(
                    nama.toString(),
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: "NeoSansBold"),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: CachedNetworkImage(
                  //     imageUrl: "http://36.93.18.9:8001/asik/images/" + photo,
                  imageUrl: "http://36.93.18.9:8001/asik/images/SF13773.jpg",
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.white70, BlendMode.colorBurn),
                      ),
                    ),
                  ),
                  placeholder: (context, url) =>
                      Image.asset("assets/images/logo.png"),
                  errorWidget: (context, url, error) => Icon(Icons.people),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenu() {
    return new SizedBox(
        width: double.infinity,
        height: 250.0,
        child: new Container(
          margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            children: <Widget>[
              MenuIcon(
                icon: Icons.auto_stories,
                iconColor: Colors.orange,
                label: "My Tickets",
                onPres: () {
                  context.goNamed('mytiket',
                      params: {'pid': nopid, 'token': token ?? ''});
                },
              ),
              MenuIcon(
                icon: Icons.add_to_home_screen,
                iconColor: Colors.green,
                label: "MK Listrik",
                onPres: () {},
              ),
              MenuIcon(
                icon: Icons.deck_rounded,
                iconColor: Colors.purple,
                label: "Umum",
                onPres: () {},
              ),
              MenuIcon(
                icon: Icons.auto_stories,
                iconColor: Colors.green,
                label: "EDP",
                onPres: () {},
              ),
              MenuIcon(
                icon: Icons.article_outlined,
                iconColor: Colors.orange,
                label: "Tiket",
                onPres: () {},
              ),
              MenuIcon(
                icon: Icons.logout_outlined,
                iconColor: Colors.blue,
                label: "Logout",
                onPres: () async {
                  await _loGout();
                  context.pushNamed('login');
                },
              ),
            ],
          ),
        ));
  }
}
