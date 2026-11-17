/// Un cours suivi par l'étudiant.
class Course {
  final String id;
  final String nom;
  final String? enseignant;
  final String? horaire; // ex. « Mardi · 08:00 »

  const Course({
    required this.id,
    required this.nom,
    this.enseignant,
    this.horaire,
  });

  Course copyWith({String? nom, String? enseignant, String? horaire}) => Course(
        id: id,
        nom: nom ?? this.nom,
        enseignant: enseignant ?? this.enseignant,
        horaire: horaire ?? this.horaire,
      );

  @override
  String toString() => 'Course($id, « $nom »)';
}
