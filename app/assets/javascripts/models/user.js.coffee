App.User = DS.Model.extend
  email: DS.attr("string")
  authentication_token: DS.attr("string")
