Feature: Buscar Usuario por ID
  Como administrador del sistema
  Quiero buscar un usuario especifico por su ID
  Para consultar su informacion

  Background:
    * url baseUrl
    * def ts = function(){ return java.lang.System.currentTimeMillis() + '' }

  Scenario: Buscar usuario existente por ID exitosamente
    * def email = 'buscarCorreo_' + ts() + '@correo.com'
    Given path '/usuarios'
    And request { nome: 'Usuario Buscar', email: '#(email)', password: 'prueba123', administrador: 'true' }
    When method POST
    Then status 201
    * def usuarioId = response._id

    Given path '/usuarios/' + usuarioId
    When method GET
    Then status 200
    And match response._id == usuarioId
    And match response.nome == '#string'
    And match response.email == '#string'
    And match response.password == '#string'
    And match response.administrador == '#string'

  Scenario: Buscar usuario con ID inexistente retorna error
    Given path '/usuarios/idnoexistente123'
    When method GET
    Then status 400
    And match response.message == 'Usuário não encontrado'