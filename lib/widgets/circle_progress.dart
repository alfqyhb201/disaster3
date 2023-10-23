import 'dart:math';

import 'package:flutter/material.dart';

class CircleProgress extends CustomPainter {
  final strokeCircle = 13.0;
  final dynamic provider;
  double currentProgress;
  int finalProgress;

  CircleProgress(this.currentProgress, this.finalProgress, this.provider);
  @override
  void paint(Canvas canvas, Size size) {
    // I will draw circle
    Paint circle = Paint()
      ..strokeWidth = strokeCircle
      ..color = Colors.black
      ..style = PaintingStyle.stroke;
    Offset center = Offset(size.width / 2, size.height / 2); // center of device
    double radius = 50;
    canvas.drawCircle(center, radius, circle);

    // Draw animation
    Paint animationArc = Paint()
      ..strokeWidth = strokeCircle
      ..color = provider.startSession ? Colors.white : Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double angle = 2 * pi * (currentProgress / finalProgress);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), pi / 2,
        angle, false, animationArc);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
// TODO: implement shouldRepaint
    return true;
  }
}
