# Symfony API basique avec API-PLatform



## Créer un projet Symfony

Dans un terminal, placez vous dans votre répertoire de travail et saisissez la commande :

```
composer create-project symfony/skeleton my_project_name
```

Ceci créera un projet Symfony vide dans le répertoire my_project_name


Toujours dans le terminal, placez vous dans le répertoire de l'application Symfony :

```
cd my_project_name
```

Toutes les commandes suivantes doivent être saisies dans ce répertoire.


## Ajouter les dépendances 
```
composer require symfony/string
composer require symfony/maker-bundle --dev
composer require symfony/api       
composer require symfony/migrations 
```

## Lancer / Arrêter le serveur PHP interne 

Le point d'entrée de l'application Symfony est le fichier public/index.php

Pour démarrer le serveur web interne de PHP directement dans public :

```
php -S localhost:3000 -t public
```

Rendez-vous sur http://localhost:3000/api/

Pour arrêter le serveur : 

> CTRL+C (Dans le terminal)

## Créer une nouvelle entité 

Une entité = représentation objet d'un élément en base de données.

```
php bin/console make:entity 
```

Répondez "Oui" à la question "is Api Resource ?" puis créez les différents champs

Une fois terminé, observez le répertoire src/Entity, votre entité a été généré.

## Configuration de la base de données 
Dans le fichier .env, décommentez la chaine de connexion adaptée à votre serveur de base de données.

> DATABASE_URL="mysql://root:root@127.0.0.1:3306/symfony_api?serverVersion=5.7"

## Créer la base de données 

```
php bin/console doctrine:database:create
```
Ceci créera la base de données définie dans la chaine de connexion du fichier .env.

Si vous souhaitez supprimer la base de données :
> php bin/console doctrine:database:drop --force


## Migrations

Pour générer le fichier de migration: 
> php bin/console make:migration
Ceci gènère un fichier qui permettra de mettre à jour la base de données (création, mise à jour des tables)

Puis appliquer la migration 
> php bin/console doctrine:migrations:migrate
Ceci applique les modifications dans la base de données (les requêtes SQL sont exécutées)


Pour supprimer toutes les migrations :
> 
php bin/console doctrine:migrations:version --all --delete

## Vider le cache 
> php bin/console cache:clear

Relancer le serveur et rendez-vous sur localhost:3000/api.



## config/packages/api-platform
Ajouter un titre, une description et une version à votre API :

Dans le fichier config/packages/api-platformSous l'élement api_platform: 

    api_platform:
        title: 'MD REST API'
        description: 'Intro API'
        version: '1.0.0'




# Quelques liens :
https://api-platform.com/
https://www.kaherecode.com/tutorial/developper-une-api-rest-avec-symfony-et-api-platform