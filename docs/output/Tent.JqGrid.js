Ext.data.JsonP.Tent_JqGrid({"tagname":"class","name":"Tent.JqGrid","autodetected":{},"files":[{"filename":"tent.js","href":"tent.html#Tent-JqGrid"}],"mixins":["Tent.Grid.Adapters","Tent.Grid.CollectionSupport","Tent.Grid.ColumnChooserSupport","Tent.Grid.ColumnMenu","Tent.Grid.EditableSupport","Tent.Grid.ExportSupport","Tent.Grid.GroupingSupport","Tent.Grid.HorizontalScrollSupport","Tent.Grid.Maximize","Tent.Grid.SelectionSupport","Tent.MandatorySupport","Tent.ValidationSupport"],"members":[{"name":"ShowAutofitButton","tagname":"property","owner":"Tent.Grid.Maximize","id":"property-ShowAutofitButton","meta":{}},{"name":"autofitIfSpaceAvailable","tagname":"property","owner":"Tent.Grid.Maximize","id":"property-autofitIfSpaceAvailable","meta":{}},{"name":"clearAction","tagname":"property","owner":"Tent.JqGrid","id":"property-clearAction","meta":{}},{"name":"collection","tagname":"property","owner":"Tent.Grid.CollectionSupport","id":"property-collection","meta":{}},{"name":"columns","tagname":"property","owner":"Tent.JqGrid","id":"property-columns","meta":{}},{"name":"content","tagname":"property","owner":"Tent.JqGrid","id":"property-content","meta":{}},{"name":"enabledExports","tagname":"property","owner":"Tent.Grid.ExportSupport","id":"property-enabledExports","meta":{}},{"name":"filtering","tagname":"property","owner":"Tent.JqGrid","id":"property-filtering","meta":{}},{"name":"fixedHeader","tagname":"property","owner":"Tent.JqGrid","id":"property-fixedHeader","meta":{}},{"name":"fixedRowsCount","tagname":"property","owner":"Tent.JqGrid","id":"property-fixedRowsCount","meta":{}},{"name":"footerRow","tagname":"property","owner":"Tent.JqGrid","id":"property-footerRow","meta":{}},{"name":"groupField","tagname":"property","owner":"Tent.JqGrid","id":"property-groupField","meta":{}},{"name":"grouping","tagname":"property","owner":"Tent.JqGrid","id":"property-grouping","meta":{}},{"name":"horizontalScrolling","tagname":"property","owner":"Tent.Grid.Maximize","id":"property-horizontalScrolling","meta":{}},{"name":"multiSelect","tagname":"property","owner":"Tent.JqGrid","id":"property-multiSelect","meta":{}},{"name":"onEditRow","tagname":"property","owner":"Tent.Grid.EditableSupport","id":"property-onEditRow","meta":{}},{"name":"onRestoreRow","tagname":"property","owner":"Tent.Grid.EditableSupport","id":"property-onRestoreRow","meta":{}},{"name":"onSaveCell","tagname":"property","owner":"Tent.Grid.EditableSupport","id":"property-onSaveCell","meta":{}},{"name":"pageSize","tagname":"property","owner":"Tent.Grid.CollectionSupport","id":"property-pageSize","meta":{}},{"name":"paged","tagname":"property","owner":"Tent.Grid.CollectionSupport","id":"property-paged","meta":{}},{"name":"required","tagname":"property","owner":"Tent.MandatorySupport","id":"property-required","meta":{}},{"name":"selection","tagname":"property","owner":"Tent.JqGrid","id":"property-selection","meta":{}},{"name":"showColumnChooser","tagname":"property","owner":"Tent.Grid.ColumnChooserSupport","id":"property-showColumnChooser","meta":{}},{"name":"showExportButton","tagname":"property","owner":"Tent.Grid.ExportSupport","id":"property-showExportButton","meta":{}},{"name":"showGroupTitle","tagname":"property","owner":"Tent.Grid.GroupingSupport","id":"property-showGroupTitle","meta":{}},{"name":"showMaximizeButton","tagname":"property","owner":"Tent.Grid.Maximize","id":"property-showMaximizeButton","meta":{}},{"name":"title","tagname":"property","owner":"Tent.JqGrid","id":"property-title","meta":{}},{"name":"validations","tagname":"property","owner":"Tent.ValidationSupport","id":"property-validations","meta":{}},{"name":"warnings","tagname":"property","owner":"Tent.ValidationSupport","id":"property-warnings","meta":{}},{"name":"clearSelection","tagname":"method","owner":"Tent.Grid.SelectionSupport","id":"method-clearSelection","meta":{}},{"name":"sendAction","tagname":"method","owner":"Tent.JqGrid","id":"method-sendAction","meta":{}}],"alternateClassNames":[],"aliases":{},"id":"class-Tent.JqGrid","short_doc":"Create a jqGrid view which displays the data provided by its content property\n\nUsage\n\n{{view Tent.JqGrid\n            ...","component":false,"superclasses":[],"subclasses":[],"mixedInto":[],"parentMixins":[],"requires":[],"uses":[],"html":"<div><pre class=\"hierarchy\"><h4>Mixins</h4><div class='dependency'>Tent.Grid.Adapters</div><div class='dependency'><a href='#!/api/Tent.Grid.CollectionSupport' rel='Tent.Grid.CollectionSupport' class='docClass'>Tent.Grid.CollectionSupport</a></div><div class='dependency'><a href='#!/api/Tent.Grid.ColumnChooserSupport' rel='Tent.Grid.ColumnChooserSupport' class='docClass'>Tent.Grid.ColumnChooserSupport</a></div><div class='dependency'>Tent.Grid.ColumnMenu</div><div class='dependency'><a href='#!/api/Tent.Grid.EditableSupport' rel='Tent.Grid.EditableSupport' class='docClass'>Tent.Grid.EditableSupport</a></div><div class='dependency'><a href='#!/api/Tent.Grid.ExportSupport' rel='Tent.Grid.ExportSupport' class='docClass'>Tent.Grid.ExportSupport</a></div><div class='dependency'><a href='#!/api/Tent.Grid.GroupingSupport' rel='Tent.Grid.GroupingSupport' class='docClass'>Tent.Grid.GroupingSupport</a></div><div class='dependency'>Tent.Grid.HorizontalScrollSupport</div><div class='dependency'><a href='#!/api/Tent.Grid.Maximize' rel='Tent.Grid.Maximize' class='docClass'>Tent.Grid.Maximize</a></div><div class='dependency'><a href='#!/api/Tent.Grid.SelectionSupport' rel='Tent.Grid.SelectionSupport' class='docClass'>Tent.Grid.SelectionSupport</a></div><div class='dependency'><a href='#!/api/Tent.MandatorySupport' rel='Tent.MandatorySupport' class='docClass'>Tent.MandatorySupport</a></div><div class='dependency'><a href='#!/api/Tent.ValidationSupport' rel='Tent.ValidationSupport' class='docClass'>Tent.ValidationSupport</a></div><h4>Files</h4><div class='dependency'><a href='source/tent.html#Tent-JqGrid' target='_blank'>tent.js</a></div></pre><div class='doc-contents'><p>Create a jqGrid view which displays the data provided by its content property</p>\n\n<h2>Usage</h2>\n\n<pre><code>{{view <a href=\"#!/api/Tent.JqGrid\" rel=\"Tent.JqGrid\" class=\"docClass\">Tent.JqGrid</a>\n                label=\"Tasks\"\n                collectionBinding=\"Pad.collection\"\n                selectionBinding=\"Pad.selectedTasks\"\n                multiSelect=true             \n            }}\n</code></pre>\n\n<ul>\n<li>collection: A collection representing an array of records, one for each row of the grid.</li>\n<li>selection: An array of selected objects. This will provide the initial selections, as well as\ncontain the items selected from the grid.</li>\n</ul>\n\n\n<p>The content of the grid will be bound to the collection.\nThe columns for the grid will be bound to collection.columnsDescriptor</p>\n</div><div class='members'><div class='members-section'><div class='definedBy'>Defined By</div><h3 class='members-title icon-property'>Properties</h3><div class='subsection'><div id='property-ShowAutofitButton' class='member first-child inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.Grid.Maximize' rel='Tent.Grid.Maximize' class='defined-in docClass'>Tent.Grid.Maximize</a><br/><a href='source/tent.html#Tent-Grid-Maximize-property-ShowAutofitButton' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Grid.Maximize-property-ShowAutofitButton' class='name expandable'>ShowAutofitButton</a> : Boolean<span class=\"signature\"></span></div><div class='description'><div class='short'>Show or hide the autofit button on the grid header panel. ...</div><div class='long'><p>Show or hide the autofit button on the grid header panel.</p>\n\n<p>The autofit button will allow the grid to toggle between two modes</p>\n\n<ul>\n<li><strong>Autofit</strong>: All columns are resized to fit within the grid viewing area</li>\n<li><strong>Non-Autofit</strong>: All columns assume their natural width (using no wrapping) and a horizontal scrollbar is\ndisplayed if necessary</li>\n</ul>\n\n</div></div></div><div id='property-autofitIfSpaceAvailable' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.Grid.Maximize' rel='Tent.Grid.Maximize' class='defined-in docClass'>Tent.Grid.Maximize</a><br/><a href='source/tent.html#Tent-Grid-Maximize-property-autofitIfSpaceAvailable' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Grid.Maximize-property-autofitIfSpaceAvailable' class='name expandable'>autofitIfSpaceAvailable</a> : Boolean<span class=\"signature\"></span></div><div class='description'><div class='short'>If autofit is turned off, and there is free space in the grid, expand the\ncolumns to fit the free space. ...</div><div class='long'><p>If autofit is turned off, and there is free space in the grid, expand the\ncolumns to fit the free space.</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-clearAction' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.JqGrid'>Tent.JqGrid</span><br/><a href='source/tent.html#Tent-JqGrid-property-clearAction' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.JqGrid-property-clearAction' class='name expandable'>clearAction</a> : Boolean<span class=\"signature\"></span></div><div class='description'><div class='short'><p>Set this property to true to deselect all the selected items and restore all the editable fields.</p>\n</div><div class='long'><p>Set this property to true to deselect all the selected items and restore all the editable fields.</p>\n</div></div></div><div id='property-collection' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.Grid.CollectionSupport' rel='Tent.Grid.CollectionSupport' class='defined-in docClass'>Tent.Grid.CollectionSupport</a><br/><a href='source/tent.html#Tent-Grid-CollectionSupport-property-collection' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Grid.CollectionSupport-property-collection' class='name expandable'>collection</a> : Object<span class=\"signature\"></span></div><div class='description'><div class='short'><p>The collection object providing the API to the data source</p>\n</div><div class='long'><p>The collection object providing the API to the data source</p>\n</div></div></div><div id='property-columns' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.JqGrid'>Tent.JqGrid</span><br/><a href='source/tent.html#Tent-JqGrid-property-columns' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.JqGrid-property-columns' class='name expandable'>columns</a> : Array<span class=\"signature\"></span></div><div class='description'><div class='short'>The array of column descriptors used to represent the data. ...</div><div class='long'><p>The array of column descriptors used to represent the data.\nBy default this will be retrieved from the collection, if provided</p>\n</div></div></div><div id='property-content' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.JqGrid'>Tent.JqGrid</span><br/><a href='source/tent.html#Tent-JqGrid-property-content' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.JqGrid-property-content' class='name expandable'>content</a> : Array<span class=\"signature\"></span></div><div class='description'><div class='short'>The array of items to display in the grid. ...</div><div class='long'><p>The array of items to display in the grid.\nBy default this will be retrieved from the collection, if provided</p>\n</div></div></div><div id='property-enabledExports' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.Grid.ExportSupport' rel='Tent.Grid.ExportSupport' class='defined-in docClass'>Tent.Grid.ExportSupport</a><br/><a href='source/tent.html#Tent-Grid-ExportSupport-property-enabledExports' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Grid.ExportSupport-property-enabledExports' class='name expandable'>enabledExports</a> : Array<span class=\"signature\"></span></div><div class='description'><div class='short'>The list of export types which are allowed\nAny types listed here will appear as options in the grids Exports dropdown. ...</div><div class='long'><p>The list of export types which are allowed\nAny types listed here will appear as options in the grids Exports dropdown.</p>\n<p>Defaults to: <code>['xls', 'csv', 'json']</code></p></div></div></div><div id='property-filtering' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.JqGrid'>Tent.JqGrid</span><br/><a href='source/tent.html#Tent-JqGrid-property-filtering' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.JqGrid-property-filtering' class='name expandable'>filtering</a> : Boolean<span class=\"signature\"></span></div><div class='description'><div class='short'>A boolean to indicate that the grid can be filtered. ...</div><div class='long'><p>A boolean to indicate that the grid can be filtered.</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-fixedHeader' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.JqGrid'>Tent.JqGrid</span><br/><a href='source/tent.html#Tent-JqGrid-property-fixedHeader' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.JqGrid-property-fixedHeader' class='name expandable'>fixedHeader</a> : Boolean<span class=\"signature\"></span></div><div class='description'><div class='short'>Boolean indicating that the header remains in view when the content is scrolled. ...</div><div class='long'><p>Boolean indicating that the header remains in view when the content is scrolled.</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-fixedRowsCount' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.JqGrid'>Tent.JqGrid</span><br/><a href='source/tent.html#Tent-JqGrid-property-fixedRowsCount' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.JqGrid-property-fixedRowsCount' class='name expandable'>fixedRowsCount</a> : Integer<span class=\"signature\"></span></div><div class='description'><div class='short'>Displays rows count at the foot of the table for summary information ...</div><div class='long'><p>Displays rows count at the foot of the table for summary information</p>\n<p>Defaults to: <code>1</code></p></div></div></div><div id='property-footerRow' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.JqGrid'>Tent.JqGrid</span><br/><a href='source/tent.html#Tent-JqGrid-property-footerRow' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.JqGrid-property-footerRow' class='name expandable'>footerRow</a> : Boolean<span class=\"signature\"></span></div><div class='description'><div class='short'>Displays a row at the foot of the table for summary information ...</div><div class='long'><p>Displays a row at the foot of the table for summary information</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-groupField' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.JqGrid'>Tent.JqGrid</span><br/><a href='source/tent.html#Tent-JqGrid-property-groupField' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.JqGrid-property-groupField' class='name expandable'>groupField</a> : String<span class=\"signature\"></span></div><div class='description'><div class='short'><p>The name of the field by which to group the grid</p>\n</div><div class='long'><p>The name of the field by which to group the grid</p>\n</div></div></div><div id='property-grouping' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.JqGrid'>Tent.JqGrid</span><br/><a href='source/tent.html#Tent-JqGrid-property-grouping' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.JqGrid-property-grouping' class='name expandable'>grouping</a> : Boolean<span class=\"signature\"></span></div><div class='description'><div class='short'>A boolean to indicate that the grid can be grouped. ...</div><div class='long'><p>A boolean to indicate that the grid can be grouped.</p>\n<p>Defaults to: <code>true</code></p></div></div></div><div id='property-horizontalScrolling' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.Grid.Maximize' rel='Tent.Grid.Maximize' class='defined-in docClass'>Tent.Grid.Maximize</a><br/><a href='source/tent.html#Tent-Grid-Maximize-property-horizontalScrolling' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Grid.Maximize-property-horizontalScrolling' class='name expandable'>horizontalScrolling</a> : Boolean<span class=\"signature\"></span></div><div class='description'><div class='short'>Allow the grid content to scroll horizontally. ...</div><div class='long'><p>Allow the grid content to scroll horizontally.\nThis property defines whether the grid content will be forced to fit within the area assiged to the grid (false),\nor whether the columns will disregard the grid width. The actual column widths will be the greater of the column\ntitle width and the column content</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-multiSelect' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.JqGrid'>Tent.JqGrid</span><br/><a href='source/tent.html#Tent-JqGrid-property-multiSelect' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.JqGrid-property-multiSelect' class='name expandable'>multiSelect</a> : Boolean<span class=\"signature\"></span></div><div class='description'><div class='short'>Boolean indicating that the list is a multi-select list ...</div><div class='long'><p>Boolean indicating that the list is a multi-select list</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-onEditRow' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.Grid.EditableSupport' rel='Tent.Grid.EditableSupport' class='defined-in docClass'>Tent.Grid.EditableSupport</a><br/><a href='source/tent.html#Tent-Grid-EditableSupport-property-onEditRow' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Grid.EditableSupport-property-onEditRow' class='name expandable'>onEditRow</a> : Function<span class=\"signature\"></span></div><div class='description'><div class='short'>A callback function which will be called when a row is made editable. ...</div><div class='long'><p>A callback function which will be called when a row is made editable.\nThe context of the function is this JqGrid View, and it will accept the following parameters:</p>\n\n<p>-rowId: the id of the selected row\n-grid: the jqGrid</p>\n</div></div></div><div id='property-onRestoreRow' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.Grid.EditableSupport' rel='Tent.Grid.EditableSupport' class='defined-in docClass'>Tent.Grid.EditableSupport</a><br/><a href='source/tent.html#Tent-Grid-EditableSupport-property-onRestoreRow' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Grid.EditableSupport-property-onRestoreRow' class='name expandable'>onRestoreRow</a> : Function<span class=\"signature\"></span></div><div class='description'><div class='short'>A callback function which will be called when editing of a row is cancelled,\nand the original values restored to the ...</div><div class='long'><p>A callback function which will be called when editing of a row is cancelled,\nand the original values restored to the cells.\nThe context of the function is this JqGrid View, and it will accept the following parameters:</p>\n\n<p>-rowId: the id of the selected row\n-grid: the jqGrid</p>\n</div></div></div><div id='property-onSaveCell' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.Grid.EditableSupport' rel='Tent.Grid.EditableSupport' class='defined-in docClass'>Tent.Grid.EditableSupport</a><br/><a href='source/tent.html#Tent-Grid-EditableSupport-property-onSaveCell' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Grid.EditableSupport-property-onSaveCell' class='name expandable'>onSaveCell</a> : Function<span class=\"signature\"></span></div><div class='description'><div class='short'>A callback function which will be called when an editable cell is saved. ...</div><div class='long'><p>A callback function which will be called when an editable cell is saved. (This\nusually occurs on change or blur)\nThe context of the function is this JqGrid View, and it will accept the following parameters:</p>\n\n<p>-rowId: the id of the selected row\n-grid: the jqGrid\n-cellName: the name of the edited cell\n-iCell: the position of the edited cell</p>\n</div></div></div><div id='property-pageSize' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.Grid.CollectionSupport' rel='Tent.Grid.CollectionSupport' class='defined-in docClass'>Tent.Grid.CollectionSupport</a><br/><a href='source/tent.html#Tent-Grid-CollectionSupport-property-pageSize' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Grid.CollectionSupport-property-pageSize' class='name expandable'>pageSize</a> : Number<span class=\"signature\"></span></div><div class='description'><div class='short'>The number of items in each page ...</div><div class='long'><p>The number of items in each page</p>\n<p>Defaults to: <code>12</code></p></div></div></div><div id='property-paged' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.Grid.CollectionSupport' rel='Tent.Grid.CollectionSupport' class='defined-in docClass'>Tent.Grid.CollectionSupport</a><br/><a href='source/tent.html#Tent-Grid-CollectionSupport-property-paged' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Grid.CollectionSupport-property-paged' class='name expandable'>paged</a> : Boolean<span class=\"signature\"></span></div><div class='description'><div class='short'>Boolean to indicate the data should be presented as a paged list ...</div><div class='long'><p>Boolean to indicate the data should be presented as a paged list</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-required' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.MandatorySupport' rel='Tent.MandatorySupport' class='defined-in docClass'>Tent.MandatorySupport</a><br/><a href='source/tent.html#Tent-MandatorySupport-property-required' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.MandatorySupport-property-required' class='name expandable'>required</a> : Boolean<span class=\"signature\"></span></div><div class='description'><div class='short'>Boolean property to determine whether a value must be provided ...</div><div class='long'><p>Boolean property to determine whether a value must be provided</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-selection' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.JqGrid'>Tent.JqGrid</span><br/><a href='source/tent.html#Tent-JqGrid-property-selection' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.JqGrid-property-selection' class='name expandable'>selection</a> : Array<span class=\"signature\"></span></div><div class='description'><div class='short'>The array of items selected in the list. ...</div><div class='long'><p>The array of items selected in the list. This can be used as a setter\nand a getter.</p>\n<p>Defaults to: <code>[]</code></p></div></div></div><div id='property-showColumnChooser' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.Grid.ColumnChooserSupport' rel='Tent.Grid.ColumnChooserSupport' class='defined-in docClass'>Tent.Grid.ColumnChooserSupport</a><br/><a href='source/tent.html#Tent-Grid-ColumnChooserSupport-property-showColumnChooser' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Grid.ColumnChooserSupport-property-showColumnChooser' class='name expandable'>showColumnChooser</a> : Boolean<span class=\"signature\"></span></div><div class='description'><div class='short'>Display a button at the top of the grid which presents\na dialog to show/hide columns. ...</div><div class='long'><p>Display a button at the top of the grid which presents\na dialog to show/hide columns. Any columns which have a property <strong>'hideable:false'</strong> will not be shown\nin this dialog</p>\n<p>Defaults to: <code>true</code></p></div></div></div><div id='property-showExportButton' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.Grid.ExportSupport' rel='Tent.Grid.ExportSupport' class='defined-in docClass'>Tent.Grid.ExportSupport</a><br/><a href='source/tent.html#Tent-Grid-ExportSupport-property-showExportButton' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Grid.ExportSupport-property-showExportButton' class='name expandable'>showExportButton</a> : Boolean<span class=\"signature\"></span></div><div class='description'><div class='short'>Display a button in the header which allows the table data to\nbe exported to a selected format. ...</div><div class='long'><p>Display a button in the header which allows the table data to\nbe exported to a selected format.</p>\n<p>Defaults to: <code>true</code></p></div></div></div><div id='property-showGroupTitle' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.Grid.GroupingSupport' rel='Tent.Grid.GroupingSupport' class='defined-in docClass'>Tent.Grid.GroupingSupport</a><br/><a href='source/tent.html#Tent-Grid-GroupingSupport-property-showGroupTitle' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Grid.GroupingSupport-property-showGroupTitle' class='name expandable'>showGroupTitle</a> : Boolean<span class=\"signature\"></span></div><div class='description'><div class='short'>Show the title of the group in each grouping row along with the group data. ...</div><div class='long'><p>Show the title of the group in each grouping row along with the group data.</p>\n<p>Defaults to: <code>true</code></p></div></div></div><div id='property-showMaximizeButton' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.Grid.Maximize' rel='Tent.Grid.Maximize' class='defined-in docClass'>Tent.Grid.Maximize</a><br/><a href='source/tent.html#Tent-Grid-Maximize-property-showMaximizeButton' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Grid.Maximize-property-showMaximizeButton' class='name expandable'>showMaximizeButton</a> : Boolean<span class=\"signature\"></span></div><div class='description'><div class='short'>Display a button at the top of the grid which presents\na dialog to maximize the grid view. ...</div><div class='long'><p>Display a button at the top of the grid which presents\na dialog to maximize the grid view.</p>\n<p>Defaults to: <code>true</code></p></div></div></div><div id='property-title' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.JqGrid'>Tent.JqGrid</span><br/><a href='source/tent.html#Tent-JqGrid-property-title' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.JqGrid-property-title' class='name expandable'>title</a> : String<span class=\"signature\"></span></div><div class='description'><div class='short'><p>The title caption to appear above the table</p>\n</div><div class='long'><p>The title caption to appear above the table</p>\n</div></div></div><div id='property-validations' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.ValidationSupport' rel='Tent.ValidationSupport' class='defined-in docClass'>Tent.ValidationSupport</a><br/><a href='source/tent.html#Tent-ValidationSupport-property-validations' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.ValidationSupport-property-validations' class='name expandable'>validations</a> : String <span class=\"signature\"></span></div><div class='description'><div class='short'><p>A list of comma-separated custom validations which should be applied to the widget</p>\n</div><div class='long'><p>A list of comma-separated custom validations which should be applied to the widget</p>\n</div></div></div><div id='property-warnings' class='member  inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.ValidationSupport' rel='Tent.ValidationSupport' class='defined-in docClass'>Tent.ValidationSupport</a><br/><a href='source/tent.html#Tent-ValidationSupport-property-warnings' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.ValidationSupport-property-warnings' class='name expandable'>warnings</a> : String<span class=\"signature\"></span></div><div class='description'><div class='short'>A list of comma-separated custom validations which should be applied to the widget, but are interpreted\nas warnings w...</div><div class='long'><p>A list of comma-separated custom validations which should be applied to the widget, but are interpreted\nas warnings which may be ignored.</p>\n</div></div></div></div></div><div class='members-section'><div class='definedBy'>Defined By</div><h3 class='members-title icon-method'>Methods</h3><div class='subsection'><div id='method-clearSelection' class='member first-child inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><a href='#!/api/Tent.Grid.SelectionSupport' rel='Tent.Grid.SelectionSupport' class='defined-in docClass'>Tent.Grid.SelectionSupport</a><br/><a href='source/tent.html#Tent-Grid-SelectionSupport-method-clearSelection' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Grid.SelectionSupport-method-clearSelection' class='name expandable'>clearSelection</a>( <span class='pre'></span> )<span class=\"signature\"></span></div><div class='description'><div class='short'>Removes all items from the selection array and resets the grid ...</div><div class='long'><p>Removes all items from the selection array and resets the grid</p>\n<h3 class='pa'>Fires</h3><ul></ul></div></div></div><div id='method-sendAction' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.JqGrid'>Tent.JqGrid</span><br/><a href='source/tent.html#Tent-JqGrid-method-sendAction' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.JqGrid-method-sendAction' class='name expandable'>sendAction</a>( <span class='pre'>action, element, rowId, colName</span> )<span class=\"signature\"></span></div><div class='description'><div class='short'>send an action to the router. ...</div><div class='long'><p>send an action to the router. This is called from the 'action' formatter,\nwhich displays cell content as a link</p>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>action</span> : Object<div class='sub-desc'></div></li><li><span class='pre'>element</span> : Object<div class='sub-desc'></div></li><li><span class='pre'>rowId</span> : Object<div class='sub-desc'></div></li><li><span class='pre'>colName</span> : Object<div class='sub-desc'></div></li></ul><h3 class='pa'>Fires</h3><ul></ul></div></div></div></div></div></div></div>","meta":{}});