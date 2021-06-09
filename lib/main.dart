import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:little_flower_app/generated/l10n.dart';
import 'package:little_flower_app/model/ki_board_manager.dart';
import 'package:little_flower_app/widget/board_info_area.dart';
import 'package:little_flower_app/widget/ki_board_area.dart';
import 'package:little_flower_app/widget/result_area.dart';
import 'package:provider/provider.dart';

import 'injection.dart';

void main() async {
  configureInjection();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var kiBoardManager = GetIt.I<KiBoardManager>();
  runApp(MyApp(kiBoardManager));
}

class MyApp extends StatelessWidget {
  final KiBoardManager _kiBoardManager;

  MyApp(this._kiBoardManager);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ChangeNotifierProvider(
          create: (context) => _kiBoardManager,
          child: FutureBuilder(
              future: _kiBoardManager.resetKiBoard(),
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
      return Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: KiBoardArea(model),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ResultArea(model),
          ),
          BoardInfoArea(model),
        ],
      );
    },
  );
}
