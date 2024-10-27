# Spring Boot REST API
## Card Manager

Esta es una API RESTful desarrollada con Spring Boot y MongoDB que permite gestionar una colección de cartas (`Card`), paquetes de cartas (`BoosterPack`), y usuarios con roles específicos (`User` y `Role`). Los endpoints permiten crear, leer, actualizar y eliminar cartas y paquetes, y gestionar la autenticación de usuarios con roles predefinidos.
Se trata de un proyecto pequeño con lo necesario para funcionar por si solo.

## Configuración del proyecto

### Prerrequisitos
1. **Java 17** o superior.
2. **Maven** para gestionar las dependencias.
3. **MongoDB**: configura MongoDB en `application.properties`.

## Tecnologías

- Spring Boot: Framework para construir aplicaciones Java basadas en Spring.
- Spring Security: Proporciona autenticación y control de acceso a las aplicaciones.
- JWT (JSON Web Token): Mecanismo para autenticación y autorización en aplicaciones web.
- JUnit: Framework para realizar pruebas unitarias en Java.
- Mockito: Biblioteca para crear objetos simulados (mocks) en pruebas.
- MongoDB: Base de datos NoSQL utilizada para el almacenamiento de datos.
- Spring Data MongoDB: Proporciona una forma sencilla de interactuar con MongoDB a través de repositorios.
- Lombok: Biblioteca que reduce el código boilerplate en clases Java mediante anotaciones.
- REST API: Arquitectura utilizada para construir servicios web que permiten la comunicación entre aplicaciones.
- Maven: Herramienta de gestión de proyectos y dependencias en Java.


## Modelos

### User

| Campo    | Tipo      | Descripción              |
|----------|-----------|--------------------------|
| id       | String    | Identificador único      |
| username | String    | Nombre de usuario        |
| email    | String    | Email del usuario        |
| password | String    | Contraseña de usuario    |
| roles    | Set<Role> | Rol del usuario          |



### ERole

| Campo           | Tipo    | Descripción                            |
|-----------------|---------|----------------------------------------|
| ROLE_USUARIO    | ENUM    | Rol de usuario estándar                |
| ROLE_MODERADOR  | ENUM    | Rol de moderador con permisos elevados |


### Role

| Campo  | Tipo    | Descripción                                |
|--------|---------|--------------------------------------------|
| id     | String  | Identificador único del rol                |
| name   | ERole   | Tipo de rol (ROLE_USUARIO, ROLE_MODERADOR) |


### BoosterPack

| Campo        | Tipo      | Descripción                            |
|--------------|-----------|----------------------------------------|
| id           | String    | Identificador único                    |
| name         | String    | Nombre de la carta                     |
| image        | String    | URL de la imagen de la carta           |
| rarity       | String    | Rareza de la carta (común, rara, etc.) |
| color        | String    | Color principal de la carta            |
| dp           | int       | Puntos de daño de la carta             |
| boosterPack  | Set<Role> | Nombre del pack al que pertenece       |






## Endpoints

### Card Endpoints

| Método        | Endpoint                   | Descripción                            | Parámetros                                 |
|---------------|----------------------------|----------------------------------------|--------------------------------------------|
| GET           | /card/getCard/{name}       | Obtener una carta por su nombre        | name: Nombre de la carta                   |
| GET           | /card/getAllCards          | Obtener todas las cartas               |                                            |
| POST          | /card/createCard           | Crear una nueva carta                  |name, image, rareza, color, dp, boosterPack |
| PUT           | /card/updateCard/{name}    | Actualizar una carta existente         |name, image, rareza, color, dp, boosterPack |
| DELETE        | /card/deleteCard/{name}    | Eliminar una carta por su nombre       |name: Nombre de la carta                    |


### BoosterPack Endpoints

