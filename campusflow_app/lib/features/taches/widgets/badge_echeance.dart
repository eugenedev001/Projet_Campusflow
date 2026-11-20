import 'package:campusflow_models/campusflow_models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';

/// Badge d'état d'une tâche : « Faite », « En retard », « Demain »…
/// Le statut est écrit en toutes lettres (pas seulement une couleur).
class BadgeEcheance extends StatelessWidget {
  const BadgeEcheance({super.key, required this.tache});

  final Task tache;

  @override
  Widget build(BuildContext context) {
    final couleurs = Theme.of(context).colorScheme;
    final statut = Theme.of(context).extension<StatutColors>();
    final maintenant = DateTime.now();

    final String texte;
    final Color fond;
    final Color encre;

    if (tache.terminee) {
      texte = 'Faite';
      fond = statut?.succes ?? couleurs.primary;
      encre = statut?.onSucces ?? couleurs.onPrimary;
    } else if (tache.estEnRetard(maintenant)) {
      texte = 'En retard';
      fond = couleurs.error;
      encre = couleurs.onError;
    } else {
      final jours = DateUtils.dateOnly(tache.echeance)
          .difference(DateUtils.dateOnly(maintenant))
          .inDays;
      if (jours <= 1) {
        texte = jours == 0 ? "Aujourd'hui" : 'Demain';
        fond = statut?.alerte ?? couleurs.secondaryContainer;
        encre = statut?.onAlerte ?? couleurs.onSecondaryContainer;
      } else {
        texte = DateFormat('d MMM', 'fr_FR').format(tache.echeance);
        fond = couleurs.primaryContainer;
        encre = couleurs.onPrimaryContainer;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: fond, borderRadius: BorderRadius.circular(12)),
      child: Text(
        texte,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: encre),
      ),
    );
  }
}
