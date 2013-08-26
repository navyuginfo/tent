require '../template/file_upload'

Tent.FileUpload = Ember.View.extend
  templateName: 'file_upload'
  classNameBindings: ['tent-file-upload']

  ###*
  * @property {helpText} helpText The text to appear on the file upload button
  ###
  helpText: 'tent.upload.buttonLabel'

  ###*
  * @property {disabled} disabled A boolean to enable or disable the widget
  ###
  disabled: false
  
  ###*
  * @property {Boolean} dropZone The classname associated with an element which is to act as the 
  * target for drag and drop
  ###
  dropZone: null

  ###*
  * @property {Hash} formData Additional params that needs to be send to server along with the 
  * uploaded files
  ###
  formData: null

  didInsertElement: -> 
    @$('input').fileupload(
      dropZone: @getDropZone()
      add: (e, data) =>
        @set('applyWait', true)
        data.formData = @get('formData')
        data.submit()
          .success(
            @uploadResultFunctionWrapper(@get('parentView.controller'), 'Success'))
          .error(
            @uploadResultFunctionWrapper(@get('parentView.controller'), 'Error'))
    )

    ###
    @getDropZone()?.bind('mouseenter', ->
      $(@).addClass('hover')
    ).bind('mouseleave',->
      $(@).removeClass('hover')
    )
    ###

  getDropZone: ->
    $('.' + @get('dropZone')) if @get('dropZone')?

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
