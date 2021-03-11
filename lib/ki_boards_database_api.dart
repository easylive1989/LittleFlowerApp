import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:little_flower_app/ki_board.dart';

class KiBoardsDatabaseApi {
  DatabaseReference _kiBoardRef;

  KiBoardsDatabaseApi() {
    _kiBoardRef = FirebaseDatabase.instance.reference().child('kiBoards');
  }

  update(KiBoard kiBoard) {
    _kiBoardRef.child(kiBoard.boardId).set(jsonEncode(kiBoard.toJson()));
  }
}
