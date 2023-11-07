import 'package:flutter/material.dart';

class GojekService {
  IconData image;
  Color color;
  String title;
  final VoidCallback onPress;

  GojekService(
      {required this.image,
      required this.title,
      required this.color,
      required this.onPress});
}

class Food {
  String title;
  String image;
  Food({required this.title, required this.image});
}

class Promo {
  String image;
  String title;
  String content;
  String button;

  Promo(
      {required this.image,
      required this.title,
      required this.content,
      required this.button});
}
