import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: BirthdayCard()));
}

class BirthdayCard extends FlameGame with SingleGameInstance {
  @override
  FutureOr<void> onLoad() async {
    List<SpriteAnimationComponent> backgroundComposited = [];
    const backgroundSpriteRowCount = 3;
    const backgroundSpriteColCount = 2;

    for (int i = 0; i < backgroundSpriteRowCount; i ++) {
      for (int j = 0; j < backgroundSpriteColCount; j ++) {
        backgroundComposited.add(
          SpriteAnimationComponent(
            size: Vector2(size.x / backgroundSpriteColCount.toDouble(), size.y / backgroundSpriteRowCount.toDouble()),
            position: Vector2(
              size.x / backgroundSpriteColCount.toDouble() * i,
              size.y / backgroundSpriteRowCount.toDouble() * j
            ),
            animation: await loadSpriteAnimation(
                "background/background_animated.png",
                SpriteAnimationData.sequenced(
                    amount: 4,
                    stepTime: 0.2,
                    textureSize: Vector2(64, 64)
                )
            )
          )
        );
      }
    }

    addAll(backgroundComposited);
  }
}