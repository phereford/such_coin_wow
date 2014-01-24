App.TransactionsRoute = Ember.Route.extend
  model: ->
    @store.find("transaction")
