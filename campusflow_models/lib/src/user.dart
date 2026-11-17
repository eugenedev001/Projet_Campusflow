/// L'étudiant connecté.
class User {
  final String id;
  final String nom;
  final String email;
  final String? filiere; // ex. « Master 1 IA »

  const User({
    required this.id,
    required this.nom,
    required this.email,
    this.filiere,
  });

  User copyWith({String? nom, String? email, String? filiere}) => User(
        id: id,
        nom: nom ?? this.nom,
        email: email ?? this.email,
        filiere: filiere ?? this.filiere,
      );

  @override
  String toString() => 'User($id, $nom, $email)';
}
