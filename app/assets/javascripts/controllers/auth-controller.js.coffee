App.AuthController = Ember.ObjectController.extend
  currentUser: null
  isAuthenticated: Em.computed.notEmpty("currentUser.email")
  login: (route) ->
    $.ajax
      url: "/users/sign_in"
      type: "POST"
      data:
        "user[email]": route.currentModel.email
        "user[password]": route.currentModel.password
      success: (data) ->
        log.log "Login msg #{data.user}"
        @set "currentUser", data.user
        route.transitionTo "dashboard"
      error: (jqXHR, textStatus, errorThrown) ->
        if jqXHR == 401
          route.controllerFor("login").set "errorMsg", "That email/password combination didn't work. Please try again."
        else if jqXHR == 406
          route.controllerFor("login").set "errorMsg", "Request not acceptable"
        else
          p "Login Error: #{jqXHR.status} | #{errorThrown}"

  register: (route) ->
    $.ajax
      url: "users/register"
      type: "POST"
      data:
        "user[email]": route.currentModel.email
        "user[password]": route.currentModel.password
        "user[password_confirmation]": route.currentModel.password_confirmation
      success: (data) ->
        @set "currentUser", data.user
        route.transitionTo "dashboard"
      error: (jqXHR, textStatus, errorThrown) ->
        route.controllerFor("registration").set "errorMsg", "That email/password combination didn't work. Please try again."
  logout: ->
    $.ajax
      url: App.urls.logout
      type: "DELETE"
      dataType: "json"
      success: (data, textStatus, jqXHR) ->
        $("meta[name='csrf-token']").attr("content", data["csrf-token"])
        $("meta[name='csrf-param']").attr("content", data["csrf-param"])
        log.info "Logged out on server"
        @set "currentUser", null
        @transitionToRoute "home"
      error: (jqXHR, textStatus, errorThrown) ->
        alert "Error logging out: #{errorThrown}"
