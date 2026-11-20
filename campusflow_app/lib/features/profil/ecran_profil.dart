import 'package:flutter/material.dart';

/// Écran Profil : simple emplacement pour l'instant.
/// Il affichera l'utilisateur connecté et la déconnexion en séance 7.
class EcranProfil extends StatelessWidget {
  const EcranProfil({super.key});

  @override
  Widget build(BuildContext context) {
    final couleurs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: couleurs.primaryContainer,
              foregroundColor: couleurs.onPrimaryContainer,
              child: const Icon(Icons.person, size: 40),
            ),
            const SizedBox(height: 16),
            Text('Connexion en séance 7', style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
