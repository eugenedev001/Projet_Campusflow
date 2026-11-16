# Séance 1 · TP 1 — Fiche comparative Android / iOS

**Cas réel étudié :** CampusFlow, une application étudiante (suivi des cours, des échéances et des tâches) destinée à l'Afrique francophone, avec le Burkina Faso comme premier marché.

## 1. Le marché dans ce contexte : de quoi parle-t-on ?

| Zone | Android | iOS | Mesure | Période | Source |
|---|---|---|---|---|---|
| Monde | 69,17 % | 30,81 % | Part des pages vues web, mobile | Sept. 2026 | StatCounter (chiffres du cours) |
| Afrique | 81,39 % | 18,57 % | Part des pages vues web, mobile | Août 2026 | StatCounter Global Stats |
| Burkina Faso | 90,59 % | 9,37 % | Part des pages vues web, mobile | Juin 2026 | StatCounter Global Stats |

**Lecture critique :**
- StatCounter mesure l'**usage web**, pas le parc installé ni les ventes. Un utilisateur iOS qui navigue beaucoup « pèse » plus qu'un utilisateur Android qui navigue peu. Les écarts réels en nombre d'appareils sont donc probablement **plus grands** encore en faveur d'Android dans nos pays.
- Il faut se méfier d'un chiffre isolé. Pour le Burkina, StatCounter attribue en juin 2026 environ 31 % des vues iOS à « iOS 11.0 », une version de 2017. Il s'agit très probablement d'un artefact de mesure (navigateur ou robot qui annonce une version figée), pas de vrais iPhone de 2017.
- **Conclusion pour CampusFlow :** au Burkina, environ 9 utilisateurs mobiles sur 10 sont sur Android. Sur le continent, la part d'iOS est plus élevée (≈ 19 %), et elle l'est davantage encore dans certains pays (≈ 24 % en Afrique du Sud, juin 2026). Si l'application sort du Burkina, iOS ne peut pas être ignoré.

## 2. Les 14 critères

| # | Critère | Android | iOS | Ce qui change pour CampusFlow en Afrique francophone |
|---|---|---|---|---|
| 1 | **Philosophie** | Open source (AOSP), multi-constructeurs | Fermé, matériel et logiciel intégrés | Le modèle ouvert explique la domination d'Android : beaucoup de constructeurs proposent des téléphones d'entrée de gamme, accessibles au budget d'un étudiant. iOS reste un marché de niche, plus aisé. |
| 2 | **Architecture** | Noyau Linux, ART, HAL, Framework | Darwin/XNU, Core OS → Cocoa Touch | Aucun impact direct pour l'utilisateur. Pour nous, cela veut dire deux piles techniques différentes si l'on développe en natif. |
| 3 | **Environnement** | Android Studio (Windows, macOS, Linux) | Xcode, **macOS uniquement** | Contrainte forte : la plupart des étudiants développeurs ont un PC Windows ou Linux. On développe et on teste Android tout de suite. iOS exige un Mac, rare et cher localement. |
| 4 | **Langage** | Kotlin (Java), Jetpack Compose | Swift, SwiftUI / UIKit | Deux langages à maîtriser en natif. Une petite équipe étudiante n'a pas les moyens de maintenir deux bases de code. |
| 5 | **Modèle d'application** | Activités, services ; paquet APK / AAB | Scènes et vues ; paquet IPA | L'APK peut circuler directement (partage, WhatsApp, Bluetooth). C'est un canal de diffusion réel chez nous, d'où l'intérêt de garder l'APK **léger**. |
| 6 | **Cycle de vie** | onCreate → onResume → onPause → onDestroy | Active → inactive → arrière-plan → suspendue | Sur les téléphones d'entrée de gamme, les surcouches constructeurs tuent agressivement les applications en arrière-plan pour économiser la batterie. Les rappels ne doivent donc **pas** dépendre d'un service qui tourne en continu : ils doivent passer par des notifications planifiées. L'état de l'écran (formulaire en cours) doit survivre à une mise en pause. |
| 7 | **Matériel** | Très nombreux constructeurs et gammes | Quelques modèles, un seul constructeur | Le téléphone type est un Android d'entrée ou de milieu de gamme : peu de RAM, peu de stockage, écrans de tailles variées. Selon la GSMA (2025), un appareil d'entrée de gamme coûte jusqu'à 87 % du revenu mensuel des 20 % les plus pauvres en Afrique subsaharienne. On conçoit donc pour un appareil **modeste**. |
| 8 | **Permissions** | Demandées à l'exécution, par permission ; notifications soumises à autorisation depuis Android 13 | Demandées à l'exécution, avec texte justificatif obligatoire | Le rappel d'échéance est au cœur du produit. Il faut demander la permission de notification au **bon moment** (à la création du premier rappel, pas au lancement), avec une explication en français. |
| 9 | **Stockage** | Bac à sable, stockage cloisonné, Keystore | Bac à sable, Keychain | Stockage limité sur les téléphones visés : cache local léger. Le jeton de connexion va dans le Keystore / Keychain (via `flutter_secure_storage`, séance 7), jamais en clair. |
| 10 | **Sécurité** | Signature, Play Protect, bac à sable | Signature, revue humaine, bac à sable | L'installation d'APK hors Play Store est courante, avec un risque d'APK modifiés. On signe l'application et on recommande le téléchargement depuis le Play Store. |
| 11 | **Distribution** | Google Play, autres magasins, installation directe | App Store (ouverture variable selon la région) | Google Play : inscription développeur unique et peu coûteuse. Apple : abonnement annuel plus un Mac. Pour une application étudiante gratuite, Google Play suffit au lancement. |
| 12 | **Fragmentation** | Forte : versions d'OS, constructeurs, tailles d'écran | Faible | Au Burkina (StatCounter, juin 2026), aucune version d'Android ne dépasse 18 % : la 13 mène (17,3 %), suivie des 14, 12, 15 et 11 (11 à 13 % chacune), et la 10 pèse encore 7 %. Il faut tester sur **plusieurs versions et tailles d'écran** et viser un `minSdk` assez bas. |
| 13 | **Mises à jour** | Dépendent du constructeur et de l'opérateur | Directes par Apple, sur les appareils compatibles | Les téléphones d'entrée de gamme reçoivent peu de mises à jour système. On ne peut pas compter sur les API récentes : il faut prévoir des solutions de repli. |
| 14 | **Contraintes développeur** | Tests sur de nombreux appareils | Mac obligatoire, revue App Store | Données mobiles chères et connexion instable : l'application doit rester **utilisable hors ligne** (consultation des échéances en cache) et consommer peu de données. Interface en **français**, dates au format local. |

## 3. Ce qui change, en résumé

1. **Android d'abord** : c'est là que sont les étudiants (≈ 90 % au Burkina).
2. **Concevoir pour un appareil modeste** : APK léger, peu de RAM, écrans variés.
3. **Concevoir pour une connexion fragile** : cache local, peu d'appels réseau.
4. **Ne pas fermer la porte à iOS** : sa part grimpe dès qu'on sort du Burkina.
