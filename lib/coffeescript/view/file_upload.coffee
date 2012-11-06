require '../template/file_upload'

Tent.FileUpload = Ember.View.extend
  templateName: 'file_upload'
  classNameBindings: ['tent-file-upload']

  didInsertElement: -> @$('input').fileupload
    add: (e, data) =>
      data.submit().success @successWrapper(@get 'parentView.controller')

  successWrapper: (context) ->
    success = @get 'uploadSuccessFunction'
    if context and success
      (result, textStatus, jqXHR) -> success.apply(context, arguments)
    else
      (result, textStatus, jqXHR) -> undefined
