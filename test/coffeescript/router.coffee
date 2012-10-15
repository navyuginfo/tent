Pad.Router = Ember.Router.extend
  location: 'history'
  enableLogging: true

  root: Ember.Route.create
    title: 'root'
         
    index: Ember.Route.create
      route: '/'
      title: 'index'
      redirectsTo: 'home'

    home: Ember.Route.create
      route: '/home'
      title: 'state.home'
       
   