Ext.data.JsonP.Tent_Date({"tagname":"class","name":"Tent.Date","extends":null,"mixins":[],"alternateClassNames":[],"aliases":{},"singleton":false,"requires":[],"uses":[],"enum":null,"override":null,"inheritable":null,"inheritdoc":null,"meta":{},"private":null,"id":"class-Tent.Date","members":{"cfg":[],"property":[],"method":[{"name":"filterZoneUsingTZAbbreviation","tagname":"method","owner":"Tent.Date","meta":{},"id":"method-filterZoneUsingTZAbbreviation"},{"name":"filterZoneUsingTZName","tagname":"method","owner":"Tent.Date","meta":{},"id":"method-filterZoneUsingTZName"},{"name":"getAbbreviatedTZFromDate","tagname":"method","owner":"Tent.Date","meta":{},"id":"method-getAbbreviatedTZFromDate"},{"name":"getAbbreviatedTZFromUTCOffsetAndName","tagname":"method","owner":"Tent.Date","meta":{},"id":"method-getAbbreviatedTZFromUTCOffsetAndName"},{"name":"getFullTZFromDate","tagname":"method","owner":"Tent.Date","meta":{},"id":"method-getFullTZFromDate"},{"name":"getFullTZFromUTCOffsetAndAbbreviation","tagname":"method","owner":"Tent.Date","meta":{},"id":"method-getFullTZFromUTCOffsetAndAbbreviation"},{"name":"getUTCOffsetFromTZ","tagname":"method","owner":"Tent.Date","meta":{},"id":"method-getUTCOffsetFromTZ"},{"name":"getZonesFromAbbreviation","tagname":"method","owner":"Tent.Date","meta":{},"id":"method-getZonesFromAbbreviation"},{"name":"getZonesFromUTCOffset","tagname":"method","owner":"Tent.Date","meta":{},"id":"method-getZonesFromUTCOffset"}],"event":[],"css_var":[],"css_mixin":[]},"linenr":2399,"files":[{"filename":"tent.js","href":"tent.html#Tent-Date"}],"html_meta":{},"statics":{"cfg":[],"property":[],"method":[],"event":[],"css_var":[],"css_mixin":[]},"component":false,"superclasses":[],"subclasses":[],"mixedInto":[],"parentMixins":[],"html":"<div><pre class=\"hierarchy\"><h4>Files</h4><div class='dependency'><a href='source/tent.html#Tent-Date' target='_blank'>tent.js</a></div></pre><div class='doc-contents'><p>This class has methods used to fetch data associated with dates and timezones.\n  Private methods used for getting UTCOffset, timezone name or abbreviations using different combinations of data available.\n  A \"zone\" object = A javascript object having timezone name, abbreviation and UTCOffset</p>\n</div><div class='members'><div class='members-section'><div class='definedBy'>Defined By</div><h3 class='members-title icon-method'>Methods</h3><div class='subsection'><div id='method-filterZoneUsingTZAbbreviation' class='member first-child not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Date'>Tent.Date</span><br/><a href='source/tent.html#Tent-Date-method-filterZoneUsingTZAbbreviation' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Date-method-filterZoneUsingTZAbbreviation' class='name expandable'>filterZoneUsingTZAbbreviation</a>( <span class='pre'>zones, abbr</span> ) : Object</div><div class='description'><div class='short'>(PRIVATE) Returns a zone object from an array of zone objects\n   if the given abbreviation matches any of the object ...</div><div class='long'><p>(PRIVATE) Returns a zone object from an array of zone objects\n   if the given abbreviation matches any of the object abbreviations\n   returns null if a list of 'zone' objects or abbreviation is not provided</p>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>zones</span> : Array of Zone Objects<div class='sub-desc'>\n</div></li><li><span class='pre'>abbr</span> : String<div class='sub-desc'>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>Object</span><div class='sub-desc'><p>Zone object</p>\n</div></li></ul></div></div></div><div id='method-filterZoneUsingTZName' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Date'>Tent.Date</span><br/><a href='source/tent.html#Tent-Date-method-filterZoneUsingTZName' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Date-method-filterZoneUsingTZName' class='name expandable'>filterZoneUsingTZName</a>( <span class='pre'>zones, name</span> ) : Object</div><div class='description'><div class='short'>(PRIVATE) Returns an zone object from an array of zone objects\n\nif the given name exactly or almost matches any of th...</div><div class='long'><p>(PRIVATE) Returns an zone object from an array of zone objects</p>\n\n<pre><code>if the given name exactly or almost matches any of the object names \n(has the scope of \"almost matching strings\" as the name may not exactly match the ones in the Tent list)\nreturns null if the list of 'zone' objects or name is not provided\n</code></pre>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>zones</span> : Array of Zone Objects<div class='sub-desc'>\n</div></li><li><span class='pre'>name</span> : String<div class='sub-desc'>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>Object</span><div class='sub-desc'><p>Zone object</p>\n</div></li></ul></div></div></div><div id='method-getAbbreviatedTZFromDate' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Date'>Tent.Date</span><br/><a href='source/tent.html#Tent-Date-method-getAbbreviatedTZFromDate' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Date-method-getAbbreviatedTZFromDate' class='name expandable'>getAbbreviatedTZFromDate</a>( <span class='pre'>date</span> ) : string</div><div class='description'><div class='short'>Returns timezone abbreviation, returns null if date is missing ...</div><div class='long'><p>Returns timezone abbreviation, returns null if date is missing</p>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>date</span> : Date Object<div class='sub-desc'><p>(Required)</p>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>string</span><div class='sub-desc'>\n</div></li></ul></div></div></div><div id='method-getAbbreviatedTZFromUTCOffsetAndName' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Date'>Tent.Date</span><br/><a href='source/tent.html#Tent-Date-method-getAbbreviatedTZFromUTCOffsetAndName' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Date-method-getAbbreviatedTZFromUTCOffsetAndName' class='name expandable'>getAbbreviatedTZFromUTCOffsetAndName</a>( <span class='pre'>UTCOffset, name</span> ) : String</div><div class='description'><div class='short'>Returns time zone abbreviation\n\n(closest match of the supplied name string is considered as full names of timezones \n...</div><div class='long'><p>Returns time zone abbreviation</p>\n\n<pre><code>(closest match of the supplied name string is considered as full names of timezones \nmight be different from what is in the Tent list). \nReturns null if UTCOffset is missing\n</code></pre>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>UTCOffset</span> : String<div class='sub-desc'><p>string of type : \"GMT+0400\"</p>\n</div></li><li><span class='pre'>name</span> : String<div class='sub-desc'><p>Optional argument which is the full name of timezone</p>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>String</span><div class='sub-desc'>\n</div></li></ul></div></div></div><div id='method-getFullTZFromDate' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Date'>Tent.Date</span><br/><a href='source/tent.html#Tent-Date-method-getFullTZFromDate' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Date-method-getFullTZFromDate' class='name expandable'>getFullTZFromDate</a>( <span class='pre'>date</span> ) : String</div><div class='description'><div class='short'>Returns timezone name, returns null if date is missing ...</div><div class='long'><p>Returns timezone name, returns null if date is missing</p>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>date</span> : Date Object<div class='sub-desc'><p>(Required)</p>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>String</span><div class='sub-desc'>\n</div></li></ul></div></div></div><div id='method-getFullTZFromUTCOffsetAndAbbreviation' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Date'>Tent.Date</span><br/><a href='source/tent.html#Tent-Date-method-getFullTZFromUTCOffsetAndAbbreviation' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Date-method-getFullTZFromUTCOffsetAndAbbreviation' class='name expandable'>getFullTZFromUTCOffsetAndAbbreviation</a>( <span class='pre'>UTCOffset, abbr</span> ) : string</div><div class='description'><div class='short'>Returns timezone name, returns null if UTC Offset is missing ...</div><div class='long'><p>Returns timezone name, returns null if UTC Offset is missing</p>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>UTCOffset</span> : String<div class='sub-desc'><p>string of type : \"GMT+0400\" (Required)</p>\n</div></li><li><span class='pre'>abbr</span> : String<div class='sub-desc'><p>Timezone abbreviation of type: \"IST\" (Optional)</p>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>string</span><div class='sub-desc'>\n</div></li></ul></div></div></div><div id='method-getUTCOffsetFromTZ' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Date'>Tent.Date</span><br/><a href='source/tent.html#Tent-Date-method-getUTCOffsetFromTZ' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Date-method-getUTCOffsetFromTZ' class='name expandable'>getUTCOffsetFromTZ</a>( <span class='pre'>abbr, [name]</span> ) : String</div><div class='description'><div class='short'>Returns UTCOffset given the timezone abbreviation and name. ...</div><div class='long'><p>Returns UTCOffset given the timezone abbreviation and name.\nIf name is not provided and there are more than one records with the given abbreviation,\nnull will be returned</p>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>abbr</span> : String<div class='sub-desc'><p>(Required)</p>\n</div></li><li><span class='pre'>name</span> : String (optional)<div class='sub-desc'>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>String</span><div class='sub-desc'>\n</div></li></ul></div></div></div><div id='method-getZonesFromAbbreviation' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Date'>Tent.Date</span><br/><a href='source/tent.html#Tent-Date-method-getZonesFromAbbreviation' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Date-method-getZonesFromAbbreviation' class='name expandable'>getZonesFromAbbreviation</a>( <span class='pre'>abbr</span> ) : Object</div><div class='description'><div class='short'>(PRIVATE) Returns an array list of zone objects which have the given abbreviation ...</div><div class='long'><p>(PRIVATE) Returns an array list of zone objects which have the given abbreviation</p>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>abbr</span> : String<div class='sub-desc'>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>Object</span><div class='sub-desc'><p>Zone object</p>\n</div></li></ul></div></div></div><div id='method-getZonesFromUTCOffset' class='member  not-inherited'><a href='#' class='side expandable'><span>&nbsp;</span></a><div class='title'><div class='meta'><span class='defined-in' rel='Tent.Date'>Tent.Date</span><br/><a href='source/tent.html#Tent-Date-method-getZonesFromUTCOffset' target='_blank' class='view-source'>view source</a></div><a href='#!/api/Tent.Date-method-getZonesFromUTCOffset' class='name expandable'>getZonesFromUTCOffset</a>( <span class='pre'>UTCOffset</span> ) : Object</div><div class='description'><div class='short'>(PRIVATE) Returns an array list of zone objects which have the given UTCOffset ...</div><div class='long'><p>(PRIVATE) Returns an array list of zone objects which have the given UTCOffset</p>\n<h3 class=\"pa\">Parameters</h3><ul><li><span class='pre'>UTCOffset</span> : String<div class='sub-desc'>\n</div></li></ul><h3 class='pa'>Returns</h3><ul><li><span class='pre'>Object</span><div class='sub-desc'><p>Zone object</p>\n</div></li></ul></div></div></div></div></div></div></div>"});