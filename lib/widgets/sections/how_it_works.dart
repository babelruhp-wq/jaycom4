import 'package:flutter/material.dart';
import '../../main.dart';
import '../../localization/app_lang.dart';
import '../../localization/strings.dart';
import 'section_shell.dart';

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
    final items = <_HowItem>[
      _HowItem(
        Icons.download_rounded,
        Tr.t(widget.l10n, "step1t"),
        Tr.t(widget.l10n, "step1s"),
        "01",
      ),
      _HowItem(
        Icons.category_rounded,
        Tr.t(widget.l10n, "step2t"),
        Tr.t(widget.l10n, "step2s"),
        "02",
      ),
      _HowItem(
        Icons.support_agent_rounded,
        Tr.t(widget.l10n, "step3t"),
        Tr.t(widget.l10n, "step3s"),
        "03",
      ),
    ];

    return SectionShell(
      title: Tr.t(widget.l10n, "howTitle"),
      subtitle: Tr.t(widget.l10n, "howSub"),
      child: Container(
        padding: EdgeInsets.all(widget.isMobile ? 16 : 20),
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
              const Positioned.fill(child: _HowDecorBackground()),
              widget.isMobile ? _mobileLayout(items) : _desktopLayout(items),
            ],
          ),
        ),
      ),
    );
  }

  Widget _desktopLayout(List<_HowItem> items) {
    return SizedBox(
      height: 285,
      child: Stack(
        children: [
          Positioned(
            top: 64,
            left: 64,
            right: 64,
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
                    left: i == 0 ? 0 : 8,
                    right: i == items.length - 1 ? 0 : 8,
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
          padding: const EdgeInsets.only(bottom: 14),
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

class _HowItem {
  final IconData icon;
  final String title;
  final String text;
  final String number;

  const _HowItem(this.icon, this.title, this.text, this.number);
}

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
      ..color = color.withOpacity(.08)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final active = Paint()
      ..shader = LinearGradient(
        colors: [
          color.withOpacity(.20),
          color.withOpacity(.45),
          color.withOpacity(.18),
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
        Paint()..color = color.withOpacity(.12),
      );
    }

    if (progress > 0.03) {
      final head = Offset(lineW, size.height / 2);

      canvas.drawCircle(
        head,
        8,
        Paint()
          ..color = color.withOpacity(.14)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
      );

      canvas.drawCircle(head, 4.2, Paint()..color = color.withOpacity(.55));
    }
  }

  @override
  bool shouldRepaint(covariant _LinePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}

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

    final child = AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      transform: Matrix4.identity()..translate(0.0, _hover ? -4.0 : 0.0),
      height: widget.isMobile ? null : 245,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.95),
        borderRadius: r,
        border: Border.all(
          color: _hover ? JC.main.withOpacity(.22) : JC.border,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: _hover ? 34 : 24,
            offset: const Offset(0, 12),
            color: (_hover ? JC.main : JC.dark).withOpacity(_hover ? .09 : .05),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -8,
            right: -6,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 220),
              opacity: _hover ? 1 : .8,
              child: Text(
                widget.item.number,
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  color: JC.main.withOpacity(.10),
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
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(
                    colors: [
                      JC.main.withOpacity(.18),
                      JC.main.withOpacity(.08),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: JC.main.withOpacity(.16)),
                  boxShadow: _hover
                      ? [
                    BoxShadow(
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                      color: JC.main.withOpacity(.10),
                    ),
                  ]
                      : null,
                ),
                child: Icon(widget.item.icon, color: JC.mainDark, size: 25),
              ),
              const SizedBox(height: 18),
              Text(
                widget.item.title,
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
                widget.item.text,
                style: const TextStyle(
                  color: JC.muted,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  height: 1.75,
                ),
              ),
              const SizedBox(height: 18),
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _hover
                      ? JC.main.withOpacity(.10)
                      : const Color(0xFFF7FCF9),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: _hover ? JC.main.withOpacity(.18) : JC.border,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: JC.mainDark,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      widget.item.number,
                      style: const TextStyle(
                        color: JC.title,
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

    if (!enableHover) return child;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _safeSetState(() => _hover = true),
      onExit: (_) => _safeSetState(() => _hover = false),
      child: child,
    );
  }
}

class _HowDecorBackground extends StatelessWidget {
  const _HowDecorBackground();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -34,
            right: -20,
            child: Container(
              width: 160,
              height: 160,
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
            bottom: -28,
            left: -18,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [JC.main.withOpacity(.06), Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned.fill(child: CustomPaint(painter: _HowDecorPainter())),
        ],
      ),
    );
  }
}

class _HowDecorPainter extends CustomPainter {
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
    canvas.drawArc(rect1.inflate(16), 1.0, 2.6, false, p2);
    canvas.drawArc(rect2, -.25, 3.3, false, p2);

    for (int i = 0; i < 4; i++) {
      final dx = size.width * .72 + (i * 16);
      final dy = size.height * .20 + (i * 10);
      canvas.drawCircle(
        Offset(dx, dy),
        2.0,
        Paint()..color = JC.main.withOpacity(.15),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}