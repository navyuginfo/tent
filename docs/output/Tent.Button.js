Ext.data.JsonP.Tent_Button({"tagname":"class","name":"Tent.Button","extends":null,"mixins":[],"alternateClassNames":[],"aliases":{},"singleton":false,"requires":[],"uses":[],"enum":null,"override":null,"inheritable":null,"inheritdoc":null,"meta":{},"private":null,"id":"class-Tent.Button","members":{"cfg":[],"property":[{"name":"action","tagname":"property","owner":"Tent.Button","meta":{},"id":"property-action"},{"name":"iconClass","tagname":"property","owner":"Tent.Button","meta":{},"id":"property-iconClass"},{"name":"label","tagname":"property","owner":"Tent.Button","meta":{},"id":"property-label"},{"name":"target","tagname":"property","owner":"Tent.Button","meta":{},"id":"property-target"},{"name":"type","tagname":"property","owner":"Tent.Button","meta":{},"id":"property-type"},{"name":"validate","tagname":"property","owner":"Tent.Button","meta":{},"id":"property-validate"}],"method":[],"event":[],"css_var":[],"css_mixin":[]},"linenr":4327,"files":[{"filename":"tent.js","href":"tent.html#Tent-Button"}],"html_meta":{},"statics":{"cfg":[],"property":[],"method":[],"event":[],"css_var":[],"css_mixin":[]},"component":false,"superclasses":[],"subclasses":[],"mixedInto":[],"parentMixins":[],"html":"<div><pre class=\"hierarchy\"><h4>Files</h4><div class='dependency'><a href='source/tent.html#Tent-Button' target='_blank'>tent.js</a></div></pre><div class='doc-contents'><h2>Usage</h2>\n\n<pre><code>  {{view <a href=\"#!/api/Tent.Button\" rel=\"Tent.Button\" class=\"docClass\">Tent.Button</a> label=\"_buttonClickMe\" type=\"primary\" action=\"clickEvent\" target=\"Pad\"}}\n</code></pre>\n</div><div class='members'><div class='members-section'><div class='definedBy'>Defined By</div><h3 class='members-title icon-property'>Properties</h3><div class='subsection'><div id='property-action' class='member first-child not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Button'>Tent.Button</span><br/><a href='source/tent.html#Tent-Button-property-action' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Button-property-action' class='name not-expandable'>action</a><span> : String</span></div><div class='description'><div class='short'><p>The action to be invoked on the target when the button is clicked</p>\n</div><div class='long'><p>The action to be invoked on the target when the button is clicked</p>\n</div></div></div><div id='property-iconClass' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Button'>Tent.Button</span><br/><a href='source/tent.html#Tent-Button-property-iconClass' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Button-property-iconClass' class='name expandable'>iconClass</a><span> : String</span></div><div class='description'><div class='short'>The css class to assign an icon to the button e.g. ...</div><div class='long'><p>The css class to assign an icon to the button e.g. 'icon-remove icon-white'</p>\n</div></div></div><div id='property-label' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Button'>Tent.Button</span><br/><a href='source/tent.html#Tent-Button-property-label' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Button-property-label' class='name expandable'>label</a><span> : String</span></div><div class='description'><div class='short'>The label for the button ...</div><div class='long'><p>The label for the button</p>\n<p>Defaults to: <code>'Button'</code></p></div></div></div><div id='property-target' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Button'>Tent.Button</span><br/><a href='source/tent.html#Tent-Button-property-target' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Button-property-target' class='name not-expandable'>target</a><span> : Object</span></div><div class='description'><div class='short'><p>The target which hosts the action function.</p>\n</div><div class='long'><p>The target which hosts the action function.</p>\n</div></div></div><div id='property-type' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Button'>Tent.Button</span><br/><a href='source/tent.html#Tent-Button-property-type' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Button-property-type' class='name expandable'>type</a><span> : String</span></div><div class='description'><div class='short'>The type of button. ...</div><div class='long'><p>The type of button.\nValid types are:</p>\n\n<ul>\n<li><strong>primary</strong>: Provides extra visual weight and identifies the primary action in a set of buttons</li>\n<li><strong>info</strong>: Used as an alternative to the default styles</li>\n<li><strong>success</strong>: Indicates a successful or positive action</li>\n<li><strong>warning</strong>: Indicates caution should be taken with this action</li>\n<li><strong>danger</strong>: Indicates a dangerous or potentially negative action</li>\n<li><strong>inverse</strong>: Alternate dark gray button, not tied to a semantic action or use</li>\n<li><strong>link</strong>: Deemphasize a button by making it look like a link while maintaining button behavior</li>\n</ul>\n\n<p>Defaults to: <code>'primary'</code></p></div></div></div><div id='property-validate' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Button'>Tent.Button</span><br/><a href='source/tent.html#Tent-Button-property-validate' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Button-property-validate' class='name expandable'>validate</a><span> : Boolean</span></div><div class='description'><div class='short'>If validate is set to true, all fields on the current form\nneed to be valid before the action will be executed. ...</div><div class='long'><p>If validate is set to true, all fields on the current form\nneed to be valid before the action will be executed. The Button will execute a form validation\nif it has not happened already.</p>\n<p>Defaults to: <code>false</code></p></div></div></div></div></div></div></div>"});