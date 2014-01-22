App.CoinsController = Ember.ArrayController.extend
  needs: [ "auth" ]
  activeCoinId: null

  actions:
    redirectToEdit: ->
      @transitionTo("coin.edit")

    startSyncing: (params) ->
      $.ajax "/coins/#{params.id}/sync",
        method: "POST"
        dataType: "json"
        success: (data) ->
          alertify.success(data)
        error: (data) ->
          alertify.log(data.responseText)
