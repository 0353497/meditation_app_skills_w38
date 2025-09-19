import 'package:flutter/services.dart';

class Topic {
  final Color containerColor;
  final String text;
  final String image;
  final bool isDarktext;
  final double height;

  Topic(this.height, {required this.containerColor, required this.text, required this.image, required this.isDarktext});
}