import 'dart:ui';
import 'package:flutter/material.dart';
import '../main.dart';
import '../localization/app_lang.dart';
import '../localization/strings.dart';

class TopBar extends StatelessWidget {
  final L10n l10n;
  final bool isMobile;
  final VoidCallback onToggleLang;
  final VoidCallback onHome, onAbout, onServices, onContact, onPrivacy, onTerms;

  const TopBar({
    super.key,
    required this.l10n,
    required this.isMobile,
    required this.onToggleLang,
    required this.onHome,
    required this.onAbout,
    required this.onServices,
    required this.onContact,
    required this.onPrivacy,
    required this.onTerms,
  });

  static const double _maxW = 1180;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.72),
              border: Border(
                bottom: BorderSide(
                  color: JC.main.withOpacity(.08),
                ),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 28,
                  offset: const Offset(0, 8),
                  color: JC.dark.withOpacity(.06),
                ),
              ],
            ),
            child: Stack(
              children: [
                const Positioned.fill(child: _TopBarDecor()),
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: _maxW),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          const _Brand(),
                          const Spacer(),
                          if (!isMobile) ...[
                            _NavItem(
                              title: Tr.t(l10n, "home"),
                              onTap: onHome,
                            ),
                            _NavItem(
                              title: Tr.t(l10n, "about"),
                              onTap: onAbout,
                            ),
                            _NavItem(
                              title: Tr.t(l10n, "services"),
                              onTap: onServices,
                            ),
                            _NavItem(
                              title: Tr.t(l10n, "contact"),
                              onTap: onContact,
                            ),
                            _NavItem(
                              title: Tr.t(l10n, "privacy_policy"),
                              onTap: onPrivacy,
                            ),
                            _NavItem(
                              title: Tr.t(l10n, "terms_conditions"),
                              onTap: onTerms,
                            ),
                            const SizedBox(width: 14),
                            _PillButton(
                              label: Tr.t(l10n, "langBtn"),
                              onTap: onToggleLang,
                              filled: false,
                              icon: Icons.language_rounded,
                            ),
                            const SizedBox(width: 8),
                            _PillButton(
                              label: Tr.t(l10n, "downloadApps"),
                              onTap: onContact,
                              filled: true,
                              icon: Icons.download_rounded,
                            ),
                          ] else ...[
                            _PillButton(
                              label: Tr.t(l10n, "langBtn"),
                              onTap: onToggleLang,
                              filled: false,
                              icon: Icons.language_rounded,
                            ),
                            const SizedBox(width: 8),
                            _PillButton(
                              label: Tr.t(l10n, "menu"),
                              onTap: () => _showMobileMenu(context),
                              filled: true,
                              icon: Icons.menu_rounded,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.96),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(26),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 30,
                offset: const Offset(0, -12),
                color: JC.dark.withOpacity(.10),
              ),
            ],
          ),
          child: Stack(
            children: [
              const Positioned.fill(child: _MobileSheetDecor()),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _MobileMenuItem(
                      title: Tr.t(l10n, "home"),
                      icon: Icons.home_rounded,
                      onTap: onHome,
                    ),
                    _MobileMenuItem(
                      title: Tr.t(l10n, "about"),
                      icon: Icons.info_rounded,
                      onTap: onAbout,
                    ),
                    _MobileMenuItem(
                      title: Tr.t(l10n, "services"),
                      icon: Icons.miscellaneous_services_rounded,
                      onTap: onServices,
                    ),
                    _MobileMenuItem(
                      title: Tr.t(l10n, "contact"),
                      icon: Icons.mail_rounded,
                      onTap: onContact,
                    ),
                    _MobileMenuItem(
                      title: Tr.t(l10n, "terms_conditions"),
                      icon: Icons.gavel_rounded,
                      onTap: onTerms,
                    ),
                    _MobileMenuItem(
                      title: Tr.t(l10n, "privacy_policy"),
                      icon: Icons.privacy_tip_rounded,
                      onTap: onPrivacy,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _PillButton(
                            label: Tr.t(l10n, "langBtn"),
                            onTap: () {
                              Navigator.pop(context);
                              onToggleLang();
                            },
                            filled: false,
                            icon: Icons.language_rounded,
                            fullWidth: true,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _PillButton(
                            label: Tr.t(l10n, "downloadApps"),
                            onTap: () {
                              Navigator.pop(context);
                              onContact();
                            },
                            filled: true,
                            icon: Icons.download_rounded,
                            fullWidth: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Brand extends StatefulWidget {
  const _Brand();

  @override
  State<_Brand> createState() => _BrandState();
}

class _BrandState extends State<_Brand> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.identity()..translate(0.0, _hover ? -1.5 : 0.0),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
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
                border: Border.all(color: Colors.white.withOpacity(.10)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: _hover ? 24 : 20,
                    offset: const Offset(0, 8),
                    color: JC.main.withOpacity(_hover ? .30 : .22),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Jaycom4",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: .3,
                    color: JC.title,
                    height: 1.1,
                  ),
                ),
                Text(
                  "Services Platform",
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    color: JC.muted.withOpacity(.85),
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _NavItem({
    required this.title,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final bg = _hover ? JC.main.withOpacity(.08) : Colors.transparent;
    final fg = _hover ? JC.mainDark : JC.muted;
    final bdr = _hover ? JC.main.withOpacity(.16) : Colors.transparent;

    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 6),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        cursor: SystemMouseCursors.click,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(14),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: bdr),
            ),
            child: Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14,
                color: fg,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileMenuItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _MobileMenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_MobileMenuItem> createState() => _MobileMenuItemState();
}

class _MobileMenuItemState extends State<_MobileMenuItem> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          color: _hover ? JC.main.withOpacity(.05) : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _hover ? JC.main.withOpacity(.14) : Colors.transparent,
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          leading: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: JC.main.withOpacity(.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: JC.main.withOpacity(.14)),
            ),
            child: Icon(widget.icon, color: JC.mainDark),
          ),
          title: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: JC.title,
            ),
          ),
          trailing: const Icon(
            Icons.chevron_right_rounded,
            color: JC.muted,
          ),
          onTap: () {
            Navigator.pop(context);
            widget.onTap();
          },
        ),
      ),
    );
  }
}

