Feature: Listar Usuarios
  Como administrador del sistema
  Quiero obtener la lista de todos los usuarios
  Para administrar la base de datos de usuarios

  Background:
    * url baseUrl

  Scenario: Obtener lista de usuarios exitosamente
    Given path '/usuarios'
    When method GET
    Then status 200
    And match response.quantidade == '#number'
    And match response.usuarios == '#array'

  Scenario: Filtrar usuarios por administrador
    Given path '/usuarios'
    And param administrador = 'true'
    When method GET
    Then status 200
    And match response.quantidade == '#number'
    And match response.usuarios == '#array'

  Scenario: Filtrar con email inexistente retorna lista vacía
    Given path '/usuarios'
    And param email = 'noexiste@noexiste.com'
    When method GET
    Then status 200
    And match response.quantidade == 0
    And match response.usuarios == []