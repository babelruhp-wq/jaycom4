import 'package:flutter/material.dart';
import '../../main.dart';
import '../../localization/app_lang.dart';
import '../../localization/strings.dart';
import 'section_shell.dart';

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
    final cards = [
      _SvcData(
        icon: Icons.flash_on_rounded,
        title: Tr.t(widget.l10n, "s1t"),
        text: Tr.t(widget.l10n, "s1s"),
        accent: JC.main,
        soft: JC.main.withOpacity(.10),
        tag: Tr.t(widget.l10n, "servicesTagFast"),
      ),
      _SvcData(
        icon: Icons.verified_rounded,
        title: Tr.t(widget.l10n, "s2t"),
        text: Tr.t(widget.l10n, "s2s"),
        accent: const Color(0xFF1F9D6E),
        soft: const Color(0xFFEAFBF4),
        tag: Tr.t(widget.l10n, "servicesTagTrusted"),
      ),
      _SvcData(
        icon: Icons.support_agent_rounded,
        title: Tr.t(widget.l10n, "s3t"),
        text: Tr.t(widget.l10n, "s3s"),
        accent: const Color(0xFF2FAE82),
        soft: const Color(0xFFF1FCF7),
        tag: Tr.t(widget.l10n, "servicesTagSupport"),
      ),
    ];

    return SectionShell(
      title: Tr.t(widget.l10n, "servicesTitle"),
      subtitle: Tr.t(widget.l10n, "servicesSub"),
      child: Container(
        padding: EdgeInsets.all(widget.isMobile ? 14 : 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: JC.border),
          boxShadow: [
            BoxShadow(
              blurRadius: 30,
              offset: const Offset(0, 12),
              color: JC.dark.withOpacity(.05),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: Stack(
            children: [
              const Positioned.fill(child: _ServicesDecorBackground()),
              GridView.count(
                crossAxisCount: widget.isMobile ? 1 : 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: widget.isMobile ? 1.18 : 0.95,
                children: List.generate(cards.length, (i) {
                  final start = i * 0.16;
                  final end = (start + 0.62).clamp(0.0, 1.0);

                  final anim = CurvedAnimation(
                    parent: _ctrl,
                    curve: Interval(start, end, curve: Curves.easeOutCubic),
                  );

                  return FadeTransition(
                    opacity: anim,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.14),
                        end: Offset.zero,
                      ).animate(anim),
                      child: _ServiceCard(
                        l10n: widget.l10n,
                        data: cards[i],
                        isMobile: widget.isMobile,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SvcData {
  final IconData icon;
  final String title;
  final String text;
  final Color accent;
  final Color soft;
  final String tag;

  const _SvcData({
    required this.icon,
    required this.title,
    required this.text,
    required this.accent,
    required this.soft,
    required this.tag,
  });
}

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

class _ServiceCardState extends State<_ServiceCard>
    with SingleTickerProviderStateMixin {
  bool _hover = false;
  bool _down = false;
  late final AnimationController _iconCtrl;

  @override
  void initState() {
    super.initState();
    _iconCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
  }

  @override
  void dispose() {
    _iconCtrl.dispose();
    super.dispose();
  }

  bool _enableHover(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 900 && !widget.isMobile;
  }

  void _safeSetState(VoidCallback fn) {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(fn);
    });
  }

  void _setHover(bool value) {
    if (!mounted) return;
    if (value == _hover) return;

    _safeSetState(() => _hover = value);

    if (value) {
      _iconCtrl.forward(from: 0);
    }
  }

  void _setDown(bool value) {
    if (!mounted) return;
    if (value == _down) return;
    _safeSetState(() => _down = value);
  }

  @override
  Widget build(BuildContext context) {
    final enableHover = _enableHover(context);
    final r = BorderRadius.circular(24);
    final lift = _down ? 0.0 : (_hover ? -5.0 : 0.0);
    final borderColor =
    _hover ? widget.data.accent.withOpacity(.22) : JC.border;

    final child = GestureDetector(
      onTapDown: (_) => _setDown(true),
      onTapUp: (_) => _setDown(false),
      onTapCancel: () => _setDown(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()..translate(0.0, lift),
        decoration: BoxDecoration(
          borderRadius: r,
          border: Border.all(color: borderColor),
          gradient: LinearGradient(
            colors: [
              Colors.white,
              widget.data.soft.withOpacity(.95),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: _hover ? 40 : 26,
              offset: const Offset(0, 12),
              color: (_hover ? widget.data.accent : JC.dark)
                  .withOpacity(_hover ? .10 : .05),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Stack(
            children: [
              Positioned(
                top: -2,
                right: 0,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 220),
                  opacity: _hover ? .14 : .09,
                  child: Text(
                    widget.data.tag.toUpperCase(),
                    style: TextStyle(
                      color: widget.data.accent,
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      height: 1,
                      letterSpacing: .6,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _AnimatedIconBadge(
                    icon: widget.data.icon,
                    accent: widget.data.accent,
                    soft: widget.data.soft,
                    controller: _iconCtrl,
                    hover: _hover,
                  ),
                  const SizedBox(height: 16),
                  _ServiceTag(
                    label: widget.data.tag,
                    accent: widget.data.accent,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    widget.data.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: JC.title,
                      fontWeight: FontWeight.w900,
                      fontSize: 17,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.data.text,
                    maxLines: widget.isMobile ? 5 : 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: JC.muted,
                      fontWeight: FontWeight.w700,
                      height: 1.72,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: widget.data.accent.withOpacity(.16),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: widget.data.accent.withOpacity(.30),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          Tr.t(widget.l10n, "svcHint"),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: JC.title.withOpacity(.68),
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
                              ? widget.data.accent.withOpacity(.10)
                              : Colors.white.withOpacity(.65),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: _hover
                                ? widget.data.accent.withOpacity(.20)
                                : JC.border,
                          ),
                        ),
                        child: Icon(
                          Directionality.of(context) == TextDirection.rtl
                              ? Icons.arrow_back_rounded
                              : Icons.arrow_forward_rounded,
                          size: 16,
                          color: widget.data.accent,
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
    );

    if (!enableHover) return child;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _setHover(true),
      onExit: (_) {
        _setHover(false);
        _setDown(false);
      },
      child: child,
    );
  }
}

class _ServiceTag extends StatelessWidget {
  final String label;
  final Color accent;

  const _ServiceTag({
    required this.label,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: accent.withOpacity(.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: accent.withOpacity(.14)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: accent,
          fontWeight: FontWeight.w900,
          fontSize: 12.2,
          letterSpacing: .2,
        ),
      ),
    );
  }
}

class _AnimatedIconBadge extends StatelessWidget {
  final IconData icon;
  final Color accent;
  final Color soft;
  final AnimationController controller;
  final bool hover;

  const _AnimatedIconBadge({
    required this.icon,
    required this.accent,
    required this.soft,
    required this.controller,
    required this.hover,
  });

  @override
  Widget build(BuildContext context) {
    return _SvcAnimBuilder(
      animation: controller,
      builder: (_, __) {
        final t = controller.value;
        final bounce =
            1.0 + (0.16 * (1.0 - (t * 2 - 1).abs()).clamp(0.0, 1.0));
        final rotation = (1 - (t * 2 - 1).abs()) * .05;
        final glowRadius = hover ? 18.0 : 10.0;

        return Transform.rotate(
          angle: controller.isAnimating ? rotation : 0,
          child: Transform.scale(
            scale: controller.isAnimating ? bounce : 1.0,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                  colors: [
                    soft.withOpacity(.96),
                    Colors.white,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: accent.withOpacity(.18)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: glowRadius,
                    offset: const Offset(0, 6),
                    color: accent.withOpacity(hover ? .18 : .08),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: accent,
                size: 27,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SvcAnimBuilder extends AnimatedWidget {
  final Widget Function(BuildContext, Widget?) builder;

  const _SvcAnimBuilder({
    super.key,
    required Animation<double> animation,
    required this.builder,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) => builder(context, null);
}

class _ServicesDecorBackground extends StatelessWidget {
  const _ServicesDecorBackground();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -36,
            right: -20,
            child: Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    JC.main.withOpacity(.08),
                    JC.main.withOpacity(.03),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -24,
            left: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    JC.main.withOpacity(.06),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: _ServicesDecorPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServicesDecorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = JC.main.withOpacity(.06);

    final p2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = JC.main.withOpacity(.04);

    final rect1 = Rect.fromCenter(
      center: Offset(size.width * .88, size.height * .18),
      width: 170,
      height: 170,
    );

    final rect2 = Rect.fromCenter(
      center: Offset(size.width * .12, size.height * .84),
      width: 110,
      height: 110,
    );

    canvas.drawArc(rect1, .35, 4.0, false, p1);
    canvas.drawArc(rect1.inflate(16), 1.0, 2.5, false, p2);
    canvas.drawArc(rect2, -.25, 3.2, false, p2);

    for (int i = 0; i < 5; i++) {
      final dx = size.width * .72 + (i * 16);
      final dy = size.height * .20 + (i * 9);
      canvas.drawCircle(
        Offset(dx, dy),
        2.0,
        Paint()..color = JC.main.withOpacity(.14),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}