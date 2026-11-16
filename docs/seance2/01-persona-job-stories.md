# Séance 2 · TP 1 — Persona et job stories

## Persona : Fatimata (persona fictif)

| | |
|---|---|
| **Identité** | Fatimata Ouédraogo, 23 ans, Master 1 Informatique à Ouagadougou |
| **Appareil** | Smartphone Android d'entrée de gamme (Android 13, 4 Go de RAM, 64 Go de stockage presque plein), écran de 6,5 pouces. Utilisé surtout **d'une main**, dans le bus ou à moto-taxi. |
| **Connexion** | Forfait data de 2 Go par semaine, souvent épuisé avant la fin. Wi-Fi seulement à l'université, et instable. Coupures d'électricité fréquentes : elle économise sa batterie. |
| **Contexte** | 6 cours par semestre, 2 projets en binôme, un travail à temps partiel le soir. Les consignes arrivent par trois canaux : plateforme de l'université, groupe WhatsApp de la promo, e-mail des enseignants. |
| **Frustrations** | Les dates sont dispersées et noyées dans les messages WhatsApp. Elle a déjà découvert un rendu la veille au soir. Les applications d'agenda génériques sont en anglais, lourdes, et demandent une connexion permanente. |
| **Objectifs** | Ne plus rater un rendu, voir d'un coup d'œil ce qui est dû cette semaine, et rester organisée même sans réseau. |
| **Citation** | « Les dates, je les ai, mais elles sont partout sauf là où je regarde. » |

## Job stories

Modèle : **Quand** [situation], **je veux** [action], **pour** [résultat].

1. **Quand** un enseignant annonce un rendu dans le groupe WhatsApp de la promo, **je veux** l'enregistrer en moins de trois appuis avec son cours et sa date, **pour** ne pas avoir à fouiller les messages plus tard.

2. **Quand** j'ouvre mon téléphone le matin, même sans connexion, **je veux** voir les échéances de la semaine triées par urgence, avec celles en retard bien visibles, **pour** décider à quoi consacrer ma journée.

## Ce que cela implique pour la conception

| Constat sur le persona | Conséquence pour CampusFlow |
|---|---|
| Usage à une main, en déplacement | Navigation par barre inférieure, bouton « + » (FAB) à portée du pouce, cibles d'au moins 48 dp |
| Data limitée, réseau instable | Liste lisible hors ligne (cache), peu d'images |
| Stockage plein, téléphone modeste | Application légère, pas d'animations lourdes |
| Consignes reçues sur plusieurs canaux | Saisie rapide : seuls le titre et la date sont obligatoires |
| Rendus découverts trop tard | Filtre « En retard » et rappels avant l'échéance |
