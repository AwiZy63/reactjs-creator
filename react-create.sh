#!/bin/bash

# Vérification du nom du projet

if [[ ! $1 ]]; then
    echo "Veuillez renseigner un nom pour votre projet."
elif [[ $2 ]]; then
    echo "Veuillez renseigner un nom de projet valide."
else
    project_name="${1,,}"
    echo "Le nom du projet est : " $project_name
fi

if [[ ! $project_name ]]; then
    exit
fi

# Vérification des dépendances

if [[ $(which nodejs) && $(which npm) ]]; then
    echo -e "Les dépendances sont déjà installées."
else 
    sudo apt-get install nodejs npm -y
fi

# Création du projet :

clear
echo -e "Votre projet React sera installé dans $HOME/projects/react/$project_name."
echo
read -p "Voulez vous créer votre projet ? [o/N] " confirm_project
case $confirm_project in
    [oO]|[yY]|[oO][uU][iI]|[yY][eE][sS])
        echo "Le projet sera créera dans quelques instants.."
        project_location=$HOME/projects/react/$project_name
    ;;
    *)
        echo "Annulation.."
        exit
    ;;
esac


mkdir -p $HOME/projects/react

cd $HOME/projects/react

npx create-react-app $project_name

# Suppression des fichiers innutiles

cd $project_location

rm ./src/logo.svg ./src/App.css ./src/App.test.js && touch ./src/App.css

echo -e "import './App.css';

function App() {
  return (
    <div className=\"App\">

    </div>
  );
}

export default App;" > ./src/App.js

echo -e "<!DOCTYPE html>
<html lang=\"en\">
  <head>
    <meta charset=\"utf-8\" />
    <link rel=\"icon\" href=\"%PUBLIC_URL%/favicon.ico\" />
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />
    <meta name=\"theme-color\" content=\"#000000\" />
    <meta
      name=\"description\"
      content=\"Vous retrouverez ici la description du projet react.\"
    />
    <link rel="apple-touch-icon\" href="%PUBLIC_URL%/logo192.png\" />
    <link rel="manifest" href=\"%PUBLIC_URL%/manifest.json\" />
    <title>Application sans nom</title>
  </head>
  <body>
    <noscript>You need to enable JavaScript to run this app.</noscript>
    <div id=\"root\"></div>
  </body>
</html>" > ./public/index.html

clear

echo -e "==================================="
echo -e "Votre projet est prêt à être lancé :"
echo -e "Vous avez juste à copier cette commande : "
echo -e "cd $project_location && npm start"
echo -e "==================================="