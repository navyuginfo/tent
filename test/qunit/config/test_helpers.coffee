@TEST = true
@Mock = sinon.mock
@Stub = sinon.stub
@Spy = sinon.spy

@testSetup = {}
@testTeardown = {}

oldTest = @test
@test = (testName) ->
  unless arguments.length == 1
    oldTest.apply(@, arguments)
  else
    oldTest.call(@, testName, ->ok(false, 'Test Not Implemented'))

oldModule = @module
@module = (moduleName, setup, teardown) ->
  @testSetup[moduleName] = setup || ->
  @testTeardown[moduleName] = teardown || ->
  oldModule(moduleName)

QUnit.testStart (opts) =>
  $('body #qunit-fixture').remove()
  $('body').append('<div id="qunit-fixture"></div>')
  @testSetup[opts.module].call()

QUnit.testDone (opts) =>
  @testTeardown[opts.module].call()
