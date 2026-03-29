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
    default:
      return AppLang.en;
  }
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/terms',
      builder: (context, state) => TermsPage(
        l10n: L10n(_parseLang(state.uri.queryParameters['lang'])),
      ),
    ),
    GoRoute(
      path: '/privacy',
      builder: (context, state) => PrivacyPage(
        l10n: L10n(_parseLang(state.uri.queryParameters['lang'])),
      ),
    ),
  ],
);