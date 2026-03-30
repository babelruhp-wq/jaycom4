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

class _CtaSectionState extends State<CtaSection> with SingleTickerProviderStateMixin {
  late final AnimationController _shimmer;

  @override
  void initState() {
    super.initState();
    _shimmer = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmer.dispose();
    super.dispose();
  }

  Future<void> _open(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.platformDefault);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    final isMobile = widget.isMobile;

    return AnimatedBuilder(
      animation: _shimmer,
      builder: (_, __) {
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
              // Grid
              Positioned.fill(
                child: CustomPaint(painter: _GridPainter()),
              ),
              // Shimmer
              Positioned.fill(
                child: CustomPaint(
                  painter: _ShimmerPainter(
                    progress: _shimmer.value,
                  ),
                ),
              ),
              // Glow orbs
              Positioned(
                top: -80,
                left: isMobile ? -40 : 120,
                child: Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        JC.main.withOpacity(.12),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -60,
                right: isMobile ? -30 : 80,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        JC.main.withOpacity(.08),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              // Content
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1180),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 18 : 24,
                      vertical: isMobile ? 54 : 72,
                    ),
                    child: isMobile
                        ? _mobileLayout(l10n)
                        : _desktopLayout(l10n),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _desktopLayout(L10n l10n) {
    return _textContent(l10n);
  }

  Widget _mobileLayout(L10n l10n) {
    return _textContent(l10n);
  }

  Widget _textContent(L10n l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badge
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
              Icon(Icons.download_rounded,
                  size: 14, color: JC.main.withOpacity(.9)),
              const SizedBox(width: 8),
              Text(
                Tr.t(l10n, "downloadApps"),
                style: TextStyle(
                  color: JC.main.withOpacity(.95),
                  fontWeight: FontWeight.w900,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Title
        Text(
          Tr.t(l10n, "ctaTitle"),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: widget.isMobile ? 28 : 38,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 14),
        // Subtitle
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Text(
            Tr.t(l10n, "ctaSub"),
            style: TextStyle(
              color: Colors.white.withOpacity(.55),
              fontWeight: FontWeight.w600,
              fontSize: 15,
              height: 1.7,
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Features
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _FeatureBadge(
                icon: Icons.flash_on_rounded,
                text: Tr.t(l10n, "ctaFastAccess")),
            _FeatureBadge(
                icon: Icons.verified_rounded,
                text: Tr.t(l10n, "ctaTrustedServices")),
            _FeatureBadge(
                icon: Icons.public_rounded,
                text: Tr.t(l10n, "ctaBuiltToScale")),
          ],
        ),
        const SizedBox(height: 28),
        // Buttons
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _CtaButton(
              filled: true,
              icon: Icons.android_rounded,
              label: Tr.t(l10n, "btnAndroid"),
              onTap: () => _open(AppLinks.androidStore),
            ),
            _CtaButton(
              filled: false,
              icon: Icons.apple_rounded,
              label: Tr.t(l10n, "btniOS"),
              onTap: () => _open(AppLinks.iosStore),
            ),
          ],
        ),
      ],
    );
  }
}

/* ─── Feature Badge ─── */
class _FeatureBadge extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureBadge({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.06),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(.10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: JC.main),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(.75),
              fontWeight: FontWeight.w800,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}

/* ─── CTA Button ─── */
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
            backgroundColor: widget.filled
                ? (_hover ? JC.mainSoft : JC.main)
                : Colors.white.withOpacity(.08),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(
                color: widget.filled
                    ? Colors.transparent
                    : Colors.white.withOpacity(.16),
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 20),
              const SizedBox(width: 10),
              Text(
                widget.label,
                style:
                const TextStyle(fontWeight: FontWeight.w900, fontSize: 14),
              ),
            ],
          ),
        ),
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

/* ─── Shimmer ─── */
class _ShimmerPainter extends CustomPainter {
  final double progress;

  _ShimmerPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final sweepW = size.width * 0.3;
    final x = -sweepW + (size.width + sweepW * 2) * progress;

    final shimmerPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.transparent,
          JC.main.withOpacity(.02),
          JC.main.withOpacity(.05),
          JC.main.withOpacity(.02),
          Colors.transparent,
        ],
        stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
      ).createShader(Rect.fromLTWH(x, 0, sweepW, size.height));

    canvas.drawRect(Rect.fromLTWH(x, 0, sweepW, size.height), shimmerPaint);
  }

  @override
  bool shouldRepaint(covariant _ShimmerPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}