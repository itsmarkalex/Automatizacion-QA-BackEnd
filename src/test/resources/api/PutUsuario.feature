Feature: Actualizar Usuario
  Como administrador del sistema
  Quiero actualizar la informacion de un usuario existente
  Para mantener los datos actualizados

  Background:
    * url baseUrl
    * def ts = function(){ return java.lang.System.currentTimeMillis() + '' }

  Scenario: Actualizar usuario existente exitosamente
    * def email = 'actualizarCorreo_' + ts() + '@correo.com'
    Given path '/usuarios'
    And request { nome: 'Usuario Actualizar', email: '#(email)', password: 'prueba123', administrador: 'true' }
    When method POST
    Then status 201
    * def usuarioId = response._id

    Given path '/usuarios/' + usuarioId
    And request { nome: 'Usuario Actualizado', email: '#(email)', password: 'nuevaPass123', administrador: 'false' }
    When method PUT
    Then status 200
    And match response.message == 'Registro alterado com sucesso'

  Scenario: Actualizar usuario con email ya usado por otro usuario
    * def emailUno = 'uno_' + ts() + '@correo.com'
    * def emailDos = 'dos_' + ts() + '@correo.com'

    Given path '/usuarios'
    And request { nome: 'Usuario Uno', email: '#(emailUno)', password: 'prueba123', administrador: 'true' }
    When method POST
    Then status 201
    * def idUsuarioDos = null

    Given path '/usuarios'
    And request { nome: 'Usuario Dos', email: '#(emailDos)', password: 'prueba123', administrador: 'false' }
    When method POST
    Then status 201
    * def idUsuarioDos = response._id

    Given path '/usuarios/' + idUsuarioDos
    And request { nome: 'Usuario Dos', email: '#(emailUno)', password: 'prueba123', administrador: 'false' }
    When method PUT
    Then status 400
    And match response.message == 'Este email já está sendo usado'

  Scenario: Actualizar usuario con ID inexistente crea un nuevo usuario
    * def email = 'nuevoCorreoPut' + ts() + '@correo.com'
    Given path '/usuarios/idnoexistente123'
    And request { nome: 'Usuario Nuevo Via PUT', email: '#(email)', password: 'prueba123', administrador: 'false' }
    When method PUT
    Then status 201
    And match response.message == 'Cadastro realizado com sucesso'