Feature: Registrar Usuario
  Como administrador del sistema
  Quiero registrar nuevos usuarios
  Para administrar la base de datos de usuarios

  Background:
    * url baseUrl

  Scenario: Registrar un nuevo usuario exitosamente
    * def ts = function(){ return java.lang.System.currentTimeMillis() + '' }
    * def email = 'usuarioCorreo_' + ts() + '@correo.com'
    Given path '/usuarios'
    And request { nome: 'Usuario Prueba', email: '#(email)', password: 'prueba123', administrador: 'true' }
    When method POST
    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'
    And match response._id == '#string'

  Scenario: No se puede registrar usuario con email ya existente
    Given path '/usuarios'
    And request { nome: 'Fulano da Silva', email: 'fulano@qa.com.br', password: 'teste', administrador: 'true' }
    When method POST
    Then status 400
    And match response.message == 'Este email já está sendo usado'

  Scenario: No se puede registrar usuario con email inválido
    Given path '/usuarios'
    And request { nome: 'Usuario Invalido', email: 'correo', password: 'prueba123', administrador: 'true' }
    When method POST
    Then status 400
    And match response.email == 'email deve ser um email válido'