import 'package:campusflow_models/campusflow_models.dart';

/// Données d'exemple de la séance 5. Elles seront remplacées par
/// l'état partagé (séance 6), puis par l'API (séance 7).
/// Les dates sont calculées à partir d'aujourd'hui pour que les badges
/// (« Demain », « En retard »…) aient toujours un sens.
List<Task> tachesExemple() {
  final aujourdhui = DateTime.now();
  DateTime jour(int decalage, int heure, [int minute = 0]) =>
      DateTime(aujourdhui.year, aujourdhui.month, aujourdhui.day + decalage, heure, minute);

  return [
    Task(
      id: '1',
      titre: 'Rendu TP Dart',
      echeance: jour(1, 23, 59),
      description: 'Package campusflow_models avec ses trois tests.',
      coursId: 'c1',
    ),
    Task(
      id: '2',
      titre: 'Exposé hallucinations des LLM',
      echeance: jour(2, 10),
      description: 'Préparer les diapositives et la démonstration.',
      coursId: 'c2',
    ),
    Task(id: '3', titre: 'Projet Spark', echeance: jour(-1, 18), coursId: 'c3'),
    Task(id: '4', titre: 'Examen UX', echeance: jour(6, 8), coursId: 'c1'),
    Task(
      id: '5',
      titre: 'Lire le chapitre 4',
      echeance: jour(-2, 8),
      terminee: true,
      coursId: 'c2',
    ),
  ];
}

const List<Course> coursExemple = [
  Course(id: 'c1', nom: 'Programmation mobile', enseignant: 'M. Compaoré', horaire: 'Lundi · 08:00'),
  Course(id: 'c2', nom: 'IA générative', horaire: 'Mardi · 08:00'),
  Course(id: 'c3', nom: 'Big Data Scala-Spark', horaire: 'Jeudi · 14:00'),
];

/// Nom du cours à partir de son identifiant (ou null si aucun cours).
String? nomDuCours(String? coursId) {
  for (final c in coursExemple) {
    if (c.id == coursId) return c.nom;
  }
  return null;
}
