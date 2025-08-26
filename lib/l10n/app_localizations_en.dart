// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get button_play_again => 'Play Again';

  @override
  String get switch_public => 'Public';

  @override
  String text_ki_wins(Object ki) {
    return '$ki Wins';
  }

  @override
  String get ki_black => 'Black';

  @override
  String get ki_white => 'White';
}
