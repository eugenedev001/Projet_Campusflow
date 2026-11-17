/// Petites fonctions de lecture sûre d'un document JSON.
///
/// Elles lèvent une [FormatException] claire au lieu d'un plantage
/// « Null is not a subtype of String » quand un champ manque.
library;

/// Lit l'identifiant. json-server peut renvoyer un nombre ou un texte :
/// on le convertit toujours en `String`.
String lireId(Map<String, dynamic> json) {
  final id = json['id'];
  if (id == null) {
    throw FormatException('Champ « id » manquant', json);
  }
  return id.toString();
}

/// Lit un texte obligatoire et non vide.
String lireTexte(Map<String, dynamic> json, String cle) {
  final valeur = json[cle];
  if (valeur is! String || valeur.trim().isEmpty) {
    throw FormatException('Champ « $cle » manquant ou vide', json);
  }
  return valeur;
}

/// Lit un texte facultatif (peut être absent ou null).
String? lireTexteFacultatif(Map<String, dynamic> json, String cle) {
  final valeur = json[cle];
  if (valeur == null) return null;
  if (valeur is! String) {
    throw FormatException('Champ « $cle » : texte attendu', json);
  }
  return valeur;
}

/// Lit une date au format ISO 8601 (ex. « 2026-11-22T23:59:00 »).
DateTime lireDate(Map<String, dynamic> json, String cle) {
  final valeur = json[cle];
  final date = valeur is String ? DateTime.tryParse(valeur) : null;
  if (date == null) {
    throw FormatException('Champ « $cle » : date ISO 8601 attendue', json);
  }
  return date;
}

/// Lit un booléen facultatif, avec une valeur par défaut.
bool lireBooleen(Map<String, dynamic> json, String cle, {bool parDefaut = false}) {
  final valeur = json[cle];
  if (valeur == null) return parDefaut;
  if (valeur is! bool) {
    throw FormatException('Champ « $cle » : booléen attendu', json);
  }
  return valeur;
}
