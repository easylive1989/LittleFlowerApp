import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/repository/ki_board_repository.dart';
import 'package:random_string/random_string.dart';

final kiBoardServiceProvider = Provider<KiBoardService>((ref) {
  return KiBoardService(ref.watch(kiBoardRepositoryProvider));
});

@Injectable()
class KiBoardService {
  KiBoardRepository _localRepository;

  KiBoardService(KiBoardRepository repository)
      : _localRepository = repository;

  Future resetKiBoard(String boardId) async {
    await _createBoard(boardId);
  }

  Future<String> createBoard() async {
    var boardId = randomAlpha(5);
    await _createBoard(boardId);
    return boardId;
  }

  Future _createBoard(String boardId) async {
    var board = KiBoard(boardId: boardId);
    await _localRepository.saveKiBoard(boardId, board);
  }
}
