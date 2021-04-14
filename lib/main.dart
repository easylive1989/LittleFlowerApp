import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:little_flower_app/ki_board_manager.dart';
import 'package:little_flower_app/ki_board_widget.dart';
import 'package:little_flower_app/preference_api.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var kiBoardManager = KiBoardManager(PreferenceApi());
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => kiBoardManager,
          child: FutureBuilder(
              future: kiBoardManager.resetKiBoard(),
              builder: (context, snapshot) {
                return KiBoardWidget();
              }),
        ),
      ),
    );
  }
}
