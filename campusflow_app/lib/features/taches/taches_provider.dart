import 'package:campusflow_models/campusflow_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'donnees_exemple.dart';

/// L'état partagé : LA liste des tâches, la même pour tous les écrans.
///
/// Règle n° 1 : l'état est immuable. On ne fait jamais `state.add(...)` :
/// on assigne une NOUVELLE liste à `state`, ce qui prévient les écrans.
class TachesNotifier extends Notifier<List<Task>> {
  @override
  List<Task> build() => tachesExemple(); // séance 7 : chargement depuis l'API

  void ajouter(Task tache) {
    state = [...state, tache];
  }

  void cocher(String id, bool faite) {
    state = [
      for (final t in state) t.id == id ? t.copyWith(terminee: faite) : t,
    ];
  }
}

final tachesProvider = NotifierProvider<TachesNotifier, List<Task>>(TachesNotifier.new);

/// Une tâche par son identifiant (null si elle n'existe pas).
/// Se recalcule tout seul quand la liste change.
final tacheParIdProvider = Provider.family<Task?, String>((ref, id) {
  for (final t in ref.watch(tachesProvider)) {
    if (t.id == id) return t;
  }
  return null;
});

// ---------------------------------------------------------------------------
// Filtres (TP 4)
// ---------------------------------------------------------------------------

enum FiltreTaches {
  aFaire('À faire'),
  faites('Faites'),
  enRetard('En retard');

  const FiltreTaches(this.libelle);
  final String libelle;
}

/// Le filtre choisi par l'utilisateur sur l'écran des échéances.
class FiltreNotifier extends Notifier<FiltreTaches> {
  @override
  FiltreTaches build() => FiltreTaches.aFaire;

  void choisir(FiltreTaches filtre) => state = filtre;
}

final filtreProvider = NotifierProvider<FiltreNotifier, FiltreTaches>(FiltreNotifier.new);

/// Fournisseur DÉRIVÉ : il ne stocke rien, il calcule les trois listes
/// à partir de tachesProvider. Une tâche cochée change de liste toute seule.
final tachesParFiltreProvider = Provider<Map<FiltreTaches, List<Task>>>((ref) {
  final maintenant = DateTime.now();
  final toutes = [...ref.watch(tachesProvider)]
    ..sort((a, b) => a.echeance.compareTo(b.echeance));

  return {
    FiltreTaches.aFaire: [
      for (final t in toutes)
        if (!t.terminee && !t.estEnRetard(maintenant)) t,
    ],
    FiltreTaches.faites: [
      for (final t in toutes)
        if (t.terminee) t,
    ],
    FiltreTaches.enRetard: [
      for (final t in toutes)
        if (t.estEnRetard(maintenant)) t,
    ],
  };
});

/// Les tâches à afficher : celles du filtre choisi.
final tachesVisiblesProvider = Provider<List<Task>>((ref) {
  final filtre = ref.watch(filtreProvider);
  return ref.watch(tachesParFiltreProvider)[filtre] ?? const [];
});
