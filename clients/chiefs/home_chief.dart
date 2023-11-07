import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siap/component/siapappbar.dart';
import 'package:siap/models/menus.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:siap/models/model.dart';
import 'package:siap/services/service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChiefHome extends StatefulWidget {
  const ChiefHome({super.key});

  @override
  State<ChiefHome> createState() => _ChiefHomeState();
}

class _ChiefHomeState extends State<ChiefHome> {
  late SharedPreferences _preferences;
  late String spNama = "";
  late String spGedung = "";
  late String spPid = "";
  late String? spToken;
  late String photo = "putih.jpg";
  SiapApiService? siapApiService;

  Future<void> _initSharedPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    _loadSpValue();
  }

  Future<void> _loadSpValue() async {
    setState(() {
      spPid = _preferences.getString("sp_pid") ?? "";
      spNama = _preferences.getString("sp_nama") ?? "";
      spGedung = _preferences.getString("sp_gedung") ?? "";
      spToken = _preferences.getString("sp_token") ?? "";
      photo = spPid + '.jpg';
    });
  }

  Future<void> _loGout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Menghapus semua data shared preferences
  }

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
    siapApiService = SiapApiService();
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
      child: new Scaffold(
        appBar: new SiapAppBar(),
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
                      _buildTopMenu(),
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
                    _menuGambar(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopMenu() {
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
                    spNama.toString(),
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
                  imageUrl: "http://36.93.18.9:8001/asik/images/" + photo,
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
                label: "MK Sewing",
                onPres: () {
                  context.goNamed('mksewing', params: {
                    'gedung': spGedung,
                    'kodebagian': 'MKS',
                    'pid': spPid,
                    'token': spToken ?? '',
                  });
                },
              ),
              MenuIcon(
                icon: Icons.add_to_home_screen,
                iconColor: Colors.green,
                label: "MK Listrik",
                onPres: () {
                  context.goNamed('mksewing', params: {
                    'gedung': spGedung,
                    'kodebagian': 'MKL',
                    'pid': spPid
                  });
                },
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
                label: "Tickets",
                onPres: () {
                  context.goNamed('opentiket', params: {'pid': spPid});
                  // params: {'pid': nopid, 'token': token ?? ''});
                },
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

  Widget _menuGambar() {
    return new Container(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),
          new Text(
            "Aktifitas Pabrik",
            style: new TextStyle(fontFamily: "NeoSansBold"),
          ),
          new SizedBox(
            height: 172.0,
            child: FutureBuilder<List>(
                future: fetchAktifitas(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return new ListView.builder(
                      itemCount: snapshot.data?.length,
                      padding: EdgeInsets.only(top: 12.0),
                      physics: new ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return _rowGambar(snapshot.data?[index]);
                      },
                    );
                  }
                  return Center(
                    child: SizedBox(
                        width: 40.0,
                        height: 40.0,
                        child: const CircularProgressIndicator()),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget _rowGambar(Aktifitas aktifitas) {
    return new Container(
      margin: EdgeInsets.only(right: 16.0),
      child: new Column(
        children: <Widget>[
          new ClipRRect(
            borderRadius: new BorderRadius.circular(8.0),
            child: Image.network(
              aktifitas.url,
              width: 132.0,
              height: 132.0,
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),
        ],
      ),
    );
  }

  Future<List<Aktifitas>> fetchAktifitas() async {
    List<Aktifitas> _listAktifitas = [];
    _listAktifitas.add(new Aktifitas(
        url: 'http://36.93.18.9:8001/asik/images/aktifitas/10.jpg'));
    _listAktifitas.add(new Aktifitas(
        url: 'http://36.93.18.9:8001/asik/images/aktifitas/11.jpg'));
    _listAktifitas.add(new Aktifitas(
        url: 'http://36.93.18.9:8001/asik/images/aktifitas/12.jpg'));
    _listAktifitas.add(new Aktifitas(
        url: 'http://36.93.18.9:8001/asik/images/aktifitas/13.jpg'));
    _listAktifitas.add(new Aktifitas(
        url: 'http://36.93.18.9:8001/asik/images/aktifitas/14.jpg'));
    return new Future.delayed(new Duration(seconds: 1), () {
      return _listAktifitas;
    });
  }
}

class Aktifitas {
  String url;

  Aktifitas({required this.url});
}
