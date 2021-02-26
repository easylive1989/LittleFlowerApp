import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class KiBoardPainter extends CustomPainter {
  final Function(int x, int y) onTap;
  final List<Point<int>> blackKiList;
  final List<Point<int>> whiteKiList;

  KiBoardPainter({
    @required this.blackKiList,
    @required this.whiteKiList,
    this.onTap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 15;
    double eHeight = size.height / 15;

    //画棋盘背景
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill //填充
      ..color = Color(0x77cdb175); //背景为纸黄色
    canvas.drawRect(Offset.zero & size, paint);

    //画棋盘网格
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Colors.black87
      ..strokeWidth = 1.0;

    for (int i = 0; i <= 15; ++i) {
      double dy = eHeight * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }

    for (int i = 0; i <= 15; ++i) {
      double dx = eWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    blackKiList.forEach((element) {
      _drawBlackKi(element, paint, canvas, size, eWidth, eHeight);
    });

    whiteKiList.forEach((element) {
      _drawWhiteKi(element, paint, canvas, size, eWidth, eHeight);
    });
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
    onTap(finalX, finalY);
    return true;
  }
}
