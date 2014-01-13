App.IndexRoute = Ember.Route.extend
  beforeModel: (transition) ->
    @transitionTo "home"
