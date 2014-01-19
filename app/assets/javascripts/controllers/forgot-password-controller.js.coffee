App.ForgotPasswordController = Ember.ObjectController.extend
  needs: ["auth"]
  isAuthenticated: Em.computed.alias "Controllers.auth.isAuthenticated"
  reset: ->
    # AJAX request for password reset that delays the email being sent
      
