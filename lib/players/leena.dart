import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:skate_love/main.dart';

import '../world/ground.dart';

class Leena extends SpriteComponent
    with CollisionCallbacks, HasGameRef<LeenaGame>, KeyboardHandler {
  Leena() : super() {
    debugMode = true;
    anchor = Anchor.bottomCenter;
  }

  double gravity = 9;
  Vector2 velocity = Vector2(0, 0);
  bool onGround = false;
  double pushSpeed = 100;
  double jumpForce = 350;
  bool facingLeft = false;

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('girl_push_single_00.png');
    size = Vector2.all(100);
    position = Vector2(624, 30);
    add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    //moving left
    // if(velocity.x < 0){
    //   velocity.x += gameRef.
    // }

    if (!onGround) {
      velocity.y += gravity;
    }
    position += velocity * dt;
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Ground) {
      if (velocity.y > 0) {
        if (intersectionPoints.length == 2) {
          var x1 = intersectionPoints.first[0];
          var x2 = intersectionPoints.last[0];
          if ((x1 - x2).abs() < 2) {
            // velocity.y = 100;
          } else {
            velocity.y = 0;
            onGround = true;
          }
        }
      } else {
        if (velocity.x != 0) {
          for (var point in intersectionPoints) {
            if (y - 5 >= point.y) {
              velocity.x = 0;
            }
          }
        }
      }
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    onGround = false;
    super.onCollisionEnd(other);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (onGround && keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      velocity.y -= jumpForce;
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      print('move left');
      velocity.x -= pushSpeed;
      if (!facingLeft) {
        facingLeft = true;
        flipHorizontallyAroundCenter();
      }
    }

    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      print('move right');
      velocity.x += pushSpeed;
      if (facingLeft) {
        facingLeft = false;
        flipHorizontallyAroundCenter();
      }
    }

    return super.onKeyEvent(event, keysPressed);
  }
}
