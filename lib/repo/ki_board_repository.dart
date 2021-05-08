import 'package:little_flower_app/model/ki_board.dart';

abstract class KiBoardRepository {
  void saveKiBoard(String boardId, KiBoard kiBoard);
  Future<KiBoard> getKiBoard(String boardId);
}
