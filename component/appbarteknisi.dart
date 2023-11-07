import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class TeknisiAppBar extends AppBar {
  TeknisiAppBar()
      : super(
            elevation: 0.25,
            backgroundColor: Colors.white,
            flexibleSpace: _buildTeknisiAppBar());

  static Widget _buildTeknisiAppBar() {
    return new Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Image.asset(
            "assets/images/logo.png",
            height: 50.0,
            width: 100.0,
          ),
          new Container(
            child: new Row(
              children: <Widget>[
                badges.Badge(
                  position: badges.BadgePosition.topEnd(top: 10, end: 10),
                  badgeAnimation: badges.BadgeAnimation.slide(),
                  badgeStyle: badges.BadgeStyle(badgeColor: Colors.red),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.email_outlined,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
