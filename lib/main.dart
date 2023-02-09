import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(
    game: Leena(),
  ));
}

class Leena extends FlameGame {
  SpriteComponent leena = SpriteComponent();

  double gravity = 1.8;
  Vector2 velocity = Vector2(0, 0);

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    await super.onLoad();
    leena
      ..sprite = await loadSprite('girl_push_single_00.png')
      ..size = Vector2.all(100)
      ..position = Vector2(100, 30);
    add(leena);
  }

  @override
  void update(double dt) {
    if (leena.y < size.y - leena.height) {
      velocity.y += gravity;
      leena.position.y += velocity.y * dt;
    }
    super.update(dt);
  }
}
