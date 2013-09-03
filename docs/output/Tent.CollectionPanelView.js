Ext.data.JsonP.Tent_CollectionPanelView({"tagname":"class","name":"Tent.CollectionPanelView","autodetected":{},"files":[{"filename":"tent.js","href":"tent.html#Tent-CollectionPanelView"}],"members":[{"name":"collection","tagname":"property","owner":"Tent.CollectionPanelView","id":"property-collection","meta":{}},{"name":"contentViewType","tagname":"property","owner":"Tent.CollectionPanelView","id":"property-contentViewType","meta":{}}],"alternateClassNames":[],"aliases":{},"id":"class-Tent.CollectionPanelView","short_doc":"Displays a collection of objects in separate panels laid out in a 2d grid. ...","component":false,"superclasses":[],"subclasses":[],"mixedInto":[],"mixins":[],"parentMixins":[],"requires":[],"uses":[],"html":"<div><pre class=\"hierarchy\"><h4>Files</h4><div class='dependency'><a href='source/tent.html#Tent-CollectionPanelView' target='_blank'>tent.js</a></div></pre><div class='doc-contents'><p>Displays a collection of objects in separate panels laid out in a 2d grid.\nThe <a href=\"#!/api/Tent.CollectionPanelView-property-contentViewType\" rel=\"Tent.CollectionPanelView-property-contentViewType\" class=\"docClass\">contentViewType</a> property must be populated with a view which will render each panel. This view\nshould be a subclass of Tent.TaskCollectionPanelContentView</p>\n\n<p>Usage within a template:\n    {{view <a href=\"#!/api/Tent.CollectionPanelView\" rel=\"Tent.CollectionPanelView\" class=\"docClass\">Tent.CollectionPanelView</a>\n              collectionBinding=\"Pad.jqRemoteCollection\"\n              contentViewType=\"Tent.TaskCollectionPanelContentView\"\n         }}</p>\n</div><div class='members'><div class='members-section'><div class='definedBy'>Defined By</div><h3 class='members-title icon-property'>Properties</h3><div class='subsection'><div id='property-collection' class='member first-child not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.CollectionPanelView'>Tent.CollectionPanelView</span><br/><a href='source/tent.html#Tent-CollectionPanelView-property-collection' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.CollectionPanelView-property-collection' class='name expandable'>collection</a> : Object<span class=\"signature\"></span></div><div class='description'><div class='short'><p>The colleciton which contains the items for display.</p>\n</div><div class='long'><p>The colleciton which contains the items for display.</p>\n</div></div></div><div id='property-contentViewType' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.CollectionPanelView'>Tent.CollectionPanelView</span><br/><a href='source/tent.html#Tent-CollectionPanelView-property-contentViewType' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.CollectionPanelView-property-contentViewType' class='name expandable'>contentViewType</a> : String<span class=\"signature\"></span></div><div class='description'><div class='short'>The name of a view class which will render the contents of each panel. ...</div><div class='long'><p>The name of a view class which will render the contents of each panel.\nThis view will have its 'content' populated with the model for that panel</p>\n</div></div></div></div></div></div></div>","meta":{}});