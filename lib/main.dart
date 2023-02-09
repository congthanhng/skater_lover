import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(
    game: Leena(),
  ));
}

class Leena extends FlameGame {
  SpriteComponent leena = SpriteComponent();
  late TiledComponent homeMap;
  double gravity = 1.8;
  Vector2 velocity = Vector2(0, 0);

  @override
  Future<void> onLoad() async {

    homeMap = await TiledComponent.load('map.tmx', Vector2.all(32));
    add(homeMap);

    double mapWidth = 32.0 * homeMap.tileMap.map.width;
    double mapHeight = 32.0 * homeMap.tileMap.map.height;

    camera.viewport = FixedResolutionViewport(Vector2(mapWidth, mapHeight));

    //add player
    leena
      ..sprite = await loadSprite('girl_push_single_00.png')
      ..size = Vector2.all(100)
      ..position = Vector2(100, 30);
    add(leena);

    super.onLoad();
  }

  @override
  void update(double dt) {
    if (leena.y < homeMap.height - leena.height) {
      velocity.y += gravity;
      leena.position.y += velocity.y * dt;
    }
    super.update(dt);
  }
}
