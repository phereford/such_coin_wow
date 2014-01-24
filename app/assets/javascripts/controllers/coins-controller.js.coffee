App.CoinsController = Ember.ArrayController.extend
  needs: [ "auth", "coinEdit" ]
  activeCoinId: null

  actions:
    redirectToTransactions: (params) ->
      @transitionToRoute("transactions.index")

    startSyncing: (params) ->
      $.ajax "/coins/#{params.id}/sync",
        method: "POST"
        dataType: "json"
        success: (data) ->
          alertify.success(data)
        error: (data) ->
          alertify.error(data.responseText)

    delete: (params) ->
      @get("store").find("coin", params.id).then (record) ->
        ticker = record.get("ticker")
        if confirm "Are you sure you want to delete #{ticker}?"
          record.destroyRecord().then(onSuccess(ticker))

      onSuccess = (ticker) ->
        alertify.success("Successfully deleted #{ticker}")
