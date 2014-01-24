App.CoinEditController = Ember.ObjectController.extend
  needs: [ "auth", "coin" ]
  startEditing: ->
    coin = @get("model")
