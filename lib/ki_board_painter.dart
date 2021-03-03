import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class KiBoardPainter extends CustomPainter {
  final Function(int x, int y) onTap;
  final List<Point<int>> blackKiList;
  final List<Point<int>> whiteKiList;

  final int row;
  final int column;

  KiBoardPainter({
    @required this.row,
    @required this.column,
    @required this.blackKiList,
    @required this.whiteKiList,
    this.onTap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / column;
    double eHeight = size.height / row;

    var paint = Paint();

    _drawBackground(paint, canvas, size);

    _drawGrids(paint, eHeight, canvas, size, eWidth);

    blackKiList.forEach((element) {
      _drawBlackKi(element, paint, canvas, size, eWidth, eHeight);
    });

    whiteKiList.forEach((element) {
      _drawWhiteKi(element, paint, canvas, size, eWidth, eHeight);
    });
  }

  void _drawGrids(
      Paint paint, double eHeight, Canvas canvas, Size size, double eWidth) {
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.black87
      ..strokeWidth = 1.0;

    for (int i = 0; i <= row; i++) {
      _drawRow(eHeight, i, canvas, size, paint);
    }

    for (int i = 0; i <= column; i++) {
      _drawColumn(eWidth, i, canvas, size, paint);
    }
  }

  void _drawBackground(Paint paint, Canvas canvas, Size size) {
    paint
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Color(0x77cdb175);
    canvas.drawRect(Offset.zero & size, paint);
  }

  void _drawColumn(
      double eWidth, int i, Canvas canvas, Size size, Paint paint) {
    double dx = eWidth * i;
    canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
  }

  void _drawRow(double eHeight, int i, Canvas canvas, Size size, Paint paint) {
    double dy = eHeight * i;
    canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
  }

  void _drawWhiteKi(Point<int> point, Paint paint, Canvas canvas, Size size,
      double eWidth, double eHeight) {
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset((point.x * 20).toDouble(), (point.y * 20).toDouble()),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );
  }

  void _drawBlackKi(Point<int> point, Paint paint, Canvas canvas, Size size,
      double eWidth, double eHeight) {
    paint
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawCircle(
      Offset((point.x * 20).toDouble(), (point.y * 20).toDouble()),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if (oldDelegate is KiBoardPainter) {
      return !(listEquals(oldDelegate.blackKiList, blackKiList) &&
          listEquals(oldDelegate.whiteKiList, whiteKiList));
    }
    return false;
  }

  @override
  bool hitTest(Offset position) {
    int finalX = position.dx % 20 == 0
        ? position.dx.toInt() ~/ 20
        : (position.dx + 10) ~/ 20;
    int finalY = position.dy % 20 == 0
        ? position.dy.toInt() ~/ 20
        : (position.dy + 10) ~/ 20;
    if (onTap != null) {
      onTap(finalX, finalY);
    }
    return true;
  }
}
