import 'package:flutter/cupertino.dart';
import 'package:little_flower_app/generated/l10n.dart';
import 'package:little_flower_app/model/ki.dart';

class TranslateHelper {
  static String getKi(BuildContext context, Ki ki) {
    return ki == Ki.black ? S.of(context).ki_black : S.of(context).ki_white;
  }
}
