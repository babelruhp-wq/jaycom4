import 'package:flutter/material.dart';
import '../../main.dart';
import '../../localization/app_lang.dart';
import '../../localization/strings.dart';

class ContactSection extends StatefulWidget {
  final L10n l10n;
  const ContactSection({super.key, required this.l10n});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _msg = TextEditingController();

  bool _sending = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _msg.dispose();
    super.dispose();
  }

  bool get _isMobile => MediaQuery.sizeOf(context).width < 820;

  void _toast(String text, {bool ok = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(14),
        backgroundColor: ok ? JC.mainDark : const Color(0xFFB91C1C),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String _requiredError(String label) => "$label *";
  String _minError(String label, int n) =>
      "$label (${Tr.t(widget.l10n, "minPrefix")} $n)";
  String _invalidError(String label) =>
      "$label (${Tr.t(widget.l10n, "invalidValue")})";

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    setState(() => _sending = true);
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _sending = false);

    _name.clear();
    _email.clear();
    _phone.clear();
    _msg.clear();

    _toast(Tr.t(widget.l10n, "sent"), ok: true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    final isMobile = _isMobile;

    return Container(
      width: double.infinity,
      color: const Color(0xFFF0F9F4),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _ContactBgPainter())),
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
                    // Section tag
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: JC.main.withOpacity(.10),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: JC.main.withOpacity(.20)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.mail_rounded,
                              size: 14, color: JC.mainDark),
                          const SizedBox(width: 8),
                          Text(
                            Tr.t(l10n, "contactTitle"),
                            style: TextStyle(
                              color: JC.mainDark,
                              fontWeight: FontWeight.w900,
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Title
                    Text(
                      Tr.t(l10n, "contactTitle"),
                      style: TextStyle(
                        color: JC.title,
                        fontWeight: FontWeight.w900,
                        fontSize: isMobile ? 26 : 32,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Subtitle
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: Text(
                        Tr.t(l10n, "contactSub"),
                        style: TextStyle(
                          color: JC.muted,
                          fontWeight: FontWeight.w600,
                          fontSize: isMobile ? 14 : 15,
                          height: 1.7,
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile ? 28 : 36),
                    // Form card
                    Container(
                      padding: EdgeInsets.all(isMobile ? 18 : 28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: JC.border),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 40,
                            offset: const Offset(0, 16),
                            color: JC.dark.withOpacity(.07),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            isMobile
                                ? _mobileForm(l10n)
                                : _desktopForm(l10n),
                            const SizedBox(height: 20),
                            // Divider
                            Container(height: 1, color: JC.border),
                            const SizedBox(height: 18),
                            // Footer row
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "• ${Tr.t(l10n, "footer")}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: JC.muted.withOpacity(.9),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.5,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                _SendButton(
                                  loading: _sending,
                                  label: Tr.t(l10n, "send"),
                                  onTap: _sending ? null : _submit,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _desktopForm(L10n l10n) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _input(
                      label: Tr.t(l10n, "name"),
                      controller: _name,
                      icon: Icons.person_rounded,
                      validator: (v) {
                        final s = (v ?? '').trim();
                        if (s.isEmpty) return _requiredError(Tr.t(l10n, "name"));
                        if (s.length < 2) return _minError(Tr.t(l10n, "name"), 2);
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _input(
                      label: Tr.t(l10n, "email"),
                      controller: _email,
                      icon: Icons.email_rounded,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        final s = (v ?? '').trim();
                        if (s.isEmpty) return _requiredError(Tr.t(l10n, "email"));
                        if (!RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$').hasMatch(s)) {
                          return _invalidError(Tr.t(l10n, "email"));
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _input(
                label: Tr.t(l10n, "phone"),
                controller: _phone,
                icon: Icons.phone_rounded,
                keyboardType: TextInputType.phone,
                validator: (v) {
                  final s = (v ?? '').trim();
                  if (s.isEmpty) return _requiredError(Tr.t(l10n, "phone"));
                  if (!RegExp(r'^[0-9+]{7,16}$').hasMatch(s)) {
                    return _invalidError(Tr.t(l10n, "phone"));
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _input(
                label: Tr.t(l10n, "message"),
                controller: _msg,
                icon: Icons.chat_rounded,
                maxLines: 5,
                validator: (v) {
                  final s = (v ?? '').trim();
                  if (s.isEmpty) return _requiredError(Tr.t(l10n, "message"));
                  if (s.length < 6) return _minError(Tr.t(l10n, "message"), 6);
                  return null;
                },
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 4,
          child: _ContactDetailsPanel(l10n: l10n),
        ),
      ],
    );
  }

  Widget _mobileForm(L10n l10n) {
    return Column(
      children: [
        _input(
          label: Tr.t(l10n, "name"),
          controller: _name,
          icon: Icons.person_rounded,
          validator: (v) {
            final s = (v ?? '').trim();
            if (s.isEmpty) return _requiredError(Tr.t(l10n, "name"));
            if (s.length < 2) return _minError(Tr.t(l10n, "name"), 2);
            return null;
          },
        ),
        const SizedBox(height: 12),
        _input(
          label: Tr.t(l10n, "email"),
          controller: _email,
          icon: Icons.email_rounded,
          keyboardType: TextInputType.emailAddress,
          validator: (v) {
            final s = (v ?? '').trim();
            if (s.isEmpty) return _requiredError(Tr.t(l10n, "email"));
            if (!RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$').hasMatch(s)) {
              return _invalidError(Tr.t(l10n, "email"));
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
        _input(
          label: Tr.t(l10n, "phone"),
          controller: _phone,
          icon: Icons.phone_rounded,
          keyboardType: TextInputType.phone,
          validator: (v) {
            final s = (v ?? '').trim();
            if (s.isEmpty) return _requiredError(Tr.t(l10n, "phone"));
            if (!RegExp(r'^[0-9+]{7,16}$').hasMatch(s)) {
              return _invalidError(Tr.t(l10n, "phone"));
            }
            return null;
          },
        ),
        const SizedBox(height: 12),
        _input(
          label: Tr.t(l10n, "message"),
          controller: _msg,
          icon: Icons.chat_rounded,
          maxLines: 5,
          validator: (v) {
            final s = (v ?? '').trim();
            if (s.isEmpty) return _requiredError(Tr.t(l10n, "message"));
            if (s.length < 6) return _minError(Tr.t(l10n, "message"), 6);
            return null;
          },
        ),
        const SizedBox(height: 16),
        _ContactDetailsPanel(l10n: l10n),
      ],
    );
  }

  Widget _input({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(
        color: JC.title,
        fontWeight: FontWeight.w800,
        height: 1.45,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: JC.muted.withOpacity(.9),
          fontWeight: FontWeight.w800,
        ),
        prefixIcon: Icon(icon, color: JC.mainDark.withOpacity(.9)),
        filled: true,
        fillColor: const Color(0xFFF7FCF9),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: JC.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: JC.main, width: 1.35),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFB91C1C), width: 1.1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFB91C1C), width: 1.2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
      ),
    );
  }
}

/* ─── Contact Details Panel ─── */
class _ContactDetailsPanel extends StatelessWidget {
  final L10n l10n;
  const _ContactDetailsPanel({required this.l10n});

  @override
  Widget build(BuildContext context) {
    final items = [
      _CItem(Icons.email_rounded, Tr.t(l10n, "email"), "support@jaycom4.com"),
      _CItem(Icons.phone_rounded, Tr.t(l10n, "phone"), "+966 5X XXX XXXX"),
      _CItem(Icons.chat_rounded, Tr.t(l10n, "contactWhatsapp"), "+966 5X XXX XXXX"),
      _CItem(Icons.location_on_rounded, Tr.t(l10n, "contactAddress"),
          Tr.t(l10n, "contactAddressValue")),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4FBF7),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: JC.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items
            .map((e) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _DetailTile(item: e),
        ))
            .toList(),
      ),
    );
  }
}

class _CItem {
  final IconData icon;
  final String title;
  final String value;
  const _CItem(this.icon, this.title, this.value);
}

class _DetailTile extends StatefulWidget {
  final _CItem item;
  const _DetailTile({required this.item});

  @override
  State<_DetailTile> createState() => _DetailTileState();
}

class _DetailTileState extends State<_DetailTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final enableHover = MediaQuery.sizeOf(context).width >= 900;

    final child = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      transform: Matrix4.identity()..translate(0.0, _hover ? -2.0 : 0.0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: _hover ? JC.main.withOpacity(.22) : JC.border,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: _hover ? 20 : 10,
            offset: const Offset(0, 8),
            color: (_hover ? JC.main : JC.dark).withOpacity(_hover ? .10 : .04),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: LinearGradient(
                colors: [JC.main.withOpacity(.18), JC.main.withOpacity(.08)],
              ),
            ),
            child: Icon(widget.item.icon, color: JC.mainDark, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.title,
                  style: const TextStyle(
                    color: JC.title,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  widget.item.value,
                  style: const TextStyle(
                    color: JC.muted,
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (!enableHover) return child;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: child,
    );
  }
}

/* ─── Send Button ─── */
class _SendButton extends StatelessWidget {
  final String label;
  final bool loading;
  final VoidCallback? onTap;

  const _SendButton({
    required this.label,
    required this.loading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: JC.main,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        shadowColor: JC.main.withOpacity(.22),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (loading) ...[
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
          ] else ...[
            const Icon(Icons.send_rounded, size: 17),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

/* ─── Background ─── */
class _ContactBgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = JC.main.withOpacity(.04)
      ..strokeWidth = 0.5;
    const sp = 80.0;
    for (double x = 0; x < size.width; x += sp) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y < size.height; y += sp) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}