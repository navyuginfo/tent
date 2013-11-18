Tent.FuzzyDateSupport = Ember.Mixin.create
	###*
	* @property {Boolean} allowFuzzyDates The date input will accept free-form text and will attempt to parse that into
	* a valid date
	###
	allowFuzzyDates: false

	###*
	* @property {String} fuzzyValue This will store the fuzzy date if one is entered by the user.
	###
	fuzzyValue: null

	useFuzzyDates: false

	initializeFromFuzzyValue: () ->
		dateRange = @getDateStringFromFuzzyValue(@get('fuzzyValue'))
		@set('value', dateRange)
		@set('dateValue', dateRange)
		@setFuzzyCheckBox(true)
		originalFuzzyValue = @get('fuzzyValue')
		@set('useFuzzyDates', true)
		@set('fuzzyValueTemp', originalFuzzyValue)

	resetFuzzyValue: () ->
		@setFuzzyCheckBox(false)
		@set('dateValue', @get('value'))
		@set('fuzzyValueTemp', @get('value'))

	setFuzzyCheckBox: (isChecked)->
		@$('.useFuzzy').prop('checked', isChecked)

	getDateStringFromFuzzyValue: (fuzzy) ->
		preset = @getPresetRangeWhichMatchesString(fuzzy)
		if preset?
			start = if typeof preset.dateStart == 'string' then Date.parse(preset.dateStart) else preset.dateStart()
			formattedStart = Tent.Formatting.date.format(start, @get('dateFormat'))
			end = if typeof preset.dateEnd == 'string' then Date.parse(preset.dateEnd) else preset.dateEnd()
			formattedEnd = Tent.Formatting.date.format(end, @get('dateFormat'))
			(formattedStart + @get('rangeSplitter') + " " + formattedEnd)
		else
			fuzzy # If not a fuzzy value, just return the original value, which may be a valid date range

	# The plugin defines a collection of pre-calculated ranges.
	# Here we select the range which corresponds to the selected fuzzy value
	getPresetRangeWhichMatchesString: (fDate) ->
		rangesFromPlugin = @get('plugin.options.presetRanges')
		selectedPresetRangeArr = rangesFromPlugin.filter (item) =>
			item.text.replace(/\ /g, "") == fDate
		selectedPresetRangeArr[0] if selectedPresetRangeArr.length > 0

	fuzzyValueDidChange: (->
		if @get('allowFuzzyDates') and @get('useFuzzyDates')
			if @isFuzzyDateInPresetsList(@get('fuzzyValueTemp'))
				@set('fuzzyValue', @get('fuzzyValueTemp'))
				@set('formattedValue', Tent.I18n.loc("tent.dateRange.presetRanges." + @get('fuzzyValueTemp')))
		else
			@set('fuzzyValue', null)
			@set('formattedValue', @getDateStringFromFuzzyValue(@get('dateValue')))
	).observes('fuzzyValueTemp','useFuzzyDates')

	isConventionalDate: (date) ->
		Tent.Formatting.date.unformat(date.trim(), @get('dateFormat'))?

	# A fuzzy date and not a conventional date
	isFuzzyDate: (date) ->
		conventional = false
		try 
			conventional = @isConventionalDate(date)
		catch e
			conventional = false
		@isFuzzyDateValid(date) and not conventional

	# It is a valid date or fuzzy date
	isFuzzyDateValid: (date) ->
		!!@parseFuzzyDate(date)

	parseFuzzyDate: (date) ->
		Date.parse(date)


	listenForFuzzyDropdownChanges: ->
		$("#" + @get('dropdownId') + " li").click (e) =>
			@setFuzzyValueFromSelectedPreset(e)

	setFuzzyValueFromSelectedPreset: (e) ->
		if @get('allowFuzzyDates')
			li = $(e.currentTarget)
			if @presetIsFuzzy(li)
				@enableCheckbox()
				classes = li.attr('class').split(' ')
				presetArr = classes.find((item)->
					if item.split('ui-daterangepicker-').length > 1 then true else false
				)
				fValue = presetArr.split('ui-daterangepicker-')[1]
				@set('fuzzyValueTemp', fValue)
			else
				@disableCheckbox()
				@setCheckValue(false)
				@set('useFuzzyDates', false)
		else
			@set('fuzzyValue', null)

	isFuzzyDateInPresetsList: (date) ->
		return false if not date?
		ranges = @get('plugin.options.presetRanges')
		ranges.filter((item) ->
			item.text.replace(/\ /g, "") == date
		).length >0

	presetIsFuzzy: (li)->
		li.attr('class').indexOf('preset_') == -1

	listenForFuzzyCheckboxChanges: ->
		_this = this;
		@$('.useFuzzy').click (e) =>
			@checkWasClicked()

	setCheckValue: (value) ->
		@$('.useFuzzy').prop('checked', value)

	isChecked: ->
		!!@$('.useFuzzy').prop('checked')

	enableCheckbox: ->
		@$('.useFuzzy').prop('disabled', false)

	disableCheckbox: ->
		@$('.useFuzzy').prop('disabled', true)

	checkWasClicked: ->
		#Using toggleProperty causes issues with rendering of the checkbox for some reason
		if @get('useFuzzyDates')
			@set('useFuzzyDates', false)
		else
			@set('useFuzzyDates', true)