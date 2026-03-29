import 'package:flutter/material.dart';
import '../../main.dart';

class SectionShell extends StatefulWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const SectionShell({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  State<SectionShell> createState() => _SectionShellState();
}

class _SectionShellState extends State<SectionShell>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  late final Animation<double> _headerFade;
  late final Animation<Offset> _headerSlide;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );

    _fade = CurvedAnimation(
      parent: _ctrl,
      curve: Curves.easeOutCubic,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic),
    );

    _headerFade = CurvedAnimation(
      parent: _ctrl,
      curve: const Interval(0.0, 0.65, curve: Curves.easeOut),
    );

    _headerSlide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
      ),
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
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 760;

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: isMobile ? 54 : 72),
          child: Center(
            child: SizedBox(
              width: 1180,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 18 : 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeTransition(
                      opacity: _headerFade,
                      child: SlideTransition(
                        position: _headerSlide,
                        child: _SectionHeader(
                          title: widget.title,
                          subtitle: widget.subtitle,
                          ctrl: _ctrl,
                          isMobile: isMobile,
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile ? 22 : 28),
                    widget.child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final AnimationController ctrl;
  final bool isMobile;

  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.ctrl,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -14,
          right: isMobile ? 0 : 18,
          child: IgnorePointer(
            child: Container(
              width: isMobile ? 90 : 120,
              height: isMobile ? 90 : 120,
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
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: isMobile ? 24 : 28,
                fontWeight: FontWeight.w900,
                color: JC.title,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Text(
                subtitle,
                style: TextStyle(
                  color: JC.muted,
                  fontWeight: FontWeight.w700,
                  fontSize: isMobile ? 14 : 15,
                  height: 1.7,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AccentLine extends AnimatedWidget {
  final AnimationController ctrl;
  const _AccentLine({required this.ctrl}) : super(listenable: ctrl);

  @override
  Widget build(BuildContext context) {
    final width = 56 + (22 * ctrl.value);

    return Container(
      height: 4,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        gradient: const LinearGradient(
          colors: [JC.main, JC.mainSoft],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: const Offset(0, 4),
            color: JC.main.withOpacity(.22),
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(.92),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: JC.main.withOpacity(.30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}