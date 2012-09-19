#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#
Tent.I18n = Ember.Namespace.create
	language: {}
	loadTranslations: (translations)->
		@set('language', translations)

	translate: (code) ->
		#Stubbed
		"t_" + code

	loc: (key, vars) ->
		string = Ember.get(@language, key) || key
		vars = [vars] if typeof vars == 'string'
		Ember.String.fmt(string, vars)

Tent.translate = Tent.I18n.translate