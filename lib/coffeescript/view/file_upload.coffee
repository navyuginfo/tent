require '../template/file_upload'

Tent.FileUpload = Ember.View.extend
  templateName: 'file_upload'
  classNameBindings: ['tent-file-upload']

  init: ->
    @_super()
    @set 'selectedFiles', Ember.A()

  didInsertElement: -> @$('input').fileupload
    add: (e, data) => @addFile(e, data)
    done: (e, data) => @doneUploading(e, data)

  successWrapper: (context) ->
    success = @get 'uploadSuccessFunction'
    if context and success
      (result, textStatus, jqXHR) -> success.apply(context, arguments)
    else
      (result, textStatus, jqXHR) -> undefined

  upload: ->
    @get('selectedFiles').forEach (file) =>
      success = @successWrapper(@get 'parentView.controller')
      file.submit().success( success )

  addFile: (e, data) -> @get('selectedFiles').pushObject(data)

  doneUploading: (e, data) ->
    selectedFiles = @get('selectedFiles')
    selectedFiles.removeObject(
      selectedFiles.filter((file) -> file.files[0] == data.files[0])[0])

  anyFiles: ( -> @get('selectedFiles').length > 0 ).property('selectedFiles.@each')
