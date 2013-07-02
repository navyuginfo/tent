Ext.data.JsonP.Tent_MessagePanel({"tagname":"class","name":"Tent.MessagePanel","extends":"Ember.View","mixins":[],"alternateClassNames":[],"aliases":{},"singleton":false,"requires":[],"uses":[],"enum":null,"override":null,"inheritable":null,"inheritdoc":null,"meta":{},"private":null,"id":"class-Tent.MessagePanel","members":{"cfg":[],"property":[{"name":"collapsed","tagname":"property","owner":"Tent.MessagePanel","meta":{},"id":"property-collapsed"},{"name":"collapsible","tagname":"property","owner":"Tent.MessagePanel","meta":{},"id":"property-collapsible"},{"name":"isActive","tagname":"property","owner":"Tent.MessagePanel","meta":{},"id":"property-isActive"},{"name":"type","tagname":"property","owner":"Tent.MessagePanel","meta":{},"id":"property-type"}],"method":[{"name":"getErrorsForView","tagname":"method","owner":"Tent.MessagePanel","meta":{},"id":"method-getErrorsForView"}],"event":[],"css_var":[],"css_mixin":[]},"linenr":10052,"files":[{"filename":"tent.js","href":"tent.html#Tent-MessagePanel"}],"html_meta":{},"statics":{"cfg":[],"property":[],"method":[],"event":[],"css_var":[],"css_mixin":[]},"component":false,"superclasses":["Ember.View"],"subclasses":[],"mixedInto":[],"parentMixins":[],"html":"<div><pre class=\"hierarchy\"><h4>Hierarchy</h4><div class='subclass first-child'>Ember.View<div class='subclass '><strong>Tent.MessagePanel</strong></div></div><h4>Files</h4><div class='dependency'><a href='source/tent.html#Tent-MessagePanel' target='_blank'>tent.js</a></div></pre><div class='doc-contents'><p>A panel for displaying error and information messages for the application.</p>\n\n<p>All Tent widgets will publish messages when they are in an error state and these will\nbe displayed dynamically by the MessagePanel. If there are no errors, the panel will be hidden.\nEach error message will identify the source of the error, if provided, and can also send focus\nto the source widget when clicked.</p>\n\n<p>Error messages can also be displayed by explicitly publishing them, setting type='error'</p>\n\n<pre><code>        $.publish('/message', {\n                type:'error', \n                messages:['Date format incorrect'], \n                sourceId: 'ember13'\n                label: 'Date'\n        })\n</code></pre>\n\n<ul>\n<li><strong>type</strong>: The type of message, can be 'error', 'info', 'success' or 'warning'</li>\n<li><strong>messages</strong>: An array of messages to display</li>\n<li><strong>sourceId</strong>: If the message refers to a Tent widget, provide the elementId of the widget\nso that focus can be transferred to it when the error is clicked</li>\n<li><strong>label</strong>: The label to display beside the messages for this source</li>\n</ul>\n\n\n<p>Each source will be allocated one line in the MessagePanel. If there are no messages for\na source, it will be removed from the MessagePanel. So in effect, to clear the messages for a source, send an\nempty messages array</p>\n\n<pre><code>        $.publish('/message', {\n                type:'error', \n                messages:[], \n                sourceId: 'ember13'\n        })\n</code></pre>\n\n<p>Information messages are displayed as-is, with no linking to source widgets.</p>\n\n<pre><code>        $.publish('/message', {\n                type:'info', \n                messages:['Please call this number for assistance..']\n        })\n</code></pre>\n\n<p>If you wish to display more than one message, use different sourceId's in the published message.</p>\n\n<p>The default state of the MessagePanel is collapsed and showing the first message. The panel can\nbe expanded if there is more than one message. The panel can be permanently expanded by setting the\n<a href=\"#!/api/Tent.MessagePanel-property-collapsible\" rel=\"Tent.MessagePanel-property-collapsible\" class=\"docClass\">collapsible</a> property to false. The default collapse state can be set with the <a href=\"#!/api/Tent.MessagePanel-property-collapsed\" rel=\"Tent.MessagePanel-property-collapsed\" class=\"docClass\">collapsed</a>\nproperty.</p>\n\n<h2>Usage</h2>\n\n<pre><code>    {{view <a href=\"#!/api/Tent.MessagePanel\" rel=\"Tent.MessagePanel\" class=\"docClass\">Tent.MessagePanel</a>}}\n</code></pre>\n</div><div class='members'><div class='members-section'><div class='definedBy'>Defined By</div><h3 class='members-title icon-property'>Properties</h3><div class='subsection'><div id='property-collapsed' class='member first-child not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.MessagePanel'>Tent.MessagePanel</span><br/><a href='source/tent.html#Tent-MessagePanel-property-collapsed' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.MessagePanel-property-collapsed' class='name expandable'>collapsed</a><span> : Boolean</span></div><div class='description'><div class='short'>A boolean indicating that the panel is collapsed by default ...</div><div class='long'><p>A boolean indicating that the panel is collapsed by default</p>\n<p>Defaults to: <code>true</code></p></div></div></div><div id='property-collapsible' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.MessagePanel'>Tent.MessagePanel</span><br/><a href='source/tent.html#Tent-MessagePanel-property-collapsible' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.MessagePanel-property-collapsible' class='name expandable'>collapsible</a><span> : Boolean</span></div><div class='description'><div class='short'>A boolean indicating that the panel is collapsible ...</div><div class='long'><p>A boolean indicating that the panel is collapsible</p>\n<p>Defaults to: <code>true</code></p></div></div></div><div id='property-isActive' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.MessagePanel'>Tent.MessagePanel</span><br/><a href='source/tent.html#Tent-MessagePanel-property-isActive' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.MessagePanel-property-isActive' class='name expandable'>isActive</a><span> : Boolean</span></div><div class='description'><div class='short'>One message panel should be active at a time, usually the primary one. ...</div><div class='long'><p>One message panel should be active at a time, usually the primary one.\nWhen a popup is displayed, it's message panel will usually become active, with the primary panel becoming\ninactive.</p>\n<p>Defaults to: <code>true</code></p></div></div></div><div id='property-type' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.MessagePanel'>Tent.MessagePanel</span><br/><a href='source/tent.html#Tent-MessagePanel-property-type' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.MessagePanel-property-type' class='name expandable'>type</a><span> : String</span></div><div class='description'><div class='short'>Defines the type of message panel. ...</div><div class='long'><p>Defines the type of message panel. Typically there will be one 'primary'\npanel per application. Modal dialogues may also have 'secondary' panels which become active when the\npanels are displayed</p>\n<p>Defaults to: <code>'primary'</code></p></div></div></div></div></div><div class='members-section'><div class='definedBy'>Defined By</div><h3 class='members-title icon-method'>Methods</h3><div class='subsection'><div id='method-getErrorsForView' class='member first-child not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.MessagePanel'>Tent.MessagePanel</span><br/><a href='source/tent.html#Tent-MessagePanel-method-getErrorsForView' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.MessagePanel-method-getErrorsForView' class='name expandable'>getErrorsForView</a>( <span class='pre'>viewId</span> )</div><div class='description'><div class='short'>return the error messages ...</div><div class='long'><p>return the error messages</p>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>viewId</span> : Object<div class='sub-desc'>\n</div></li></ul></div></div></div></div></div></div></div>"});