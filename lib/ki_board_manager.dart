import 'package:little_flower_app/ki_board.dart';
import 'package:random_string/random_string.dart';

class KiBoardManager {
  get current => KiBoard(getBoardId());

  String getBoardId() {
    return randomAlpha(5);
  }
}
