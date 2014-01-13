App.CoinRoute = Ember.Route.extend
  model: ->
    @store.find('coin', 1)
