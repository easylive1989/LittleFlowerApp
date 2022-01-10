import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:little_flower_app/service/ki_board_service.dart';

import 'injection.dart';
import 'main_app.dart';

void main() async {
  configureInjection();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var kiBoardManager = GetIt.I<KiBoardService>();
  runApp(
    MainApp(kiBoardManager),
  );
}

