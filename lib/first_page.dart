import 'dart:math';

import 'package:birthday_card_flame/saw_tooth_clipper.dart';
import 'package:birthday_card_flame/sectorized_border.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
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

class TextFactory {
  TextStyle style;
  StrutStyle strut;
  EdgeInsets? padding;
  TextFactory({
    required this.style,
    required this.strut,
    this.padding
  });

  Widget createText(String text, [bool debug = false]) {
    return Container(
      padding: padding,
      color: debug ? Colors.black : null,
      child: OutlinedText(
        text: Text(
            text,
            textAlign: TextAlign.center,
            style: style,
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

  @override
  Widget build(BuildContext context) {
    TextFactory headerFactory = TextFactory(
      style: const TextStyle(
        color: Colors.pink,
        fontFamily: "Plup",
        fontSize: 42
      ),
      strut: const StrutStyle(
          height: 3.5,
          forceStrutHeight: true
      )
    );

    TextFactory regularFactory = TextFactory(
      style: const TextStyle(
        color: Color.fromRGBO(252, 190, 0, 1.0),
        fontFamily: "Plup",
        fontSize: 28
      ),
      strut: const StrutStyle(
          height: 2.5,
          forceStrutHeight: true
      ),
      padding: EdgeInsets.only(bottom: 16)
    );

    TextFactory endingFactory = TextFactory(
        style: const TextStyle(
            color: Colors.blueAccent,
            fontFamily: "Plup",
            fontSize: 28
        ),
        strut: const StrutStyle(
            height: 0.01,
            forceStrutHeight: true
        ),
        padding: EdgeInsets.only(bottom: 16)
    );


    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      child: particleField.stackAbove(
        child: RepaintBoundary(
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
          
                    headerFactory.createText("Дорогая Мама!"),
          
                    const SizedBox(
                      height: 20,
                    ),
          
                    regularFactory.createText("Желаю тебе всегда хорошего настроения,"),
                    regularFactory.createText("Пусть все дела решаются легко,"),
                    regularFactory.createText("Пусть мы с Сашей чаще радуем тебя,"),
                    regularFactory.createText("Желаю тебе крепкого здоровья"),

                    const SizedBox(
                      height: 20,
                    ),

                    endingFactory.createText("Мы любим тебя!"),

                    Container(
                      // color: Colors.black,
                      child: Icon(
                        Ionicons.heart,
                        color: Colors.red,
                        size: 150,
                        shadows: [
                          for (int i = 0; i < 5; i ++) const Shadow(
                              color: Colors.black,
                            blurRadius: 20
                          ),
                        ],
                      ),
                    )
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
