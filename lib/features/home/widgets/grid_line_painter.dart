import 'package:flutter/material.dart';

class GridLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0;

    double cellWidth = size.width / 3;
    double cellHeight = size.height / 2;

    // Draw vertical lines
    for (int i = 1; i < 3; i++) {
      double dx = i * cellWidth;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    // Draw horizontal line
    canvas.drawLine(
        Offset(0, cellHeight), Offset(size.width, cellHeight), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
