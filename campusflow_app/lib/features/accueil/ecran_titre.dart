import 'package:flutter/material.dart';

/// Écran de titre. Aucune couleur ni taille écrite en dur :
/// tout est lu dans le thème (Theme.of(context)).
class EcranTitre extends StatelessWidget {
  const EcranTitre({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final couleurs = theme.colorScheme;
    final textes = theme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.event_available, size: 96, color: couleurs.primary),
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
                const SizedBox(height: 40),
                FilledButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Les écrans arrivent en séance 5')),
                  ),
                  child: const Text('Commencer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
