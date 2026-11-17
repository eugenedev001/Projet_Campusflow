import 'package:campusflow_models/campusflow_models.dart';
import 'package:test/test.dart';

void main() {
  final echeance = DateTime(2026, 11, 22, 23, 59);

  test('copyWith crée une copie modifiée sans changer l\'original', () {
    final original = Task(id: '1', titre: 'Rendu TP Dart', echeance: echeance);

    final copie = original.copyWith(terminee: true);

    expect(copie.terminee, isTrue);
    expect(copie.id, original.id);
    expect(copie.titre, original.titre);
    expect(copie.echeance, original.echeance);
    expect(original.terminee, isFalse); // l'original n'a pas bougé
  });

  test('fromJson construit une Task à partir d\'un document JSON', () {
    final json = <String, dynamic>{
      'id': 42, // json-server peut renvoyer un nombre
      'titre': 'Projet Flutter',
      'echeance': '2026-11-22T23:59:00',
      'terminee': true,
      'description': null,
      'coursId': 'c1',
    };

    final tache = Task.fromJson(json);

    expect(tache.id, '42');
    expect(tache.titre, 'Projet Flutter');
    expect(tache.echeance, echeance);
    expect(tache.terminee, isTrue);
    expect(tache.description, isNull);
    expect(tache.coursId, 'c1');
  });

  test('fromJson lève une FormatException si le titre manque', () {
    final json = <String, dynamic>{
      'id': 7,
      'echeance': '2026-11-22T23:59:00',
    };

    expect(() => Task.fromJson(json), throwsFormatException);
  });
}
