import 'dart:math';

import 'package:birthday_card_flame/saw_tooth_clipper.dart';
import 'package:birthday_card_flame/sectorized_border.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:particle_field/particle_field.dart';
import 'package:rnd/rnd.dart';
import 'package:outlined_text/outlined_text.dart';

class ParticleInfo {
  double dx;
  double dy;
  double rotationVelocity;
  ParticleInfo({
    this.dx = 0.0,
    this.dy = 0.0,
    this.rotationVelocity = 0.0
  });
}

Map<Particle, ParticleInfo> particleInfo = {};

class BackwardPage extends StatefulWidget {
  const BackwardPage({super.key});

  @override
  State<BackwardPage> createState() => BackwardPageState();
}

class BackwardPageState extends State<BackwardPage> {
  static const countOfArts = 5;
  static const artHeight = 200;
  static const artScale = 0.6;
  double? previousElapsed;

  late SpriteSheet sprite = SpriteSheet(
      image: const AssetImage("assets/images/spritesheet.png"),
      frameWidth: 200
  );

  late final particleField = ParticleField(
      origin: Alignment.topLeft,
      spriteSheet: sprite,
      onTick: (controller, elapsed, size) {
        List<Particle> particles = controller.particles;

        while (particles.length < countOfArts) {
          double scale = rnd(0.25, artScale);

          final particle = Particle(
              frame: rnd.nextInt(3),
              scale: scale,
              x: rnd(0, size.width),
              y: size.height + artHeight / 2 * scale,
              vy: rnd(-5, -10),
              rotation: pi
          );

          if (particle.x > size.width / 2) {
            particle.vx = rnd(-6, -2);
          } else {
            particle.vx = rnd(2, 6);
          }
          particles.add(particle);
          particleInfo[particle] = ParticleInfo(
              dx: 0,
              dy: 10,
              rotationVelocity: rnd(30 * pi / 180, 360 * pi / 180)
          );
        }

        previousElapsed ??= elapsed.inMilliseconds / 1000;
        double currentElapsed = elapsed.inMilliseconds / 1000;
        double delta = currentElapsed - previousElapsed!;

        for (final particle in particles) {
          final info = particleInfo[particle];
          particle.update(
              vx: particle.vx + info!.dx * delta,
              vy: particle.vy + info.dy * delta,
              rotation: particle.rotation + info.rotationVelocity * delta
          );
        }

        for (int i = particles.length - 1; i >= 0; i --) {
          final particle = particles[i];

          if (particle.y > size.height + artHeight * particle.scale) {
            particles.remove(particle);
          }
        }

        previousElapsed = currentElapsed;
      });

  Widget _createText(String text, StrutStyle strut) {
    return Container(
      // color: Colors.black,
      child: OutlinedText(
        text: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color.fromRGBO(252, 190, 0, 1.0),
                fontSize: 28
            ),
            strutStyle: strut
        ),

        strokes: [
          OutlinedTextStroke(
              color: Colors.black,
              width: 8,
              strutStyle: strut
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print("test - ${DateTime.now()}");
    const strut = StrutStyle(
      height: 3.5,
      forceStrutHeight: true
    );

    const smallStrut = StrutStyle(
      height: 2,
      forceStrutHeight: true
    );

    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      child: particleField.stackAbove(
        child: Stack(
          children: [
            Center(
                child: Image.asset(
              "assets/images/background/first_ornament.jpg",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            )),

            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // TODO: first text, then style
                  // TODO: problems with strut??????
                  Container(
                    // color: Colors.black,
                    child: OutlinedText(
                      text: Text(
                        "Дорогая Мама!",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 42
                        ),
                        strutStyle: strut
                      ),

                      strokes: [
                        OutlinedTextStroke(
                          color: Colors.black,
                          width: 8,
                          strutStyle: strut
                        )
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  _createText("Желаю тебе хорошего настроения,", smallStrut),
                  _createText("Чтобы мы с Сашей чаще радовали тебя,", smallStrut),


                  // Container(
                  //   // color: Colors.black,
                  //   child: OutlinedText(
                  //     text: const Text(
                  //         "Желаю тебе хорошего настроения,\n" +
                  //         "Чтобы мы с Сашей чаще радовали тебя,",
                  //         textAlign: TextAlign.center,
                  //         style: TextStyle(
                  //             color: Color.fromRGBO(252, 190, 0, 1.0),
                  //             fontSize: 28
                  //         ),
                  //         strutStyle: smallStrut
                  //     ),
                  //
                  //     strokes: [
                  //       OutlinedTextStroke(
                  //           color: Colors.black,
                  //           width: 8,
                  //           strutStyle: smallStrut
                  //       )
                  //     ],
                  //   ),
                  // ),
                  //


                  // OutlinedText(
                  //   text: const Text(
                  //     "Дорогая Мама!\n",
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //       color: Colors.pinkAccent,
                  //       fontSize: 42,
                  //     ),
                  //     strutStyle: StrutStyle(
                  //         forceStrutHeight: true
                  //     ),
                  //   ),
                  //   strokes: [
                  //     OutlinedTextStroke(
                  //       color: Colors.black,
                  //       width: 8
                  //     )
                  //   ],
                  // ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
