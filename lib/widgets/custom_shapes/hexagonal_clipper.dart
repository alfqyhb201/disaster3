import 'package:flutter/material.dart';

class HexagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;
    final s = w / 2;
    path.moveTo(s, 0);
    path.lineTo(w, h / 4);
    path.lineTo(w, 3 * h / 4);
    path.lineTo(s, h);
    path.lineTo(0, 3 * h / 4);
    path.lineTo(0, h / 4);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(HexagonalClipper oldClipper) => false;
}
