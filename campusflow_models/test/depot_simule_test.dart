import 'package:campusflow_models/campusflow_models.dart';
import 'package:test/test.dart';

/// Tests complémentaires : Course, User, règle « en retard » et Future.
void main() {
  const depotRapide = DepotSimule(latence: Duration.zero);

  test('le dépôt simulé renvoie les tâches après l\'attente', () async {
    final taches = await depotRapide.chargerTaches();
    expect(taches, hasLength(4));
    expect(taches.first.titre, 'Rendu TP Dart');
  });

  test('le dépôt en échec lève une DepotException', () async {
    const depot = DepotSimule(latence: Duration.zero, echec: true);
    await expectLater(depot.chargerTaches(), throwsA(isA<DepotException>()));
  });

  test('Course.fromJson et User.fromJson', () async {
    final cours = await depotRapide.chargerCours();
    final utilisateur = await depotRapide.chargerUtilisateur();
    expect(cours.first.nom, 'Programmation mobile');
    expect(cours[1].enseignant, isNull);
    expect(utilisateur.email, contains('@'));
  });

  test('une tâche non faite dont l\'échéance est passée est en retard', () {
    final maintenant = DateTime(2026, 11, 16);
    final tache = Task(id: '1', titre: 'TP', echeance: DateTime(2026, 11, 15));
    expect(tache.estEnRetard(maintenant), isTrue);
    expect(tache.copyWith(terminee: true).estEnRetard(maintenant), isFalse);
  });
}
