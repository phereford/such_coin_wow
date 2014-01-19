App.ForgotPasswordRoute = Ember.Route.extend
  model: -> Ember.Object.create()
  setupController: (controller, model) ->
    controller.set "content", model
    controller.set "errorMsg", ""
  actions:
    resetPassword: ->
      console.log "Resetting password"
      @controllerFor("forgotPassword").reset this
