import 'app_lang.dart';
import 'strings_ar.dart';
import 'strings_en.dart';
import 'strings_ur.dart';

class Tr {
  static String t(L10n l10n, String key) => _map[l10n.lang]?[key] ?? key;

  static const Map<AppLang, Map<String, String>> _map = {
    AppLang.ar: arStrings,
    AppLang.en: enStrings,
    AppLang.ur: urStrings,
  };
}