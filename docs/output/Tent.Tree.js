Ext.data.JsonP.Tent_Tree({"tagname":"class","name":"Tent.Tree","extends":null,"mixins":[],"alternateClassNames":[],"aliases":{},"singleton":false,"requires":[],"uses":[],"enum":null,"override":null,"inheritable":null,"inheritdoc":null,"meta":{},"private":null,"id":"class-Tent.Tree","members":{"cfg":[],"property":[{"name":"activeVisible","tagname":"property","owner":"Tent.Tree","meta":{},"id":"property-activeVisible"},{"name":"aria","tagname":"property","owner":"Tent.Tree","meta":{},"id":"property-aria"},{"name":"autoActivate","tagname":"property","owner":"Tent.Tree","meta":{},"id":"property-autoActivate"},{"name":"autoCollapse","tagname":"property","owner":"Tent.Tree","meta":{},"id":"property-autoCollapse"},{"name":"autoScroll","tagname":"property","owner":"Tent.Tree","meta":{},"id":"property-autoScroll"},{"name":"checkbox","tagname":"property","owner":"Tent.Tree","meta":{},"id":"property-checkbox"},{"name":"collapseAutomatically","tagname":"property","owner":"Tent.Tree","meta":{},"id":"property-collapseAutomatically"},{"name":"content","tagname":"property","owner":"Tent.Tree","meta":{},"id":"property-content"},{"name":"disabled","tagname":"property","owner":"Tent.Tree","meta":{},"id":"property-disabled"},{"name":"extensions","tagname":"property","owner":"Tent.Tree","meta":{},"id":"property-extensions"},{"name":"folderOnClickShould","tagname":"property","owner":"Tent.Tree","meta":{},"id":"property-folderOnClickShould"},{"name":"generateIds","tagname":"property","owner":"Tent.Tree","meta":{},"id":"property-generateIds"},{"name":"icons","tagname":"property","owner":"Tent.Tree","meta":{},"id":"property-icons"},{"name":"isFlattened","tagname":"property","owner":"Tent.Tree","meta":{},"id":"property-isFlattened"},{"name":"keyboard","tagname":"property","owner":"Tent.Tree","meta":{},"id":"property-keyboard"},{"name":"minExpandLevel","tagname":"property","owner":"Tent.Tree","meta":{},"id":"property-minExpandLevel"},{"name":"nodeSelecion","tagname":"property","owner":"Tent.Tree","meta":{},"id":"property-nodeSelecion"},{"name":"radio","tagname":"property","owner":"Tent.Tree","meta":{},"id":"property-radio"},{"name":"selection","tagname":"property","owner":"Tent.Tree","meta":{},"id":"property-selection"},{"name":"tabbable","tagname":"property","owner":"Tent.Tree","meta":{},"id":"property-tabbable"}],"method":[],"event":[],"css_var":[],"css_mixin":[]},"linenr":10439,"files":[{"filename":"tent.js","href":"tent.html#Tent-Tree"}],"html_meta":{},"statics":{"cfg":[],"property":[],"method":[],"event":[],"css_var":[],"css_mixin":[]},"component":false,"superclasses":[],"subclasses":[],"mixedInto":[],"parentMixins":[],"html":"<div><pre class=\"hierarchy\"><h4>Files</h4><div class='dependency'><a href='source/tent.html#Tent-Tree' target='_blank'>tent.js</a></div></pre><div class='doc-contents'><p>Usage</p>\n\n<pre><code>   {{view <a href=\"#!/api/Tent.Tree\" rel=\"Tent.Tree\" class=\"docClass\">Tent.Tree</a>\n        contentBinding=\"\" \n        selectionBinding=\"\" \n        aria=\"\"\n        activeVisible=\"\"\n        autoActivate=\"\"\n        autoScroll=\"\"\n        checkbox=\"\"\n        folderOnClickShould=\"\"\n        disabled=\"\"\n        icons=\"\"\n        keyboard=\"\"\n        nodeSelection=\"\"\n        tabbable=\"\"\n        radio=\"\"\n      }}\n</code></pre>\n</div><div class='members'><div class='members-section'><div class='definedBy'>Defined By</div><h3 class='members-title icon-property'>Properties</h3><div class='subsection'><div id='property-activeVisible' class='member first-child not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Tree'>Tent.Tree</span><br/><a href='source/tent.html#Tent-Tree-property-activeVisible' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Tree-property-activeVisible' class='name expandable'>activeVisible</a><span> : Boolean</span></div><div class='description'><div class='short'>A boolean property which makes sure active nodes\nare visible (expanded). ...</div><div class='long'><p>A boolean property which makes sure active nodes\nare visible (expanded).</p>\n<p>Defaults to: <code>true</code></p></div></div></div><div id='property-aria' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Tree'>Tent.Tree</span><br/><a href='source/tent.html#Tent-Tree-property-aria' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Tree-property-aria' class='name expandable'>aria</a><span> : Boolean</span></div><div class='description'><div class='short'>A boolean property which enables/disables WAI-ARIA support. ...</div><div class='long'><p>A boolean property which enables/disables WAI-ARIA support.</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-autoActivate' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Tree'>Tent.Tree</span><br/><a href='source/tent.html#Tent-Tree-property-autoActivate' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Tree-property-autoActivate' class='name expandable'>autoActivate</a><span> : Boolean</span></div><div class='description'><div class='short'>A boolean property indicating whether to\nautomatically activate a node when it is focused (using keys). ...</div><div class='long'><p>A boolean property indicating whether to\nautomatically activate a node when it is focused (using keys).</p>\n<p>Defaults to: <code>true</code></p></div></div></div><div id='property-autoCollapse' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Tree'>Tent.Tree</span><br/><a href='source/tent.html#Tent-Tree-property-autoCollapse' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Tree-property-autoCollapse' class='name expandable'>autoCollapse</a><span> : Boolean</span></div><div class='description'><div class='short'>A boolean property indicating whether to\nautomatically collapse all siblings, when a node is expanded. ...</div><div class='long'><p>A boolean property indicating whether to\nautomatically collapse all siblings, when a node is expanded.</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-autoScroll' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Tree'>Tent.Tree</span><br/><a href='source/tent.html#Tent-Tree-property-autoScroll' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Tree-property-autoScroll' class='name expandable'>autoScroll</a><span> : Boolean</span></div><div class='description'><div class='short'>A boolean property indicating whether to\nautomatically scroll nodes into visible area ...</div><div class='long'><p>A boolean property indicating whether to\nautomatically scroll nodes into visible area</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-checkbox' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Tree'>Tent.Tree</span><br/><a href='source/tent.html#Tent-Tree-property-checkbox' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Tree-property-checkbox' class='name expandable'>checkbox</a><span> : Boolean</span></div><div class='description'><div class='short'>A boolean property responsible for displaying\ncheckboxes on the nodes. ...</div><div class='long'><p>A boolean property responsible for displaying\ncheckboxes on the nodes.</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-collapseAutomatically' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Tree'>Tent.Tree</span><br/><a href='source/tent.html#Tent-Tree-property-collapseAutomatically' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Tree-property-collapseAutomatically' class='name expandable'>collapseAutomatically</a><span> : Boolean</span></div><div class='description'><div class='short'>Defines whether the menu should collapse when the content area recieves focus. ...</div><div class='long'><p>Defines whether the menu should collapse when the content area recieves focus.</p>\n<p>Defaults to: <code>true</code></p></div></div></div><div id='property-content' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Tree'>Tent.Tree</span><br/><a href='source/tent.html#Tent-Tree-property-content' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Tree-property-content' class='name expandable'>content</a><span> : Array</span></div><div class='description'><div class='short'>an array of parent child relationship which is responsible for\nrendering the tree. ...</div><div class='long'><p>an array of parent child relationship which is responsible for\nrendering the tree.\nExample:\n[\n {\n   title: 'Node Title',\n   folder: true, // the value must be set to true else folderOnClickShould value wont have any effect\n   tooltip: 'tooltip that needs to be displayed for the node on hover',\n   extraClasses: 'class1 class2', //Adding classes to nodes,\n   expanded: true, //Will be expanded on load\n   lazy: true, //TODO, children will be loaded via AJAX call\n   children: [</p>\n\n<pre><code> {\n   title: \"&lt;span&gt;can enter HTML too using a span tag &lt;/span&gt;\",\n   value: 100 // if it is a leaf node then we must specify the value, which will be \n             // collected in selection array on selection.\n },\n {title: 'child 2', value: 'can be any data type'}\n</code></pre>\n\n<p>   ]\n }\n]</p>\n</div></div></div><div id='property-disabled' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Tree'>Tent.Tree</span><br/><a href='source/tent.html#Tent-Tree-property-disabled' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Tree-property-disabled' class='name expandable'>disabled</a><span> : Boolean</span></div><div class='description'><div class='short'>A boolean property responsible for enabling/disabling\nthe entire tree ...</div><div class='long'><p>A boolean property responsible for enabling/disabling\nthe entire tree</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-extensions' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Tree'>Tent.Tree</span><br/><a href='source/tent.html#Tent-Tree-property-extensions' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Tree-property-extensions' class='name expandable'>extensions</a><span> : Array</span></div><div class='description'><div class='short'>built for the fancytree widget which we wish to load\nmust be specified here. ...</div><div class='long'><p>built for the fancytree widget which we wish to load\nmust be specified here.</p>\n<p>Defaults to: <code>[]</code></p></div></div></div><div id='property-folderOnClickShould' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Tree'>Tent.Tree</span><br/><a href='source/tent.html#Tent-Tree-property-folderOnClickShould' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Tree-property-folderOnClickShould' class='name expandable'>folderOnClickShould</a><span> : String</span></div><div class='description'><div class='short'>The property responsible for the folder click behaviour\nIf the value is 'expandOnDblClick' the folder expands only on...</div><div class='long'><p>The property responsible for the folder click behaviour\nIf the value is 'expandOnDblClick' the folder expands only on double click\nIf the value is 'activate' the folder gets activated (not selected) on click\nIf the value is 'expand' the folder expands on click (not selected &amp; activated)\nIf the value is 'activateAndExpand' the folder is expanded &amp; activated on click</p>\n<p>Defaults to: <code>'expandOnDblClick'</code></p></div></div></div><div id='property-generateIds' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Tree'>Tent.Tree</span><br/><a href='source/tent.html#Tent-Tree-property-generateIds' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Tree-property-generateIds' class='name expandable'>generateIds</a><span> : Boolean</span></div><div class='description'><div class='short'>A boolean property indicating whether to generate\nunique ids for li elements. ...</div><div class='long'><p>A boolean property indicating whether to generate\nunique ids for li elements.</p>\n<p>Defaults to: <code>true</code></p></div></div></div><div id='property-icons' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Tree'>Tent.Tree</span><br/><a href='source/tent.html#Tent-Tree-property-icons' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Tree-property-icons' class='name expandable'>icons</a><span> : Boolean</span></div><div class='description'><div class='short'>when true icons for the nodes are displayed on the UI ...</div><div class='long'><p>when true icons for the nodes are displayed on the UI</p>\n<p>Defaults to: <code>true</code></p></div></div></div><div id='property-isFlattened' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Tree'>Tent.Tree</span><br/><a href='source/tent.html#Tent-Tree-property-isFlattened' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Tree-property-isFlattened' class='name expandable'>isFlattened</a><span> : Boolean</span></div><div class='description'><div class='short'>Render all menu items in a single hierarchy, ignoring grouping. ...</div><div class='long'><p>Render all menu items in a single hierarchy, ignoring grouping.</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-keyboard' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Tree'>Tent.Tree</span><br/><a href='source/tent.html#Tent-Tree-property-keyboard' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Tree-property-keyboard' class='name expandable'>keyboard</a><span> : Boolean</span></div><div class='description'><div class='short'>A boolean property indicating keyboard navigation support ...</div><div class='long'><p>A boolean property indicating keyboard navigation support</p>\n<p>Defaults to: <code>true</code></p></div></div></div><div id='property-minExpandLevel' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Tree'>Tent.Tree</span><br/><a href='source/tent.html#Tent-Tree-property-minExpandLevel' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Tree-property-minExpandLevel' class='name expandable'>minExpandLevel</a><span> : Integer</span></div><div class='description'><div class='short'>Locks expand/collapse for all the nodes on the given minExpandLevel value ...</div><div class='long'><p>Locks expand/collapse for all the nodes on the given minExpandLevel value</p>\n<p>Defaults to: <code>1</code></p></div></div></div><div id='property-nodeSelecion' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Tree'>Tent.Tree</span><br/><a href='source/tent.html#Tent-Tree-property-nodeSelecion' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Tree-property-nodeSelecion' class='name expandable'>nodeSelecion</a><span> : String</span></div><div class='description'><div class='short'>The property resposible for node selection behaviour\nIf the value is 'singleSelect' user can select only one node\nIf ...</div><div class='long'><p>The property resposible for node selection behaviour\nIf the value is 'singleSelect' user can select only one node\nIf the value is 'multiSelect' user can select multiple nodes\nIf the value is 'heirMultiSelect' user can select all the children on selecting parent node</p>\n</div></div></div><div id='property-radio' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Tree'>Tent.Tree</span><br/><a href='source/tent.html#Tent-Tree-property-radio' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Tree-property-radio' class='name expandable'>radio</a><span> : Boolean</span></div><div class='description'><div class='short'>Displays radio buttons instead of checkboxes when set to true\nproperty checkbox must be set to true in order to see t...</div><div class='long'><p>Displays radio buttons instead of checkboxes when set to true\nproperty checkbox must be set to true in order to see the radio button.\nTo simulate radio group behavior the property nodeSelection must be set to 'singleSelect'\nelse we will have multi-select radio buttons.</p>\n<p>Defaults to: <code>false</code></p></div></div></div><div id='property-selection' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Tree'>Tent.Tree</span><br/><a href='source/tent.html#Tent-Tree-property-selection' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Tree-property-selection' class='name not-expandable'>selection</a><span> : Array</span></div><div class='description'><div class='short'><p>an array which holds selected leafnode values from the tree.</p>\n</div><div class='long'><p>an array which holds selected leafnode values from the tree.</p>\n</div></div></div><div id='property-tabbable' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Tree'>Tent.Tree</span><br/><a href='source/tent.html#Tent-Tree-property-tabbable' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Tree-property-tabbable' class='name expandable'>tabbable</a><span> : Boolean</span></div><div class='description'><div class='short'>a boolean indicating whether the whole tree behaves as one single control ...</div><div class='long'><p>a boolean indicating whether the whole tree behaves as one single control</p>\n<p>Defaults to: <code>true</code></p></div></div></div></div></div></div></div>"});