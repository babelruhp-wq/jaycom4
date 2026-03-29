import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jaycom/widgets/top_bar.dart';
import '../localization/app_lang.dart';
import '../localization/strings.dart';
import '../main.dart';
import '../widgets/sections/footer.dart';

/* ─── Data Model ─── */
class _TermsSection {
  final String id;
  final String title;
  final String icon;
  final String? content;
  final List<String>? bullets;

  const _TermsSection({
    required this.id,
    required this.title,
    required this.icon,
    this.content,
    this.bullets,
  });
}

/* ─── Colors ─── */
class _C {
  static const bg = Color(0xFFF0F2F0);
  static const dark = Color(0xFF0A1F14);
  static const dark2 = Color(0xFF0F2E1D);
  static const accent = Color(0xFF1DB954);
  static const accentDark = Color(0xFF148A3D);
  static const card = Color(0xFFFFFFFF);
  static const title = Color(0xFF0D1B12);
  static const body = Color(0xFF3A5245);
  static const muted = Color(0xFF6B8578);
  static const border = Color(0xFFD8E4DC);
  static const borderLight = Color(0xFFE8F0EB);
  static const tocBg = Color(0xFFFAFCFB);
  static const activeBg = Color(0xFFE8F5ED);
  static const progressTrack = Color(0xFFD8E4DC);
}

/* ════════════════════════════════════════════════════════════════
   TERMS PAGE
   ════════════════════════════════════════════════════════════════ */
class TermsPage extends StatefulWidget {
  final L10n l10n;

  const TermsPage({super.key, required this.l10n});

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {};
  String _activeId = 'clients';
  double _scrollProgress = 0;
  bool _scrollUpdateScheduled = false;

  late AnimationController _heroAnimController;
  late Animation<double> _heroFade;
  late Animation<Offset> _heroSlide;

