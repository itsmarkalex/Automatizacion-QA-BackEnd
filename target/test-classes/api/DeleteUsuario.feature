Feature: Eliminar Usuario
  Como administrador del sistema
  Quiero eliminar un usuario del sistema
  Para mantener la base de datos actualizada

  Background:
    * url baseUrl
    * def ts = function(){ return java.lang.System.currentTimeMillis() + '' }

  Scenario: Eliminar usuario existente exitosamente
    * def email = 'eliminarCorreo' + ts() + '@correo.com'
    Given path '/usuarios'
    And request { nome: 'Usuario Eliminar', email: '#(email)', password: 'prueba123', administrador: 'true' }
    When method POST
    Then status 201
    * def usuarioId = response._id

    Given path '/usuarios/' + usuarioId
    When method DELETE
    Then status 200
    And match response.message == 'Registro excluído com sucesso'

  Scenario: Eliminar usuario con ID inexistente
    Given path '/usuarios/idnoexistente123'
    When method DELETE
    Then status 200
    And match response.message == 'Nenhum registro excluído'

  Scenario: Verificar que el usuario fue eliminado correctamente
    * def email = 'verificarCorreo' + ts() + '@correo.com'
    Given path '/usuarios'
    And request { nome: 'Usuario Verificar', email: '#(email)', password: 'prueba123', administrador: 'true' }
    When method POST
    Then status 201
    * def usuarioId = response._id

    Given path '/usuarios/' + usuarioId
    When method DELETE
    Then status 200

    Given path '/usuarios/' + usuarioId
    When method GET
    Then status 400
    And match response.message == 'Usuário não encontrado'