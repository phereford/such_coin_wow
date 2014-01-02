class @SyncTransaction
  constructor: ->
    $('a.sync').click(@sync)

  sync: (evt) =>
    evt.preventDefault()
    link = $(evt.currentTarget).attr('href')
    $.ajax link,
      method: 'POST'
      success: =>
        alertify.success('The sync has been queued.')
      error: =>
        alertify.error('There was an error.')
