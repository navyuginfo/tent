
$.extend($.jgrid,{
	template : function(format){ //jqgformat
		var args = $.makeArray(arguments).slice(1), j = 1;
		if(format===undefined) { format = ""; }
		if (args[3] && args[3].range && args[3].range.rowTitle) {
			args[0] = args[3].range.rowTitle(args[4], args[5])
		}
		return format.replace(/\{([\w\-]+)(?:\:([\w\.]*)(?:\((.*?)?\))?)?\}/g, function(m,i){
			if(!isNaN(parseInt(i,10))) {
				j++;
				return args[parseInt(i,10)];
			} else {
				var nmarr = args[ j ],
				k = nmarr.length;
				while(k--) {
					if(i===nmarr[k].nm) {
						return nmarr[k].v;
						break;
					}
				}
				j++;
			}
		});
	}
});


$.jgrid.extend({
	groupingPrepare : function (rData, gdata, record, irow) {
		this.each(function(){
			var grp = this.p.groupingView, $t= this;
			if (grp.range == undefined) {
				grp.range = {
					compare: function(last, value){
						return last !== value
					}
				}
			}
			var grlen = grp.groupField.length, 
			fieldName,
			v,
			changed = 0;
			for(var i=0;i<grlen;i++) {
				fieldName = grp.groupField[i];
				v = record[fieldName];
				if( v !== undefined ) {
					if(irow === 0 ) {
						// First record always starts a new group
						grp.groups.push({idx:i,dataIndex:fieldName,value:v, startRow: irow, cnt:1, summary : [] } );
						grp.lastvalues[i] = v;
						grp.counters[i] = {cnt:1, pos:grp.groups.length-1, summary: $.extend(true,[],grp.summary)};
						$.each(grp.counters[i].summary,function() {
							if ($.isFunction(this.st)) {
								this.v = this.st.call($t, this.v, this.nm, record);
							} else {
								this.v = $($t).jqGrid('groupingCalculations.handler',this.st, this.v, this.nm, this.sr, this.srt, record);
							}
						});
						grp.groups[grp.counters[i].pos].summary = grp.counters[i].summary;
					} else {

						if( (!grp.range.compare(grp.lastvalues[i], v)) ) {
							// This record is not in same group as previous one
							grp.groups.push({idx:i,dataIndex:fieldName,value:v, startRow: irow, cnt:1, summary : [] } );
							grp.lastvalues[i] = v;
							changed = 1;
							grp.counters[i] = {cnt:1, pos:grp.groups.length-1, summary: $.extend(true,[],grp.summary)};
							$.each(grp.counters[i].summary,function() {
								if ($.isFunction(this.st)) {
									this.v = this.st.call($t, this.v, this.nm, record);
								} else {
									this.v = $($t).jqGrid('groupingCalculations.handler',this.st, this.v, this.nm, this.sr, this.srt, record);
								}
							});
							grp.groups[grp.counters[i].pos].summary = grp.counters[i].summary;
						} else {
							if (changed === 1) {
								// This group has changed because an earlier group changed.
								grp.groups.push({idx:i,dataIndex:fieldName,value:v, startRow: irow, cnt:1, summary : [] } );
								grp.lastvalues[i] = v;
								grp.counters[i] = {cnt:1, pos:grp.groups.length-1, summary: $.extend(true,[],grp.summary)};
								$.each(grp.counters[i].summary,function() {
									if ($.isFunction(this.st)) {
										this.v = this.st.call($t, this.v, this.nm, record);
									} else {
										this.v = $($t).jqGrid('groupingCalculations.handler',this.st, this.v, this.nm, this.sr, this.srt, record);
									}
								});
								grp.groups[grp.counters[i].pos].summary = grp.counters[i].summary;
							} else {
								grp.counters[i].cnt += 1;
								grp.groups[grp.counters[i].pos].cnt = grp.counters[i].cnt;
								$.each(grp.counters[i].summary,function() {
									if ($.isFunction(this.st)) {
										this.v = this.st.call($t, this.v, this.nm, record);
									} else {
										this.v = $($t).jqGrid('groupingCalculations.handler',this.st, this.v, this.nm, this.sr, this.srt, record);
									}
								});
								grp.groups[grp.counters[i].pos].summary = grp.counters[i].summary;
							}
						}
					}
				}
			}
			gdata.push( rData );
		})
		return gdata;
	},

	groupingRender : function (grdata, colspans ) {
		return this.each(function(){
			var $t = this,
			grp = $t.p.groupingView,
			str = "", icon = "", hid, clid, pmrtl = grp.groupCollapse ? grp.plusicon : grp.minusicon, gv, cp=[], ii, len =grp.groupField.length;
			pmrtl += " tree-wrap-"+$t.p.direction; 
			ii = 0;
			$.each($t.p.colModel, function (i,n){
				for(var ii=0;ii<len;ii++) {
					if(grp.groupField[ii] === n.name ) {
						cp[ii] = i;
						break;
					}
				}
			});
			var toEnd = 0;
			function findGroupIdx( ind , offset, grp) {
				if(offset===0) {
					return grp[ind];
				} else {
					var id = grp[ind].idx;
					if(id===0) { return grp[ind]; }
					for(var i=ind;i >= 0; i--) {
						if(grp[i].idx === id-offset) {
							return grp[i];
						}
					}
				}
			}
			var sumreverse = $.makeArray(grp.groupSummary);
			sumreverse.reverse();
			$.each(grp.groups,function(i,n){
				toEnd++;
				clid = $t.p.id+"ghead_"+n.idx;
				hid = clid+"_"+i;
				icon = "<span style='cursor:pointer;' class='ui-icon "+pmrtl+"' onclick=\"jQuery('#"+$.jgrid.jqID($t.p.id)+"').jqGrid('groupingToggle','"+hid+"');return false;\"></span>";
				try {
					gv = $t.formatter(hid, n.value, cp[n.idx], n.value );
				} catch (egv) {
					gv = n.value;
				}

				/* Create a formatter by currying the current values */
				formatter = function(value) {
					return $t.formatter(hid, value, cp[n.idx], value );
				}

				str += "<tr id=\""+hid+"\" role=\"row\" class= \"ui-widget-content jqgroup ui-row-"+$t.p.direction+" "+clid+"\"><td style=\"padding-left:"+(n.idx * 12) + "px;"+"\" colspan=\""+colspans+"\">"+icon+$.jgrid.template(grp.groupText[n.idx], gv, n.cnt, n.summary, grp, n.value, formatter)+"</td></tr>";
				var leaf = len-1 === n.idx; 
				if( leaf ) {
					var gg = grp.groups[i+1];
					var end = gg !== undefined ?  grp.groups[i+1].startRow : grdata.length;
					for(var kk=n.startRow;kk<end;kk++) {
						str += grdata[kk].join('');
					}
					var jj;
					if (gg !== undefined) {
						for (jj = 0; jj < grp.groupField.length; jj++) {
							if (gg.dataIndex === grp.groupField[jj]) {
								break;
							}
						}
						toEnd = grp.groupField.length - jj;
					}
					for (var ik = 0; ik < toEnd; ik++) {
						if(!sumreverse[ik]) { continue; }
						var hhdr = "";
						if(grp.groupCollapse && !grp.showSummaryOnHide) {
							hhdr = " style=\"display:none;\"";
						}
						str += "<tr"+hhdr+" jqfootlevel=\""+(n.idx-ik)+"\" role=\"row\" class=\"ui-widget-content jqfoot ui-row-"+$t.p.direction+"\">";
						var fdata = findGroupIdx(i, ik, grp.groups),
						cm = $t.p.colModel,
						vv, grlen = fdata.cnt;
						for(var k=0; k<colspans;k++) {
							var tmpdata = "<td "+$t.formatCol(k,1,'')+">&#160;</td>",
							tplfld = "{0}";
							$.each(fdata.summary,function(){
								if(this.nm === cm[k].name) {
									if(cm[k].summaryTpl)  {
										tplfld = cm[k].summaryTpl;
									}
									if(typeof(this.st) === 'string' && this.st.toLowerCase() === 'avg') {
										if(this.v && grlen > 0) {
											this.v = (this.v/grlen);
										}
									}
									try {
										vv = $t.formatter('', this.v, k, this);
									} catch (ef) {
										vv = this.v;
									}
									tmpdata= "<td "+$t.formatCol(k,1,'')+">"+$.jgrid.format(tplfld,vv)+ "</td>";
									return false;
								}
							});
							str += tmpdata;
						}
						str += "</tr>";
					}
					toEnd = jj;
				}
			});
			$("#"+$.jgrid.jqID($t.p.id)+" tbody:first").append(str);
			// free up memory
			str = null;
		});
	},

	groupingGroupBy : function (name, options ) {
		return this.each(function(){
			var $t = this;
			if(typeof(name) === "string") {
				name = [name];
			}
			var grp = $t.p.groupingView;
			$t.p.grouping = true;

			//Set default, in case visibilityOnNextGrouping is undefined 
			if (typeof grp.visibiltyOnNextGrouping === "undefined") {
				grp.visibiltyOnNextGrouping = [];
			}
			var i;
			// show previous hidden groups if they are hidden and weren't removed yet
			for(i=0;i<grp.groupField.length;i++) {
				if(!grp.groupColumnShow[i] && grp.visibiltyOnNextGrouping[i]) {
				$($t).jqGrid('showCol',grp.groupField[i]);
				}
			}
			// set visibility status of current group columns on next grouping
			for(i=0;i<name.length;i++) {
				grp.visibiltyOnNextGrouping[i] = $("#"+$.jgrid.jqID($t.p.id)+"_"+$.jgrid.jqID(name[i])).is(":visible");
			}
			$t.p.groupingView = $.extend($t.p.groupingView, options || {});
			grp.groupField = name;
			/*$($t).trigger("reloadGrid");*/
		});
	}
});