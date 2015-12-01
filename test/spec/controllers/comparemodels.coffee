'use strict'

describe 'Controller: ComparemodelsCtrl', ->

  # load the controller's module
  beforeEach module 'crossmodelApp'

  ComparemodelsCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    ComparemodelsCtrl = $controller 'ComparemodelsCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(ComparemodelsCtrl.awesomeThings.length).toBe 3
