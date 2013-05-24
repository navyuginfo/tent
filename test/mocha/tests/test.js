/*global describe, it */
'use strict'; 
var assert = chai.assert;
var expect = chai.expect;

$('body').append('<div id="qunit-fixture"></div>');

(function () { 
    describe('Give it some context', function () {
        describe('maybe a bit more context here', function () {
            it('should run here few assertions', function () {
            	var foo = '1';
                var $fixture = $( "#qunit-fixture" );
                $fixture.append( "<div>hello!</div>" );
                assert.equal( $( "div", $fixture ).length, 1);
            	//expect(foo).to.be.a('string');
            	assert.equal(-1, [1,2,3].indexOf(5));
      			assert.equal(-1, [1,2,3].indexOf(0)); 
            });
            it('should run here few assertions', function () {
            	var foo = '1';
            	//expect(foo).to.be.a('string');
            	assert.equal(-1, [1,2,3].indexOf(5));
      			assert.equal(-1, [1,2,3].indexOf(0));
            });
            it('should run here few assertions', function () {
            	var foo = '1';
            	//expect(foo).to.be.a('string');
            	assert.equal(-1, [1,2,3].indexOf(5));
      			assert.equal(-1, [1,2,3].indexOf(0));
            });
            it('should run here few assertions', function () {
            	var foo = '1';
            	//expect(foo).to.be.a('string');
            	assert.equal(-1, [1,2,3].indexOf(5));
      			assert.equal(-1, [1,2,3].indexOf(0));
            });
            it('should run here few assertions', function () {
            	var foo = '1';
            	//expect(foo).to.be.a('string');
            	assert.equal(-1, [1,2,3].indexOf(5));
      			assert.equal(-1, [1,2,3].indexOf(0));
            });
        });
    });
})();
