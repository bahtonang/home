import 'package:flutter/material.dart';
import 'package:siap/constans.dart';

class MenuIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback onPres;

  MenuIcon({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.onPres,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPres,
      behavior: HitTestBehavior.opaque,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: iconColor.withOpacity(.9),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: GojekPalette.grey, width: 1)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                icon,
                color: GojekPalette.grey,
                size: 35,
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            label,
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
