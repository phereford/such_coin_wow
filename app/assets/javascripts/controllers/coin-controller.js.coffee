App.CoinController = Ember.ObjectController.extend
  needs: [ "auth", "coinEdit" ]
  isEditing: false

  startEditing: ->
    coinEditController = @get("controllers.coinEdit")
    coinEditController.set("model", @get("model"))
    coinEditController.startEditing()
    @set("isEditing", true)
