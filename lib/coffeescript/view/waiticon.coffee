Tent.WaitIcon = Ember.View.extend
	template: Ember.Handlebars.compile """
    <div class="wait">
      {{#if view.isIE}}
        <img src='/images/ajax_loader.gif' class='ajax-loader' />
      {{else}}
        <i class="icon-spinner icon-spin icon-2x"></i>
      {{/if}}
    </div>
  """
  isIE: (-> Tent.Browsers.isIE()).property()