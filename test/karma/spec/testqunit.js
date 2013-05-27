
var view = null;
var appendView = function() {
  Ember.run(function(){
    view.appendTo('#qunit-fixture');
  });
};

var setup = function(){};
var teardown = function(){};
module ("Tent.AlertMessage tests", setup, teardown);


test('// Ensure AlertMessage renders for text', function(){
  var amount = Tent.AmountField.create();
  equal(amount.format(123), '123.00', '123');

});
