import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../core/links.dart';
import '../localization/app_lang.dart';

class ContactFab extends StatefulWidget {
  final L10n l10n;
  final VoidCallback onOpenContactSection;

  const ContactFab({
    super.key,
    required this.l10n,
    required this.onOpenContactSection,
  });

  @override
  State<ContactFab> createState() => _ContactFabState();
}

class _ContactFabState extends State<ContactFab>
    with SingleTickerProviderStateMixin {
  bool open = false;
  late final AnimationController _pulseCtrl;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  bool _enableHover(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 900;
  }

  void _safeSetState(VoidCallback fn) {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(fn);
    });
  }

  void _setOpen(bool value) {
    if (open == value) return;
    _safeSetState(() => open = value);
  }

  Future<void> _launch(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;

    final ok = await launchUrl(uri, mode: LaunchMode.platformDefault);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Could not open: $url"),
          behavior: SnackBarBehavior.floating,
          backgroundColor: JC.mainDark,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAr = widget.l10n.isAr;

    return Align(
      alignment: isAr ? Alignment.bottomLeft : Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: SafeArea(
          child: SizedBox(
            width: 96,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: Tween<double>(begin: .94, end: 1).animate(animation),
                    child: child,
                  ),
                );
              },
              child: open ? _dockWithBarrier(context, isAr) : _mainFab(isAr),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dockWithBarrier(BuildContext context, bool isAr) {
    return Stack(
      alignment: isAr ? Alignment.bottomLeft : Alignment.bottomRight,
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () => _setOpen(false),
            child: Container(color: Colors.transparent),
          ),
        ),
        _dock(context, isAr),
      ],
    );
  }

  Widget _mainFab(bool isAr) {
    return _FabMainButton(
      pulse: _pulseCtrl,
      onTap: () => _setOpen(true),
      icon: Icons.support_agent_rounded,
    );
  }

  Widget _dock(BuildContext context, bool isAr) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
      builder: (_, t, child) {
        return Transform.translate(
          offset: Offset(0, (1 - t) * 12),
          child: Opacity(opacity: t, child: child),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            width: 82,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF0B1F18).withOpacity(.92),
                  const Color(0xFF102921).withOpacity(.82),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              border: Border.all(color: Colors.white.withOpacity(.08)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 28,
                  offset: const Offset(0, 16),
                  color: Colors.black.withOpacity(.22),
                ),
                BoxShadow(
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                  color: JC.main.withOpacity(.10),
                ),
              ],
            ),
            child: Stack(
              children: [
                const Positioned.fill(child: _FabDockDecor()),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _DockIcon(
                      bg: const Color(0xFF111111),
                      icon: FontAwesomeIcons.tiktok,
                      iconColor: Colors.white,
                      onTap: () => _launch(AppLinks.tiktok),
                    ),
                    const SizedBox(height: 12),
                    _DockIcon(
                      bg: const Color(0xFFFFEB3B),
                      icon: FontAwesomeIcons.snapchatGhost,
                      iconColor: Colors.black,
                      onTap: () => _launch(AppLinks.snapchat),
                    ),
                    const SizedBox(height: 12),
                    _DockIcon(
                      bg: const Color(0xFF111111),
                      icon: FontAwesomeIcons.xTwitter,
                      iconColor: Colors.white,
                      onTap: () => _launch(AppLinks.x),
                    ),
                    const SizedBox(height: 12),
                    _DockIcon(
                      bg: const Color(0xFF25D366),
                      icon: FontAwesomeIcons.whatsapp,
                      iconColor: Colors.white,
                      onTap: () => _launch(AppLinks.whatsapp),
                    ),
                    const SizedBox(height: 12),
                    _DockIcon(
                      bg: JC.main,
                      icon: Icons.mail_rounded,
                      iconColor: Colors.white,
                      onTap: () {
                        _setOpen(false);
                        widget.onOpenContactSection();
                      },
                    ),
                    const SizedBox(height: 14),
                    _FabMainButton(
                      onTap: () => _setOpen(false),
                      icon: Icons.close_rounded,
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

class _DockIcon extends StatefulWidget {
  final Color bg;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _DockIcon({
    required this.bg,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  State<_DockIcon> createState() => _DockIconState();
}

class _DockIconState extends State<_DockIcon> {
  bool _hover = false;
  bool _down = false;

  bool _enableHover(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 900;
  }

  void _safeSetState(VoidCallback fn) {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(fn);
    });
  }

  void _setHover(bool value) {
    if (_hover == value) return;
    _safeSetState(() => _hover = value);
  }

  void _setDown(bool value) {
    if (_down == value) return;
    _safeSetState(() => _down = value);
  }

  @override
  Widget build(BuildContext context) {
    final enableHover = _enableHover(context);
    final scale = _down ? .94 : (_hover ? 1.05 : 1.0);

    final child = GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _setDown(true),
      onTapUp: (_) => _setDown(false),
      onTapCancel: () => _setDown(false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOut,
        scale: scale,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.bg,
            border: Border.all(
              color: _hover
                  ? Colors.white.withOpacity(.18)
                  : Colors.white.withOpacity(.08),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: _hover ? 22 : 14,
                offset: const Offset(0, 10),
                color: (_hover ? JC.main : Colors.black)
                    .withOpacity(_hover ? .18 : .25),
              ),
            ],
          ),
          child: Center(
            child: widget.icon == Icons.mail_rounded
                ? Icon(widget.icon, color: widget.iconColor, size: 24)
                : FaIcon(widget.icon, color: widget.iconColor, size: 22),
          ),
        ),
      ),
    );

    if (!enableHover) return child;

    return MouseRegion(
      onEnter: (_) => _setHover(true),
      onExit: (_) {
        _setHover(false);
        _setDown(false);
      },
      child: child,
    );
  }
}

