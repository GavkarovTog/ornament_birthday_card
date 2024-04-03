import 'dart:math';

import 'package:birthday_card_flame/saw_tooth_clipper.dart';
import 'package:birthday_card_flame/sectorized_border.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => FrontPageState();
}

class FrontPageState extends State<FrontPage> {
  @override
  void initState() {
    // print("FrontPage.initState() - ${DateTime.now()}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("FrontPage.build - ${DateTime.now()}");

    return LayoutBuilder(
      builder: (_, constraints) {
        const toCompareWith = 392.72727272727275;

        double scale = min(constraints.maxWidth, constraints.maxHeight)
            / toCompareWith;


        return Stack(
          children: [
            Center(child: Image.asset(
              "assets/images/background/title_ornament.jpg",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            )),

            Align(
              alignment: Alignment.center,
              child: ClipPath(
                child: Container(
                  padding: EdgeInsets.all(5 * scale),
                  decoration: const ShapeDecoration(
                      color: Color.fromRGBO(151, 32, 83, 1.0),
                      shape: SectorizedBorder(
                          sectorsCount: 50,
                          side: BorderSide(
                              color: Color.fromRGBO(5, 82, 153, 1.0),
                              width: 30
                          )
                      )
                  ),
                  child: Container(
                    padding: EdgeInsets.all(5 * scale),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black
                        ),
                        color: const Color.fromRGBO(137, 70, 128, 1.0),
                        shape: BoxShape.circle
                    ),
                    child: Container(
                      padding: EdgeInsets.all(1.5 * scale),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black
                          ),
                          color: Colors.white,
                          shape: BoxShape.circle
                      ),
                      child: Container(
                        padding: EdgeInsets.all(20 * scale),
                        decoration: const ShapeDecoration(
                            color: Color.fromRGBO(116, 196, 182, 1.0),
                            shape: SectorizedBorder(
                                sectorsCount: 100,
                                side: BorderSide(
                                    color: Color.fromRGBO(240, 187, 56, 1.0),
                                    width: 15
                                )
                            )
                        ),
                        child: Container(
                          // padding: const EdgeInsets.all(0),
                          padding: EdgeInsets.all(20 * scale),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black
                              ),
                              color: const Color.fromRGBO(20, 82, 145, 1.0),
                              shape: BoxShape.circle
                          ),
                          child: Container(
                            padding: EdgeInsets.all(1.5 * scale),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.black
                                ),
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),
                            child: Container(
                                height: 160 * scale,
                                width: 160 * scale,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black
                                    ),
                                    color: const Color.fromRGBO(
                                        0, 167, 195, 1.0),
                                    shape: BoxShape.circle
                                ),
                                child: Text("С ДНЕМ\nРОЖДЕНИЯ!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Yarin-Bold",
                                      fontSize: 36 * scale),
                                )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      }
    );
  }
}

