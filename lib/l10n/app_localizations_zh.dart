// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get button_play_again => '再玩一次';

  @override
  String get switch_public => '公開';

  @override
  String text_ki_wins(Object ki) {
    return '$ki 贏了';
  }

  @override
  String get ki_black => '黑棋';

  @override
  String get ki_white => '白棋';
}
