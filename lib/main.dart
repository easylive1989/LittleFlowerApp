import 'package:flutter/material.dart';
import 'package:little_flower_app/controller/ki_board_controller.dart';

import 'injection.dart';
import 'main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  var kiBoardController = getIt<KiBoardController>();
  runApp(
    MainApp(kiBoardController),
  );
}
