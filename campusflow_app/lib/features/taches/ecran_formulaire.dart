import 'package:campusflow_models/campusflow_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/router/app_router.dart';
import 'donnees_exemple.dart';
import 'taches_provider.dart';

/// Écran « Nouvelle tâche », à l'adresse /taches/nouvelle.
/// La tâche créée est ajoutée dans l'état partagé.
class EcranFormulaire extends ConsumerStatefulWidget {
  const EcranFormulaire({super.key});

  @override
  ConsumerState<EcranFormulaire> createState() => _EcranFormulaireState();
}

class _EcranFormulaireState extends ConsumerState<EcranFormulaire> {
  final _formKey = GlobalKey<FormState>();
  final _titre = TextEditingController();
  final _description = TextEditingController();
  String? _coursId;
  late DateTime _echeance = _demainSoir();

  static DateTime _demainSoir() {
    final d = DateTime.now();
    return DateTime(d.year, d.month, d.day + 1, 23, 59);
  }

  @override
  void dispose() {
    _titre.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _choisirEcheance() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _echeance,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (date == null || !mounted) return;
    final heure = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_echeance),
    );
    if (!mounted) return;
    final h = heure ?? TimeOfDay.fromDateTime(_echeance);
    setState(() => _echeance = DateTime(date.year, date.month, date.day, h.hour, h.minute));
  }

  void _enregistrer() {
    final valide = _formKey.currentState?.validate() ?? false;
    if (!valide) return; // le validator affiche le message sous le champ

    final description = _description.text.trim();
    final tache = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      titre: _titre.text.trim(),
      echeance: _echeance,
      description: description.isEmpty ? null : description,
      coursId: _coursId,
    );

    // ref.read dans une action : on ajoute à l'état partagé.
    ref.read(tachesProvider.notifier).ajouter(tache);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tâche « ${tache.titre} » enregistrée')),
    );
    retourOuListe(context);
  }

  @override
  Widget build(BuildContext context) {
    final echeanceTexte = DateFormat("EEE d MMM y 'à' HH:mm", 'fr_FR').format(_echeance);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nouvelle tâche'),
        leading: CloseButton(onPressed: () => retourOuListe(context)),
      ),
      // SingleChildScrollView : le clavier ne bloque jamais le bouton.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titre,
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Titre *',
                  hintText: 'Ex. : Rendu TP Dart',
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Le titre est obligatoire' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String?>(
                value: _coursId,
                decoration: const InputDecoration(labelText: 'Cours'),
                items: [
                  const DropdownMenuItem<String?>(value: null, child: Text('Aucun cours')),
                  for (final c in coursExemple)
                    DropdownMenuItem<String?>(value: c.id, child: Text(c.nom)),
                ],
                onChanged: (v) => setState(() => _coursId = v),
              ),
              const SizedBox(height: 16),
              InputDecorator(
                decoration: const InputDecoration(labelText: 'Échéance'),
                child: InkWell(
                  onTap: _choisirEcheance,
                  child: Row(
                    children: [
                      const Icon(Icons.event, size: 20),
                      const SizedBox(width: 12),
                      Expanded(child: Text(echeanceTexte)),
                      const Icon(Icons.edit_calendar, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _description,
                minLines: 3,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(onPressed: _enregistrer, child: const Text('Enregistrer')),
            ],
          ),
        ),
      ),
    );
  }
}
