import 'package:flutter/material.dart';

abstract final class AppColors {
  // --- Superficie / fondo ---
  static final Color surface = Colors.indigo[50]!;

  // --- Primario (Indigo) ---
  static final Color primary          = Colors.indigo[400]!;
  static final Color primaryMuted     = Colors.indigo.withAlpha(80);
  static final Color primaryContainer = Colors.indigo.withAlpha(24);

  // --- Sobre primario ---
  static const Color onPrimary = Colors.white;

  // --- Acento ---
  static const Color accent = Colors.orange;

  // --- Design system tokens (DESIGN.md) ---
  static const Color deepIndigo            = Color(0xFF24389C);
  static const Color brandIndigo           = Color(0xFF3F51B5);
  static const Color textPrimary           = Color(0xFF191C1D);
  static const Color textSecondary         = Color(0xFF454652);
  static const Color outlineLight          = Color(0xFF757684);
  static const Color outlineVariant        = Color(0xFFC5C5D4);
  static const Color surfaceBg             = Color(0xFFF8F9FA);
  static const Color surfaceContainerHigh  = Color(0xFFE7E8E9);
  static const Color borderLight           = Color(0xFFE1E3E4);
}
