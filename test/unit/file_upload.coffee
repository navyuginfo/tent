#
# Copyright PrimeRevenue, Inc. 2012
# All rights reserved.
#

require 'tent'

view = null
appendView = -> (Ember.run -> view.appendTo('#qunit-fixture'))

module "Tent.FileUpload Widget", ->
    @TemplateTests = Ember.Namespace.create()
  , ->
    if view
      Ember.run -> view.destroy()
      view = null
    @TemplateTests = undefined

test(
  'successWrapper should return a function callable with context',
  ->
    view = Ember.View.create
      template: Ember.Handlebars.compile '{{view Tent.FileUpload dataUrl="/fileupload"}}'

    appendView()

    context = {}

    success = (result, textStatus, jqXHR) -> @

    upload = Tent.FileUpload.create()

    upload.set 'uploadSuccessFunction', success

    ok(
      upload.successWrapper(context)() == context,
      "data should have been removed from array"
    )
)
