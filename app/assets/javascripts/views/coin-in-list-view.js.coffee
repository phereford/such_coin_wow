App.CoinInListView = Em.View.extend
  tagName: "tr"
  templateName: "coin-in-list-view"
  classNameBindings: "isActive:active"

  isActive: (->
    @get("content.id") is @get("controller.activeCoinId")
  ).property("controller.activeCoinId")
