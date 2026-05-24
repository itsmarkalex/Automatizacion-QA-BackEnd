ServeRest API
-------------

Requisitos
----------
- Java JDK 8 (jdk1.8.0_481 o superior)
- Maven 3.8+
- IntelliJ IDEA

Stack
-----
- Karate DSL 1.2.0
- JUnit 4.12

Configuración
-------------
1. Abrir IntelliJ IDEA
2. File - Open - seleccionar la carpeta del proyecto
3. Esperar que Maven descargue las dependencias automaticamente
4. Maven - Reload Project

Ejecución
---------
1. Abrir src/test/java/com/bdd/apitesting/ApiRunnerTest.java
2. Click derecho en el metodo testAll
3. Run 'testAll'

Reportes
--------
Al ejecutar se genera automaticamente en:
target/karate-reports/karate-summary.html
