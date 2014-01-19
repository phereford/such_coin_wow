App.LoginRoute = Ember.Route.extend
  model: -> Ember.Object.create()
  setupController: (controller, model) ->
    controller.set "content", model
    controller.set "errorMsg", ""
  actions:
    login: ->
      console.log "Logging in..."
      @controllerFor("auth").login this
    cancel: ->
      log.info "cancelling login"
      @transitionTo "home"
    forgotPassword: ->
      console.log "forgot password"
      @transitionTo "forgotPassword"
