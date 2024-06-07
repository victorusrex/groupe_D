
# Projet Mobile 2024 - Groupe D

Dans le cadre de la ressource R4-11A du semestre 4, nous avons réalisé un projet Flutter portant sur le thème de la Formule 1.

Nous avons fait ce choix afin de nous démarquer des autres groupes et surtout parce que cette idée plaisait à l'ensemble du groupe.

Pour obtenir un maximum de données, nous avons pu utiliser l'API open source appelée "Open F1" qui recense tous les pilotes, les circuits et les courses.



## Fonctionnalités de l'application 

L'application **F1 Pulse** vous propose une immersion totale dans le monde de la formule 1 qui devient de plus en plus populaire. Elle se divise en 3 pages distinctes : 

- La page **Accueil :**  C'est celle que l'utilisateur voit en premier et comporte un bouton fonctionnel qui permet d'accéder à l'application 

- La page **Drivers :** Elle sert de trombinoscope des pilotes et dès que l'utilisateur clique sur un pilote, il obtient toutes les informations complémentaires de celui ci

- La page **Calendrier :** Cette dernière page permet d'afficher la liste des différents circuits 

En plus de la possibilité de voir les données, l'utilisateur peut intégrer ses propres données dans l'application. Par contre, quand ce derniere la quitte, les données sont effacés
## Réfénrence de l'API



```http
  GET https://openf1.org/
```


### Drivers

```http
  GET https://api.openf1.org/v1/drivers
```
| Parameter       | Type     | Description                                                      |
| :-------------- | :------- | :--------------------------------------------------------------- |
| `broadcast_name` | `string` | The driver's name, as displayed on TV.                           |
| `country_code`   | `string` | A code that uniquely identifies the country.                     |
| `driver_number`  | `integer` | The unique number assigned to an F1 driver (cf. Wikipedia).      |
| `first_name`     | `string` | The driver's first name.                                         |
| `full_name`      | `string` | The driver's full name.                                          |
| `headshot_url`   | `string` | URL of the driver's face photo.                                  |
| `last_name`      | `string` | The driver's last name.                                          |
| `meeting_key`    | `integer` | The unique identifier for the meeting. Use `latest` to identify the latest or current meeting. |
| `name_acronym`   | `string` | Three-letter acronym of the driver's name.                       |
| `session_key`    | `integer` | The unique identifier for the session. Use `latest` to identify the latest or current session. |
| `team_colour`    | `string` | The hexadecimal color value (RRGGBB) of the driver's team.       |
| `team_name`      | `string` | Name of the driver's team.

### Meetings

```http
  GET https://api.openf1.org/v1/meetings
```
| Parameter              | Type     | Description                                                                                         |
| :--------------------- | :------- | :-------------------------------------------------------------------------------------------------- |
| `circuit_key`          | `integer` | The unique identifier for the circuit where the event takes place.                                   |
| `circuit_short_name`   | `string` | The short or common name of the circuit where the event takes place.                                 |
| `country_code`         | `string` | A code that uniquely identifies the country.                                                        |
| `country_key`          | `integer` | The unique identifier for the country where the event takes place.                                   |
| `country_name`         | `string` | The full name of the country where the event takes place.                                            |
| `date_start`           | `string` | The UTC starting date and time, in ISO 8601 format.                                                  |
| `gmt_offset`           | `string` | The difference in hours and minutes between local time at the location of the event and Greenwich Mean Time (GMT). |
| `location`             | `string` | The city or geographical location where the event takes place.                                       |
| `meeting_key`          | `integer` | The unique identifier for the meeting. Use `latest` to identify the latest or current meeting.       |
| `meeting_name`         | `string` | The name of the meeting.                                                                             |
| `meeting_official_name`| `string` | The official name of the meeting.                                                                    |
| `year`                 | `integer` | The year the event takes place.                                                                      |


## Améliorations possibles

Nous reconnaissons les domaines dans lesquels nous pourrions nous améliorer :


- Utilisation d'une base de données MySQL, qui n'a pas été réalisée par manque de temps sur le projet.

- Meilleure utilisation de Git. Avec un groupe composé de deux étudiants, nous étions plus en mesure de discuter des choses à faire en personne ou sur Discord, puis de pousser le travail sur Git ensuite.

- Possibilités d'intégrer les données des saisons précédentes au niveau du calendrier avec les courses passées et les 3è pilotes dit de reserve (qui courent parfois en F1).

- Notifier l'utilisateur à la fin de chaque course, sur chaque rumeur de transfert, etc....
## Auteurs

CANVA Baptiste & FOURNIER Victor \
\
*Étudiants en BUT Informatique 2ème année à l'IUT du Littoral de la Côte d'Opale*

*Juin 2024*

