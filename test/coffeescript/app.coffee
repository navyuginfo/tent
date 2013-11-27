
## Application bootstrapper
Ember.LOG_BINDINGS = false

window.Pad = Ember.Application.create 
    Views       : Em.Namespace.create
    Models      : Em.Namespace.create
    Controllers : Em.Namespace.create
    LOG_TRANSITIONS : false


