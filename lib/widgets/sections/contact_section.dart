import 'package:flutter/material.dart';
import '../../main.dart';
import '../../localization/app_lang.dart';
import '../../localization/strings.dart';
import 'section_shell.dart';

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

    return SectionShell(
      title: Tr.t(l10n, "contactTitle"),
      subtitle: Tr.t(l10n, "contactSub"),
      child: Container(
        padding: EdgeInsets.all(_isMobile ? 18 : 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: JC.border),
          gradient: const LinearGradient(
            colors: [
              Colors.white,
              Color(0xFFF8FFFB),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 36,
              offset: const Offset(0, 14),
              color: JC.dark.withOpacity(.06),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _Header(l10n: l10n),
              const SizedBox(height: 18),
              Divider(color: JC.border, height: 1),
              const SizedBox(height: 18),
              _isMobile
                  ? Column(
                children: [
                  _input(
                    label: Tr.t(l10n, "name"),
                    controller: _name,
                    icon: Icons.person_rounded,
                    validator: (v) {
                      final s = (v ?? '').trim();
                      if (s.isEmpty) {
                        return "${Tr.t(l10n, "name")} *";
                      }
                      if (s.length < 2) {
                        return "${Tr.t(l10n, "name")} (min 2)";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  _input(
                    label: "Email",
                    controller: _email,
                    icon: Icons.email_rounded,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      final s = (v ?? '').trim();
                      if (s.isEmpty) return "Email *";
                      final ok = RegExp(
                        r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$',
                      ).hasMatch(s);
                      if (!ok) return "Email (invalid)";
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
                      if (s.isEmpty) {
                        return "${Tr.t(l10n, "phone")} *";
                      }
                      if (!RegExp(r'^[0-9+]{7,16}$').hasMatch(s)) {
                        return "${Tr.t(l10n, "phone")} (invalid)";
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
                      if (s.isEmpty) {
                        return "${Tr.t(l10n, "message")} *";
                      }
                      if (s.length < 6) {
                        return "${Tr.t(l10n, "message")} (min 6)";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const _ContactDetailsPanel(),
                ],
              )
                  : Row(
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
                                  if (s.isEmpty) {
                                    return "${Tr.t(l10n, "name")} *";
                                  }
                                  if (s.length < 2) {
                                    return "${Tr.t(l10n, "name")} (min 2)";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _input(
                                label: "Email",
                                controller: _email,
                                icon: Icons.email_rounded,
                                keyboardType: TextInputType.emailAddress,
                                validator: (v) {
                                  final s = (v ?? '').trim();
                                  if (s.isEmpty) return "Email *";
                                  final ok = RegExp(
                                    r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$',
                                  ).hasMatch(s);
                                  if (!ok) return "Email (invalid)";
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
                            if (s.isEmpty) {
                              return "${Tr.t(l10n, "phone")} *";
                            }
                            if (!RegExp(r'^[0-9+]{7,16}$').hasMatch(s)) {
                              return "${Tr.t(l10n, "phone")} (invalid)";
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
                            if (s.isEmpty) {
                              return "${Tr.t(l10n, "message")} *";
                            }
                            if (s.length < 6) {
                              return "${Tr.t(l10n, "message")} (min 6)";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 18),
                  const Expanded(
                    flex: 4,
                    child: _ContactDetailsPanel(),
                  ),
                ],
              ),
              const SizedBox(height: 18),
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

class _Header extends StatelessWidget {
  final L10n l10n;
  const _Header({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              colors: [
                JC.main.withOpacity(.16),
                JC.main.withOpacity(.08),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: JC.main.withOpacity(.18)),
          ),
          child: const Icon(
            Icons.mail_rounded,
            color: JC.mainDark,
            size: 24,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Tr.t(l10n, "contactTitle"),
                style: const TextStyle(
                  color: JC.title,
                  fontWeight: FontWeight.w900,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                Tr.t(l10n, "contactSub"),
                style: const TextStyle(
                  color: JC.muted,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContactDetailsPanel extends StatelessWidget {
  const _ContactDetailsPanel();

  @override
  Widget build(BuildContext context) {
    final items = [
      const _ContactDetailItem(
        icon: Icons.email_rounded,
        title: "Email",
        value: "support@jaycom4.com",
      ),
      const _ContactDetailItem(
        icon: Icons.phone_rounded,
        title: "Phone",
        value: "+966 5X XXX XXXX",
      ),
      const _ContactDetailItem(
        icon: Icons.chat_rounded,
        title: "WhatsApp",
        value: "+966 5X XXX XXXX",
      ),
      const _ContactDetailItem(
        icon: Icons.location_on_rounded,
        title: "Address",
        value: "Riyadh, Saudi Arabia",
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FEFB),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: JC.border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items
            .map(
              (e) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _ContactDetailTile(item: e),
          ),
        )
            .toList(),
      ),
    );
  }
}

class _ContactDetailItem {
  final IconData icon;
  final String title;
  final String value;

  const _ContactDetailItem({
    required this.icon,
    required this.title,
    required this.value,
  });
}

class _ContactDetailTile extends StatelessWidget {
  final _ContactDetailItem item;
  const _ContactDetailTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: JC.border),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 8),
            color: JC.dark.withOpacity(.04),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: LinearGradient(
                colors: [
                  JC.main.withOpacity(.18),
                  JC.main.withOpacity(.08),
                ],
              ),
            ),
            child: Icon(
              item.icon,
              color: JC.mainDark,
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    color: JC.title,
                    fontWeight: FontWeight.w900,
                    fontSize: 13.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.value,
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
  }
}

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
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
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