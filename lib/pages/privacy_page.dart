import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jaycom/widgets/top_bar.dart';
import '../localization/app_lang.dart';
import '../localization/strings.dart';
import '../main.dart';
import '../widgets/sections/footer.dart';

class PrivacyPage extends StatelessWidget {
  final L10n l10n;

  const PrivacyPage({super.key, required this.l10n});

  bool _isMobile(BuildContext context) => MediaQuery.sizeOf(context).width < 1180;

  void _goHome(BuildContext context, {String? section}) {
    final lang = l10n.lang.name;
    final target = section == null || section.isEmpty
        ? '/?lang=$lang'
        : '/?lang=$lang&section=$section';
    context.go(target);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = _isMobile(context);

    return Directionality(
      textDirection: l10n.dir,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7FB),
        body: Column(
          children: [
            TopBar(
              l10n: l10n,
              isMobile: isMobile,
              onSelectLang: (lang) {
                context.go('/privacy?lang=${lang.name}');
              },
              onHome: () => _goHome(context, section: 'home'),
              onAbout: () => _goHome(context, section: 'about'),
              onServices: () => _goHome(context, section: 'services'),
              onContact: () => _goHome(context, section: 'contact'),
              onPrivacy: () => context.go('/privacy?lang=${l10n.lang.name}'),
              onTerms: () => context.go('/terms?lang=${l10n.lang.name}'),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(
                        24,
                        isMobile ? 36 : 56,
                        24,
                        isMobile ? 40 : 64,
                      ),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [JC.dark, JC.dark2, Color(0xFF0D3326)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0, 0.6, 1.0],
                        ),
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1180),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: JC.main.withOpacity(.12),
                                  borderRadius: BorderRadius.circular(999),
                                  border: Border.all(
                                    color: JC.main.withOpacity(.22),
                                  ),
                                ),
                                child: Text(
                                  Tr.t(l10n, 'privacy_policy'),
                                  style: TextStyle(
                                    color: JC.main.withOpacity(.95),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12.5,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 18),
                              Text(
                                Tr.t(l10n, 'privacy_policy'),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: isMobile ? 32 : 48,
                                  height: 1.12,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 700),
                                child: Text(
                                  'This page is under preparation.',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(.68),
                                    fontSize: isMobile ? 14 : 15,
                                    height: 1.7,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -26),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 1180),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(isMobile ? 20 : 28),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: JC.border),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 30,
                                    offset: const Offset(0, 14),
                                    color: JC.dark.withOpacity(.06),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 56,
                                        height: 56,
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
                                          border: Border.all(
                                            color: JC.main.withOpacity(.18),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.privacy_tip_rounded,
                                          color: JC.mainDark,
                                          size: 28,
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              Tr.t(l10n, 'privacy_policy'),
                                              style: const TextStyle(
                                                color: JC.title,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 22,
                                                height: 1.2,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              'Temporary content area until the final privacy policy is added.',
                                              style: TextStyle(
                                                color: JC.muted,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 14,
                                                height: 1.7,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 22),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(isMobile ? 18 : 22),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF8FCFA),
                                      borderRadius: BorderRadius.circular(24),
                                      border: Border.all(color: JC.border),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          Tr.t(l10n, 'privacy_policy'),
                                          style: const TextStyle(
                                            color: JC.title,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'Privacy Policy',
                                          style: TextStyle(
                                            color: JC.mainDark,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'This section is a placeholder for now.',
                                          style: TextStyle(
                                            color: JC.muted,
                                            fontWeight: FontWeight.w700,
                                            height: 1.8,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Footer(l10n: l10n),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}