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
  final AppLang initialLang;
  final String? initialSection;

  const HomePage({
    super.key,
    this.initialLang = AppLang.ar,
    this.initialSection,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  late AppLang _lang;
  String? _lastHandledSection;

  L10n get _l10n => L10n(_lang);

  @override
  void initState() {
    super.initState();
    _lang = widget.initialLang;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleInitialSection();
    });
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialLang != widget.initialLang && _lang != widget.initialLang) {
      setState(() {
        _lang = widget.initialLang;
      });
    }

    if (oldWidget.initialSection != widget.initialSection) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleInitialSection();
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleInitialSection() {
    final section = widget.initialSection;
    if (section == null || section.isEmpty) return;
    if (_lastHandledSection == section) return;

    _lastHandledSection = section;

    switch (section) {
      case 'home':
        _scrollTo(_homeKey);
        break;
      case 'about':
        _scrollTo(_aboutKey);
        break;
      case 'services':
        _scrollTo(_servicesKey);
        break;
      case 'contact':
        _scrollTo(_contactKey);
        break;
    }
  }

  void _setLang(AppLang lang) {
    if (_lang == lang) return;

    setState(() {
      _lang = lang;
    });

    final uri = Uri.parse(GoRouterState.of(context).uri.toString());
    final updatedQuery = Map<String, String>.from(uri.queryParameters);
    updatedQuery['lang'] = lang.name;

    final newUri = uri.replace(queryParameters: updatedQuery);
    context.go(newUri.toString());
  }

  Future<void> _scrollTo(GlobalKey key, {String? sectionName}) async {
    final ctx = key.currentContext;
    if (ctx == null) return;

    if (sectionName != null) {
      final uri = Uri.parse(GoRouterState.of(context).uri.toString());
      final updatedQuery = Map<String, String>.from(uri.queryParameters);
      updatedQuery['lang'] = _lang.name;
      updatedQuery['section'] = sectionName;

      final newUri = uri.replace(
        path: '/',
        queryParameters: updatedQuery,
      );

      if (uri.toString() != newUri.toString()) {
        context.go(newUri.toString());
      }
    }

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
                    onSelectLang: _setLang,
                    onHome: () => _scrollTo(_homeKey, sectionName: 'home'),
                    onAbout: () => _scrollTo(_aboutKey, sectionName: 'about'),
                    onServices: () =>
                        _scrollTo(_servicesKey, sectionName: 'services'),
                    onContact: () =>
                        _scrollTo(_contactKey, sectionName: 'contact'),
                    onPrivacy: () => context.go('/privacy?lang=${_lang.name}'),
                    onTerms: () => context.go('/terms?lang=${_lang.name}'),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    key: _homeKey,
                    child: HeroSection(
                      l10n: _l10n,
                      isMobile: isMobile,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: HowItWorks(
                    l10n: _l10n,
                    isMobile: isMobile,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    key: _aboutKey,
                    child: AboutSection(
                      l10n: _l10n,
                      isMobile: isMobile,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    key: _servicesKey,
                    child: ServicesSection(
                      l10n: _l10n,
                      isMobile: isMobile,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: CtaSection(
                    l10n: _l10n,
                    isMobile: isMobile,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    key: _contactKey,
                    child: ContactSection(
                      l10n: _l10n,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Footer(l10n: _l10n),
                ),
              ],
            ),
            Positioned(
              right: _l10n.isRtl ? null : 16,
              left: _l10n.isRtl ? 16 : null,
              bottom: 16,
              child: ContactFab(
                l10n: _l10n,
                onOpenContactSection: () =>
                    _scrollTo(_contactKey, sectionName: 'contact'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}