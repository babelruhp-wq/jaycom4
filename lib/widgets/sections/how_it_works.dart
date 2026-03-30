import 'package:flutter/material.dart';
import '../../main.dart';
import '../../localization/app_lang.dart';
import '../../localization/strings.dart';

class HowItWorks extends StatefulWidget {
  final L10n l10n;
  final bool isMobile;

  const HowItWorks({super.key, required this.l10n, required this.isMobile});

  @override
  State<HowItWorks> createState() => _HowItWorksState();
}

class _HowItWorksState extends State<HowItWorks>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
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

    final items = <_HowItem>[
      _HowItem(
        Icons.download_rounded,
        Tr.t(l10n, "step1t"),
        Tr.t(l10n, "step1s"),
        "01",
      ),
      _HowItem(
        Icons.category_rounded,
        Tr.t(l10n, "step2t"),
        Tr.t(l10n, "step2s"),
        "02",
      ),
      _HowItem(
        Icons.support_agent_rounded,
        Tr.t(l10n, "step3t"),
        Tr.t(l10n, "step3s"),
        "03",
      ),
    ];

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [JC.dark, JC.dark2, Color(0xFF0D3326)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.6, 1.0],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: _GridPainter()),
          ),
          Positioned(
            top: -60,
            right: isMobile ? -40 : 80,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    JC.main.withOpacity(.10),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            left: isMobile ? -30 : 60,
            child: Container(
              width: 160,
              height: 160,
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
          Center(
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
                    _SectionHeader(l10n: l10n, isMobile: isMobile),
                    SizedBox(height: isMobile ? 30 : 40),
                    if (!isMobile) _desktopLayout(items),
                    if (isMobile) _mobileLayout(items),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _desktopLayout(List<_HowItem> items) {
    return SizedBox(
      height: 310,
      child: Stack(
        children: [
          Positioned(
            top: 72,
            left: 80,
            right: 80,
            child: _ConnectingLine(ctrl: _ctrl),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(items.length, (i) {
              final start = i * 0.18;
              final end = (start + 0.62).clamp(0.0, 1.0);

              final anim = CurvedAnimation(
                parent: _ctrl,
                curve: Interval(start, end, curve: Curves.easeOutCubic),
              );

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: i == 0 ? 0 : 10,
                    right: i == items.length - 1 ? 0 : 10,
                  ),
                  child: FadeTransition(
                    opacity: anim,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, .16),
                        end: Offset.zero,
                      ).animate(anim),
                      child: _HowCard(item: items[i], isMobile: false),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _mobileLayout(List<_HowItem> items) {
    return Column(
      children: List.generate(items.length, (i) {
        final start = i * 0.18;
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
                begin: const Offset(.08, 0),
                end: Offset.zero,
              ).animate(anim),
              child: _HowCard(item: items[i], isMobile: true),
            ),
          ),
        );
      }),
    );
  }
}

/* ─── Section Header ─── */
class _SectionHeader extends StatelessWidget {
  final L10n l10n;
  final bool isMobile;

  const _SectionHeader({required this.l10n, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: JC.main.withOpacity(.12),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: JC.main.withOpacity(.22)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.route_rounded,
                  size: 14, color: JC.main.withOpacity(.9)),
              const SizedBox(width: 8),
              Text(
                Tr.t(l10n, "howTitle"),
                style: TextStyle(
                  color: JC.main.withOpacity(.95),
                  fontWeight: FontWeight.w900,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          Tr.t(l10n, "howTitle"),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: isMobile ? 26 : 32,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Text(
            Tr.t(l10n, "howSub"),
            style: TextStyle(
              color: Colors.white.withOpacity(.55),
              fontWeight: FontWeight.w600,
              fontSize: isMobile ? 14 : 15,
              height: 1.7,
            ),
          ),
        ),
      ],
    );
  }
}

/* ─── Data ─── */
class _HowItem {
  final IconData icon;
  final String title;
  final String text;
  final String number;

  const _HowItem(this.icon, this.title, this.text, this.number);
}

/* ─── Connecting Line ─── */
class _ConnectingLine extends AnimatedWidget {
  final AnimationController ctrl;

  const _ConnectingLine({required this.ctrl}) : super(listenable: ctrl);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 10),
      painter: _LinePainter(progress: ctrl.value, color: JC.main),
    );
  }
}

class _LinePainter extends CustomPainter {
  final double progress;
  final Color color;

