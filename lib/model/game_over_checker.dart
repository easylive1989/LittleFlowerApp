import 'dart:math';

class GameOverChecker {
  final List<Point<int>> kiList;
  final int row;
  final int column;

  GameOverChecker(this.kiList, this.row, this.column);

  bool isGameOver(Point lastMove) {
    var verticalCount = _verify(
        lastMove,
        (point) => Point(point.x + 1, point.y),
        (point) => Point(point.x - 1, point.y));
    if (verticalCount >= 5) {
      return true;
    }

    var horizontalCount = _verify(
        lastMove,
        (point) => Point(point.x, point.y + 1),
        (point) => Point(point.x, point.y - 1));
    if (horizontalCount >= 5) {
      return true;
    }

    var slopeCount = _verify(
        lastMove,
        (point) => Point(point.x + 1, point.y + 1),
        (point) => Point(point.x - 1, point.y - 1));
    if (slopeCount >= 5) {
      return true;
    }

    var antiSlopeCount = _verify(
        lastMove,
        (point) => Point(point.x + 1, point.y - 1),
        (point) => Point(point.x - 1, point.y + 1));
    if (antiSlopeCount >= 5) {
      return true;
    }
    return false;
  }

  int _verify(Point point, Point Function(Point) nextPositiveFn,
      Point Function(Point) nextNegativeFn) {
    if (point.x < 0 || point.y < 0 || point.x > row || point.y > column) {
      return 0;
    }

    if (kiList.contains(point)) {
      return 1 +
          (nextPositiveFn == null
              ? 0
              : _verify(nextPositiveFn(point), nextPositiveFn, null)) +
          (nextNegativeFn == null
              ? 0
              : _verify(nextNegativeFn(point), null, nextNegativeFn));
    } else {
      return 0;
    }
  }
}
