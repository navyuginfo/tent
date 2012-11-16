Ext.data.JsonP.Tent_SlickGrid({"tagname":"class","name":"Tent.SlickGrid","extends":null,"mixins":["Tent.FieldSupport","Tent.GridPagingSupport","Tent.GridSortingSupport","Tent.GridFilteringSupport"],"alternateClassNames":[],"aliases":{},"singleton":false,"requires":[],"uses":[],"enum":null,"override":null,"inheritable":null,"inheritdoc":null,"meta":{},"private":null,"id":"class-Tent.SlickGrid","members":{"cfg":[],"property":[{"name":"collection","tagname":"property","owner":"Tent.SlickGrid","meta":{},"id":"property-collection"},{"name":"dataStore","tagname":"property","owner":"Tent.SlickGrid","meta":{},"id":"property-dataStore"},{"name":"dataType","tagname":"property","owner":"Tent.SlickGrid","meta":{},"id":"property-dataType"},{"name":"disabled","tagname":"property","owner":"Tent.FieldSupport","meta":{},"id":"property-disabled"},{"name":"formLayout","tagname":"property","owner":"Tent.SlickGrid","meta":{},"id":"property-formLayout"},{"name":"formattedValue","tagname":"property","owner":"Tent.FieldSupport","meta":{},"id":"property-formattedValue"},{"name":"hasPrefix","tagname":"property","owner":"Tent.FieldSupport","meta":{},"id":"property-hasPrefix"},{"name":"helpBlock","tagname":"property","owner":"Tent.FieldSupport","meta":{},"id":"property-helpBlock"},{"name":"isEditable","tagname":"property","owner":"Tent.FieldSupport","meta":{},"id":"property-isEditable"},{"name":"label","tagname":"property","owner":"Tent.FieldSupport","meta":{},"id":"property-label"},{"name":"multiSelect","tagname":"property","owner":"Tent.SlickGrid","meta":{},"id":"property-multiSelect"},{"name":"paged","tagname":"property","owner":"Tent.GridPagingSupport","meta":{},"id":"property-paged"},{"name":"placeholder","tagname":"property","owner":"Tent.FieldSupport","meta":{},"id":"property-placeholder"},{"name":"prefix","tagname":"property","owner":"Tent.FieldSupport","meta":{},"id":"property-prefix"},{"name":"readOnly","tagname":"property","owner":"Tent.FieldSupport","meta":{},"id":"property-readOnly"},{"name":"remotePaging","tagname":"property","owner":"Tent.GridPagingSupport","meta":{},"id":"property-remotePaging"},{"name":"required","tagname":"property","owner":"Tent.MandatorySupport","meta":{},"id":"property-required"},{"name":"span","tagname":"property","owner":"Tent.SpanSupport","meta":{},"id":"property-span"},{"name":"textDisplay","tagname":"property","owner":"Tent.FieldSupport","meta":{},"id":"property-textDisplay"},{"name":"useColumnFilters","tagname":"property","owner":"Tent.GridFilteringSupport","meta":{},"id":"property-useColumnFilters"},{"name":"validations","tagname":"property","owner":"Tent.ValidationSupport","meta":{},"id":"property-validations"},{"name":"value","tagname":"property","owner":"Tent.FieldSupport","meta":{},"id":"property-value"},{"name":"vspan","tagname":"property","owner":"Tent.SpanSupport","meta":{},"id":"property-vspan"},{"name":"warnings","tagname":"property","owner":"Tent.ValidationSupport","meta":{},"id":"property-warnings"}],"method":[],"event":[],"css_var":[],"css_mixin":[]},"linenr":2233,"files":[{"filename":"tent.js","href":"tent.html#Tent-SlickGrid"}],"html_meta":{},"statics":{"cfg":[],"property":[],"method":[],"event":[],"css_var":[],"css_mixin":[]},"component":false,"superclasses":[],"subclasses":[],"mixedInto":[],"parentMixins":[],"html":"<div><pre class=\"hierarchy\"><h4>Mixins</h4><div class='dependency'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='docClass'>Tent.FieldSupport</a></div><div class='dependency'><a href='#!/api/Tent.GridFilteringSupport' rel='Tent.GridFilteringSupport' class='docClass'>Tent.GridFilteringSupport</a></div><div class='dependency'><a href='#!/api/Tent.GridPagingSupport' rel='Tent.GridPagingSupport' class='docClass'>Tent.GridPagingSupport</a></div><div class='dependency'><a href='#!/api/Tent.GridSortingSupport' rel='Tent.GridSortingSupport' class='docClass'>Tent.GridSortingSupport</a></div><h4>Files</h4><div class='dependency'><a href='source/tent.html#Tent-SlickGrid' target='_blank'>tent.js</a></div></pre><div class='doc-contents'><p>An advanced grid widget with support for paging, sorting, filtering, column-reordering, column resizing and infinite paging.</p>\n\n<h2>Usage</h2>\n\n<p>The data to be displayed in the grid is maintained in a <a href=\"#!/api/Tent.Data.Collection\" rel=\"Tent.Data.Collection\" class=\"docClass\">Tent.Data.Collection</a> object. The collection will provide the grid\nwith column and paging information, and act as a facade for paging, sorting and filtering the data.\nYou may provide a collection to the grid explicitly using the <a href=\"#!/api/Tent.SlickGrid-property-collection\" rel=\"Tent.SlickGrid-property-collection\" class=\"docClass\">collection</a> property, or allow the grid to create\na collection by providing it with <a href=\"#!/api/Tent.SlickGrid-property-dataStore\" rel=\"Tent.SlickGrid-property-dataStore\" class=\"docClass\">dataStore</a> and <a href=\"#!/api/Tent.SlickGrid-property-dataType\" rel=\"Tent.SlickGrid-property-dataType\" class=\"docClass\">dataType</a> properties.</p>\n\n<p>You may determine whether the collection is paged through the <a href=\"#!/api/Tent.SlickGrid-property-paged\" rel=\"Tent.SlickGrid-property-paged\" class=\"docClass\">paged</a> property, and you may optionally provide a\npageSize. By default, the grid will perform paging on the data that it is initially provided with.\nIf <a href=\"#!/api/Tent.SlickGrid-property-remotePaging\" rel=\"Tent.SlickGrid-property-remotePaging\" class=\"docClass\">remotePaging</a> is set to true, only the first page will be given to the grid initially, and further paging\nwill fetch pages from the server.</p>\n\n<p>The object(s) selected from the grid will be stored in the property defined by {#selection}.\nMultiple items can be selected by turning <a href=\"#!/api/Tent.SlickGrid-property-multiSelect\" rel=\"Tent.SlickGrid-property-multiSelect\" class=\"docClass\">multiSelect</a> on.</p>\n\n<pre><code>   {{view <a href=\"#!/api/Tent.SlickGrid\" rel=\"Tent.SlickGrid\" class=\"docClass\">Tent.SlickGrid</a>\n              label=\"\"\n              collectionBinding=\"\"\n              selectionBinding=\"\"\n              paged=true\n              pageSize=5\n              remotePaging=false\n              multiSelect=false\n              useColumnFilters=false\n          }}\n</code></pre>\n</div><div class='members'><div class='members-section'><div class='definedBy'>Defined By</div><h3 class='members-title icon-property'>Properties</h3><div class='subsection'><div id='property-collection' class='member first-child not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.SlickGrid'>Tent.SlickGrid</span><br/><a href='source/tent.html#Tent-SlickGrid-property-collection' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.SlickGrid-property-collection' class='name expandable'>collection</a><span> : <a href=\"#!/api/Tent.Data.Collection\" rel=\"Tent.Data.Collection\" class=\"docClass\">Tent.Data.Collection</a></span></div><div class='description'><div class='short'>A collection which provides access to the list data. ...</div><div class='long'><p>A collection which provides access to the list data. If a collection is not\nprovided, the grid will create one on initialization.</p>\n</div></div></div><div id='property-dataStore' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.SlickGrid'>Tent.SlickGrid</span><br/><a href='source/tent.html#Tent-SlickGrid-property-dataStore' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.SlickGrid-property-dataStore' class='name not-expandable'>dataStore</a><span> : Object</span></div><div class='description'><div class='short'><p>An implementation of a {DataStore} which is used to populate the collection.</p>\n</div><div class='long'><p>An implementation of a {DataStore} which is used to populate the collection.</p>\n</div></div></div><div id='property-dataType' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.SlickGrid'>Tent.SlickGrid</span><br/><a href='source/tent.html#Tent-SlickGrid-property-dataType' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.SlickGrid-property-dataType' class='name expandable'>dataType</a><span> : String</span></div><div class='description'><div class='short'>The data type of the objects that are managed by the grid. ...</div><div class='long'><p>The data type of the objects that are managed by the grid.\nIf a collection is not provided (by the {<a href=\"#!/api/Tent.SlickGrid-property-collection\" rel=\"Tent.SlickGrid-property-collection\" class=\"docClass\">collection</a>} property), the slickgrid will create a collection\nusing the dataType and {<a href=\"#!/api/Tent.SlickGrid-property-dataStore\" rel=\"Tent.SlickGrid-property-dataStore\" class=\"docClass\">dataStore</a>} properties</p>\n</div></div></div><div id='property-disabled' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-disabled' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-disabled' class='name expandable'>disabled</a><span> : String</span></div><div class='description'><div class='short'>A boolean indicating that the field is disabled. ...</div><div class='long'><p>A boolean indicating that the field is disabled.\nWhen disabled, the user is prevented from interacting with the field. In addition, if the field\nis tied to a form, its value will not be included in the form submission</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-formLayout' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.SlickGrid'>Tent.SlickGrid</span><br/><a href='source/tent.html#Tent-SlickGrid-property-formLayout' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.SlickGrid-property-formLayout' class='name expandable'>formLayout</a><span> : String</span></div><div class='description'><div class='short'>Defines the layout environment into which the grid is being placed. ...</div><div class='long'><p>Defines the layout environment into which the grid is being placed.\nPossible values are:</p>\n\n<ul>\n<li><p><strong>form</strong>:  the grid is a form field, and should be displayed similar to other fields, with a positioned label.</p></li>\n<li><p><strong>wide</strong>:  the grid is not displayed in a form, and will fill the entire width of its container.</p></li>\n</ul>\n\n<p>Defaults to: <code>form</code></p></div></div></div><div id='property-formattedValue' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-formattedValue' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-formattedValue' class='name not-expandable'>formattedValue</a><span> : String</span></div><div class='description'><div class='short'><p>The current value of the field in its formatted form.</p>\n</div><div class='long'><p>The current value of the field in its formatted form.</p>\n</div></div></div><div id='property-hasPrefix' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-hasPrefix' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-hasPrefix' class='name expandable'>hasPrefix</a><span> : Boolean</span></div><div class='description'><div class='short'>A boolean indicating whether a prefix should be displayed before the value ...</div><div class='long'><p>A boolean indicating whether a prefix should be displayed before the value</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-helpBlock' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-helpBlock' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-helpBlock' class='name not-expandable'>helpBlock</a><span> : String</span></div><div class='description'><div class='short'><p>A block of text which provides additional help for completing the field</p>\n</div><div class='long'><p>A block of text which provides additional help for completing the field</p>\n</div></div></div><div id='property-isEditable' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-isEditable' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-isEditable' class='name expandable'>isEditable</a><span> : Boolean</span></div><div class='description'><div class='short'>A boolean value indicating whether the field is editable ...</div><div class='long'><p>A boolean value indicating whether the field is editable</p>\n<p>Defaults to: <code>true</code></p></div></div></div><div id='property-label' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-label' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-label' class='name expandable'>label</a><span> : String</span></div><div class='description'><div class='short'>The label for the field. ...</div><div class='long'><p>The label for the field.</p>\n<p>Defaults to: <code>&quot;&quot;</code></p></div></div></div><div id='property-multiSelect' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.SlickGrid'>Tent.SlickGrid</span><br/><a href='source/tent.html#Tent-SlickGrid-property-multiSelect' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.SlickGrid-property-multiSelect' class='name expandable'>multiSelect</a><span> : Boolean</span></div><div class='description'><div class='short'>A boolean property to determine whether multiple items can be selected ...</div><div class='long'><p>A boolean property to determine whether multiple items can be selected</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-paged' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.GridPagingSupport' rel='Tent.GridPagingSupport' class='defined-in docClass'>Tent.GridPagingSupport</a><br/><a href='source/tent.html#Tent-GridPagingSupport-property-paged' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.GridPagingSupport-property-paged' class='name expandable'>paged</a><span> : Boolean</span></div><div class='description'><div class='short'>A boolean indicating whether paging is to be supported ...</div><div class='long'><p>A boolean indicating whether paging is to be supported</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-placeholder' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-placeholder' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-placeholder' class='name expandable'>placeholder</a><span> : String</span></div><div class='description'><div class='short'>A block of descriptive text to display in the field, usually hint as to the expected content. ...</div><div class='long'><p>A block of descriptive text to display in the field, usually hint as to the expected content.\nThe placeholder will not be recognised as a value, and will be hidden when text is entered into the field.</p>\n</div></div></div><div id='property-prefix' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-prefix' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-prefix' class='name not-expandable'>prefix</a><span> : String</span></div><div class='description'><div class='short'><p>A string value to display as the prefix</p>\n</div><div class='long'><p>A string value to display as the prefix</p>\n</div></div></div><div id='property-readOnly' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-readOnly' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-readOnly' class='name expandable'>readOnly</a><span> : String</span></div><div class='description'><div class='short'>A boolean indicating that the field is read-only. ...</div><div class='long'><p>A boolean indicating that the field is read-only.\nAlthough this allows the user to interact with the field (highlight, copy etc), they are not able to change\nits value.</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-remotePaging' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.GridPagingSupport' rel='Tent.GridPagingSupport' class='defined-in docClass'>Tent.GridPagingSupport</a><br/><a href='source/tent.html#Tent-GridPagingSupport-property-remotePaging' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.GridPagingSupport-property-remotePaging' class='name expandable'>remotePaging</a><span> : Boolean</span></div><div class='description'><div class='short'>A boolean indicating whether paging, sorting and filtering\nare performed on the server ...</div><div class='long'><p>A boolean indicating whether paging, sorting and filtering\nare performed on the server</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-required' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.MandatorySupport' rel='Tent.MandatorySupport' class='defined-in docClass'>Tent.MandatorySupport</a><br/><a href='source/tent.html#Tent-MandatorySupport-property-required' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.MandatorySupport-property-required' class='name expandable'>required</a><span> : Boolean</span></div><div class='description'><div class='short'>Boolean property to determine whether a value must be provided ...</div><div class='long'><p>Boolean property to determine whether a value must be provided</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-span' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.SpanSupport' rel='Tent.SpanSupport' class='defined-in docClass'>Tent.SpanSupport</a><br/><a href='source/tent.html#Tent-SpanSupport-property-span' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.SpanSupport-property-span' class='name not-expandable'>span</a><span> : Number</span></div><div class='description'><div class='short'><p>The horizontal span which should be allocated to this widget</p>\n</div><div class='long'><p>The horizontal span which should be allocated to this widget</p>\n</div></div></div><div id='property-textDisplay' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-textDisplay' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-textDisplay' class='name expandable'>textDisplay</a><span> : Boolean</span></div><div class='description'><div class='short'>When set to true, the formatted value of the widget will be displayed,\nrather than the widget itself. ...</div><div class='long'><p>When set to true, the formatted value of the widget will be displayed,\nrather than the widget itself.</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-useColumnFilters' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.GridFilteringSupport' rel='Tent.GridFilteringSupport' class='defined-in docClass'>Tent.GridFilteringSupport</a><br/><a href='source/tent.html#Tent-GridFilteringSupport-property-useColumnFilters' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.GridFilteringSupport-property-useColumnFilters' class='name expandable'>useColumnFilters</a><span> : Boolean</span></div><div class='description'><div class='short'>Display a freetext filter above each column to act as client-side filters. ...</div><div class='long'><p>Display a freetext filter above each column to act as client-side filters.</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-validations' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.ValidationSupport' rel='Tent.ValidationSupport' class='defined-in docClass'>Tent.ValidationSupport</a><br/><a href='source/tent.html#Tent-ValidationSupport-property-validations' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.ValidationSupport-property-validations' class='name not-expandable'>validations</a><span> : String </span></div><div class='description'><div class='short'><p>A list of comma-separated custom validations which should be applied to the widget</p>\n</div><div class='long'><p>A list of comma-separated custom validations which should be applied to the widget</p>\n</div></div></div><div id='property-value' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.FieldSupport' rel='Tent.FieldSupport' class='defined-in docClass'>Tent.FieldSupport</a><br/><a href='source/tent.html#Tent-FieldSupport-property-value' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.FieldSupport-property-value' class='name not-expandable'>value</a><span> : String</span></div><div class='description'><div class='short'><p>The current value of the field.</p>\n</div><div class='long'><p>The current value of the field.</p>\n</div></div></div><div id='property-vspan' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.SpanSupport' rel='Tent.SpanSupport' class='defined-in docClass'>Tent.SpanSupport</a><br/><a href='source/tent.html#Tent-SpanSupport-property-vspan' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.SpanSupport-property-vspan' class='name not-expandable'>vspan</a><span> : Number</span></div><div class='description'><div class='short'><p>The vertical span which should be allocated to this widget</p>\n</div><div class='long'><p>The vertical span which should be allocated to this widget</p>\n</div></div></div><div id='property-warnings' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.ValidationSupport' rel='Tent.ValidationSupport' class='defined-in docClass'>Tent.ValidationSupport</a><br/><a href='source/tent.html#Tent-ValidationSupport-property-warnings' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.ValidationSupport-property-warnings' class='name expandable'>warnings</a><span> : String</span></div><div class='description'><div class='short'>A list of comma-separated custom validations which should be applied to the widget, but are interpreted\nas warnings w...</div><div class='long'><p>A list of comma-separated custom validations which should be applied to the widget, but are interpreted\nas warnings which may be ignored.</p>\n</div></div></div></div></div></div></div>"});