App.DashboardController = Ember.ObjectController.extend
  needs: ["auth"]
  isAuthenticated: Em.computed.alias "Controllers.auth.isAuthenticated"
