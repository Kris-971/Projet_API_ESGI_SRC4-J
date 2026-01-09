#!/bin/bash

API_URL="https://dev.to/api"

# Fonction pour demander ET VÉRIFIER la clé API
ask_token() {
    while true; do
        echo "------------------------------------------------"
        echo "AUTHENTIFICATION REQUISE"
        echo "Veuillez entrer votre Clé API Dev.to (api-key) :"
        
        read -s TOKEN
        
        
        if [ -z "$TOKEN" ]; then
            echo "Erreur : Vous n'avez rien entré."
            continue
        fi

        echo ""
        echo "Vérification de la clé auprès de Dev.to..."

        # (Test de connexion)
        # On tente de lire les articles publiés (besoin d'auth)
        HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" -H "api-key: $TOKEN" "${API_URL}/articles/me/published")

        if [ "$HTTP_CODE" == "200" ]; then
            echo "Clé VALIDE ! Connexion établie."
            echo "------------------------------------------------"
            break #
        else
            echo "ERREUR : Cette clé n'est pas valide (Code $HTTP_CODE)."
            echo "Vérifiez que vous avez bien tout copié."
            echo "------------------------------------------------"
            
        fi
    done
}


get_articles() {
    echo "Récupération des articles publics..."
    curl -s -H "Accept: application/json" "${API_URL}/articles" | jq .
}


get_single_article() {
    echo "Entrez l'ID de l'article à lire :"
    read id
    echo "Recherche de l'article $id..."
    curl -s -H "Accept: application/json" "${API_URL}/articles/${id}" | jq .
}


publish_article() {
    echo "--- CRÉATION D'UN ARTICLE ---"
    echo "Entrez le titre de l'article :"
    read title
    echo "Entrez le contenu (Markdown) :"
    read body

    json_data="{\"article\":{\"title\":\"$title\",\"body_markdown\":\"$body\",\"published\":false,\"tags\":[\"test\",\"bash\"]}}"

    echo "Envoi en cours..."
    curl -s -X POST "${API_URL}/articles" \
        -H "api-key: $TOKEN" \
        -H "Content-Type: application/json" \
        -H "Accept: application/json" \
        -d "$json_data" | jq .
    
    echo ""
    echo "IMPORTANT : Notez l'ID qui s'affiche ci-dessus dans le JSON (champ 'id') !"
}


update_article() {
    echo "Entrez l'ID de l'article à modifier :"
    read id
    echo "Entrez le NOUVEAU titre :"
    read new_title
    
    echo "Voulez-vous publier cet article maintenant ? (oui/non)"
    read publish_choice
    
    is_published="false"
    if [ "$publish_choice" == "oui" ]; then
        is_published="true"
    fi

    json_data="{\"article\":{\"title\":\"$new_title\",\"published\":$is_published}}"

    curl -s -X PUT "${API_URL}/articles/${id}" \
        -H "api-key: $TOKEN" \
        -H "Content-Type: application/json" \
        -H "Accept: application/json" \
        -d "$json_data" | jq .
}


get_tags() {
    echo "Récupération des tags..."
    curl -s -H "Accept: application/json" "${API_URL}/tags" | jq .
}


get_comments() {
    echo "Entrez l'ID de l'article pour voir les commentaires :"
    read id
    curl -s -H "Accept: application/json" "${API_URL}/comments?a_id=${id}" | jq .
}


my_published_articles() {
    echo "Récupération de vos articles PUBLIÉS..."
    curl -s -H "Accept: application/json" \
        -H "api-key: $TOKEN" \
        "${API_URL}/articles/me/published" | jq .
}


my_unpublished_articles() {
    echo "Récupération de vos articles BROUILLONS (Unpublished)..."
    curl -s -H "Accept: application/json" \
        -H "api-key: $TOKEN" \
        "${API_URL}/articles/me/unpublished" | jq .
}

# --- MENU INTERACTIF ---
# On lance la sécurisation dès le début
ask_token

while true; do
    echo ""
    echo "========================================="
    echo "      MENU PROJET ADMIN SYS (BASH)       "
    echo "========================================="
    echo "1. get_articles (Public)"
    echo "2. publish_article (Créer brouillon)"
    echo "3. update_article (Modifier/Publier)"
    echo "4. get_tags"
    echo "5. get_comments"
    echo "6. get_single_article (Lire un publié)"
    echo "7. my_published_articles"
    echo "8. my_unpublished_articles"
    echo "q. Quitter"
    echo "========================================="
    echo -n "Votre choix : "
    read choice

    case $choice in
        1) get_articles ;;
        2) publish_article ;;
        3) update_article ;;
        4) get_tags ;;
        5) get_comments ;;
        6) get_single_article ;;
        7) my_published_articles ;;
        8) my_unpublished_articles ;;
        q) echo "Au revoir !"; exit 0 ;;
        *) echo "Choix invalide." ;;
    esac
    
    echo ""
    echo "Appuyez sur Entrée pour continuer..."
    read
done