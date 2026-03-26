import 'package:flutter/widgets.dart';

enum AppLang { ar, en }

class L10n {
  final AppLang lang;
  const L10n(this.lang);

  bool get isAr => lang == AppLang.ar;
  TextDirection get dir => isAr ? TextDirection.rtl : TextDirection.ltr;
}
