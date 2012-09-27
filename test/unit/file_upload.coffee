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
  'addFile method adds the uploaded file object to selectedFiles array',
  ->
    view = Ember.View.create
      template: Ember.Handlebars.compile '{{view Tent.FileUpload dataUrl="/fileupload"}}'

    appendView()

    upload = Tent.FileUpload.create()

    data = {}
    upload.addFile({},data)

    ok(
      upload.get('selectedFiles').indexOf(data) != -1,
      "data should have been included in array"
    )
)

test(
  'doneUploading should remove uploaded element from selectedFiles array',
  ->
    view = Ember.View.create
      template: Ember.Handlebars.compile '{{view Tent.FileUpload dataUrl="/fileupload"}}'

    appendView()

    upload = Tent.FileUpload.create()

    file = {}
    add_data = {files:[file]}
    upload.addFile({}, add_data)

    delete_data = {files:[file]}
    upload.doneUploading({}, delete_data)

    ok(
      upload.get('selectedFiles').indexOf(add_data) == -1,
      "data should have been removed from array"
    )
)
