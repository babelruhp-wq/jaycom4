import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../localization/app_lang.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/contact_section.dart';
import '../widgets/sections/cta_section.dart';
import '../widgets/sections/footer.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/how_it_works.dart';
import '../widgets/sections/services_section.dart';
import '../widgets/top_bar.dart';
import '../widgets/contact_fab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  AppLang _lang = AppLang.en;

  L10n get _l10n => L10n(_lang);

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleLang() {
    setState(() {
      switch (_lang) {
        case AppLang.en:
          _lang = AppLang.ar;
          break;
        case AppLang.ar:
          _lang = AppLang.ur;
          break;
        case AppLang.ur:
          _lang = AppLang.en;
          break;
      }
    });
  }

  Future<void> _scrollTo(GlobalKey key) async {
    final ctx = key.currentContext;
    if (ctx == null) return;

    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
      alignment: 0.05,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 1180;

    return Directionality(
      textDirection: _l10n.dir,
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: TopBar(
                    l10n: _l10n,
                    isMobile: isMobile,
                    onSelectLang: (lang) {
                      setState(() {
                        _lang = lang;
                      });
                    },
                    onHome: () => _scrollTo(_homeKey),
                    onAbout: () => _scrollTo(_aboutKey),
                    onServices: () => _scrollTo(_servicesKey),
                    onContact: () => _scrollTo(_contactKey),
                    onPrivacy: () =>
                        context.push('/privacy?lang=${_lang.name}'),
                    onTerms: () => context.push('/terms?lang=${_lang.name}'),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    key: _homeKey,
                    child: HeroSection(l10n: _l10n, isMobile: isMobile),
                  ),
                ),
                SliverToBoxAdapter(
                  child: HowItWorks(l10n: _l10n, isMobile: isMobile),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    key: _aboutKey,
                    child: AboutSection(l10n: _l10n, isMobile: isMobile),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    key: _servicesKey,
                    child: ServicesSection(l10n: _l10n, isMobile: isMobile),
                  ),
                ),
                SliverToBoxAdapter(
                  child: CtaSection(l10n: _l10n, isMobile: isMobile),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    key: _contactKey,
                    child: ContactSection(l10n: _l10n),
                  ),
                ),
                SliverToBoxAdapter(child: Footer(l10n: _l10n)),
              ],
            ),
            Positioned(
              right: _l10n.isRtl ? null : 16,
              left: _l10n.isRtl ? 16 : null,
              bottom: 16,
              child: ContactFab(
                l10n: _l10n,
                onOpenContactSection: () => _scrollTo(_contactKey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
