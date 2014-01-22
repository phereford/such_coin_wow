App.CoinController = Ember.ObjectController.extend
  needs: [ "auth", "coinEdit" ]
  isEditing: false
