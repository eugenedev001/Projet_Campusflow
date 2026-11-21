import 'package:campusflow_models/campusflow_models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/router/app_router.dart';
import 'donnees_exemple.dart';
import 'widgets/badge_echeance.dart';

/// Écran Détail (téléphone), à l'adresse /taches/:id.
///
/// TP 2 : la tâche est retrouvée par son :id dans les données d'exemple.
/// Le bouton ne peut pas encore prévenir la liste : c'est exactement
/// le problème que l'état partagé (TP 3) va résoudre.
class EcranDetail extends StatelessWidget {
  const EcranDetail({super.key, required this.id});

  final String id; // paramètre :id de l'adresse

  @override
  Widget build(BuildContext context) {
    final tache = tachesExemple().where((t) => t.id == id).firstOrNull;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail'),
        leading: BackButton(onPressed: () => retourOuListe(context)),
      ),
      body: tache == null
          ? Center(child: Text('Tâche « $id » introuvable'))
          : DetailTache(
              tache: tache,
              onMarquerFait: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Branché sur l\'état partagé au TP 3')),
              ),
            ),
    );
  }
}

/// Contenu du détail, réutilisé tel quel dans la colonne de droite
/// de la version tablette (≥ 840 dp).
class DetailTache extends StatelessWidget {
  const DetailTache({super.key, required this.tache, required this.onMarquerFait});

  final Task tache;
  final VoidCallback onMarquerFait;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textes = theme.textTheme;
    final couleurs = theme.colorScheme;
    final cours = nomDuCours(tache.coursId);
    final echeance = DateFormat("EEEE d MMMM 'à' HH:mm", 'fr_FR').format(tache.echeance);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (cours != null)
                        Expanded(
                          child: Text(
                            cours.toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            style: textes.labelSmall?.copyWith(color: couleurs.primary),
                          ),
                        )
                      else
                        const Spacer(),
                      BadgeEcheance(tache: tache),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(tache.titre, style: textes.titleLarge),
                  const SizedBox(height: 16),
                  _Ligne(icone: Icons.event, texte: 'Échéance : $echeance'),
                  _Ligne(
                    icone: tache.terminee ? Icons.check_circle : Icons.radio_button_unchecked,
                    texte: 'Statut : ${tache.terminee ? 'faite' : 'à faire'}',
                  ),
                  const Divider(height: 32),
                  Text('Description', style: textes.titleMedium),
                  const SizedBox(height: 8),
                  Text(
                    tache.description ?? 'Aucune description.',
                    style: textes.bodyLarge?.copyWith(color: couleurs.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            // null = bouton désactivé quand la tâche est déjà faite
            onPressed: tache.terminee ? null : onMarquerFait,
            icon: const Icon(Icons.check),
            label: Text(tache.terminee ? 'Déjà faite' : 'Marquer comme fait'),
          ),
        ],
      ),
    );
  }
}

class _Ligne extends StatelessWidget {
  const _Ligne({required this.icone, required this.texte});

  final IconData icone;
  final String texte;

  @override
  Widget build(BuildContext context) {
    final couleurs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icone, size: 20, color: couleurs.onSurfaceVariant),
          const SizedBox(width: 12),
          // Expanded : sans lui, un texte long provoque « RenderFlex overflowed ».
          Expanded(child: Text(texte, style: Theme.of(context).textTheme.bodyLarge)),
        ],
      ),
    );
  }
}
