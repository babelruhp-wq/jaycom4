import 'package:flutter/material.dart';
import '../../main.dart';
import '../../localization/app_lang.dart';
import '../../localization/strings.dart';

class ServicesSection extends StatefulWidget {
  final L10n l10n;
  final bool isMobile;

  const ServicesSection({
    super.key,
    required this.l10n,
    required this.isMobile,
  });

  @override
  State<ServicesSection> createState() => _ServicesSectionState();
}

class _ServicesSectionState extends State<ServicesSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    final isMobile = widget.isMobile;

    final cards = [
      _SvcData(
        icon: Icons.flash_on_rounded,
        title: Tr.t(l10n, "s1t"),
        text: Tr.t(l10n, "s1s"),
        accent: JC.main,
        soft: const Color(0xFFE6F9F1),
        tag: Tr.t(l10n, "servicesTagFast"),
        number: "01",
      ),
      _SvcData(
        icon: Icons.verified_rounded,
        title: Tr.t(l10n, "s2t"),
        text: Tr.t(l10n, "s2s"),
        accent: const Color(0xFF1F9D6E),
        soft: const Color(0xFFEAFBF4),
        tag: Tr.t(l10n, "servicesTagTrusted"),
        number: "02",
      ),
      _SvcData(
        icon: Icons.support_agent_rounded,
        title: Tr.t(l10n, "s3t"),
        text: Tr.t(l10n, "s3s"),
        accent: const Color(0xFF2FAE82),
        soft: const Color(0xFFF1FCF7),
        tag: Tr.t(l10n, "servicesTagSupport"),
        number: "03",
      ),
    ];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 18 : 24,
            vertical: isMobile ? 54 : 72,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section header
              _SectionTag(l10n: l10n),
              const SizedBox(height: 16),
              Text(
                Tr.t(l10n, "servicesTitle"),
                style: TextStyle(
                  color: JC.title,
                  fontWeight: FontWeight.w900,
                  fontSize: isMobile ? 26 : 32,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 10),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Text(
                  Tr.t(l10n, "servicesSub"),
                  style: TextStyle(
                    color: JC.muted,
                    fontWeight: FontWeight.w600,
                    fontSize: isMobile ? 14 : 15,
                    height: 1.7,
                  ),
                ),
              ),
              SizedBox(height: isMobile ? 28 : 36),
              // Cards
              isMobile ? _mobileCards(cards) : _desktopCards(cards),
            ],
          ),
        ),
      ),
    );
  }

  Widget _desktopCards(List<_SvcData> cards) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(cards.length, (i) {
        final start = i * 0.16;
        final end = (start + 0.62).clamp(0.0, 1.0);
        final anim = CurvedAnimation(
          parent: _ctrl,
          curve: Interval(start, end, curve: Curves.easeOutCubic),
        );

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: i == 0 ? 0 : 8,
              right: i == cards.length - 1 ? 0 : 8,
            ),
            child: FadeTransition(
              opacity: anim,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.14),
                  end: Offset.zero,
                ).animate(anim),
                child: _ServiceCard(
                  l10n: widget.l10n,
                  data: cards[i],
                  isMobile: false,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _mobileCards(List<_SvcData> cards) {
    return Column(
      children: List.generate(cards.length, (i) {
        final start = i * 0.16;
        final end = (start + 0.62).clamp(0.0, 1.0);
        final anim = CurvedAnimation(
          parent: _ctrl,
          curve: Interval(start, end, curve: Curves.easeOutCubic),
        );

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: FadeTransition(
            opacity: anim,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.1),
                end: Offset.zero,
              ).animate(anim),
              child: _ServiceCard(
                l10n: widget.l10n,
                data: cards[i],
                isMobile: true,
              ),
            ),
          ),
        );
      }),
    );
  }
}

/* ─── Section Tag ─── */
class _SectionTag extends StatelessWidget {
  final L10n l10n;
  const _SectionTag({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: JC.main.withOpacity(.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: JC.main.withOpacity(.20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.miscellaneous_services_rounded,
              size: 14, color: JC.mainDark),
          const SizedBox(width: 8),
          Text(
            Tr.t(l10n, "servicesTitle"),
            style: TextStyle(
              color: JC.mainDark,
              fontWeight: FontWeight.w900,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}

/* ─── Data ─── */
class _SvcData {
  final IconData icon;
  final String title;
  final String text;
  final Color accent;
  final Color soft;
  final String tag;
  final String number;

  const _SvcData({
    required this.icon,
    required this.title,
    required this.text,
    required this.accent,
    required this.soft,
    required this.tag,
    required this.number,
  });
}

/* ─── Service Card ─── */
class _ServiceCard extends StatefulWidget {
  final L10n l10n;
  final _SvcData data;
  final bool isMobile;

  const _ServiceCard({
    required this.l10n,
    required this.data,
    required this.isMobile,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hover = false;

  bool _enableHover(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 900 && !widget.isMobile;
  }

  @override
  Widget build(BuildContext context) {
    final enableHover = _enableHover(context);
    final d = widget.data;
    final lift = _hover ? -5.0 : 0.0;

    final child = AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      transform: Matrix4.identity()..translate(0.0, lift),
      height: widget.isMobile ? null : 340,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _hover ? d.accent.withOpacity(.25) : JC.border,
        ),
        gradient: LinearGradient(
          colors: [
            Colors.white,
            d.soft.withOpacity(.95),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: _hover ? 44 : 28,
            offset: const Offset(0, 14),
            color:
            (_hover ? d.accent : JC.dark).withOpacity(_hover ? .12 : .06),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Big number watermark
          Positioned(
            top: -8,
            right: 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 220),
              opacity: _hover ? .12 : .06,
              child: Text(
                d.number,
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w900,
                  color: d.accent,
                  height: 1,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(
                    colors: [
                      d.soft,
                      Colors.white,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: d.accent.withOpacity(.20)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: _hover ? 18 : 10,
                      offset: const Offset(0, 6),
                      color: d.accent.withOpacity(_hover ? .16 : .08),
                    ),
                  ],
                ),
                child: Icon(d.icon, color: d.accent, size: 27),
              ),
              const SizedBox(height: 16),
              // Tag
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
                decoration: BoxDecoration(
                  color: d.accent.withOpacity(.08),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: d.accent.withOpacity(.14)),
                ),
                child: Text(
                  d.tag,
                  style: TextStyle(
                    color: d.accent,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    letterSpacing: .2,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Title
              Text(
                d.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: JC.title,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 10),
              // Description
              Text(
                d.text,
                maxLines: widget.isMobile ? 5 : 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: JC.muted,
                  fontWeight: FontWeight.w700,
                  height: 1.75,
                  fontSize: 14,
                ),
              ),
              if (!widget.isMobile) const Spacer(),
              if (widget.isMobile) const SizedBox(height: 16),
              // Bottom row
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: d.accent.withOpacity(.20),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: d.accent.withOpacity(.35)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      Tr.t(widget.l10n, "svcHint"),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: JC.title.withOpacity(.6),
                        fontWeight: FontWeight.w800,
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: _hover
                          ? d.accent.withOpacity(.10)
                          : Colors.white.withOpacity(.65),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: _hover
                            ? d.accent.withOpacity(.22)
                            : JC.border,
                      ),
                    ),
                    child: Icon(
                      Directionality.of(context) == TextDirection.rtl
                          ? Icons.arrow_back_rounded
                          : Icons.arrow_forward_rounded,
                      size: 16,
                      color: d.accent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );

    if (!enableHover) return child;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: child,
    );
  }
}