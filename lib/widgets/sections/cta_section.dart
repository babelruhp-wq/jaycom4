import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../main.dart';
import '../../core/links.dart';
import '../../localization/app_lang.dart';
import '../../localization/strings.dart';

class CtaSection extends StatefulWidget {
  final L10n l10n;
  final bool isMobile;

  const CtaSection({super.key, required this.l10n, required this.isMobile});

  @override
  State<CtaSection> createState() => _CtaSectionState();
}

class _CtaSectionState extends State<CtaSection>
    with TickerProviderStateMixin {
  late final AnimationController _shimmer;
  late final AnimationController _float;

  static const _maxW = 1180.0;

  @override
  void initState() {
    super.initState();

    _shimmer = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _float = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _shimmer.dispose();
    _float.dispose();
    super.dispose();
  }

  Future<void> _open(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.isMobile ? 16 : 22),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _maxW),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AnimatedBuilder(
              animation: Listenable.merge([_shimmer, _float]),
              builder: (_, __) {
                return Container(
                  padding: EdgeInsets.all(widget.isMobile ? 20 : 28),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        const Color(0xFFF7FFFB),
                        JC.main.withOpacity(.10),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(color: JC.border),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 36,
                        offset: const Offset(0, 14),
                        color: JC.dark.withOpacity(.06),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: CustomPaint(
                            painter: _CtaBackgroundPainter(
                              shimmerProgress: _shimmer.value,
                              floatProgress: _float.value,
                            ),
                          ),
                        ),
                        widget.isMobile ? _mobileLayout() : _desktopLayout(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _desktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 6, child: _textBlock()),
        const SizedBox(width: 24),
        Expanded(
          flex: 4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _miniPreviewCard(),
              const SizedBox(width: 16),
              Flexible(child: _actionsBlock()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _mobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textBlock(),
        const SizedBox(height: 18),
        _miniPreviewCard(mobile: true),
        const SizedBox(height: 16),
        _actionsBlock(fullWidth: true),
      ],
    );
  }

  Widget _textBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: JC.main.withOpacity(.10),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: JC.main.withOpacity(.18)),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                offset: const Offset(0, 4),
                color: JC.main.withOpacity(.06),
              ),
            ],
          ),
          child: Text(
            Tr.t(widget.l10n, "downloadApps"),
            style: TextStyle(
              color: JC.title.withOpacity(.88),
              fontWeight: FontWeight.w900,
              fontSize: 12.5,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          Tr.t(widget.l10n, "ctaTitle"),
          style: const TextStyle(
            color: JC.title,
            fontSize: 22,
            fontWeight: FontWeight.w900,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          Tr.t(widget.l10n, "ctaSub"),
          style: const TextStyle(
            color: JC.muted,
            fontWeight: FontWeight.w700,
            height: 1.65,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _TinyBadge(
              icon: Icons.flash_on_rounded,
              text: Tr.t(widget.l10n, "ctaFastAccess"),
            ),
            _TinyBadge(
              icon: Icons.verified_rounded,
              text: Tr.t(widget.l10n, "ctaTrustedServices"),
            ),
            _TinyBadge(
              icon: Icons.public_rounded,
              text: Tr.t(widget.l10n, "ctaBuiltToScale"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _miniPreviewCard({bool mobile = false}) {
    return Transform.translate(
      offset: Offset(0, sin(_float.value * pi * 2) * 5),
      child: Container(
        width: mobile ? double.infinity : 180,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.78),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: JC.main.withOpacity(.14)),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              offset: const Offset(0, 10),
              color: JC.main.withOpacity(.08),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 54,
              height: 54,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  colors: [JC.mainDark, JC.main],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                    color: JC.main.withOpacity(.20),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Jaycom4",
              style: TextStyle(
                color: JC.title,
                fontWeight: FontWeight.w900,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              Tr.t(widget.l10n, "ctaAvailableNow"),
              style: const TextStyle(
                color: JC.muted,
                fontWeight: FontWeight.w700,
                fontSize: 12.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionsBlock({bool fullWidth = false}) {
    final btnMinW = fullWidth ? double.infinity : 0.0;

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: btnMinW),
          child: _CtaButton(
            filled: true,
            icon: Icons.android_rounded,
            label: Tr.t(widget.l10n, "btnAndroid"),
            onTap: () => _open(AppLinks.androidStore),
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: btnMinW),
          child: _CtaButton(
            filled: false,
            icon: Icons.apple_rounded,
            label: Tr.t(widget.l10n, "btniOS"),
            onTap: () => _open(AppLinks.iosStore),
          ),
        ),
      ],
    );
  }
}

class _CtaButton extends StatefulWidget {
  final bool filled;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _CtaButton({
    required this.filled,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<_CtaButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final bg = widget.filled ? JC.main : Colors.white.withOpacity(.72);
    final fg = widget.filled ? Colors.white : JC.title;
    final borderColor =
    widget.filled ? Colors.transparent : JC.main.withOpacity(.18);

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.identity()..translate(0.0, _hover ? -2.0 : 0.0),
        child: ElevatedButton(
          onPressed: widget.onTap,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor:
            widget.filled ? (_hover ? JC.mainSoft : bg) : bg,
            foregroundColor: fg,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(color: borderColor),
            ),
            shadowColor: JC.main.withOpacity(.18),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 18),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TinyBadge extends StatelessWidget {
  final IconData icon;
  final String text;

  const _TinyBadge({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.72),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: JC.main.withOpacity(.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: JC.mainDark),
          const SizedBox(width: 7),
          Text(
            text,
            style: const TextStyle(
              color: JC.title,
              fontWeight: FontWeight.w800,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _CtaBackgroundPainter extends CustomPainter {
  final double shimmerProgress;
  final double floatProgress;

  _CtaBackgroundPainter({
    required this.shimmerProgress,
    required this.floatProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final glow1 = Paint()
      ..shader = RadialGradient(
        colors: [
          JC.main.withOpacity(.10),
          JC.main.withOpacity(.03),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(size.width * .18, size.height * .18),
          radius: 180,
        ),
      );

    final glow2 = Paint()
      ..shader = RadialGradient(
        colors: [
          JC.main.withOpacity(.07),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(size.width * .86, size.height * .72),
          radius: 220,
        ),
      );

    canvas.drawRect(rect, glow1);
    canvas.drawRect(rect, glow2);

    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = JC.main.withOpacity(.06);

    final orbitPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = JC.main.withOpacity(.08);

    final r1 = Rect.fromCenter(
      center: Offset(size.width * .84, size.height * .30),
      width: 180,
      height: 180,
    );

    final r2 = Rect.fromCenter(
      center: Offset(size.width * .14, size.height * .80),
      width: 130,
      height: 130,
    );

    canvas.drawArc(r1, .4, 4.2, false, linePaint);
    canvas.drawArc(r1.inflate(18), 1.1, 2.6, false, orbitPaint);
    canvas.drawArc(r2, -.3, 3.3, false, orbitPaint);

    for (int i = 0; i < 5; i++) {
      final dx = size.width * .72 + (i * 16);
      final dy = size.height * .20 + (i * 8);
      canvas.drawCircle(
        Offset(dx, dy),
        2.1,
        Paint()..color = JC.main.withOpacity(.16),
      );
    }

    final sweepW = size.width * 0.34;
    final x = -sweepW + (size.width + sweepW * 2) * shimmerProgress;

    final shimmerPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.transparent,
          JC.main.withOpacity(.025),
          JC.main.withOpacity(.055),
          JC.main.withOpacity(.025),
          Colors.transparent,
        ],
        stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
      ).createShader(Rect.fromLTWH(x, 0, sweepW, size.height));

    canvas.drawRect(Rect.fromLTWH(x, 0, sweepW, size.height), shimmerPaint);

    final pulse = (sin(floatProgress * pi * 2) + 1) / 2;
    final pulsePaint = Paint()
      ..color = JC.main.withOpacity(.10 + (pulse * .05));

    canvas.drawCircle(
      Offset(size.width * .90, size.height * .24),
      4 + (pulse * 1.5),
      pulsePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CtaBackgroundPainter oldDelegate) {
    return oldDelegate.shimmerProgress != shimmerProgress ||
        oldDelegate.floatProgress != floatProgress;
  }
}