  _LinePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final base = Paint()
      ..color = Colors.white.withOpacity(.06)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final active = Paint()
      ..shader = LinearGradient(
        colors: [
          color.withOpacity(.30),
          color.withOpacity(.60),
          color.withOpacity(.25),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      base,
    );

    final lineW = size.width * progress;

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(lineW, size.height / 2),
      active,
    );

    const dotSpacing = 34.0;
    for (double x = 0; x < lineW; x += dotSpacing) {
      canvas.drawCircle(
        Offset(x, size.height / 2),
        2,
        Paint()..color = color.withOpacity(.18),
      );
    }

    if (progress > 0.03) {
      final head = Offset(lineW, size.height / 2);

      canvas.drawCircle(
        head,
        8,
        Paint()
          ..color = color.withOpacity(.20)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
      );

      canvas.drawCircle(head, 4.2, Paint()..color = color.withOpacity(.65));
    }
  }

  @override
  bool shouldRepaint(covariant _LinePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}

/* ─── Card ─── */
class _HowCard extends StatefulWidget {
  final _HowItem item;
  final bool isMobile;

  const _HowCard({required this.item, required this.isMobile});

  @override
  State<_HowCard> createState() => _HowCardState();
}

class _HowCardState extends State<_HowCard> {
  bool _hover = false;

  bool _enableHover(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 900 && !widget.isMobile;
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
    final r = BorderRadius.circular(24);

    final child = widget.isMobile ? _mobileCard(r) : _desktopCard(r);

    if (!enableHover) return child;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _safeSetState(() => _hover = true),
      onExit: (_) => _safeSetState(() => _hover = false),
      child: child,
    );
  }

  Widget _mobileCard(BorderRadius r) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: r,
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(.08),
            Colors.white.withOpacity(.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withOpacity(.08)),
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            offset: const Offset(0, 14),
            color: Colors.black.withOpacity(.18),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon + number
          Column(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      JC.main.withOpacity(.20),
                      JC.main.withOpacity(.08),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: JC.main.withOpacity(.22)),
                ),
                child: Icon(widget.item.icon, color: JC.main, size: 24),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.06),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: Colors.white.withOpacity(.10)),
                ),
                child: Text(
                  widget.item.number,
                  style: TextStyle(
                    color: JC.main.withOpacity(.8),
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 18),
          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 17,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.item.text,
                  style: TextStyle(
                    color: Colors.white.withOpacity(.50),
                    fontWeight: FontWeight.w600,
                    fontSize: 13.5,
                    height: 1.65,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _desktopCard(BorderRadius r) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      transform: Matrix4.identity()..translate(0.0, _hover ? -5.0 : 0.0),
      height: 280,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: r,
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(_hover ? .12 : .08),
            Colors.white.withOpacity(_hover ? .06 : .03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: _hover
              ? JC.main.withOpacity(.30)
              : Colors.white.withOpacity(.08),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: _hover ? 40 : 24,
            offset: const Offset(0, 14),
            color: Colors.black.withOpacity(_hover ? .25 : .18),
          ),
          if (_hover)
            BoxShadow(
              blurRadius: 30,
              offset: const Offset(0, 8),
              color: JC.main.withOpacity(.08),
            ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -10,
            right: -4,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 220),
              opacity: _hover ? .15 : .08,
              child: Text(
                widget.item.number,
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  color: JC.main,
                  height: 1,
                ),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(
                    colors: [
                      JC.main.withOpacity(_hover ? .28 : .20),
                      JC.main.withOpacity(_hover ? .14 : .08),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                    color: JC.main.withOpacity(_hover ? .35 : .22),
                  ),
                  boxShadow: _hover
                      ? [
                    BoxShadow(
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                      color: JC.main.withOpacity(.15),
                    ),
                  ]
                      : null,
                ),
                child: Icon(widget.item.icon, color: JC.main, size: 26),
              ),
              const SizedBox(height: 20),
              Text(
                widget.item.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.item.text,
                style: TextStyle(
                  color: Colors.white.withOpacity(.50),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.75,
                ),
              ),
              const Spacer(),
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _hover
                      ? JC.main.withOpacity(.14)
                      : Colors.white.withOpacity(.06),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: _hover
                        ? JC.main.withOpacity(.28)
                        : Colors.white.withOpacity(.10),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: _hover ? JC.main : Colors.white.withOpacity(.5),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      widget.item.number,
                      style: TextStyle(
                        color:
                        _hover ? JC.main : Colors.white.withOpacity(.6),
                        fontWeight: FontWeight.w900,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* ─── Grid Background ─── */
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = JC.main.withOpacity(.04)
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