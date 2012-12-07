require '../template/file_upload'

Tent.FileUpload = Ember.View.extend
  templateName: 'file_upload'
  classNameBindings: ['tent-file-upload']

  didInsertElement: -> @$('input').fileupload
    add: (e, data) =>
      $('<div class="modal-backdrop" id="file-upload-wait"></div>').appendTo($('body'))
      data.submit().success @successWrapper(@get 'parentView.controller')

  successWrapper: (context) ->
    success = @get 'uploadSuccessFunction'
    $('#file-upload-wait').remove()
    if context and success
      (result, textStatus, jqXHR) -> success.apply(context, arguments)
    else
      (result, textStatus, jqXHR) -> undefined
