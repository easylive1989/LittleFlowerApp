import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:little_flower_app/generated/l10n.dart';
import 'package:little_flower_app/widget/board_info/board_id_widget.dart';
import 'package:little_flower_app/widget/board/ki_board_area.dart';
import 'package:little_flower_app/widget/result_area.dart';

class MainApp extends StatelessWidget {
  const MainApp();

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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              BoardIdWidget(),
              SizedBox(height: 16),
              KiBoardArea(),
              ResultArea(),
            ],
          ),
        ),
      ),
    );
  }
}
