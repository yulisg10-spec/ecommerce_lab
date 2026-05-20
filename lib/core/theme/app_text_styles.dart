import 'package:flutter/material.dart';

abstract final class AppTextStyles {
  // --- 14px ---
  static const TextStyle smRegular = TextStyle(
    fontSize: 14,
  );
  static const TextStyle smBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle smItalic = TextStyle(
    fontSize: 14,
    fontStyle: FontStyle.italic,
  );

  // --- 16px ---
  static const TextStyle mdRegular = TextStyle(
    fontSize: 16,
  );
  static const TextStyle mdBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle mdItalic = TextStyle(
    fontSize: 16,
    fontStyle: FontStyle.italic,
  );

  // --- 18px ---
  static const TextStyle lgRegular = TextStyle(
    fontSize: 18,
  );
  static const TextStyle lgBold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle lgItalic = TextStyle(
    fontSize: 18,
    fontStyle: FontStyle.italic,
  );

  // --- 24px ---
  static const TextStyle xlRegular = TextStyle(
    fontSize: 24,
  );
  static const TextStyle xlBold = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle xlItalic = TextStyle(
    fontSize: 24,
    fontStyle: FontStyle.italic,
  );
}
