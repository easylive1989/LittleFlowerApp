import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:little_flower_app/entity/ki_board.dart';
import 'package:little_flower_app/generated/l10n.dart';
import 'package:little_flower_app/providers.dart';
import 'package:little_flower_app/widget/ki_board_area.dart';

class MainApp extends StatelessWidget {
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
        body: KiBoardListView(),
      ),
    );
  }
}

class KiBoardListView extends ConsumerWidget {
  const KiBoardListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<KiBoard>> kiBoardsFuture = ref.watch(kiBoardsProvider);
    return kiBoardsFuture.when(
      data: (kiBoards) {
        return PageView.builder(
          controller: PageController(viewportFraction: 0.6),
          scrollDirection: Axis.vertical,
          itemCount: kiBoards.length,
          itemBuilder: (context, index) {
            return KiBoardArea(kiBoard: kiBoards[index]);
          },
        );
      },
      error: (e, st) => SizedBox(),
      loading: () => CircularProgressIndicator(),
    );
  }
}