class _PillButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool filled;
  final IconData icon;
  final bool fullWidth;

  const _PillButton({
    required this.label,
    required this.onTap,
    required this.filled,
    required this.icon,
    this.fullWidth = false,
  });

  @override
  State<_PillButton> createState() => _PillButtonState();
}

class _PillButtonState extends State<_PillButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final bg = widget.filled
        ? (_hover ? JC.mainSoft : JC.main)
        : (_hover ? JC.main.withOpacity(.10) : JC.mainLight);
    final fg = widget.filled ? Colors.white : JC.mainDark;
    final border =
    widget.filled ? Colors.transparent : JC.main.withOpacity(.10);

    return SizedBox(
      width: widget.fullWidth ? double.infinity : null,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          transform: Matrix4.identity()..translate(0.0, _hover ? -1.5 : 0.0),
          child: ElevatedButton(
            onPressed: widget.onTap,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: bg,
              foregroundColor: fg,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(color: border),
              ),
              shadowColor:
              widget.filled ? JC.main.withOpacity(.25) : Colors.transparent,
            ),
            child: Row(
              mainAxisSize:
              widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.icon, size: 18),
                const SizedBox(width: 8),
                Text(
                  widget.label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TopBarDecor extends StatelessWidget {
  const _TopBarDecor();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -30,
            left: 120,
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
          Positioned(
            right: 180,
            top: -40,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    JC.main.withOpacity(.05),
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

class _MobileSheetDecor extends StatelessWidget {
  const _MobileSheetDecor();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -40,
            right: -20,
            child: Container(
              width: 140,
              height: 140,
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
          Positioned(
            bottom: -24,
            left: -12,
            child: Container(
              width: 110,
              height: 110,
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
        ],
      ),
    );
  }
}