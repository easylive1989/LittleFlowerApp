import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:little_flower_app/model/ki_board_manager.dart';
import 'package:little_flower_app/repo/ki_board_repository_factory.dart';
import 'package:little_flower_app/widget/board_info_area.dart';
import 'package:little_flower_app/widget/ki_board_area.dart';
import 'package:little_flower_app/widget/result_area.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var kiBoardManager = KiBoardManager(KiBoardRepositoryFactory());
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ChangeNotifierProvider(
          create: (context) => kiBoardManager,
          child: FutureBuilder(
              future: kiBoardManager.resetKiBoard(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return _buildKiBoardArea();
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }
}

Widget _buildKiBoardArea() {
  return Consumer<KiBoardManager>(
    builder: (context, model, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(child: BoardInfoArea(model)),
          KiBoardArea(model),
          ResultArea(model),
        ],
      );
    },
  );
}
