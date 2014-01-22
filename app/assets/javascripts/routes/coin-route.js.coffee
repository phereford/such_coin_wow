App.CoinRoute = Ember.Route.extend
  model: (params) ->
    @store.find("coin", params.coin_id)

  setupController: (controller, model) ->
    @._super.apply(@, arguments)
    if controller.get("isEditing")
      controller.stopEditing()

    @controllerFor("coins").set("activeCoinId", model.get("id"))

  deactivate: ->
    controller = @controllerFor("coin")

    if controller.get("isEditing")
      controller.stopEditing()

    @controllerFor("coins").set("activeCoinId", null)
