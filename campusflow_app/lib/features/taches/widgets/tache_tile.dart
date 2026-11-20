import 'package:campusflow_models/campusflow_models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../donnees_exemple.dart';
import 'badge_echeance.dart';

/// Une ligne de la liste des échéances (composant « carte de tâche »
/// du design system).
class TacheTile extends StatelessWidget {
  const TacheTile({
    super.key,
    required this.tache,
    required this.onTap,
    required this.onCocher,
    this.selectionnee = false,
  });

  final Task tache;
  final VoidCallback onTap;
  final ValueChanged<bool> onCocher;
  final bool selectionnee; // vrai en mode tablette pour la tâche affichée

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cours = nomDuCours(tache.coursId);
    final date = DateFormat("EEE d MMM · HH:mm", 'fr_FR').format(tache.echeance);

    return Card(
      color: selectionnee ? theme.colorScheme.primaryContainer : null,
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 4, right: 12),
        leading: Checkbox(
          value: tache.terminee,
          onChanged: (valeur) => onCocher(valeur ?? false),
        ),
        title: Text(
          tache.titre,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleMedium?.copyWith(
            decoration: tache.terminee ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          cours == null ? date : '$cours · $date',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: BadgeEcheance(tache: tache),
        onTap: onTap,
      ),
    );
  }
}
