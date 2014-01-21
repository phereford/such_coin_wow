Ember.Handlebars.helper 'parseTime', (time, options) ->
  if time
    new Handlebars.SafeString(moment(time).fromNow())
