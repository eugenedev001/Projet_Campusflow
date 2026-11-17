import 'json_utils.dart';

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

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: lireId(json),
        nom: lireTexte(json, 'nom'),
        email: lireTexte(json, 'email'),
        filiere: lireTexteFacultatif(json, 'filiere'),
      );

  /// Le mot de passe n'est jamais stocké dans le modèle.
  Map<String, dynamic> toJson() => {
        'id': id,
        'nom': nom,
        'email': email,
        'filiere': filiere,
      };

  @override
  String toString() => 'User($id, $nom, $email)';
}
