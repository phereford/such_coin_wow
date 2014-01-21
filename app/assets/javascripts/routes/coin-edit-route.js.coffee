App.CoinEditRoute = Ember.Route.extend
  model: (params) ->
    @store.find("coin", params.coin_id)
