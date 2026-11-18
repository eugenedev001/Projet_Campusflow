import 'package:flutter/material.dart';

/// Couleurs du design system v1 (docs/seance2/04-design-system-v1.md).
///
/// Ces constantes ne sont utilisées **qu'ici**. Les widgets lisent
/// les couleurs dans le thème : `Theme.of(context).colorScheme.primary`.
abstract final class _Couleurs {
  static const primary = Color(0xFF1D4ED8); // 6,70:1 avec du blanc
  static const primaryContainer = Color(0xFFDBEAFE);
  static const onPrimaryContainer = Color(0xFF1E3A8A); // 8,49:1
  static const surface = Color(0xFFFFFFFF);
  static const onSurface = Color(0xFF1F2937); // 14,68:1
  static const fond = Color(0xFFF5F7FB);
  static const onSurfaceVariant = Color(0xFF4B5563); // 7,05:1 sur le fond
  static const bordure = Color(0xFFD1D5DB);
  static const error = Color(0xFFB91C1C); // 6,47:1 avec du blanc
  static const succes = Color(0xFF15803D); // 5,02:1 avec du blanc
  static const alerte = Color(0xFFFEF3C7);
  static const onAlerte = Color(0xFF92400E); // 6,37:1
}

/// Couleurs de statut d'une tâche, absentes du ColorScheme de Material.
/// On les range dans le thème grâce à une ThemeExtension :
/// `Theme.of(context).extension<StatutColors>()!.succes`
@immutable
class StatutColors extends ThemeExtension<StatutColors> {
  final Color succes;
  final Color onSucces;
  final Color alerte;
  final Color onAlerte;

  const StatutColors({
    required this.succes,
    required this.onSucces,
    required this.alerte,
    required this.onAlerte,
  });

  @override
  StatutColors copyWith({Color? succes, Color? onSucces, Color? alerte, Color? onAlerte}) =>
      StatutColors(
        succes: succes ?? this.succes,
        onSucces: onSucces ?? this.onSucces,
        alerte: alerte ?? this.alerte,
        onAlerte: onAlerte ?? this.onAlerte,
      );

  @override
  StatutColors lerp(ThemeExtension<StatutColors>? other, double t) {
    if (other is! StatutColors) return this;
    return StatutColors(
      succes: Color.lerp(succes, other.succes, t)!,
      onSucces: Color.lerp(onSucces, other.onSucces, t)!,
      alerte: Color.lerp(alerte, other.alerte, t)!,
      onAlerte: Color.lerp(onAlerte, other.onAlerte, t)!,
    );
  }
}

/// Thème unique de CampusFlow : couleurs, typographie, formes des composants.
abstract final class AppTheme {
  static ThemeData get clair {
    final scheme = ColorScheme.fromSeed(seedColor: _Couleurs.primary).copyWith(
      primary: _Couleurs.primary,
      onPrimary: Colors.white,
      primaryContainer: _Couleurs.primaryContainer,
      onPrimaryContainer: _Couleurs.onPrimaryContainer,
      surface: _Couleurs.surface,
      onSurface: _Couleurs.onSurface,
      onSurfaceVariant: _Couleurs.onSurfaceVariant,
      outlineVariant: _Couleurs.bordure,
      error: _Couleurs.error,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: _Couleurs.fond,

      // Typographie : Roboto (police par défaut sous Android), échelle Material 3.
      textTheme: const TextTheme(
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.5),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: _Couleurs.fond,
        foregroundColor: _Couleurs.onSurface,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
      ),

      // Carte de tâche : arrondi 12, bordure fine, sans ombre.
      cardTheme: CardThemeData(
        color: _Couleurs.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: _Couleurs.bordure),
        ),
      ),

      // Bouton principal : hauteur 52, forme pilule.
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, 52),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, 52),
          shape: const StadiumBorder(),
          side: const BorderSide(color: _Couleurs.primary),
        ),
      ),

      // Champ de saisie : arrondi 8, fond blanc.
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _Couleurs.surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: _Couleurs.bordure),
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _Couleurs.primary,
        foregroundColor: Colors.white,
      ),

      extensions: const [
        StatutColors(
          succes: _Couleurs.succes,
          onSucces: Colors.white,
          alerte: _Couleurs.alerte,
          onAlerte: _Couleurs.onAlerte,
        ),
      ],
    );
  }
}
