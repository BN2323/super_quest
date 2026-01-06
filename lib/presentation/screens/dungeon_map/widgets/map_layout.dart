import 'dart:ui';

class MapLayout {
  static const double nodeSize = 64;
  static const double verticalSpacing = 120;
  static const double horizontalOffset = 90;

  static Offset roomPosition({
    required int index,
    required double mapWidth,
  }) {
    final centerX = (mapWidth - nodeSize) / 2;
    final leftX = centerX - horizontalOffset;
    final rightX = centerX + horizontalOffset;

    double x;
    if (index % 3 == 0) {
      x = centerX;
    } else if (index % 3 == 1) {
      x = leftX;
    } else {
      x = rightX;
    }

    final y = index * verticalSpacing;
    return Offset(x, y);
  }

  static double mapHeight(int roomCount) {
    return roomCount * verticalSpacing + 200;
  }
}
