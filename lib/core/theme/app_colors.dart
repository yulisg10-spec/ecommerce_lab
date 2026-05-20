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
}
