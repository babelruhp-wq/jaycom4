import 'package:flutter/material.dart';

import '../localization/app_lang.dart';
import '../widgets/sections/footer.dart';
import '../widgets/top_bar.dart';

class SiteShellPage extends StatelessWidget {
  final L10n l10n;
  final Widget child;

  const SiteShellPage({
    super.key,
    required this.l10n,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 1180;

    return Directionality(
      textDirection: l10n.dir,
      child: Scaffold(
        backgroundColor: const Color(0xFF16A34A),
        body: Column(
          children: [
            TopBar(
              l10n: l10n,
              isMobile: isMobile,
              onSelectLang: (lang) {},
              onHome: () {},
              onAbout: () {},
              onServices: () {},
              onContact: () {},
              onPrivacy: () {},
              onTerms: () {},
            ),
            Expanded(child: child),
            Footer(l10n: l10n),
          ],
        ),
      ),
    );
  }
}