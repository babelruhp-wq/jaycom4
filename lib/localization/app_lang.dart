import 'package:flutter/widgets.dart';

enum AppLang { ar, en, ur }

class L10n {
  final AppLang lang;
  const L10n(this.lang);

  bool get isAr => lang == AppLang.ar;
  bool get isEn => lang == AppLang.en;
  bool get isUr => lang == AppLang.ur;

  bool get isRtl => lang == AppLang.ar || lang == AppLang.ur;

  TextDirection get dir => isRtl ? TextDirection.rtl : TextDirection.ltr;

  String get code => lang.name;

  String get nextLangLabel {
    switch (lang) {
      case AppLang.en:
        return 'AR';
      case AppLang.ar:
        return 'اردو';
      case AppLang.ur:
        return 'EN';
    }
  }
}