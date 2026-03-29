import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../main.dart';
import '../../core/links.dart';
import '../../localization/app_lang.dart';
import '../../localization/strings.dart';

class HeroSection extends StatefulWidget {
  final L10n l10n;
  final bool isMobile;

  const HeroSection({super.key, required this.l10n, required this.isMobile});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late final AnimationController _globeCtrl;
  late final AnimationController _enterCtrl;
  late final AnimationController _cardCtrl;
  late final AnimationController _particleCtrl;

  late final Animation<double> _enterFade;
  late final Animation<Offset> _enterSlide;

  late final Animation<double> _cardFade;
  late final Animation<Offset> _cardSlide;

  static const double _maxWidth = 1180;

  @override
  void initState() {
    super.initState();

    _globeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();

    _enterCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _enterFade = CurvedAnimation(
      parent: _enterCtrl,
      curve: Curves.easeOutCubic,
    );

    _enterSlide = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _enterCtrl, curve: Curves.easeOutCubic));

    _cardCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _cardFade = CurvedAnimation(parent: _cardCtrl, curve: Curves.easeOutCubic);

    _cardSlide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _cardCtrl, curve: Curves.easeOutCubic));

    _particleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _enterCtrl.forward();
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _cardCtrl.forward();
    });
  }

  @override
  void dispose() {
    _globeCtrl.dispose();
    _enterCtrl.dispose();
    _cardCtrl.dispose();
    _particleCtrl.dispose();
    super.dispose();
  }

  Future<void> _open(BuildContext context, String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    if (!await canLaunchUrl(uri)) return;
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final globeSize = widget.isMobile ? screenW * 0.95 : screenW * 0.50;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: widget.isMobile ? 56 : 100,
        horizontal: 24,
      ),
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
          Positioned.fill(child: CustomPaint(painter: _GlowPainter())),

          Positioned(
            right: widget.isMobile ? -globeSize * 0.35 : -globeSize * 0.05,
            top: widget.isMobile ? -globeSize * 0.20 : -globeSize * 0.15,
            child: _HeroAnimBuilder(
              animation: _globeCtrl,
              builder: (_, __) => SizedBox(
                width: globeSize,
                height: globeSize,
                child: CustomPaint(
                  painter: _GlobePainter(
                    rotation: _globeCtrl.value * 2 * pi,
                    lineColor: JC.main.withOpacity(.06),
                    accentColor: JC.main.withOpacity(.12),
                  ),
                ),
              ),
            ),
          ),

          Positioned.fill(
            child: _HeroAnimBuilder(
              animation: _particleCtrl,
              builder: (_, __) => CustomPaint(
                painter: _ParticlePainter(
                  progress: _particleCtrl.value,
                  color: JC.main,
                  count: widget.isMobile ? 12 : 25,
                ),
              ),
            ),
          ),

          if (!widget.isMobile) ...[
            Positioned(
              right: screenW * 0.18,
              top: 90,
              child: const _PingDot(delay: 0),
            ),
            Positioned(
              right: screenW * 0.26,
              top: 200,
              child: const _PingDot(delay: 700),
            ),
            Positioned(
              right: screenW * 0.11,
              top: 260,
              child: const _PingDot(delay: 1400),
            ),
            Positioned(
              right: screenW * 0.22,
              top: 140,
              child: const _PingDot(delay: 350),
            ),
            Positioned(
              right: screenW * 0.14,
              top: 170,
              child: const _PingDot(delay: 1050),
            ),
          ],

          Center(
            child: SizedBox(
              width: _maxWidth,
              child: widget.isMobile ? _mobile(context) : _desktop(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _desktop(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: FadeTransition(
            opacity: _enterFade,
            child: SlideTransition(
              position: _enterSlide,
              child: _heroContent(context),
            ),
          ),
        ),
        const SizedBox(width: 48),
        Expanded(
          flex: 4,
          child: FadeTransition(
            opacity: _cardFade,
            child: SlideTransition(position: _cardSlide, child: _statsCard()),
          ),
        ),
      ],
    );
  }

  Widget _mobile(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FadeTransition(
          opacity: _enterFade,
          child: SlideTransition(
            position: _enterSlide,
            child: _heroContent(context),
          ),
        ),
        const SizedBox(height: 32),
        FadeTransition(
          opacity: _cardFade,
          child: SlideTransition(position: _cardSlide, child: _statsCard()),
        ),
      ],
    );
  }

  Widget _heroContent(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final titleSize = w >= 1200
        ? 56.0
        : w >= 920
        ? 48.0
        : w >= 520
        ? 40.0
        : 34.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: JC.main.withOpacity(.12),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: JC.main.withOpacity(.25)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _PulsingDot(),
              const SizedBox(width: 8),
              Text(
                Tr.t(widget.l10n, "heroBadge"),
                style: TextStyle(
                  color: JC.main.withOpacity(.95),
                  fontWeight: FontWeight.w800,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: titleSize,
              height: 1.08,
              fontWeight: FontWeight.w900,
            ),
            children: [
              TextSpan(
                text: Tr.t(widget.l10n, "heroHeadlineTop"),
                style: const TextStyle(color: Colors.white),
              ),
              TextSpan(
                text: Tr.t(widget.l10n, "heroHeadlineBottom"),
                style: const TextStyle(color: JC.main),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Text(
            Tr.t(widget.l10n, "heroDescription"),
            style: TextStyle(
              color: Colors.white.withOpacity(.65),
              fontSize: 15,
              height: 1.7,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _HeroButton(
              icon: Icons.android_rounded,
              label: Tr.t(widget.l10n, "btnAndroid"),
              filled: true,
              onTap: () => _open(context, AppLinks.androidStore),
            ),
            _HeroButton(
              icon: Icons.apple_rounded,
              label: Tr.t(widget.l10n, "btniOS"),
              filled: false,
              onTap: () => _open(context, AppLinks.iosStore),
            ),
          ],
        ),
      ],
    );
  }

  Widget _statsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.05),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(.10)),
        boxShadow: [
          BoxShadow(
            blurRadius: 48,
            offset: const Offset(0, 20),
            color: Colors.black.withOpacity(.25),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: const LinearGradient(
                colors: [JC.mainDark, JC.main],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 22,
                  offset: const Offset(0, 8),
                  color: JC.main.withOpacity(.25),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Jaycom4",
            style: TextStyle(
              color: Colors.white.withOpacity(.95),
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            Tr.t(widget.l10n, "heroStatsSubtitle"),
            style: TextStyle(
              color: Colors.white.withOpacity(.5),
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 20),
          Container(height: 1, color: Colors.white.withOpacity(.08)),
          const SizedBox(height: 20),
          Row(
            children: [
              _AnimatedStat(
                icon: Icons.flash_on_rounded,
                end: 30,
                suffix: "+",
                label: Tr.t(widget.l10n, "heroStatServices"),
              ),
              _AnimatedStat(
                icon: Icons.people_rounded,
                end: 1000,
                suffix: "+",
                label: Tr.t(widget.l10n, "heroStatUsers"),
                abbreviate: true,
              ),
              _AnimatedStat(
                icon: Icons.star_rounded,
                end: 48,
                suffix: "",
                label: Tr.t(widget.l10n, "heroStatRating"),
                divideBy: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnimatedStat extends StatefulWidget {
  final IconData icon;
  final int end;
  final String suffix;
  final String label;
  final bool abbreviate;
  final int divideBy;

  const _AnimatedStat({
    required this.icon,
    required this.end,
    required this.suffix,
    required this.label,
    this.abbreviate = false,
    this.divideBy = 1,
  });

  @override
  State<_AnimatedStat> createState() => _AnimatedStatState();
}

class _AnimatedStatState extends State<_AnimatedStat>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  String _format(double val) {
    if (widget.divideBy > 1) {
      return (val / widget.divideBy).toStringAsFixed(1);
    }
    if (widget.abbreviate && val >= 1000) {
      return "${(val / 1000).toStringAsFixed(0)}K";
    }
    return val.toInt().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _HeroAnimBuilder(
        animation: _anim,
        builder: (_, __) {
          final v = _anim.value * widget.end;
          return Column(
            children: [
              Icon(widget.icon, color: JC.main, size: 20),
              const SizedBox(height: 8),
              Text(
                "${_format(v)}${widget.suffix}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                widget.label,
                style: TextStyle(
                  color: Colors.white.withOpacity(.5),
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _GlobePainter extends CustomPainter {
  final double rotation;
  final Color lineColor;
  final Color accentColor;

  _GlobePainter({
    required this.rotation,
    required this.lineColor,
    required this.accentColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width * 0.45;

    final line = Paint()
      ..color = lineColor
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    final accent = Paint()
      ..color = accentColor
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(Offset(cx, cy), r, accent);

    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, cy), width: r * 2, height: r * 0.12),
      accent,
    );

    for (final lat in [0.25, 0.5, 0.75]) {
      final yOff = r * lat;
      final w = 2 * sqrt(r * r - yOff * yOff);
      if (w > 0) {
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(cx, cy - yOff),
            width: w,
            height: w * 0.07,
          ),
          line,
        );
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(cx, cy + yOff),
            width: w,
            height: w * 0.07,
          ),
          line,
        );
      }
    }

    for (int i = 0; i < 8; i++) {
      final angle = (i / 8) * pi + rotation;
      final xShift = sin(angle);
      final halfW = r * (1.0 - xShift.abs()) * 0.4;
      if (halfW < 5) continue;
      final xCenter = cx + xShift * r * 0.55;

      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(xCenter, cy),
          width: halfW * 0.6,
          height: r * 2,
        ),
        line,
      );
    }

    canvas.drawCircle(
      Offset(cx, cy),
      r + 10,
      Paint()
        ..color = accentColor.withOpacity(0.03)
        ..strokeWidth = 24
        ..style = PaintingStyle.stroke
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 24),
    );
  }

  @override
  bool shouldRepaint(covariant _GlobePainter oldDelegate) {
    return oldDelegate.rotation != rotation ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.accentColor != accentColor;
  }
}

class _ParticlePainter extends CustomPainter {
  final double progress;
  final Color color;
  final int count;

  _ParticlePainter({
    required this.progress,
    required this.color,
    required this.count,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rng = Random(42);

    for (int i = 0; i < count; i++) {
      final baseX = rng.nextDouble() * size.width;
      final baseY = rng.nextDouble() * size.height;
      final speed = 0.3 + rng.nextDouble() * 0.7;
      final phase = rng.nextDouble();
      final radius = 1.0 + rng.nextDouble() * 1.5;

      final t = (progress * speed + phase) % 1.0;
      final y = baseY - t * size.height * 0.2;
      final x = baseX + sin(t * 2 * pi + phase * 6) * 15;

      final opacity = sin(t * pi) * 0.4;
      if (opacity <= 0) continue;

      canvas.drawCircle(
        Offset(x % size.width, y % size.height),
        radius,
        Paint()..color = color.withOpacity(opacity.clamp(0.0, 0.35)),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.count != count;
  }
}

class _PingDot extends StatefulWidget {
  final int delay;

  const _PingDot({this.delay = 0});

  @override
  State<_PingDot> createState() => _PingDotState();
}

class _PingDotState extends State<_PingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _ctrl.repeat();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      height: 28,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _HeroAnimBuilder(
            animation: _ctrl,
            builder: (_, __) {
              final scale = 0.5 + _ctrl.value * 2.0;
              final opacity = (1.0 - _ctrl.value).clamp(0.0, 0.6);

              return Transform.scale(
                scale: scale,
                child: Opacity(
                  opacity: opacity,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: JC.main, width: 1.5),
                    ),
                  ),
                ),
              );
            },
          ),
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: JC.main,
              boxShadow: [
                BoxShadow(blurRadius: 8, color: JC.main.withOpacity(.6)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  const _PulsingDot();

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _HeroAnimBuilder(
      animation: _ctrl,
      builder: (_, __) {
        final scale = 0.8 + _ctrl.value * 0.4;
        return Transform.scale(
          scale: scale,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: JC.main,
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  color: JC.main.withOpacity(.4 + _ctrl.value * .3),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HeroButton extends StatefulWidget {
  final String label;
  final bool filled;
  final VoidCallback onTap;
  final IconData icon;

  const _HeroButton({
    required this.label,
    required this.filled,
    required this.onTap,
    required this.icon,
  });

  @override
  State<_HeroButton> createState() => _HeroButtonState();
}

class _HeroButtonState extends State<_HeroButton> {
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

    final bg = widget.filled ? JC.main : Colors.white.withOpacity(.08);
    final border = widget.filled
        ? Colors.transparent
        : Colors.white.withOpacity(.16);

    final child = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      transform: Matrix4.identity()..translate(0.0, _hover ? -2.0 : 0.0),
      child: ElevatedButton.icon(
        onPressed: widget.onTap,
        icon: Icon(widget.icon, size: 18),
        label: Text(
          widget.label,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: _hover && widget.filled ? JC.mainSoft : bg,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: border),
          ),
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

class _GlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawRect(
      rect,
      Paint()
        ..shader = RadialGradient(
          center: const Alignment(0.5, -0.2),
          radius: 0.8,
          colors: [JC.main.withOpacity(.07), Colors.transparent],
        ).createShader(rect),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HeroAnimBuilder extends AnimatedWidget {
  final Widget Function(BuildContext, Widget?) builder;

  const _HeroAnimBuilder({
    super.key,
    required Animation<double> animation,
    required this.builder,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) => builder(context, null);
}