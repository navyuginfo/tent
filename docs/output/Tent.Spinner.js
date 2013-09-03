Ext.data.JsonP.Tent_Spinner({"tagname":"class","name":"Tent.Spinner","autodetected":{},"files":[{"filename":"tent.js","href":"tent.html#Tent-Spinner"}],"extends":"Tent.TextField","members":[{"name":"controlClass","tagname":"property","owner":"Tent.TextField","id":"property-controlClass","meta":{}},{"name":"disabled","tagname":"property","owner":"Tent.FieldSupport","id":"property-disabled","meta":{}},{"name":"formattedValue","tagname":"property","owner":"Tent.FieldSupport","id":"property-formattedValue","meta":{}},{"name":"hasPrefix","tagname":"property","owner":"Tent.FieldSupport","id":"property-hasPrefix","meta":{}},{"name":"helpBlock","tagname":"property","owner":"Tent.FieldSupport","id":"property-helpBlock","meta":{}},{"name":"isEditable","tagname":"property","owner":"Tent.FieldSupport","id":"property-isEditable","meta":{}},{"name":"label","tagname":"property","owner":"Tent.FieldSupport","id":"property-label","meta":{}},{"name":"placeholder","tagname":"property","owner":"Tent.FieldSupport","id":"property-placeholder","meta":{}},{"name":"prefix","tagname":"property","owner":"Tent.FieldSupport","id":"property-prefix","meta":{}},{"name":"readOnly","tagname":"property","owner":"Tent.FieldSupport","id":"property-readOnly","meta":{}},{"name":"required","tagname":"property","owner":"Tent.MandatorySupport","id":"property-required","meta":{}},{"name":"serializedValue","tagname":"property","owner":"Tent.FieldSupport","id":"property-serializedValue","meta":{}},{"name":"span","tagname":"property","owner":"Tent.SpanSupport","id":"property-span","meta":{}},{"name":"textDisplay","tagname":"property","owner":"Tent.FieldSupport","id":"property-textDisplay","meta":{}},{"name":"tooltip","tagname":"property","owner":"Tent.TooltipSupport","id":"property-tooltip","meta":{}},{"name":"type","tagname":"property","owner":"Tent.TextField","id":"property-type","meta":{}},{"name":"validations","tagname":"property","owner":"Tent.ValidationSupport","id":"property-validations","meta":{}},{"name":"value","tagname":"property","owner":"Tent.FieldSupport","id":"property-value","meta":{}},{"name":"vspan","tagname":"property","owner":"Tent.SpanSupport","id":"property-vspan","meta":{}},{"name":"warnings","tagname":"property","owner":"Tent.ValidationSupport","id":"property-warnings","meta":{}}],"alternateClassNames":[],"aliases":{},"id":"class-Tent.Spinner","short_doc":"Usage\n      {{view Tent.Spinner label=\"\"\n                    valueBinding=\"\"\n                    minBinding=\"\"\n      ...","component":false,"superclasses":["Tent.TextField"],"subclasses":[],"mixedInto":[],"mixins":[],"parentMixins":["Tent.FieldSupport","Tent.FormattingSupport","Tent.TooltipSupport"],"requires":[],"uses":[],"html":"<div><pre class=\"hierarchy\"><h4>Hierarchy</h4><div class='subclass first-child'><a href='#!/api/Tent.TextField' rel='Tent.TextField' class='docClass'>Tent.TextField</a><div class='subclass '><strong>Tent.Spinner</strong></div></div><h4>Inherited mixins</h4><div class='dependency'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='docClass'>Tent.FieldSupport</a></div><div class='dependency'><a href='#!/api/Tent.FormattingSupport' rel='Tent.FormattingSupport' class='docClass'>Tent.FormattingSupport</a></div><div class='dependency'><a href='#!/api/Tent.TooltipSupport' rel='Tent.TooltipSupport' class='docClass'>Tent.TooltipSupport</a></div><h4>Files</h4><div class='dependency'><a href='source/tent.html#Tent-Spinner' target='_blank'>tent.js</a></div></pre><div class='doc-contents'><p>Usage\n      {{view <a href=\"#!/api/Tent.Spinner\" rel=\"Tent.Spinner\" class=\"docClass\">Tent.Spinner</a> label=\"\"\n                    valueBinding=\"\"\n                    minBinding=\"\"\n                    maxBinding=\"\"\n         }}\n  value can be entered maually in the spinner.\n  To put restrictions on that use custom validation: valueBetween\n              {{view <a href=\"#!/api/Tent.Spinner\" rel=\"Tent.Spinner\" class=\"docClass\">Tent.Spinner</a> label=\"\"\n                        valueBinding=\"\"\n                        minBinding=\"\"\n                        maxBinding=\"\"\n                        validations=\"valueBetween\"\n                  validationOptions=\"{valueBetween:{min:2, max:20}}\"}}\n  To restrict only one min/max value, give the other as null <br/>\n            eg: validationOptions = \"{valueBetween:{min:null, max:20}}\"</p>\n</div><div class='members'><div class='members-section'><div class='definedBy'>Defined By</div><h3 class='members-title icon-property'>Properties</h3><div class='subsection'><div id='property-controlClass' class='member first-child inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.TextField' rel='Tent.TextField' class='defined-in docClass'>Tent.TextField</a><br/><a href='source/tent.html#Tent-TextField-property-controlClass' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.TextField-property-controlClass' class='name expandable'>controlClass</a> : String<span class=\"signature\"></span></div><div class='description'><div class='short'>Additional classes to be added to the input field (not added to the wrapping elements) ...</div><div class='long'><p>Additional classes to be added to the input field (not added to the wrapping elements)</p>\n<p>Defaults to: <code>''</code></p></div></div></div><div id='property-disabled' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-disabled' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-disabled' class='name expandable'>disabled</a> : String<span class=\"signature\"></span></div><div class='description'><div class='short'>A boolean indicating that the field is disabled. ...</div><div class='long'><p>A boolean indicating that the field is disabled.\nWhen disabled, the user is prevented from interacting with the field. In addition, if the field\nis tied to a form, its value will not be included in the form submission</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-formattedValue' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-formattedValue' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-formattedValue' class='name expandable'>formattedValue</a> : String<span class=\"signature\"></span></div><div class='description'><div class='short'><p>The current value of the field in its formatted form.</p>\n</div><div class='long'><p>The current value of the field in its formatted form.</p>\n</div></div></div><div id='property-hasPrefix' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-hasPrefix' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-hasPrefix' class='name expandable'>hasPrefix</a> : Boolean<span class=\"signature\"></span></div><div class='description'><div class='short'>A boolean indicating whether a prefix should be displayed before the value ...</div><div class='long'><p>A boolean indicating whether a prefix should be displayed before the value</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-helpBlock' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-helpBlock' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-helpBlock' class='name expandable'>helpBlock</a> : String<span class=\"signature\"></span></div><div class='description'><div class='short'><p>A block of text which provides additional help for completing the field</p>\n</div><div class='long'><p>A block of text which provides additional help for completing the field</p>\n</div></div></div><div id='property-isEditable' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-isEditable' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-isEditable' class='name expandable'>isEditable</a> : Boolean<span class=\"signature\"></span></div><div class='description'><div class='short'>A boolean value indicating whether the field is editable ...</div><div class='long'><p>A boolean value indicating whether the field is editable</p>\n<p>Defaults to: <code>true</code></p></div></div></div><div id='property-label' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-label' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-label' class='name expandable'>label</a> : String<span class=\"signature\"></span></div><div class='description'><div class='short'>The label for the field. ...</div><div class='long'><p>The label for the field.</p>\n<p>Defaults to: <code>&quot;&quot;</code></p></div></div></div><div id='property-placeholder' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-placeholder' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-placeholder' class='name expandable'>placeholder</a> : String<span class=\"signature\"></span></div><div class='description'><div class='short'>A block of descriptive text to display in the field, usually hint as to the expected content. ...</div><div class='long'><p>A block of descriptive text to display in the field, usually hint as to the expected content.\nThe placeholder will not be recognised as a value, and will be hidden when text is entered into the field.</p>\n</div></div></div><div id='property-prefix' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-prefix' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-prefix' class='name expandable'>prefix</a> : String<span class=\"signature\"></span></div><div class='description'><div class='short'><p>A string value to display as the prefix</p>\n</div><div class='long'><p>A string value to display as the prefix</p>\n</div></div></div><div id='property-readOnly' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-readOnly' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-readOnly' class='name expandable'>readOnly</a> : String<span class=\"signature\"></span></div><div class='description'><div class='short'>A boolean indicating that the field is read-only. ...</div><div class='long'><p>A boolean indicating that the field is read-only.\nAlthough this allows the user to interact with the field (highlight, copy etc), they are not able to change\nits value.</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-required' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.MandatorySupport' rel='Tent.MandatorySupport' class='defined-in docClass'>Tent.MandatorySupport</a><br/><a href='source/tent.html#Tent-MandatorySupport-property-required' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.MandatorySupport-property-required' class='name expandable'>required</a> : Boolean<span class=\"signature\"></span></div><div class='description'><div class='short'>Boolean property to determine whether a value must be provided ...</div><div class='long'><p>Boolean property to determine whether a value must be provided</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-serializedValue' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-serializedValue' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-serializedValue' class='name expandable'>serializedValue</a> : Object<span class=\"signature\"></span></div><div class='description'><div class='short'>If a serializer has been defined, this will contain the serialized\nvalue. ...</div><div class='long'><p>If a serializer has been defined, this will contain the serialized\nvalue. If this value is set, a deserialized version of it will be set on the 'value' property</p>\n</div></div></div><div id='property-span' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.SpanSupport' rel='Tent.SpanSupport' class='defined-in docClass'>Tent.SpanSupport</a><br/><a href='source/tent.html#Tent-SpanSupport-property-span' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.SpanSupport-property-span' class='name expandable'>span</a> : Number<span class=\"signature\"></span></div><div class='description'><div class='short'><p>The horizontal span which should be allocated to this widget</p>\n</div><div class='long'><p>The horizontal span which should be allocated to this widget</p>\n</div></div></div><div id='property-textDisplay' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-textDisplay' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-textDisplay' class='name expandable'>textDisplay</a> : Boolean<span class=\"signature\"></span></div><div class='description'><div class='short'>When set to true, the formatted value of the widget will be displayed,\nrather than the widget itself. ...</div><div class='long'><p>When set to true, the formatted value of the widget will be displayed,\nrather than the widget itself.</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-tooltip' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.TooltipSupport' rel='Tent.TooltipSupport' class='defined-in docClass'>Tent.TooltipSupport</a><br/><a href='source/tent.html#Tent-TooltipSupport-property-tooltip' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.TooltipSupport-property-tooltip' class='name expandable'>tooltip</a> : String<span class=\"signature\"></span></div><div class='description'><div class='short'><p>A detailed information message presented as a hover-icon beside the field</p>\n</div><div class='long'><p>A detailed information message presented as a hover-icon beside the field</p>\n</div></div></div><div id='property-type' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.TextField' rel='Tent.TextField' class='defined-in docClass'>Tent.TextField</a><br/><a href='source/tent.html#Tent-TextField-property-type' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.TextField-property-type' class='name expandable'>type</a> : String<span class=\"signature\"></span></div><div class='description'><div class='short'>The type of the input element ('text', 'password' etc) ...</div><div class='long'><p>The type of the input element ('text', 'password' etc)</p>\n<p>Defaults to: <code>'text'</code></p></div></div></div><div id='property-validations' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.ValidationSupport' rel='Tent.ValidationSupport' class='defined-in docClass'>Tent.ValidationSupport</a><br/><a href='source/tent.html#Tent-ValidationSupport-property-validations' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.ValidationSupport-property-validations' class='name expandable'>validations</a> : String <span class=\"signature\"></span></div><div class='description'><div class='short'><p>A list of comma-separated custom validations which should be applied to the widget</p>\n</div><div class='long'><p>A list of comma-separated custom validations which should be applied to the widget</p>\n</div></div></div><div id='property-value' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-value' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-value' class='name expandable'>value</a> : String<span class=\"signature\"></span></div><div class='description'><div class='short'><p>The current value of the field.</p>\n</div><div class='long'><p>The current value of the field.</p>\n</div></div></div><div id='property-vspan' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.SpanSupport' rel='Tent.SpanSupport' class='defined-in docClass'>Tent.SpanSupport</a><br/><a href='source/tent.html#Tent-SpanSupport-property-vspan' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.SpanSupport-property-vspan' class='name expandable'>vspan</a> : Number<span class=\"signature\"></span></div><div class='description'><div class='short'><p>The vertical span which should be allocated to this widget</p>\n</div><div class='long'><p>The vertical span which should be allocated to this widget</p>\n</div></div></div><div id='property-warnings' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.ValidationSupport' rel='Tent.ValidationSupport' class='defined-in docClass'>Tent.ValidationSupport</a><br/><a href='source/tent.html#Tent-ValidationSupport-property-warnings' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.ValidationSupport-property-warnings' class='name expandable'>warnings</a> : String<span class=\"signature\"></span></div><div class='description'><div class='short'>A list of comma-separated custom validations which should be applied to the widget, but are interpreted\nas warnings w...</div><div class='long'><p>A list of comma-separated custom validations which should be applied to the widget, but are interpreted\nas warnings which may be ignored.</p>\n</div></div></div></div></div></div></div>","meta":{}});