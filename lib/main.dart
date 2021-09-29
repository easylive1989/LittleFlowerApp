import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:little_flower_app/generated/l10n.dart';
import 'package:little_flower_app/service/ki_board_service.dart';
import 'package:little_flower_app/widget/board_info_area.dart';
import 'package:little_flower_app/widget/ki_board_area.dart';
import 'package:little_flower_app/widget/result_area.dart';
import 'package:provider/provider.dart';

import 'injection.dart';

void main() async {
  configureInjection();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var kiBoardManager = GetIt.I<KiBoardService>();
  kiBoardManager.loadBoardIds();
  runApp(MyApp(kiBoardManager));
}

class MyApp extends StatelessWidget {
  final KiBoardService _kiBoardService;

  MyApp(this._kiBoardService);

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
          create: (context) => _kiBoardService,
          child: FutureBuilder(
              future: _kiBoardService.resetKiBoard(),
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
  return Stack(
    children: [
      Align(
        alignment: Alignment.center,
        child: KiBoardArea(),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: ResultArea(),
      ),
      BoardInfoArea(),
    ],
  );
}
