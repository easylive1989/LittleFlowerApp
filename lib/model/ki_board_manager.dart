import 'package:flutter/material.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/repo/IKiBoardRepository.dart';
import 'package:random_string/random_string.dart';

class KiBoardManager extends ChangeNotifier {
  KiBoard _current;

  KiBoard get current => _current;

  String _boardId;

  String get boardId => _boardId;

  IKiBoardRepository _kiBoardRepository;

  KiBoardManager(IKiBoardRepository kiBoardRepository) {
    _kiBoardRepository = kiBoardRepository;
  }

  Future resetKiBoard({boardId}) async {
    _boardId = boardId ?? getBoardId();
    _updateKiBoard(await _kiBoardRepository.getKiBoard(_boardId));
    notify();
  }

  void _updateKiBoard(KiBoard kiBoard) {
    _current?.removeListener(notify);
    _current = kiBoard;
    _current.addListener(notify);
  }

  void notify() {
    _kiBoardRepository.saveKiBoard(boardId, _current);
    notifyListeners();
  }

  String getBoardId() {
    return randomAlpha(5);
  }
}
