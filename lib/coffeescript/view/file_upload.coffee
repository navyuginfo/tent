require '../template/file_upload'

Tent.FileUpload = Ember.View.extend
  templateName: 'file_upload'
  classNameBindings: ['tent-file-upload']

  didInsertElement: -> @$('input').fileupload
    add: (e, data) =>
      @set('applyWait', true)
      data.submit()
        .success(
          @uploadResultFunctionWrapper(@get('parentView.controller'), 'Success'))
        .error(
          @uploadResultFunctionWrapper(@get('parentView.controller'), 'Error'))

  uploadResultFunctionWrapper: (context, name) ->
    resultFunction = @get 'upload' + name + 'Function'
    self = @
    if context and resultFunction
      (result, textStatus, jqXHR) ->
        self.set('applyWait', false)
        resultFunction.apply(context, arguments)
    else
      (result, textStatus, jqXHR) ->
        self.set('applyWait', false)
        undefined
