import 'json_utils.dart';

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

  /// JSON → objet. Lève une [FormatException] si un champ obligatoire
  /// manque ou a un mauvais type.
  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: lireId(json),
        titre: lireTexte(json, 'titre'),
        echeance: lireDate(json, 'echeance'),
        terminee: lireBooleen(json, 'terminee'),
        description: lireTexteFacultatif(json, 'description'),
        coursId: lireTexteFacultatif(json, 'coursId'),
      );

  /// Objet → JSON (servira pour POST et PATCH en séance 7).
  Map<String, dynamic> toJson() => {
        'id': id,
        'titre': titre,
        'echeance': echeance.toIso8601String(),
        'terminee': terminee,
        'description': description,
        'coursId': coursId,
      };

  @override
  String toString() =>
      'Task($id, « $titre », ${echeance.toIso8601String()}, '
      '${terminee ? 'faite' : 'à faire'})';
}
