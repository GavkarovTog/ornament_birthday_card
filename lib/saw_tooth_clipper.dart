import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SawToothClipper extends CustomClipper<Path> {
  int toothCount;
  double toothHeight;

  SawToothClipper({required this.toothCount, required this.toothHeight});

  @override
  Path getClip(Size size) {
    Path path = Path();
    double radius = min(size.width, size.height) / 2;

    double xCenter = size.width / 2;
    double yCenter = size.height / 2;

    path.moveTo(xCenter + radius, yCenter);
    bool toDown = false;
    for (double i = 0; i <= 2 * pi; i += pi / toothCount) {
      double x = xCenter + radius * cos(i);
      double y = yCenter + radius * sin(i);

      if (! toDown) {
        print("($x, $y) - regular");
        path.lineTo(x, y);
      } else {
        // print(5);
        double xToCenter = xCenter - x;
        double yToCenter = yCenter - y;
        double normFactor = sqrt(xToCenter * xToCenter + yToCenter * yToCenter);

        xToCenter /= normFactor;
        yToCenter /= normFactor;

        print("($x, $y) - irregular");
        print("(${x + xToCenter * toothHeight}, ${y + yToCenter * toothHeight}) - down");
        path.lineTo(
          x + xToCenter * toothHeight,
          y + yToCenter * toothHeight
        );
      }

      toDown = ! toDown;
    }

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}