| Método        | Endpoint                           | Descripción                                | Parámetros              |
|---------------|------------------------------------|--------------------------------------------|-------------------------|
| GET           | /booster/getBoosterPacks           | Obtener todos los paquetes de cartas       |                         |
| GET           | /booster/getBoosterPacksName       | Obtener los nombres de todos los paquetes  |                         |
| POST          | /booster/createBoosterPack         | Crear un nuevo paquete de cartas           |name, file               |
| DELETE        | /booster/deleteBoosterPack/{name}  | Eliminar un paquete por su nombre          |name: Nombre del paquete |
| GET           | /booster/getPack/{name}            | Obtener un paquete por su nombre           |name: Nombre del paquete |


### BoosterPack Endpoints

| Método        | Endpoint                           | Descripción                            | Parámetros                   |
|---------------|------------------------------------|----------------------------------------|------------------------------|
| POST          | /auth/register-user                | Registrar un nuevo usuario             | username, email, password    |
| POST          | /auth/login                        | Autenticar un usuario registrado       | email, password              |
| PUT           | /auth/changePassword               | Cambiar la contraseña de un usuario    | email, newPassword           |





## Test

El proyecto incluye una serie de pruebas unitarias diseñadas para verificar el correcto funcionamiento de los componentes del sistema. A continuación, se describen los diferentes conjuntos de pruebas implementadas:

### CardServiceTest

Esta clase de prueba se encarga de verificar el comportamiento del CardService, que gestiona la lógica relacionada con las cartas. Las pruebas incluidas son:

- createCardWhenNotExistsReturnsCard: Verifica que al intentar crear una carta que no existe, se crea correctamente y se retorna la carta.
- createCardWhenAlreadyExistsThrowsException: Asegura que al intentar crear una carta que ya existe, se lanza una excepción.
- getExistingCardReturnsCard: Verifica que se puede obtener una carta existente.
- getNonExistingCardThrowsException: Asegura que al intentar obtener una carta que no existe, se lanza una excepción.
- getAllCardsReturnsListOfCards: Verifica que se pueden recuperar todas las cartas.
- deleteExistingCardDeletesCard: Asegura que se puede eliminar una carta existente sin lanzar excepciones.
- deleteNonExistingCardThrowsException: Verifica que se lanza una excepción al intentar eliminar una carta que no existe.
- updateExistingCardUpdatesCard: Verifica que se puede actualizar correctamente una carta existente.
- updateNonExistingCardThrowsException: Asegura que se lanza una excepción al intentar actualizar una carta que no existe.



### BoosterPackServiceTest

Esta clase de prueba se centra en el BoosterPackService, el cual maneja la lógica relacionada con los paquetes. Las pruebas incluyen:

- getBoosterPacksReturnsListOfBoosterPacks: Verifica que se pueden recuperar todos los paquetes de refuerzo.
- getBoosterPackNamesReturnsListOfNames: Asegura que se pueden recuperar solo los nombres de los paquetes de refuerzo.
- createBoosterPackWhenNotExistsReturnsPack: Verifica que se puede crear un nuevo paquete de refuerzo y se retorna el paquete.
- createBoosterPackWhenAlreadyExistsThrowsException: Asegura que se lanza una excepción al intentar crear un paquete de refuerzo que ya existe.
- getExistingPackReturnsPack: Verifica que se puede obtener un paquete de refuerzo existente.
- getNonExistingPackThrowsException: Asegura que se lanza una excepción al intentar obtener un paquete que no existe.
- deleteExistingPackDeletesPack: Verifica que se puede eliminar un paquete de refuerzo existente sin lanzar excepciones.
- deleteNonExistingPackThrowsException: Asegura que se lanza una excepción al intentar eliminar un paquete que no existe.


### UserServiceImplTest

Esta clase de prueba valida el UserServiceImpl, que maneja la lógica relacionada con los usuarios. Las pruebas incluyen:

- getUserByEmailReturnsUser: Verifica que se puede obtener un usuario a través de su email.
- getUserByNonExistentEmailThrowsException: Asegura que se lanza una excepción al intentar obtener un usuario que no existe.
- getUserByUsernameReturnsUser: Verifica que se puede obtener un usuario a través de su nombre de usuario.
- getUserByNonExistentUsernameThrowsException: Asegura que se lanza una excepción al intentar obtener un usuario que no existe.

