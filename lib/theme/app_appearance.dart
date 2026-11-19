import 'package:flutter/material.dart';

enum AppAppearance {
  reikland(
    'Reikland',
    'Diurno - Rojo',
    Color(0xFFFFFFFF),
    Color(0xFFF4F5F7),
    Color(0xFF20242A),
    Color(0xFF59616C),
    Color(0xFFD7DBE0),
    Color(0xFF7B293B),
    Color(0xFFFFFFFF),
  ),
  middenland(
    'Middenland',
    'Diurno - Azul',
    Color(0xFFFFFFFF),
    Color(0xFFF4F5F7),
    Color(0xFF20242A),
    Color(0xFF59616C),
    Color(0xFFD7DBE0),
    Color(0xFF23486C),
    Color(0xFFFFFFFF),
  ),
  stirland(
    'Stirland',
    'Diurno - Verde',
    Color(0xFFFFFFFF),
    Color(0xFFF4F5F7),
    Color(0xFF20242A),
    Color(0xFF59616C),
    Color(0xFFD7DBE0),
    Color(0xFF224E3C),
    Color(0xFFFFFFFF),
  ),
  nuln(
    'Nuln',
    'Noche - Azul',
    Color(0xFF15181D),
    Color(0xFF222730),
    Color(0xFFF1EEE7),
    Color(0xFFB4BAC4),
    Color(0xFF414954),
    Color(0xFF91ADCB),
    Color(0xFF15181D),
  ),
  talabecland(
    'Talabecland',
    'Clásico',
    Color(0xFFF1E5CC),
    Color(0xFFFAF3E3),
    Color(0xFF33291F),
    Color(0xFF6D5A43),
    Color(0xFFCAB892),
    Color(0xFF803629),
    Color(0xFFFFFFFF),
  );

  const AppAppearance(
    this.label,
    this.description,
    this.background,
    this.surface,
    this.primaryText,
    this.secondaryText,
    this.border,
    this.accent,
    this.onAccent,
  );

  final String label;
  final String description;
  final Color background;
  final Color surface;
  final Color primaryText;
  final Color secondaryText;
  final Color border;
  final Color accent;
  final Color onAccent;
}
