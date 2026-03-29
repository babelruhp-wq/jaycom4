import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'pages/home_page.dart';
import 'pages/terms_page.dart';
import 'pages/privacy_page.dart';
import 'localization/app_lang.dart';

AppLang _parseLang(String? value) {
  switch (value) {
    case 'ar':
      return AppLang.ar;
    case 'ur':
      return AppLang.ur;
    case 'en':
      return AppLang.en;
    default:
      return AppLang.ar;
  }
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => NoTransitionPage(
        child: HomePage(
          initialLang: _parseLang(state.uri.queryParameters['lang']),
          initialSection: state.uri.queryParameters['section'],
        ),
      ),
    ),
    GoRoute(
      path: '/terms',
      pageBuilder: (context, state) => NoTransitionPage(
        child: TermsPage(
          l10n: L10n(_parseLang(state.uri.queryParameters['lang'])),
        ),
      ),
    ),
    GoRoute(
      path: '/privacy',
      pageBuilder: (context, state) => NoTransitionPage(
        child: PrivacyPage(
          l10n: L10n(_parseLang(state.uri.queryParameters['lang'])),
        ),
      ),
    ),
  ],
);