class _FabMainButton extends StatefulWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Animation<double>? pulse;

  const _FabMainButton({
    required this.onTap,
    required this.icon,
    this.pulse,
  });

  @override
  State<_FabMainButton> createState() => _FabMainButtonState();
}

class _FabMainButtonState extends State<_FabMainButton> {
  bool _hover = false;
  bool _down = false;

  bool _enableHover(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 900;
  }

  void _safeSetState(VoidCallback fn) {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(fn);
    });
  }

  void _setHover(bool value) {
    if (_hover == value) return;
    _safeSetState(() => _hover = value);
  }

  void _setDown(bool value) {
    if (_down == value) return;
    _safeSetState(() => _down = value);
  }

  @override
  Widget build(BuildContext context) {
    final enableHover = _enableHover(context);
    final scale = _down ? .94 : (_hover ? 1.04 : 1.0);

    Widget button = GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _setDown(true),
      onTapUp: (_) => _setDown(false),
      onTapCancel: () => _setDown(false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOut,
        scale: scale,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [JC.mainDark, JC.main],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: Colors.white.withOpacity(.88),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: _hover ? 22 : 16,
                offset: const Offset(0, 10),
                color: JC.main.withOpacity(_hover ? .40 : .30),
              ),
            ],
          ),
          child: Center(
            child: Icon(widget.icon, color: Colors.white, size: 28),
          ),
        ),
      ),
    );

    if (enableHover) {
      button = MouseRegion(
        onEnter: (_) => _setHover(true),
        onExit: (_) {
          _setHover(false);
          _setDown(false);
        },
        child: button,
      );
    }

    if (widget.pulse != null) {
      button = AnimatedBuilder(
        animation: widget.pulse!,
        builder: (_, child) {
          final glow = .18 + (widget.pulse!.value * .10);
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 24,
                  spreadRadius: 1,
                  color: JC.main.withOpacity(glow),
                ),
              ],
            ),
            child: child,
          );
        },
        child: button,
      );
    }

    return button;
  }
}

class _FabDockDecor extends StatelessWidget {
  const _FabDockDecor();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -20,
            right: -12,
            child: Container(
              width: 80,
              height: 80,
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
            bottom: 40,
            left: -18,
            child: Container(
              width: 60,
              height: 60,
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
        ],
      ),
    );
  }
}