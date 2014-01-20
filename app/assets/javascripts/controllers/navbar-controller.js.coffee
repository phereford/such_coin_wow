App.NavbarController = Ember.ObjectController.extend
  needs: ["auth"]
  isAuthenticated: Em.computed.alias "controllers.auth.isAuthenticated"
  actions:
    logout: ->
      log.info "NavbarController handling logout event..."
      @get("controllers.auth").logout()
