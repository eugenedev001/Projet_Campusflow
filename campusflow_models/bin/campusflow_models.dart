import 'package:campusflow_models/campusflow_models.dart';

/// Démonstration : `dart run` depuis le dossier campusflow_models.
void main() {
  final cours = Course(id: 'c1', nom: 'Programmation mobile', enseignant: 'M. Compaoré');
  final tache = Task(
    id: '1',
    titre: 'Rendu TP Dart',
    echeance: DateTime(2026, 11, 22, 23, 59),
    coursId: cours.id,
  );
  final moi = User(id: 'u1', nom: 'Fatimata Ouédraogo', email: 'etudiant@campusflow.example');

  print(moi);
  print(cours);
  print(tache);

  // Immuabilité : « cocher » une tâche = créer une copie.
  final cochee = tache.copyWith(terminee: true);
  print('Original : ${tache.terminee} · Copie : ${cochee.terminee}');
}
