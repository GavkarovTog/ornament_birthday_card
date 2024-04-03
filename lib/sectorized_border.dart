import 'dart:math';

import 'package:flutter/material.dart';

class SectorizedBorder extends OutlinedBorder {
  final int sectorsCount;
  const SectorizedBorder({this.sectorsCount = 10, super.side});

  @override
  OutlinedBorder copyWith({BorderSide? side}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getInnerPath
    throw UnimplementedError();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();
    path.addOval(Rect.fromCenter(center: rect.center, width: rect.width, height: rect.height));

    // TODO: implement getOuterPath
    // throw UnimplementedError();
    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    Paint outlinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = side.color
      ..strokeWidth = side.width;

    Paint borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = 1;

    Paint sectorPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = side.width
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(rect.center, rect.width / 2 - side.width / 2, outlinePaint);
    canvas.drawCircle(rect.center, rect.width / 2, borderPaint);
    canvas.drawCircle(rect.center, rect.width / 2 - side.width, borderPaint);

    // canvas.drawArc(Rect.fromCenter(center: rect.center, width: rect.width - 3, height: rect.height - 3), 0, pi / 4, false, sectorPaint);
    for (double i = 0; i <= 2 * pi; i += 2 * pi / sectorsCount) {
      canvas.drawArc(
          Rect.fromCenter(center: rect.center, width: rect.width - side.width, height: rect.height - side.width),
          i,
          0.15 * pi / 180,
          false,
          sectorPaint
      );
    }
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    throw UnimplementedError();
  }
}