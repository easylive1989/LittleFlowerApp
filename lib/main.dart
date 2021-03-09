import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:little_flower_app/ki_board.dart';
import 'package:little_flower_app/ki_board_model.dart';
import 'package:little_flower_app/ki_boards_database_api.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => KiBoardModel(KiBoardsDatabaseApi()),
          child: KiBoard(),
        ),
      ),
    );
  }
}
