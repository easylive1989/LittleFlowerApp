import 'package:little_flower_app/model/ki_board.dart';

abstract class KiBoardRepository {
  Future saveKiBoard(String boardId, KiBoard kiBoard);
  Future<KiBoard?> getKiBoard(String boardId);
  Stream<KiBoard> onValue(String boardId);
}
