App.AuthController = Ember.ObjectController.extend
  currentUser: null
  isAuthenticated: Em.computed.notEmpty("currentUser.email")
  login: (route) ->
    me = @
    $.ajax
      url: "/users/sign_in.json"
      type: "POST"
      data:
        "user[email]": route.currentModel.email
        "user[password]": route.currentModel.password
      success: (data) ->
        console.log "Login msg #{data.user}"
        debugger
        me.set "currentUser", data.user
        App.Store.authToken = data.user.authentication_token
        route.transitionTo "dashboard"
      error: (jqXHR, textStatus, errorThrown) ->
        if jqXHR == 401
          route.controllerFor("login").set "errorMsg", "That email/password combination didn't work. Please try again."
        else if jqXHR == 406
          route.controllerFor("login").set "errorMsg", "Request not acceptable"
        else
          console.log "Login Error: #{jqXHR.status} | #{errorThrown}"
  logout: ->
    me = @
    $.ajax
      url: App.urls.logout
      type: "DELETE"
      dataType: "json"
      success: (data, textStatus, jqXHR) ->
        $("meta[name='csrf-token']").attr("content", data["csrf-token"])
        $("meta[name='csrf-param']").attr("content", data["csrf-param"])
        log.info "Logged out on server"
        me.set "currentUser", null
        @transitionToRoute "home"
      error: (jqXHR, textStatus, errorThrown) ->
        alert "Error logging out: #{errorThrown}"
