Ext.data.JsonP.jqgrid_formatter_action({"tagname":"class","name":"jqgrid.formatter.action","extends":null,"mixins":[],"alternateClassNames":[],"aliases":{},"singleton":false,"requires":[],"uses":[],"enum":null,"override":null,"inheritable":null,"inheritdoc":null,"meta":{},"private":null,"id":"class-jqgrid.formatter.action","members":{"cfg":[],"property":[],"method":[],"event":[],"css_var":[],"css_mixin":[]},"linenr":6415,"files":[{"filename":"tent.js","href":"tent.html#jqgrid-formatter-action"}],"html_meta":{},"statics":{"cfg":[],"property":[],"method":[],"event":[],"css_var":[],"css_mixin":[]},"component":false,"superclasses":[],"subclasses":[],"mixedInto":[],"parentMixins":[],"html":"<div><pre class=\"hierarchy\"><h4>Files</h4><div class='dependency'><a href='source/tent.html#jqgrid-formatter-action' target='_blank'>tent.js</a></div></pre><div class='doc-contents'><p>Allows jsGrid cell content to be treated as a link.\nThis formatter should be added to a column descriptor as follows (redirectColumn is optional):</p>\n\n<pre><code>  {id: \"some_id\", ..., formatter: \"action\", .formatoptions({action: 'showNewRoute', redirectColumn: 'columnName'})\n</code></pre>\n\n<p>If no column name is supplied, it will redirect to 'newRoute' with context as data of the clicked row. The clicked row is\nsearched on the basis of field 'id' in the data hash by comparing it against the clicked row Id.\nIf a column name is passed with in the format options, instead of rowId, value of the given column on the clicked row is compared\nagainst the column value in the grid data.\nThis speacial redirectColumn option is required, for complicated data such that, data with single id needs to be shown\nin different rows, with certain different column values, in that case, the 'id' for all the rows would be different\nto meet ember data needs but the actual id for that data should be stored in some other column, so that\nappropriate processing and redirection can be done.</p>\n</div><div class='members'></div></div>"});