import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Ground extends PositionComponent {
  Ground({required size, required position})
      : super(size: size, position: position) {
    debugMode = true;
  }

  final groundResistance = 0.22;

  @override
  Future<void> onLoad()async {
    add(RectangleHitbox());
    return super.onLoad();
  }
}
