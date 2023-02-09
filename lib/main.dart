import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:skate_love/players/leena.dart';
import 'package:skate_love/world/ground.dart';

void main() {
  runApp(GameWidget(
    game: LeenaGame(),
  ));
}

class LeenaGame extends FlameGame with HasCollisionDetection, HasKeyboardHandlerComponents{
  Leena leena = Leena();
  late TiledComponent homeMap;


  @override
  Future<void> onLoad() async {
    homeMap = await TiledComponent.load('map.tmx', Vector2.all(32));
    add(homeMap);

    double mapWidth = 32.0 * homeMap.tileMap.map.width;
    double mapHeight = 32.0 * homeMap.tileMap.map.height;

    final obstacleGroup = homeMap.tileMap.getLayer<ObjectGroup>('ground');

    for (final obj in obstacleGroup!.objects) {
      add(Ground(
          size: Vector2(obj.width, obj.height),
          position: Vector2(obj.x, obj.y)));
    }

    camera.viewport = FixedResolutionViewport(Vector2(mapWidth, mapHeight));

    //add player
    add(leena);

    super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
