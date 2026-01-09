# CLI Dev.to - Script de Gestion d'Articles (Bash)

Ce projet est un outil en ligne de commande (CLI) écrit en Bash. Il permet d'interagir avec l'API de la plateforme Dev.to pour gérer des articles, consulter des tags et lire des commentaires directement depuis le terminal.

Le script est interactif et sécurisé : il ne stocke aucune donnée sensible sur le disque.

## Pré-requis

Pour utiliser ce script, votre environnement doit disposer des outils suivants :

1.  **Bash** : Un terminal Bash (Git Bash sur Windows, ou terminal standard sur Linux/macOS).
2.  **cURL** : Pour effectuer les requêtes HTTP vers l'API.
3.  **jq** : Pour formater et colorer les réponses JSON.
4.  **Clé API Dev.to** : Une clé valide générée depuis les paramètres de votre compte Dev.to (section Extensions).

## Installation

1.  Téléchargez le fichier `Projet_api.sh`.
2.  Ouvrez votre terminal.
3.  Rendez le script exécutable avec la commande suivante :

    chmod +x Projet_api.sh

## Utilisation

Lancez le script depuis votre terminal :

    ./Projet_api.sh

Ou si vous êtes sur Git Bash :

    bash Projet_api.sh

### Authentification
Au démarrage, le script vous demandera de saisir votre clé API (api-key).
* Pour des raisons de sécurité, la saisie est masquée (rien ne s'affiche à l'écran).
* Le script vérifie immédiatement la validité de la clé auprès de Dev.to.
* Si la clé est valide, le menu principal s'ouvre.
* La clé est stockée uniquement dans la mémoire temporaire (RAM) et est effacée dès la fermeture du script.

## Fonctionnalités

Le menu interactif propose les 8 fonctions suivantes :

1.  **get_articles** : Récupère et affiche la liste des articles publics récents sur Dev.to.
2.  **publish_article** : Crée un nouvel article en mode "Brouillon" (Draft). Vous devrez fournir un titre et le contenu au format Markdown. Le script retourne l'ID de l'article créé.
3.  **update_article** : Permet de modifier le titre d'un article existant via son ID et de changer son statut (Brouillon vers Publié).
4.  **get_tags** : Affiche la liste des tags (mots-clés) populaires de la plateforme.
5.  **get_comments** : Récupère les commentaires associés à un article spécifique via son ID.
6.  **get_single_article** : Affiche les détails complets d'un article publié via son ID.
7.  **my_published_articles** : Affiche uniquement la liste de vos propres articles qui sont publics.
8.  **my_unpublished_articles** : Affiche uniquement la liste de vos propres articles qui sont encore à l'état de brouillon.

## Structure des données

Toutes les réponses de l'API sont retournées au format JSON et traitées par l'outil `jq` pour assurer une lisibilité optimale dans le terminal.

## Avertissement

Ce script est fourni à des fins éducatives. Assurez-vous de ne jamais partager votre clé API ou de l'écrire en clair dans le code source.
