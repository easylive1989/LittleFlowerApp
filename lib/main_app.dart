import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:little_flower_app/controller/ki_board_controller.dart';
import 'package:little_flower_app/generated/l10n.dart';
import 'package:little_flower_app/widget/board_info_area.dart';
import 'package:little_flower_app/widget/ki_board_area.dart';
import 'package:little_flower_app/widget/result_area.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  final KiBoardController _kiBoardController;

  MainApp(this._kiBoardController);

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
          create: (context) => _kiBoardController,
          child: FutureBuilder(
              future: _kiBoardController.resetKiBoard(),
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
}