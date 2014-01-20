App.CoinsRoute = Ember.Route.extend
  model: ->
    @store.findAll("coin")
