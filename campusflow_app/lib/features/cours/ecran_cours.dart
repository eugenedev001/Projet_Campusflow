import 'package:flutter/material.dart';

import '../taches/donnees_exemple.dart';

/// Écran Cours (wireframe n° 5) : la liste des cours de l'étudiant.
class EcranCours extends StatelessWidget {
  const EcranCours({super.key});

  @override
  Widget build(BuildContext context) {
    final couleurs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Mes cours')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: coursExemple.length,
        itemBuilder: (context, i) {
          final c = coursExemple[i];
          final details = [c.enseignant, c.horaire].whereType<String>().join(' · ');
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: couleurs.primaryContainer,
                  foregroundColor: couleurs.onPrimaryContainer,
                  child: const Icon(Icons.school),
                ),
                title: Text(c.nom),
                subtitle: details.isEmpty ? null : Text(details),
              ),
            ),
          );
        },
      ),
    );
  }
}
