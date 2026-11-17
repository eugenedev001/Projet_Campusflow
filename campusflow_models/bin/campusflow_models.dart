import 'package:campusflow_models/campusflow_models.dart';

/// Démonstration : `dart run` depuis le dossier campusflow_models.
Future<void> main() async {
  // 1. Chargement réussi : async / await sans bloquer.
  print('Chargement des tâches…');
  try {
    final taches = await const DepotSimule().chargerTaches();
    print('${taches.length} tâche(s) reçue(s) :');
    for (final t in taches) {
      final retard = t.estEnRetard() ? '  ⚠ en retard' : '';
      print('  - $t$retard');
    }

    // Immuabilité : cocher une tâche = créer une copie.
    final premiere = taches.first;
    final cochee = premiere.copyWith(terminee: true);
    print('Original : ${premiere.terminee} · Copie : ${cochee.terminee}');
  } on DepotException catch (e) {
    print('Erreur : ${e.message}');
  } finally {
    print('Fin du chargement\n');
  }

  // 2. Chargement en échec : l'erreur est interceptée, pas de plantage.
  print('Chargement avec serveur en panne…');
  try {
    await const DepotSimule(echec: true).chargerTaches();
  } on DepotException catch (e) {
    print('Erreur interceptée : ${e.message}');
  } finally {
    print('Fin du chargement');
  }
}
