###*
 * @class Tent.CurrencySupport
 * Some docs here...
###
# Any computations related to currency can be added in this mixin
Tent.CurrencySupport = Ember.Mixin.create


	centesimalValue: (->
		#More currencies need to be added
		if @get('currency') && (@get('currency') in ['JPY', 'KWD', 'OMR']) 
			3
		else
			# defaults to 2.
			2
	).property('currency')



