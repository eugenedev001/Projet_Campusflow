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
