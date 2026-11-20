import 'package:campusflow_models/campusflow_models.dart';
import 'package:flutter/material.dart';

import 'donnees_exemple.dart';
import 'ecran_detail.dart';
import 'widgets/tache_tile.dart';

/// Écran Échéances : AppBar, ListView.builder de ListTile, bouton flottant.
/// (La NavigationBar est dans EcranPrincipal, partagée par les 3 onglets.)
class EcranEcheances extends StatefulWidget {
  const EcranEcheances({super.key});

  @override
  State<EcranEcheances> createState() => _EcranEcheancesState();
}

class _EcranEcheancesState extends State<EcranEcheances> {
  List<Task> _taches = tachesExemple();

  /// Remplace une tâche par sa nouvelle version.
  /// Immuable : on construit une NOUVELLE liste, on ne modifie pas l'ancienne.
  void _remplacer(Task nouvelle) {
    setState(() {
      _taches = [for (final t in _taches) t.id == nouvelle.id ? nouvelle : t];
    });
  }

  void _cocher(Task tache, bool faite) => _remplacer(tache.copyWith(terminee: faite));

  void _ouvrirFormulaire() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Le formulaire arrive au TP 3')),
    );
  }

  void _ouvrirDetail(Task tache) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EcranDetail(tache: tache, onMarquerFait: _remplacer),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Tri : la plus proche échéance en premier.
    final taches = [..._taches]..sort((a, b) => a.echeance.compareTo(b.echeance));

    return Scaffold(
      appBar: AppBar(title: const Text('Mes échéances')),
      floatingActionButton: FloatingActionButton(
        onPressed: _ouvrirFormulaire,
        tooltip: 'Nouvelle tâche',
        child: const Icon(Icons.add),
      ),
      body: _ListeTaches(
        taches: taches,
        onTap: _ouvrirDetail,
        onCocher: _cocher,
      ),
    );
  }
}

class _ListeTaches extends StatelessWidget {
  const _ListeTaches({
    required this.taches,
    required this.onTap,
    required this.onCocher,
  });

  final List<Task> taches;
  final ValueChanged<Task> onTap;
  final void Function(Task, bool) onCocher;

  @override
  Widget build(BuildContext context) {
    if (taches.isEmpty) {
      return const Center(child: Text('Aucune tâche. Appuie sur + pour en ajouter une.'));
    }
    return ListView.builder(
      // marge du bas : le bouton flottant ne cache pas la dernière ligne
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
      itemCount: taches.length,
      itemBuilder: (context, i) {
        final t = taches[i];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: TacheTile(
            tache: t,
            onTap: () => onTap(t),
            onCocher: (faite) => onCocher(t, faite),
          ),
        );
      },
    );
  }
}
