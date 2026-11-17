/// Une tâche (rendu, examen, lecture…) liée à un cours.
///
/// Objet **immuable** : tous les attributs sont `final`.
/// Pour « modifier » une tâche, on en crée une copie avec [copyWith].
class Task {
  final String id;
  final String titre;
  final DateTime echeance;
  final bool terminee;
  final String? description; // facultative : peut être null
  final String? coursId; // facultatif : tâche sans cours

  const Task({
    required this.id,
    required this.titre,
    required this.echeance,
    this.terminee = false,
    this.description,
    this.coursId,
  });

  /// Règle métier : une tâche est en retard si elle n'est pas faite
  /// et que son échéance est passée. [maintenant] sert aux tests.
  bool estEnRetard([DateTime? maintenant]) =>
      !terminee && echeance.isBefore(maintenant ?? DateTime.now());

  /// Copie avec un ou plusieurs champs modifiés. L'original ne change pas.
  Task copyWith({
    String? titre,
    DateTime? echeance,
    bool? terminee,
    String? description,
    String? coursId,
  }) =>
      Task(
        id: id,
        titre: titre ?? this.titre,
        echeance: echeance ?? this.echeance,
        terminee: terminee ?? this.terminee,
        description: description ?? this.description,
        coursId: coursId ?? this.coursId,
      );

  @override
  String toString() =>
      'Task($id, « $titre », ${echeance.toIso8601String()}, '
      '${terminee ? 'faite' : 'à faire'})';
}
