###*
* @class Tent.DateRangeField
* @extends Tent.TextField
* Usage
*       {{view Tent.DateRangeField label="" 
			valueBinding="" 
			showOtherMonths=true  
			dateFormat=""
         }}
###

require '../template/text_field'
require '../mixin/jquery_ui'

Tent.DateRangeField = Tent.TextField.extend
	classNames: ['tent-date-range-field']