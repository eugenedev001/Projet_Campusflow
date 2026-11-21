import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Écran de titre. Aucune couleur ni taille écrite en dur :
/// tout est lu dans le thème (Theme.of(context)).
///
/// - Asset : le logo `assets/images/logo.png`, déclaré dans pubspec.yaml.
/// - Package : `intl`, pour la date du jour en français.
class EcranTitre extends StatelessWidget {
  const EcranTitre({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final couleurs = theme.colorScheme;
    final textes = theme.textTheme;
    final aujourdhui = DateFormat('EEEE d MMMM y', 'fr_FR').format(DateTime.now());

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 120,
                  height: 120,
                  semanticLabel: 'Logo CampusFlow',
                ),
                const SizedBox(height: 24),
                Text(
                  'CampusFlow',
                  style: textes.headlineMedium?.copyWith(color: couleurs.primary),
                ),
                const SizedBox(height: 8),
                Text(
                  'Toutes tes échéances au même endroit',
                  textAlign: TextAlign.center,
                  style: textes.bodyLarge?.copyWith(color: couleurs.onSurfaceVariant),
                ),
                const SizedBox(height: 16),
                Chip(
                  avatar: Icon(Icons.today, size: 18, color: couleurs.onPrimaryContainer),
                  label: Text(_majuscule(aujourdhui)),
                  backgroundColor: couleurs.primaryContainer,
                  labelStyle: textes.labelLarge?.copyWith(color: couleurs.onPrimaryContainer),
                  side: BorderSide.none,
                ),
                const SizedBox(height: 40),
                FilledButton(
                  // go : remplace l'adresse (pas de retour vers l'écran d'entrée)
                  onPressed: () => context.go('/taches'),
                  child: const Text('Commencer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// « mercredi 18 novembre 2026 » → « Mercredi 18 novembre 2026 »
  static String _majuscule(String texte) =>
      texte.isEmpty ? texte : texte[0].toUpperCase() + texte.substring(1);
}
