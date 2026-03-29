import 'package:flutter/material.dart';
import '../../main.dart';
import '../../localization/app_lang.dart';
import '../../localization/strings.dart';
import 'section_shell.dart';

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

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, .08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

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

    return SectionShell(
      title: Tr.t(l10n, "aboutTitle"),
      subtitle: Tr.t(l10n, "aboutSub"),
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: Container(
            padding: EdgeInsets.all(isMobile ? 18 : 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: JC.border),
              boxShadow: [
                BoxShadow(
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                  color: JC.dark.withOpacity(.05),
                ),
              ],
            ),
            child: Stack(
              children: [
                const Positioned.fill(child: _AboutBackgroundDecor()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Header(l10n: l10n),
                    const SizedBox(height: 18),
                    Divider(height: 1, color: JC.border),
                    const SizedBox(height: 18),
                    isMobile
                        ? Column(
                      children: [
                        _Bullet(text: Tr.t(l10n, "bullet1")),
                        _Bullet(text: Tr.t(l10n, "bullet2")),
                        _Bullet(text: Tr.t(l10n, "bullet3")),
                        const SizedBox(height: 10),
                        _MiniHighlights(isMobile: true, l10n: l10n),
                      ],
                    )
                        : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 6,
                          child: Column(
                            children: [
                              _Bullet(text: Tr.t(l10n, "bullet1")),
                              _Bullet(text: Tr.t(l10n, "bullet2")),
                              _Bullet(text: Tr.t(l10n, "bullet3")),
                            ],
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          flex: 4,
                          child: _MiniHighlights(
                            isMobile: false,
                            l10n: l10n,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final L10n l10n;
  const _Header({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              colors: [
                JC.main.withOpacity(.16),
                JC.main.withOpacity(.08),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: JC.main.withOpacity(.18)),
            boxShadow: [
              BoxShadow(
                blurRadius: 16,
                offset: const Offset(0, 6),
                color: JC.main.withOpacity(.10),
              ),
            ],
          ),
          child: const Icon(
            Icons.public_rounded,
            color: JC.mainDark,
            size: 26,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Tr.t(l10n, "aboutTitle"),
                style: const TextStyle(
                  color: JC.title,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                Tr.t(l10n, "aboutSub"),
                style: const TextStyle(
                  color: JC.muted,
                  fontWeight: FontWeight.w700,
                  height: 1.6,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Bullet extends StatefulWidget {
  final String text;
  const _Bullet({required this.text});

  @override
  State<_Bullet> createState() => _BulletState();
}

class _BulletState extends State<_Bullet> {
  bool _hover = false;

  bool _enableHover(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 900;
  }

  void _safeSetState(VoidCallback fn) {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(fn);
    });
  }

  @override
  Widget build(BuildContext context) {
    final enableHover = _enableHover(context);

    final child = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: _hover ? JC.main.withOpacity(.045) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _hover ? JC.main.withOpacity(.18) : Colors.transparent,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            margin: const EdgeInsets.only(top: 2),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: JC.main.withOpacity(_hover ? .16 : .10),
              border: Border.all(color: JC.main.withOpacity(.30)),
              boxShadow: _hover
                  ? [
                BoxShadow(
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                  color: JC.main.withOpacity(.12),
                ),
              ]
                  : null,
            ),
            child: const Icon(
              Icons.check_rounded,
              size: 17,
              color: JC.mainDark,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.text,
              style: const TextStyle(
                color: JC.title,
                fontWeight: FontWeight.w800,
                height: 1.7,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );

    if (!enableHover) return child;

    return MouseRegion(
      onEnter: (_) => _safeSetState(() => _hover = true),
      onExit: (_) => _safeSetState(() => _hover = false),
      child: child,
    );
  }
}

class _MiniHighlights extends StatelessWidget {
  final bool isMobile;
  final L10n l10n;

  const _MiniHighlights({
    required this.isMobile,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      _MiniItem(
        icon: Icons.location_on_rounded,
        title: Tr.t(l10n, "aboutFastReachTitle"),
        subtitle: Tr.t(l10n, "aboutFastReachSub"),
      ),
      _MiniItem(
        icon: Icons.verified_rounded,
        title: Tr.t(l10n, "aboutTrustedQualityTitle"),
        subtitle: Tr.t(l10n, "aboutTrustedQualitySub"),
      ),
      _MiniItem(
        icon: Icons.language_rounded,
        title: Tr.t(l10n, "aboutWiderVisionTitle"),
        subtitle: Tr.t(l10n, "aboutWiderVisionSub"),
      ),
    ];

    return Column(
      children: items
          .map(
            (e) => Padding(
          padding: EdgeInsets.only(bottom: isMobile ? 10 : 12),
          child: _InfoTile(item: e),
        ),
      )
          .toList(),
    );
  }
}

class _MiniItem {
  final IconData icon;
  final String title;
  final String subtitle;

  const _MiniItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

class _InfoTile extends StatefulWidget {
  final _MiniItem item;
  const _InfoTile({required this.item});

  @override
  State<_InfoTile> createState() => _InfoTileState();
}

class _InfoTileState extends State<_InfoTile> {
  bool _hover = false;

  bool _enableHover(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 900;
  }

  void _safeSetState(VoidCallback fn) {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(fn);
    });
  }

  @override
  Widget build(BuildContext context) {
    final enableHover = _enableHover(context);

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
            color:
            (_hover ? JC.main : JC.dark).withOpacity(_hover ? .10 : .04),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: LinearGradient(
                colors: [
                  JC.main.withOpacity(.18),
                  JC.main.withOpacity(.08),
                ],
              ),
            ),
            child: Icon(
              widget.item.icon,
              color: JC.mainDark,
              size: 21,
            ),
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
                    fontSize: 13.5,
                  ),
                ),
                const SizedBox(height: 4),
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
      onEnter: (_) => _safeSetState(() => _hover = true),
      onExit: (_) => _safeSetState(() => _hover = false),
      child: child,
    );
  }
}

class _AboutBackgroundDecor extends StatelessWidget {
  const _AboutBackgroundDecor();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            Positioned(
              top: -50,
              right: -40,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      JC.main.withOpacity(.10),
                      JC.main.withOpacity(.04),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -30,
              left: -20,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      JC.main.withOpacity(.07),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: CustomPaint(
                painter: _SoftLinesPainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SoftLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = JC.main.withOpacity(.08);

    final p2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = JC.main.withOpacity(.05);

    final rect1 = Rect.fromCenter(
      center: Offset(size.width * .88, size.height * .18),
      width: 180,
      height: 180,
    );

    final rect2 = Rect.fromCenter(
      center: Offset(size.width * .12, size.height * .84),
      width: 120,
      height: 120,
    );

    canvas.drawArc(rect1, 0.4, 4.2, false, p1);
    canvas.drawArc(rect1.inflate(18), 1.0, 2.9, false, p2);
    canvas.drawArc(rect2, -0.3, 3.4, false, p2);

    for (int i = 0; i < 4; i++) {
      final dx = size.width * .72 + (i * 18);
      final dy = size.height * .22 + (i * 10);
      canvas.drawCircle(
        Offset(dx, dy),
        2.2,
        Paint()..color = JC.main.withOpacity(.18),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}