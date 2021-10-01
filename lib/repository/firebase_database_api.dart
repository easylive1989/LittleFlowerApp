import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import 'package:little_flower_app/model/ki_board.dart';
import 'package:little_flower_app/repository/ki_board_repository.dart';

@Injectable()
class FirebaseDatabaseApi extends KiBoardRepository {
  final DatabaseReference _kiBoardRef;

  FirebaseDatabaseApi()
      : _kiBoardRef = FirebaseDatabase.instance.reference().child('kiBoards');

  Stream<KiBoard> onValue(boardId) {
    return _kiBoardRef.child(boardId).onValue.map((event) {
      return KiBoard.fromJson(jsonDecode(event.snapshot.value));
    });
  }

  @override
  Future<KiBoard?> getKiBoard(String boardId) async {
    var dataSnapshot = await _kiBoardRef.child(boardId).once();
    if (dataSnapshot.value != null) {
      return KiBoard.fromJson(jsonDecode(dataSnapshot.value));
    } else {
      return null;
    }
  }

  @override
  Future saveKiBoard(String boardId, KiBoard kiBoard) async {
    await _kiBoardRef.child(boardId).set(jsonEncode(kiBoard.toJson()));
  }

  @override
  Future<List<String>> getBoardIds() async {
    var data = await _kiBoardRef.once();
    if (data.value != null) {
      return data.value;
    } else {
      return List<String>.empty();
    }
  }

  @override
  Future remove(String boardId) async {
    await _kiBoardRef.child(boardId).remove();
  }
}