  List<_TermsSection> _sections(L10n l10n) {
    return [
      _TermsSection(
        id: 'clients',
        title: Tr.t(l10n, 'terms_sec_clients_title'),
        icon: '👥',
        content: Tr.t(l10n, 'terms_sec_clients_content'),
      ),
      _TermsSection(
        id: 'service',
        title: Tr.t(l10n, 'terms_sec_service_title'),
        icon: '⚙️',
        content: Tr.t(l10n, 'terms_sec_service_content'),
      ),
      _TermsSection(
        id: 'overview',
        title: Tr.t(l10n, 'terms_sec_overview_title'),
        icon: '🔭',
        content: Tr.t(l10n, 'terms_sec_overview_content'),
      ),
      _TermsSection(
        id: 'registration',
        title: Tr.t(l10n, 'terms_sec_registration_title'),
        icon: '🔐',
        bullets: [
          Tr.t(l10n, 'terms_sec_registration_b1'),
          Tr.t(l10n, 'terms_sec_registration_b2'),
          Tr.t(l10n, 'terms_sec_registration_b3'),
          Tr.t(l10n, 'terms_sec_registration_b4'),
          Tr.t(l10n, 'terms_sec_registration_b5'),
          Tr.t(l10n, 'terms_sec_registration_b6'),
        ],
      ),
      _TermsSection(
        id: 'data',
        title: Tr.t(l10n, 'terms_sec_data_title'),
        icon: '📊',
        content: Tr.t(l10n, 'terms_sec_data_content'),
        bullets: [
          Tr.t(l10n, 'terms_sec_data_b1'),
          Tr.t(l10n, 'terms_sec_data_b2'),
          Tr.t(l10n, 'terms_sec_data_b3'),
          Tr.t(l10n, 'terms_sec_data_b4'),
          Tr.t(l10n, 'terms_sec_data_b5'),
        ],
      ),
      _TermsSection(
        id: 'mechanism',
        title: Tr.t(l10n, 'terms_sec_mechanism_title'),
        icon: '🔄',
        bullets: [
          Tr.t(l10n, 'terms_sec_mechanism_b1'),
          Tr.t(l10n, 'terms_sec_mechanism_b2'),
          Tr.t(l10n, 'terms_sec_mechanism_b3'),
          Tr.t(l10n, 'terms_sec_mechanism_b4'),
          Tr.t(l10n, 'terms_sec_mechanism_b5'),
        ],
      ),
      _TermsSection(
        id: 'payment',
        title: Tr.t(l10n, 'terms_sec_payment_title'),
        icon: '💳',
        content: Tr.t(l10n, 'terms_sec_payment_content'),
        bullets: [
          Tr.t(l10n, 'terms_sec_payment_b1'),
          Tr.t(l10n, 'terms_sec_payment_b2'),
          Tr.t(l10n, 'terms_sec_payment_b3'),
          Tr.t(l10n, 'terms_sec_payment_b4'),
          Tr.t(l10n, 'terms_sec_payment_b5'),
          Tr.t(l10n, 'terms_sec_payment_b6'),
          Tr.t(l10n, 'terms_sec_payment_b7'),
        ],
      ),
      _TermsSection(
        id: 'control',
        title: Tr.t(l10n, 'terms_sec_control_title'),
        icon: '🛡️',
        content: Tr.t(l10n, 'terms_sec_control_content'),
      ),
      _TermsSection(
        id: 'modifications',
        title: Tr.t(l10n, 'terms_sec_modifications_title'),
        icon: '📝',
        content: Tr.t(l10n, 'terms_sec_modifications_content'),
        bullets: [
          Tr.t(l10n, 'terms_sec_modifications_b1'),
          Tr.t(l10n, 'terms_sec_modifications_b2'),
          Tr.t(l10n, 'terms_sec_modifications_b3'),
        ],
      ),
      _TermsSection(
        id: 'notifications',
        title: Tr.t(l10n, 'terms_sec_notifications_title'),
        icon: '🔔',
        content: Tr.t(l10n, 'terms_sec_notifications_content'),
        bullets: [
          Tr.t(l10n, 'terms_sec_notifications_b1'),
          Tr.t(l10n, 'terms_sec_notifications_b2'),
          Tr.t(l10n, 'terms_sec_notifications_b3'),
        ],
      ),
      _TermsSection(
        id: 'ip',
        title: Tr.t(l10n, 'terms_sec_ip_title'),
        icon: '©️',
        content: Tr.t(l10n, 'terms_sec_ip_content'),
        bullets: [
          Tr.t(l10n, 'terms_sec_ip_b1'),
          Tr.t(l10n, 'terms_sec_ip_b2'),
        ],
      ),
      _TermsSection(
        id: 'liability',
        title: Tr.t(l10n, 'terms_sec_liability_title'),
        icon: '⚖️',
        content: Tr.t(l10n, 'terms_sec_liability_content'),
        bullets: [
          Tr.t(l10n, 'terms_sec_liability_b1'),
          Tr.t(l10n, 'terms_sec_liability_b2'),
          Tr.t(l10n, 'terms_sec_liability_b3'),
          Tr.t(l10n, 'terms_sec_liability_b4'),
        ],
      ),
      _TermsSection(
        id: 'severability',
        title: Tr.t(l10n, 'terms_sec_severability_title'),
        icon: '📄',
        content: Tr.t(l10n, 'terms_sec_severability_content'),
      ),
      _TermsSection(
        id: 'assignment',
        title: Tr.t(l10n, 'terms_sec_assignment_title'),
        icon: '🔀',
        content: Tr.t(l10n, 'terms_sec_assignment_content'),
      ),
      _TermsSection(
        id: 'law',
        title: Tr.t(l10n, 'terms_sec_law_title'),
        icon: '🏛️',
        content: Tr.t(l10n, 'terms_sec_law_content'),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();

    _heroAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _heroFade =
        CurvedAnimation(parent: _heroAnimController, curve: Curves.easeOut);
    _heroSlide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _heroAnimController, curve: Curves.easeOutCubic),
    );

    _heroAnimController.forward();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final sections = _sections(widget.l10n);
    _sectionKeys.clear();
    for (final s in sections) {
      _sectionKeys[s.id] = GlobalKey();
    }
    if (!sections.any((e) => e.id == _activeId)) {
      _activeId = sections.first.id;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _heroAnimController.dispose();
    super.dispose();
  }

  bool _isMobile(BuildContext context) => MediaQuery.sizeOf(context).width < 1024;

  void _goHome(BuildContext context, {String? section}) {
    final lang = widget.l10n.lang.name;
    final target = section == null || section.isEmpty
        ? '/?lang=$lang'
        : '/?lang=$lang&section=$section';
    context.go(target);
  }

  void _onScroll() {
    if (_scrollUpdateScheduled) return;
    _scrollUpdateScheduled = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _scrollUpdateScheduled = false;

      if (!_scrollController.hasClients) return;
      final sections = _sections(widget.l10n);
      final pos = _scrollController.position;
      final max = pos.maxScrollExtent;
      final newProgress = max > 0 ? (pos.pixels / max).clamp(0.0, 1.0) : 0.0;

      String newActive = sections.first.id;
      for (final s in sections) {
        final key = _sectionKeys[s.id];
        if (key?.currentContext != null) {
          final renderObj = key!.currentContext!.findRenderObject();
          if (renderObj is RenderBox && renderObj.attached) {
            final offset = renderObj.localToGlobal(Offset.zero);
            if (offset.dy < 280) {
              newActive = s.id;
            }
          }
        }
      }

      if (newProgress != _scrollProgress || newActive != _activeId) {
        setState(() {
          _scrollProgress = newProgress;
          _activeId = newActive;
        });
      }
    });
  }

  void _scrollToSection(String id) {
    final key = _sectionKeys[id];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
        alignment: 0.05,
      );
    }
  }

  void _openMobileToc() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'TOC',
      barrierColor: const Color(0xFF0A1F14).withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (ctx, anim, anim2) => const SizedBox.shrink(),
      transitionBuilder: (ctx, anim, anim2, child) {
        final sections = _sections(widget.l10n);
        final slide = Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic));
        return SlideTransition(
          position: slide,
          child: Align(
            alignment: Alignment.centerRight,
            child: Material(
              color: Colors.transparent,
              child: _MobileTocDrawer(
                sections: sections,
                activeId: _activeId,
                onSelect: (id) {
                  Navigator.of(ctx).pop();
                  _scrollToSection(id);
                },
                l10n: widget.l10n,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = _isMobile(context);
    final l10n = widget.l10n;
    final sections = _sections(l10n);
    final currentIdx = sections.indexWhere((s) => s.id == _activeId);

    return Directionality(
      textDirection: l10n.dir,
      child: Scaffold(
        backgroundColor: _C.bg,
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: isMobile ? _MobileFab(onTap: _openMobileToc) : null,
        body: Column(
          children: [
            TopBar(
              l10n: l10n,
              isMobile: isMobile,
              onSelectLang: (lang) => context.go('/terms?lang=${lang.name}'),
              onHome: () => _goHome(context, section: 'home'),
              onAbout: () => _goHome(context, section: 'about'),
              onServices: () => _goHome(context, section: 'services'),
              onContact: () => _goHome(context, section: 'contact'),
              onPrivacy: () => context.go('/privacy?lang=${l10n.lang.name}'),
              onTerms: () => context.go('/terms?lang=${l10n.lang.name}'),
            ),
            Expanded(
              child: isMobile
                  ? _buildMobileLayout(l10n, sections, currentIdx)
                  : _buildDesktopLayout(l10n, sections, currentIdx),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(
      L10n l10n,
      List<_TermsSection> sections,
      int currentIdx,
      ) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          _HeroHeader(
            l10n: l10n,
            isMobile: true,
            scrollProgress: _scrollProgress,
            currentIdx: currentIdx,
            heroFade: _heroFade,
            heroSlide: _heroSlide,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
            child: Column(
              children: [
                const SizedBox(height: 20),
                ...sections.asMap().entries.map((e) {
                  final i = e.key;
                  final s = e.value;
                  return Padding(
                    key: _sectionKeys[s.id],
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _SectionCard(
                      index: i,
                      section: s,
                      isActive: _activeId == s.id,
                      isMobile: true,
                      l10n: l10n,
                    ),
                  );
                }),
                _FooterNote(l10n: l10n),
              ],
            ),
          ),
          Footer(l10n: l10n),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(
      L10n l10n,
      List<_TermsSection> sections,
      int currentIdx,
      ) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          _HeroHeader(
            l10n: l10n,
            isMobile: false,
            scrollProgress: _scrollProgress,
            currentIdx: currentIdx,
            heroFade: _heroFade,
            heroSlide: _heroSlide,
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 60),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 300,
                      child: _DesktopToc(
                        sections: sections,
                        activeId: _activeId,
                        scrollProgress: _scrollProgress,
                        onSelect: _scrollToSection,
                        l10n: l10n,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        children: [
                          ...sections.asMap().entries.map((e) {
                            final i = e.key;
                            final s = e.value;
                            return Padding(
                              key: _sectionKeys[s.id],
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _SectionCard(
                                index: i,
                                section: s,
                                isActive: _activeId == s.id,
                                isMobile: false,
                                l10n: l10n,
                              ),
                            );
                          }),
                          _FooterNote(l10n: l10n),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Footer(l10n: l10n),
        ],
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  final L10n l10n;
  final bool isMobile;
  final double scrollProgress;
  final int currentIdx;
  final Animation<double> heroFade;
  final Animation<Offset> heroSlide;

  const _HeroHeader({
    required this.l10n,
    required this.isMobile,
    required this.scrollProgress,
    required this.currentIdx,
    required this.heroFade,
    required this.heroSlide,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24, isMobile ? 32 : 48, 24, isMobile ? 48 : 64),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_C.dark, _C.dark2, Color(0xFF0D3326)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 0.6, 1],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: _GridPainter()),
          ),
          Positioned(
            top: -60,
            left: MediaQuery.sizeOf(context).width * 0.2,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _C.accent.withOpacity(0.09),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: SlideTransition(
                position: heroSlide,
                child: FadeTransition(
                  opacity: heroFade,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: _C.accent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: _C.accent.withOpacity(0.2)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('⚖️', style: TextStyle(fontSize: 14)),
                            const SizedBox(width: 8),
                            Text(
                              Tr.t(l10n, 'terms_conditions'),
                              style: TextStyle(
                                color: _C.accent.withOpacity(0.95),
                                fontWeight: FontWeight.w900,
                                fontSize: 13,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        Tr.t(l10n, 'terms_conditions'),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: isMobile ? 28 : 44,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 14),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 680),
                        child: Text(
                          Tr.t(l10n, 'terms_hero_subtitle'),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: isMobile ? 14 : 16,
                            height: 1.9,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        children: [
                          SizedBox(
                            width: isMobile ? 180 : 280,
                            height: 4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(99),
                              child: LinearProgressIndicator(
                                value: scrollProgress,
                                backgroundColor: Colors.white.withOpacity(0.1),
                                valueColor: const AlwaysStoppedAnimation<Color>(_C.accent),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Text(
                            '${(scrollProgress * 100).round()}%',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '|',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.25),
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Text(
                            '${currentIdx + 1} / ${_sectionsCountLabel(l10n, currentIdx + 1)}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _sectionsCountLabel(L10n l10n, int current) {
    return '${15} ${Tr.t(l10n, 'terms_sections_count_suffix')}';
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _C.accent.withOpacity(0.04)
      ..strokeWidth = 0.5;
    const spacing = 60.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DesktopToc extends StatelessWidget {
  final List<_TermsSection> sections;
  final String activeId;
  final double scrollProgress;
  final ValueChanged<String> onSelect;
  final L10n l10n;

  const _DesktopToc({
    required this.sections,
    required this.activeId,
    required this.scrollProgress,
    required this.onSelect,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 20, 12, 16),
      decoration: BoxDecoration(
        color: _C.card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _C.border),
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            offset: const Offset(0, 4),
            color: _C.dark.withOpacity(0.06),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 14),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        _C.accent.withOpacity(0.13),
                        _C.accent.withOpacity(0.04),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(color: _C.accent.withOpacity(0.13)),
                  ),
                  child: const Center(child: Text('📑', style: TextStyle(fontSize: 14))),
                ),
                const SizedBox(width: 8),
                Text(
                  Tr.t(l10n, 'terms_toc_title'),
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: _C.title,
                  ),
                ),
              ],
            ),
          ),
          Container(height: 1, color: _C.borderLight),
          const SizedBox(height: 10),
          ...sections.asMap().entries.map((e) {
            final i = e.key;
            final s = e.value;
            final isActive = activeId == s.id;
            return _TocItem(
              index: i,
              title: s.title,
              isActive: isActive,
              onTap: () => onSelect(s.id),
            );
          }),
          const SizedBox(height: 14),
          Container(height: 1, color: _C.borderLight),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Tr.t(l10n, 'terms_reading_progress'),
                      style: const TextStyle(
                        fontSize: 11,
                        color: _C.muted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${(scrollProgress * 100).round()}%',
                      style: const TextStyle(
                        fontSize: 11,
                        color: _C.accent,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: SizedBox(
                    height: 4,
                    child: LinearProgressIndicator(
                      value: scrollProgress,
                      backgroundColor: _C.progressTrack,
                      valueColor: const AlwaysStoppedAnimation<Color>(_C.accent),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TocItem extends StatefulWidget {
  final int index;
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _TocItem({
    required this.index,
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_TocItem> createState() => _TocItemState();
}

class _TocItemState extends State<_TocItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final highlight = widget.isActive || _hovered;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 2),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            color: highlight ? _C.activeBg : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: widget.isActive
                ? Border(
              right: BorderSide(color: _C.accent, width: 3),
            )
                : null,
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: widget.isActive ? _C.accent : _C.bg,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${widget.index + 1}'.padLeft(2, '0'),
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: widget.isActive ? Colors.white : _C.muted,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight:
                    widget.isActive ? FontWeight.w700 : FontWeight.w500,
                    color: widget.isActive ? _C.title : _C.body,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatefulWidget {
  final int index;
  final _TermsSection section;
  final bool isActive;
  final bool isMobile;
  final L10n l10n;

  const _SectionCard({
    required this.index,
    required this.section,
    required this.isActive,
    required this.isMobile,
    required this.l10n,
  });

  @override
  State<_SectionCard> createState() => _SectionCardState();
}

class _SectionCardState extends State<_SectionCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final s = widget.section;
    final i = widget.index;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        padding: EdgeInsets.all(widget.isMobile ? 20 : 28),
        decoration: BoxDecoration(
          color: _C.card,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: widget.isActive ? _C.accent.withOpacity(0.35) : _C.border,
            width: widget.isActive ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: _hovered ? 48 : 24,
              offset: Offset(0, _hovered ? 16 : 12),
              color: _C.dark.withOpacity(_hovered ? 0.08 : 0.05),
            ),
          ],
        ),
        transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: LinearGradient(
                      colors: [
                        _C.accent.withOpacity(0.12),
                        _C.accent.withOpacity(0.04),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(color: _C.accent.withOpacity(0.12)),
                  ),
                  alignment: Alignment.center,
                  child: Text(s.icon, style: const TextStyle(fontSize: 20)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: _C.accent.withOpacity(0.07),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '${Tr.t(widget.l10n, 'terms_clause_prefix')} ${(i + 1).toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _C.accent,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        s.title,
                        style: TextStyle(
                          fontSize: widget.isMobile ? 19 : 22,
                          fontWeight: FontWeight.w900,
                          color: _C.title,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if ((s.content ?? '').isNotEmpty) ...[
              const SizedBox(height: 18),
              Padding(
                padding: EdgeInsets.only(right: widget.isMobile ? 0 : 62),
                child: Text(
                  s.content!,
                  style: const TextStyle(
                    color: _C.body,
                    fontSize: 14.5,
                    height: 2,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
            if ((s.bullets ?? []).isNotEmpty) ...[
              SizedBox(height: s.content != null ? 16 : 18),
              Padding(
                padding: EdgeInsets.only(right: widget.isMobile ? 0 : 62),
                child: Column(
                  children: s.bullets!.asMap().entries.map((e) {
                    final bi = e.key;
                    final b = e.value;
                    return _BulletRow(text: b, isEven: bi % 2 == 0);
                  }).toList(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _BulletRow extends StatefulWidget {
  final String text;
  final bool isEven;

  const _BulletRow({required this.text, required this.isEven});

  @override
  State<_BulletRow> createState() => _BulletRowState();
}

class _BulletRowState extends State<_BulletRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: widget.isEven ? _C.tocBg : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        transform: Matrix4.translationValues(_hovered ? -4 : 0, 0, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 24,
              margin: const EdgeInsets.only(top: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: _C.accent.withOpacity(0.1),
                border: Border.all(color: _C.accent.withOpacity(0.15)),
              ),
              child: const Icon(Icons.check_rounded, size: 14, color: _C.accent),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: _C.title,
                  fontSize: 13.5,
                  height: 1.9,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileTocDrawer extends StatelessWidget {
  final List<_TermsSection> sections;
  final String activeId;
  final ValueChanged<String> onSelect;
  final L10n l10n;

  const _MobileTocDrawer({
    required this.sections,
    required this.activeId,
    required this.onSelect,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: _C.card,
        boxShadow: [
          BoxShadow(
            blurRadius: 40,
            offset: Offset(-8, 0),
            color: Color(0x26000000),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Tr.t(l10n, 'terms_toc_title'),
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 17,
                      color: _C.title,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: _C.bg,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: _C.border),
                      ),
                      child: const Icon(Icons.close_rounded, size: 18, color: _C.muted),
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 1, color: _C.borderLight),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: sections.length,
                itemBuilder: (ctx, i) {
                  final s = sections[i];
                  final isActive = activeId == s.id;
                  return GestureDetector(
                    onTap: () => onSelect(s.id),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 2),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isActive ? _C.activeBg : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: isActive
                            ? Border(right: BorderSide(color: _C.accent, width: 3))
                            : null,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: isActive ? _C.accent : _C.bg,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${i + 1}'.padLeft(2, '0'),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: isActive ? Colors.white : _C.muted,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              s.title,
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight:
                                isActive ? FontWeight.w700 : FontWeight.w500,
                                color: isActive ? _C.title : _C.body,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileFab extends StatelessWidget {
  final VoidCallback onTap;

  const _MobileFab({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: _C.accent,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              blurRadius: 24,
              offset: const Offset(0, 8),
              color: _C.accent.withOpacity(0.35),
            ),
          ],
        ),
        child: const Icon(Icons.menu_rounded, color: Colors.white, size: 26),
      ),
    );
  }
}

class _FooterNote extends StatelessWidget {
  final L10n l10n;

  const _FooterNote({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          decoration: BoxDecoration(
            color: _C.card,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: _C.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('📌', style: TextStyle(fontSize: 14)),
              const SizedBox(width: 8),
              Text(
                Tr.t(l10n, 'terms_last_updated'),
                style: const TextStyle(
                  color: _C.muted,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}