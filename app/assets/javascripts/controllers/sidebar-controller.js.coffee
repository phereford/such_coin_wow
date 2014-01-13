App.SidebarController = Ember.ObjectController.extend
  needs: ["auth"]
  isAuthenticated: Em.computed.alias "Controllers.auth.isAuthenticated"
  actions:
    logout: ->
      log.info "Navbar Controller handling logout event..."
      @get("controllers.auth").logout()
