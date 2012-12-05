###*
 * @class Tent.CurrencySupport
 * To get the centesimal value of a currency use the property 'centesimalValue'
 * To get the ISO name of a currency use the property 'name'
###
require '../common/currencies'

# Any computations related to currency can be added in this mixin
Tent.CurrencySupport = Ember.Mixin.create

	centesimalValue: (->
		if @get('currency')
			if @get('isValidCurrency')
				Tent.CURRENCIES_ISO_4217[@get('currency')].cent
	).property('currency')

	name: (->
		if @get('currency')
			if @get('isValidCurrency') 
				Tent.CURRENCIES_ISO_4217[@get('currency')].name
	).property('currency')

	isValidCurrency: (->
		(Tent.CURRENCIES_ISO_4217[@get('currency')])?
	).property('currency')
