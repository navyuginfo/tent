Ext.data.JsonP.Tent_DateRangeField({"tagname":"class","name":"Tent.DateRangeField","extends":"Tent.TextField","mixins":[],"alternateClassNames":[],"aliases":{},"singleton":false,"requires":[],"uses":[],"enum":null,"override":null,"inheritable":null,"inheritdoc":null,"meta":{},"private":null,"id":"class-Tent.DateRangeField","members":{"cfg":[],"property":[{"name":"arrows","tagname":"property","owner":"Tent.DateRangeField","meta":{},"id":"property-arrows"},{"name":"closeOnSelect","tagname":"property","owner":"Tent.DateRangeField","meta":{},"id":"property-closeOnSelect"},{"name":"controlClass","tagname":"property","owner":"Tent.TextField","meta":{},"id":"property-controlClass"},{"name":"dateFormat","tagname":"property","owner":"Tent.DateRangeField","meta":{},"id":"property-dateFormat"},{"name":"disabled","tagname":"property","owner":"Tent.FieldSupport","meta":{},"id":"property-disabled"},{"name":"earliestDate","tagname":"property","owner":"Tent.DateRangeField","meta":{},"id":"property-earliestDate"},{"name":"endDate","tagname":"property","owner":"Tent.DateRangeField","meta":{},"id":"property-endDate"},{"name":"formattedValue","tagname":"property","owner":"Tent.FieldSupport","meta":{},"id":"property-formattedValue"},{"name":"hasPrefix","tagname":"property","owner":"Tent.FieldSupport","meta":{},"id":"property-hasPrefix"},{"name":"helpBlock","tagname":"property","owner":"Tent.FieldSupport","meta":{},"id":"property-helpBlock"},{"name":"isEditable","tagname":"property","owner":"Tent.FieldSupport","meta":{},"id":"property-isEditable"},{"name":"label","tagname":"property","owner":"Tent.FieldSupport","meta":{},"id":"property-label"},{"name":"latestDate","tagname":"property","owner":"Tent.DateRangeField","meta":{},"id":"property-latestDate"},{"name":"placeholder","tagname":"property","owner":"Tent.FieldSupport","meta":{},"id":"property-placeholder"},{"name":"prefix","tagname":"property","owner":"Tent.FieldSupport","meta":{},"id":"property-prefix"},{"name":"presetRanges","tagname":"property","owner":"Tent.DateRangeField","meta":{},"id":"property-presetRanges"},{"name":"presets","tagname":"property","owner":"Tent.DateRangeField","meta":{},"id":"property-presets"},{"name":"rangeSplitter","tagname":"property","owner":"Tent.DateRangeField","meta":{},"id":"property-rangeSplitter"},{"name":"readOnly","tagname":"property","owner":"Tent.FieldSupport","meta":{},"id":"property-readOnly"},{"name":"required","tagname":"property","owner":"Tent.MandatorySupport","meta":{},"id":"property-required"},{"name":"serializedValue","tagname":"property","owner":"Tent.FieldSupport","meta":{},"id":"property-serializedValue"},{"name":"span","tagname":"property","owner":"Tent.SpanSupport","meta":{},"id":"property-span"},{"name":"startDate","tagname":"property","owner":"Tent.DateRangeField","meta":{},"id":"property-startDate"},{"name":"textDisplay","tagname":"property","owner":"Tent.FieldSupport","meta":{},"id":"property-textDisplay"},{"name":"tooltip","tagname":"property","owner":"Tent.TooltipSupport","meta":{},"id":"property-tooltip"},{"name":"type","tagname":"property","owner":"Tent.TextField","meta":{},"id":"property-type"},{"name":"validations","tagname":"property","owner":"Tent.ValidationSupport","meta":{},"id":"property-validations"},{"name":"value","tagname":"property","owner":"Tent.FieldSupport","meta":{},"id":"property-value"},{"name":"vspan","tagname":"property","owner":"Tent.SpanSupport","meta":{},"id":"property-vspan"},{"name":"warnings","tagname":"property","owner":"Tent.ValidationSupport","meta":{},"id":"property-warnings"}],"method":[{"name":"getValue","tagname":"method","owner":"Tent.DateRangeField","meta":{},"id":"method-getValue"},{"name":"setValue","tagname":"method","owner":"Tent.DateRangeField","meta":{},"id":"method-setValue"}],"event":[],"css_var":[],"css_mixin":[]},"linenr":8328,"files":[{"filename":"tent.js","href":"tent.html#Tent-DateRangeField"}],"html_meta":{},"statics":{"cfg":[],"property":[],"method":[],"event":[],"css_var":[],"css_mixin":[]},"component":false,"superclasses":["Tent.TextField"],"subclasses":[],"mixedInto":[],"parentMixins":["Tent.FieldSupport","Tent.FormattingSupport","Tent.TooltipSupport"],"html":"<div><pre class=\"hierarchy\"><h4>Hierarchy</h4><div class='subclass first-child'><a href='#!/api/Tent.TextField' rel='Tent.TextField' class='docClass'>Tent.TextField</a><div class='subclass '><strong>Tent.DateRangeField</strong></div></div><h4>Inherited mixins</h4><div class='dependency'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='docClass'>Tent.FieldSupport</a></div><div class='dependency'><a href='#!/api/Tent.FormattingSupport' rel='Tent.FormattingSupport' class='docClass'>Tent.FormattingSupport</a></div><div class='dependency'><a href='#!/api/Tent.TooltipSupport' rel='Tent.TooltipSupport' class='docClass'>Tent.TooltipSupport</a></div><h4>Files</h4><div class='dependency'><a href='source/tent.html#Tent-DateRangeField' target='_blank'>tent.js</a></div></pre><div class='doc-contents'><p>This widget wraps the Filament Date Range Picker control. The selected value will consist of\ntwo dates which are bound to the <a href=\"#!/api/Tent.DateRangeField-property-startDate\" rel=\"Tent.DateRangeField-property-startDate\" class=\"docClass\">startDate</a> and <a href=\"#!/api/Tent.DateRangeField-property-endDate\" rel=\"Tent.DateRangeField-property-endDate\" class=\"docClass\">endDate</a> properties.\nThe <a href=\"#!/api/Tent.DateRangeField-property-value\" rel=\"Tent.DateRangeField-property-value\" class=\"docClass\">value</a> property is also bound with the string value of the range, as seen in the\ninput control ('date1 - date2').</p>\n\n<p>The initial value can be sourced from the value property if provided. If no value is provided,\nthen the startDate and endDate properties will be used to initialize the control.</p>\n\n<p>Usage</p>\n\n<pre><code>  {{view <a href=\"#!/api/Tent.DateRangeField\" rel=\"Tent.DateRangeField\" class=\"docClass\">Tent.DateRangeField</a> label=\"\" \n        valueBinding=\"\" \n        startDateBinding=\"\"\n        endDateBinding=\"\"\n        showOtherMonths=true  \n        dateFormat=\"\"\n     }}\n</code></pre>\n</div><div class='members'><div class='members-section'><div class='definedBy'>Defined By</div><h3 class='members-title icon-property'>Properties</h3><div class='subsection'><div id='property-arrows' class='member first-child not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.DateRangeField'>Tent.DateRangeField</span><br/><a href='source/tent.html#Tent-DateRangeField-property-arrows' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.DateRangeField-property-arrows' class='name expandable'>arrows</a><span> : Boolean</span></div><div class='description'><div class='short'>will add date range advancing arrows to input. ...</div><div class='long'><p>will add date range advancing arrows to input.</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-closeOnSelect' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.DateRangeField'>Tent.DateRangeField</span><br/><a href='source/tent.html#Tent-DateRangeField-property-closeOnSelect' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.DateRangeField-property-closeOnSelect' class='name expandable'>closeOnSelect</a><span> : Boolean</span></div><div class='description'><div class='short'>will close the rangepicker when a full range is selected ...</div><div class='long'><p>will close the rangepicker when a full range is selected</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-controlClass' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.TextField' rel='Tent.TextField' class='defined-in docClass'>Tent.TextField</a><br/><a href='source/tent.html#Tent-TextField-property-controlClass' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.TextField-property-controlClass' class='name expandable'>controlClass</a><span> : String</span></div><div class='description'><div class='short'>Additional classes to be added to the input field (not added to the wrapping elements) ...</div><div class='long'><p>Additional classes to be added to the input field (not added to the wrapping elements)</p>\n<p>Defaults to: <code>''</code></p></div></div></div><div id='property-dateFormat' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.DateRangeField'>Tent.DateRangeField</span><br/><a href='source/tent.html#Tent-DateRangeField-property-dateFormat' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.DateRangeField-property-dateFormat' class='name not-expandable'>dateFormat</a><span> : String</span></div><div class='description'><div class='short'><p>The expected format for each date in the range</p>\n</div><div class='long'><p>The expected format for each date in the range</p>\n</div></div></div><div id='property-disabled' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-disabled' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-disabled' class='name expandable'>disabled</a><span> : String</span></div><div class='description'><div class='short'>A boolean indicating that the field is disabled. ...</div><div class='long'><p>A boolean indicating that the field is disabled.\nWhen disabled, the user is prevented from interacting with the field. In addition, if the field\nis tied to a form, its value will not be included in the form submission</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-earliestDate' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.DateRangeField'>Tent.DateRangeField</span><br/><a href='source/tent.html#Tent-DateRangeField-property-earliestDate' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.DateRangeField-property-earliestDate' class='name expandable'>earliestDate</a><span> : Date</span></div><div class='description'><div class='short'>The earliest date allowed in the system. ...</div><div class='long'><p>The earliest date allowed in the system. e.g. the 'All Dates Before'\nrange will use this as the first date in the range</p>\n</div></div></div><div id='property-endDate' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.DateRangeField'>Tent.DateRangeField</span><br/><a href='source/tent.html#Tent-DateRangeField-property-endDate' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.DateRangeField-property-endDate' class='name not-expandable'>endDate</a><span> : Date</span></div><div class='description'><div class='short'><p>The selected end date in the range</p>\n</div><div class='long'><p>The selected end date in the range</p>\n</div></div></div><div id='property-formattedValue' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-formattedValue' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-formattedValue' class='name not-expandable'>formattedValue</a><span> : String</span></div><div class='description'><div class='short'><p>The current value of the field in its formatted form.</p>\n</div><div class='long'><p>The current value of the field in its formatted form.</p>\n</div></div></div><div id='property-hasPrefix' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-hasPrefix' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-hasPrefix' class='name expandable'>hasPrefix</a><span> : Boolean</span></div><div class='description'><div class='short'>A boolean indicating whether a prefix should be displayed before the value ...</div><div class='long'><p>A boolean indicating whether a prefix should be displayed before the value</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-helpBlock' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-helpBlock' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-helpBlock' class='name not-expandable'>helpBlock</a><span> : String</span></div><div class='description'><div class='short'><p>A block of text which provides additional help for completing the field</p>\n</div><div class='long'><p>A block of text which provides additional help for completing the field</p>\n</div></div></div><div id='property-isEditable' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-isEditable' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-isEditable' class='name expandable'>isEditable</a><span> : Boolean</span></div><div class='description'><div class='short'>A boolean value indicating whether the field is editable ...</div><div class='long'><p>A boolean value indicating whether the field is editable</p>\n<p>Defaults to: <code>true</code></p></div></div></div><div id='property-label' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-label' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-label' class='name expandable'>label</a><span> : String</span></div><div class='description'><div class='short'>The label for the field. ...</div><div class='long'><p>The label for the field.</p>\n<p>Defaults to: <code>&quot;&quot;</code></p></div></div></div><div id='property-latestDate' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.DateRangeField'>Tent.DateRangeField</span><br/><a href='source/tent.html#Tent-DateRangeField-property-latestDate' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.DateRangeField-property-latestDate' class='name expandable'>latestDate</a><span> : Date</span></div><div class='description'><div class='short'>The latest date allowed in the system. ...</div><div class='long'><p>The latest date allowed in the system. e.g. the 'All Dates After'\nrange will use this as the last date in the range</p>\n</div></div></div><div id='property-placeholder' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-placeholder' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-placeholder' class='name expandable'>placeholder</a><span> : String</span></div><div class='description'><div class='short'>A block of descriptive text to display in the field, usually hint as to the expected content. ...</div><div class='long'><p>A block of descriptive text to display in the field, usually hint as to the expected content.\nThe placeholder will not be recognised as a value, and will be hidden when text is entered into the field.</p>\n</div></div></div><div id='property-prefix' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-prefix' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-prefix' class='name not-expandable'>prefix</a><span> : String</span></div><div class='description'><div class='short'><p>A string value to display as the prefix</p>\n</div><div class='long'><p>A string value to display as the prefix</p>\n</div></div></div><div id='property-presetRanges' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.DateRangeField'>Tent.DateRangeField</span><br/><a href='source/tent.html#Tent-DateRangeField-property-presetRanges' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.DateRangeField-property-presetRanges' class='name expandable'>presetRanges</a><span> : Array</span></div><div class='description'><div class='short'>Array of objects to be made into menu range presets. ...</div><div class='long'><p>Array of objects to be made into menu range presets.</p>\n\n<p>Each object requires 3 properties:\n- text: string, text for menu item\n- dateStart: date.js string, or function which returns a date object, start of date range\n- dateEnd: date.js string, or function which returns a date object, end of date range</p>\n</div></div></div><div id='property-presets' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.DateRangeField'>Tent.DateRangeField</span><br/><a href='source/tent.html#Tent-DateRangeField-property-presets' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.DateRangeField-property-presets' class='name expandable'>presets</a><span> : Array</span></div><div class='description'><div class='short'>Available options are:\n- 'specificDate'\n- 'allDatesBefore'\n- 'allDatesAfter'\n- 'dateRange'. ...</div><div class='long'><p>Available options are:\n- 'specificDate'\n- 'allDatesBefore'\n- 'allDatesAfter'\n- 'dateRange'.</p>\n\n<p>Each can be passed a string for link and label text. (example: presets: {specificDate: 'Pick a date'} )</p>\n</div></div></div><div id='property-rangeSplitter' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.DateRangeField'>Tent.DateRangeField</span><br/><a href='source/tent.html#Tent-DateRangeField-property-rangeSplitter' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.DateRangeField-property-rangeSplitter' class='name expandable'>rangeSplitter</a><span> : String</span></div><div class='description'><div class='short'>The character to use between two dates in the range ...</div><div class='long'><p>The character to use between two dates in the range</p>\n<p>Defaults to: <code>','</code></p></div></div></div><div id='property-readOnly' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-readOnly' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-readOnly' class='name expandable'>readOnly</a><span> : String</span></div><div class='description'><div class='short'>A boolean indicating that the field is read-only. ...</div><div class='long'><p>A boolean indicating that the field is read-only.\nAlthough this allows the user to interact with the field (highlight, copy etc), they are not able to change\nits value.</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-required' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.MandatorySupport' rel='Tent.MandatorySupport' class='defined-in docClass'>Tent.MandatorySupport</a><br/><a href='source/tent.html#Tent-MandatorySupport-property-required' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.MandatorySupport-property-required' class='name expandable'>required</a><span> : Boolean</span></div><div class='description'><div class='short'>Boolean property to determine whether a value must be provided ...</div><div class='long'><p>Boolean property to determine whether a value must be provided</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-serializedValue' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-serializedValue' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-serializedValue' class='name expandable'>serializedValue</a><span> : Object</span></div><div class='description'><div class='short'>If a serializer has been defined, this will contain the serialized\nvalue. ...</div><div class='long'><p>If a serializer has been defined, this will contain the serialized\nvalue. If this value is set, a deserialized version of it will be set on the 'value' property</p>\n</div></div></div><div id='property-span' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.SpanSupport' rel='Tent.SpanSupport' class='defined-in docClass'>Tent.SpanSupport</a><br/><a href='source/tent.html#Tent-SpanSupport-property-span' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.SpanSupport-property-span' class='name not-expandable'>span</a><span> : Number</span></div><div class='description'><div class='short'><p>The horizontal span which should be allocated to this widget</p>\n</div><div class='long'><p>The horizontal span which should be allocated to this widget</p>\n</div></div></div><div id='property-startDate' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.DateRangeField'>Tent.DateRangeField</span><br/><a href='source/tent.html#Tent-DateRangeField-property-startDate' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.DateRangeField-property-startDate' class='name not-expandable'>startDate</a><span> : Date</span></div><div class='description'><div class='short'><p>The selected start date in the range</p>\n</div><div class='long'><p>The selected start date in the range</p>\n</div></div></div><div id='property-textDisplay' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-textDisplay' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-textDisplay' class='name expandable'>textDisplay</a><span> : Boolean</span></div><div class='description'><div class='short'>When set to true, the formatted value of the widget will be displayed,\nrather than the widget itself. ...</div><div class='long'><p>When set to true, the formatted value of the widget will be displayed,\nrather than the widget itself.</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-tooltip' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.TooltipSupport' rel='Tent.TooltipSupport' class='defined-in docClass'>Tent.TooltipSupport</a><br/><a href='source/tent.html#Tent-TooltipSupport-property-tooltip' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.TooltipSupport-property-tooltip' class='name not-expandable'>tooltip</a><span> : String</span></div><div class='description'><div class='short'><p>A detailed information message presented as a hover-icon beside the field</p>\n</div><div class='long'><p>A detailed information message presented as a hover-icon beside the field</p>\n</div></div></div><div id='property-type' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.TextField' rel='Tent.TextField' class='defined-in docClass'>Tent.TextField</a><br/><a href='source/tent.html#Tent-TextField-property-type' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.TextField-property-type' class='name expandable'>type</a><span> : String</span></div><div class='description'><div class='short'>The type of the input element ('text', 'password' etc) ...</div><div class='long'><p>The type of the input element ('text', 'password' etc)</p>\n<p>Defaults to: <code>'text'</code></p></div></div></div><div id='property-validations' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.ValidationSupport' rel='Tent.ValidationSupport' class='defined-in docClass'>Tent.ValidationSupport</a><br/><a href='source/tent.html#Tent-ValidationSupport-property-validations' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.ValidationSupport-property-validations' class='name not-expandable'>validations</a><span> : String </span></div><div class='description'><div class='short'><p>A list of comma-separated custom validations which should be applied to the widget</p>\n</div><div class='long'><p>A list of comma-separated custom validations which should be applied to the widget</p>\n</div></div></div><div id='property-value' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-value' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-value' class='name not-expandable'>value</a><span> : String</span></div><div class='description'><div class='short'><p>The current value of the field.</p>\n</div><div class='long'><p>The current value of the field.</p>\n</div></div></div><div id='property-vspan' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.SpanSupport' rel='Tent.SpanSupport' class='defined-in docClass'>Tent.SpanSupport</a><br/><a href='source/tent.html#Tent-SpanSupport-property-vspan' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.SpanSupport-property-vspan' class='name not-expandable'>vspan</a><span> : Number</span></div><div class='description'><div class='short'><p>The vertical span which should be allocated to this widget</p>\n</div><div class='long'><p>The vertical span which should be allocated to this widget</p>\n</div></div></div><div id='property-warnings' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.ValidationSupport' rel='Tent.ValidationSupport' class='defined-in docClass'>Tent.ValidationSupport</a><br/><a href='source/tent.html#Tent-ValidationSupport-property-warnings' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.ValidationSupport-property-warnings' class='name expandable'>warnings</a><span> : String</span></div><div class='description'><div class='short'>A list of comma-separated custom validations which should be applied to the widget, but are interpreted\nas warnings w...</div><div class='long'><p>A list of comma-separated custom validations which should be applied to the widget, but are interpreted\nas warnings which may be ignored.</p>\n</div></div></div></div></div><div class='members-section'><div class='definedBy'>Defined By</div><h3 class='members-title icon-method'>Methods</h3><div class='subsection'><div id='method-getValue' class='member first-child not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.DateRangeField'>Tent.DateRangeField</span><br/><a href='source/tent.html#Tent-DateRangeField-method-getValue' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.DateRangeField-method-getValue' class='name expandable'>getValue</a>( <span class='pre'></span> ) : String</div><div class='description'><div class='short'>Return the current value of the input field ...</div><div class='long'><p>Return the current value of the input field</p>\n<h3 class='pa'>Returns</h3><ul><li><span class='pre'>String</span><div class='sub-desc'>\n</div></li></ul></div></div></div><div id='method-setValue' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.DateRangeField'>Tent.DateRangeField</span><br/><a href='source/tent.html#Tent-DateRangeField-method-setValue' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.DateRangeField-method-setValue' class='name expandable'>setValue</a>( <span class='pre'>value</span> )</div><div class='description'><div class='short'>Set the value of the input field ...</div><div class='long'><p>Set the value of the input field</p>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>value</span> : String<div class='sub-desc'>\n</div></li></ul></div></div></div></div></div></div></div>"});