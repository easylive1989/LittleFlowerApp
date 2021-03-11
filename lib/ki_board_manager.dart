import 'package:little_flower_app/ki_board_model.dart';
import 'package:random_string/random_string.dart';

class KiBoardManager {
  get current => KiBoardModel(getBoardId());

  String getBoardId() {
    return randomAlpha(5);
  }
}
