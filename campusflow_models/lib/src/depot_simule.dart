import 'course.dart';
import 'task.dart';
import 'user.dart';

/// Erreur renvoyée par le dépôt (réseau coupé, serveur en panne…).
class DepotException implements Exception {
  final String message;
  const DepotException(this.message);

  @override
  String toString() => 'DepotException: $message';
}

/// Dépôt **simulé** : renvoie des données après une attente,
/// comme le ferait un vrai serveur, mais sans réseau.
///
/// - [latence] : durée de l'attente (Future.delayed).
/// - [echec] : si `true`, chaque appel échoue, pour tester try/catch.
class DepotSimule {
  final Duration latence;
  final bool echec;

  const DepotSimule({
    this.latence = const Duration(milliseconds: 800),
    this.echec = false,
  });

  Future<List<Task>> chargerTaches() async {
    await _attendre();
    return _tachesJson.map((j) => Task.fromJson(j)).toList();
  }

  Future<List<Course>> chargerCours() async {
    await _attendre();
    return _coursJson.map((j) => Course.fromJson(j)).toList();
  }

  Future<User> chargerUtilisateur() async {
    await _attendre();
    return User.fromJson(_utilisateurJson);
  }

  Future<void> _attendre() async {
    await Future.delayed(latence);
    if (echec) {
      throw const DepotException('Serveur injoignable (simulation)');
    }
  }
}

// Données au format JSON, comme elles arriveront de l'API en séance 7.
const List<Map<String, dynamic>> _tachesJson = [
  {
    'id': '1',
    'titre': 'Rendu TP Dart',
    'echeance': '2026-11-22T23:59:00',
    'terminee': false,
    'description': 'Package campusflow_models avec trois tests.',
    'coursId': 'c1',
  },
  {
    'id': '2',
    'titre': 'Exposé hallucinations des LLM',
    'echeance': '2026-11-18T10:00:00',
    'terminee': false,
    'description': null,
    'coursId': 'c2',
  },
  {
    'id': '3',
    'titre': 'Projet Spark',
    'echeance': '2026-11-14T18:00:00',
    'terminee': false,
    'coursId': 'c3',
  },
  {
    'id': '4',
    'titre': 'Lire le chapitre 4',
    'echeance': '2026-11-12T08:00:00',
    'terminee': true,
  },
];

const List<Map<String, dynamic>> _coursJson = [
  {'id': 'c1', 'nom': 'Programmation mobile', 'enseignant': 'M. Compaoré', 'horaire': 'Lundi · 08:00'},
  {'id': 'c2', 'nom': 'IA générative', 'horaire': 'Mardi · 08:00'},
  {'id': 'c3', 'nom': 'Big Data Scala-Spark', 'horaire': 'Jeudi · 14:00'},
];

const Map<String, dynamic> _utilisateurJson = {
  'id': 'u1',
  'nom': 'Fatimata Ouédraogo',
  'email': 'etudiant@campusflow.example',
  'filiere': 'Master IA',
};
