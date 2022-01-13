import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:little_flower_app/controller/ki_board_controller.dart';

import 'injection.dart';
import 'main_app.dart';

void main() async {
  configureInjection();
  WidgetsFlutterBinding.ensureInitialized();
  var kiBoardController = GetIt.I<KiBoardController>();
  runApp(
    MainApp(kiBoardController),
  );
}
