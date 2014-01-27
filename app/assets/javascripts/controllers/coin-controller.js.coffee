App.CoinController = Ember.ObjectController.extend
  needs: [ "auth", "coinEdit" ]
  isEditing: false

  transactions: (->
    Ember.ArrayProxy.createWithMixins Ember.SortableMixin,
      sortProperties: [ "occurredAt" ],
      sortAscending: false,
      content: @get("content.transactions")
  ).property("content.transactions")

  startEditing: ->
    coinEditController = @get("controllers.coinEdit")
    coinEditController.set("model", @get("model"))
    coinEditController.startEditing()
    @set("isEditing", true)
