import 'package:flutter/material.dart';
import '../../main.dart';
import '../../localization/app_lang.dart';
import '../../localization/strings.dart';

class AboutSection extends StatefulWidget {
  final L10n l10n;
  final bool isMobile;

  const AboutSection({super.key, required this.l10n, required this.isMobile});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _slide = Tween<Offset>(
      begin: const Offset(0, .08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    final isMobile = widget.isMobile;

    return Container(
      width: double.infinity,
      color: const Color(0xFFF0F9F4),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _AboutBgPainter())),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1180),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 18 : 24,
                  vertical: isMobile ? 54 : 72,
                ),
                child: FadeTransition(
                  opacity: _fade,
                  child: SlideTransition(
                    position: _slide,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section header
                        _SectionTag(l10n: l10n),
                        const SizedBox(height: 16),
                        Text(
                          Tr.t(l10n, "aboutTitle"),
                          style: TextStyle(
                            color: JC.title,
                            fontWeight: FontWeight.w900,
                            fontSize: isMobile ? 26 : 32,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 550),
                          child: Text(
                            Tr.t(l10n, "aboutSub"),
                            style: TextStyle(
                              color: JC.muted,
                              fontWeight: FontWeight.w600,
                              fontSize: isMobile ? 14 : 15,
                              height: 1.7,
                            ),
                          ),
                        ),
                        SizedBox(height: isMobile ? 28 : 36),
                        // Main card
                        Container(
                          padding: EdgeInsets.all(isMobile ? 18 : 28),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(color: JC.border),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 40,
                                offset: const Offset(0, 16),
                                color: JC.dark.withOpacity(.07),
                              ),
                            ],
                          ),
                          child: isMobile
                              ? _mobileContent(l10n)
                              : _desktopContent(l10n),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _desktopContent(L10n l10n) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BulletItem(text: Tr.t(l10n, "bullet1"), index: 0),
              _BulletItem(text: Tr.t(l10n, "bullet2"), index: 1),
              _BulletItem(text: Tr.t(l10n, "bullet3"), index: 2),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          flex: 4,
          child: _HighlightsPanel(l10n: l10n),
        ),
      ],
    );
  }

  Widget _mobileContent(L10n l10n) {
    return Column(
      children: [
        _BulletItem(text: Tr.t(l10n, "bullet1"), index: 0),
        _BulletItem(text: Tr.t(l10n, "bullet2"), index: 1),
        _BulletItem(text: Tr.t(l10n, "bullet3"), index: 2),
        const SizedBox(height: 16),
        _HighlightsPanel(l10n: l10n),
      ],
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
          Icon(Icons.public_rounded, size: 14, color: JC.mainDark),
          const SizedBox(width: 8),
          Text(
            Tr.t(l10n, "aboutTitle"),
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

/* ─── Bullet Item ─── */
class _BulletItem extends StatefulWidget {
  final String text;
  final int index;
  const _BulletItem({required this.text, required this.index});

  @override
  State<_BulletItem> createState() => _BulletItemState();
}

class _BulletItemState extends State<_BulletItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final enableHover = MediaQuery.sizeOf(context).width >= 900;

    final child = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: _hover ? JC.main.withOpacity(.05) : const Color(0xFFF8FCFA),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: _hover ? JC.main.withOpacity(.20) : JC.border,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  JC.main.withOpacity(.16),
                  JC.main.withOpacity(.08),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: JC.main.withOpacity(.22)),
            ),
            child: const Icon(Icons.check_rounded, size: 18, color: JC.mainDark),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 2),
                Text(
                  widget.text,
                  style: const TextStyle(
                    color: JC.title,
                    fontWeight: FontWeight.w800,
                    height: 1.65,
                    fontSize: 14.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (!enableHover) return child;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: child,
    );
  }
}

/* ─── Highlights Panel ─── */
class _HighlightsPanel extends StatelessWidget {
  final L10n l10n;
  const _HighlightsPanel({required this.l10n});

  @override
  Widget build(BuildContext context) {
    final items = [
      _HItem(Icons.location_on_rounded, Tr.t(l10n, "aboutFastReachTitle"),
          Tr.t(l10n, "aboutFastReachSub")),
      _HItem(Icons.verified_rounded, Tr.t(l10n, "aboutTrustedQualityTitle"),
          Tr.t(l10n, "aboutTrustedQualitySub")),
      _HItem(Icons.language_rounded, Tr.t(l10n, "aboutWiderVisionTitle"),
          Tr.t(l10n, "aboutWiderVisionSub")),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4FBF7),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: JC.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items
            .map((e) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _HighlightTile(item: e),
        ))
            .toList(),
      ),
    );
  }
}

class _HItem {
  final IconData icon;
  final String title;
  final String subtitle;
  const _HItem(this.icon, this.title, this.subtitle);
}

class _HighlightTile extends StatefulWidget {
  final _HItem item;
  const _HighlightTile({required this.item});

  @override
  State<_HighlightTile> createState() => _HighlightTileState();
}

class _HighlightTileState extends State<_HighlightTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final enableHover = MediaQuery.sizeOf(context).width >= 900;

    final child = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      transform: Matrix4.identity()..translate(0.0, _hover ? -2.0 : 0.0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: _hover ? JC.main.withOpacity(.22) : JC.border,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: _hover ? 20 : 10,
            offset: const Offset(0, 8),
            color: (_hover ? JC.main : JC.dark).withOpacity(_hover ? .10 : .04),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: LinearGradient(
                colors: [JC.main.withOpacity(.18), JC.main.withOpacity(.08)],
              ),
            ),
            child: Icon(widget.item.icon, color: JC.mainDark, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.title,
                  style: const TextStyle(
                    color: JC.title,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  widget.item.subtitle,
                  style: const TextStyle(
                    color: JC.muted,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (!enableHover) return child;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: child,
    );
  }
}

/* ─── Background ─── */
class _AboutBgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = JC.main.withOpacity(.04)
      ..strokeWidth = 0.5;
    const sp = 80.0;
    for (double x = 0; x < size.width; x += sp) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y < size.height; y += sp) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}