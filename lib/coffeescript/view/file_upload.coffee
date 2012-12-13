require '../template/file_upload'

Tent.FileUpload = Ember.View.extend
  templateName: 'file_upload'
  classNameBindings: ['tent-file-upload']

  didInsertElement: -> @$('input').fileupload
    add: (e, data) =>
      $('<div class="modal-backdrop" id="file-upload-wait"></div>').appendTo($('body'))
      data.submit()
        .success(
          @uploadResultFunctionWrapper(@get('parentView.controller'), 'Success'))
        .error(
          @uploadResultFunctionWrapper(@get('parentView.controller'), 'Error'))

  uploadResultFunctionWrapper: (context, name) ->
    resultFunction = @get 'upload' + name + 'Function'
    $('#file-upload-wait').remove()
    if context and resultFunction
      (result, textStatus, jqXHR) -> resultFunction.apply(context, arguments)
    else
      (result, textStatus, jqXHR) -> undefined
