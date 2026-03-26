import 'package:flutter/material.dart';
import '../../main.dart';
import '../../localization/app_lang.dart';
import '../../localization/strings.dart';

class Footer extends StatefulWidget {
  final L10n l10n;

  const Footer({super.key, required this.l10n});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF081610), Color(0xFF0B1F18), Color(0xFF0A1712)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _FooterBackgroundPainter(_controller.value),
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          JC.main.withOpacity(.25),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 26),
                    child: Center(
                      child: SizedBox(
                        width: 1180,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: LayoutBuilder(
                            builder: (context, c) {
                              final isMobile = c.maxWidth < 760;

                              final left = Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const _FooterLogo(),
                                  const SizedBox(width: 12),
                                  Text(
                                    "© $year Jaycom4",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(.78),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                      letterSpacing: .2,
                                    ),
                                  ),
                                ],
                              );

                              final right = _FooterHint(
                                text: Tr.t(widget.l10n, "footer"),
                              );

                              if (isMobile) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    left,
                                    const SizedBox(height: 12),
                                    right,
                                  ],
                                );
                              }

                              return Row(
                                children: [left, const Spacer(), right],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FooterLogo extends StatefulWidget {
  const _FooterLogo();

  @override
  State<_FooterLogo> createState() => _FooterLogoState();
}

class _FooterLogoState extends State<_FooterLogo> {
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
      width: 44,
      height: 44,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: const LinearGradient(
          colors: [JC.mainDark, JC.main],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withOpacity(.08)),
        boxShadow: [
          BoxShadow(
            blurRadius: _hover ? 24 : 18,
            offset: const Offset(0, 8),
            color: JC.main.withOpacity(_hover ? .30 : .22),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
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

class _FooterHint extends StatefulWidget {
  final String text;

  const _FooterHint({required this.text});

  @override
  State<_FooterHint> createState() => _FooterHintState();
}

class _FooterHintState extends State<_FooterHint> {
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _hover
            ? Colors.white.withOpacity(.06)
            : Colors.white.withOpacity(.03),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: _hover
              ? JC.main.withOpacity(.20)
              : Colors.white.withOpacity(.06),
        ),
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          color: Colors.white.withOpacity(.68),
          fontWeight: FontWeight.w800,
          fontSize: 13,
          height: 1.35,
        ),
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

class _FooterBackgroundPainter extends CustomPainter {
  final double progress;

  _FooterBackgroundPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final glowLeft = Paint()
      ..shader =
          RadialGradient(
            colors: [
              JC.main.withOpacity(.08),
              JC.main.withOpacity(.03),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * .15, size.height * .15),
              radius: 180,
            ),
          );

    final glowRight = Paint()
      ..shader =
          RadialGradient(
            colors: [JC.main.withOpacity(.07), Colors.transparent],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * .88, size.height * .72),
              radius: 220,
            ),
          );

    canvas.drawRect(rect, glowLeft);
    canvas.drawRect(rect, glowRight);

    final orbit1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = JC.main.withOpacity(.08);

    final orbit2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.white.withOpacity(.05);

    final rect1 = Rect.fromCenter(
      center: Offset(size.width * .88, size.height * .18),
      width: 180,
      height: 180,
    );

    final rect2 = Rect.fromCenter(
      center: Offset(size.width * .12, size.height * .82),
      width: 120,
      height: 120,
    );

    canvas.drawArc(rect1, .35, 4.0, false, orbit1);
    canvas.drawArc(rect1.inflate(18), 1.0, 2.7, false, orbit2);
    canvas.drawArc(rect2, -.2, 3.4, false, orbit2);

    for (int i = 0; i < 5; i++) {
      final dx = size.width * .72 + (i * 16);
      final dy = size.height * .24 + (i * 8);
      canvas.drawCircle(
        Offset(dx, dy),
        2.0,
        Paint()..color = JC.main.withOpacity(.14),
      );
    }

    final shimmerWidth = size.width * .22;
    final x = -shimmerWidth + (size.width + shimmerWidth * 2) * progress;

    final shimmer = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.transparent,
          JC.main.withOpacity(.015),
          JC.main.withOpacity(.04),
          JC.main.withOpacity(.015),
          Colors.transparent,
        ],
        stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
      ).createShader(Rect.fromLTWH(x, 0, shimmerWidth, size.height));

    canvas.drawRect(Rect.fromLTWH(x, 0, shimmerWidth, size.height), shimmer);
  }

  @override
  bool shouldRepaint(covariant _FooterBackgroundPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
