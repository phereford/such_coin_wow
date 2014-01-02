class @RemoveObject
  constructor: ->
    $('a.remove').click(@promptAndRemove)

  promptAndRemove: (evt) =>
    evt.preventDefault();
    if confirm('Are you sure?')
      $(evt.currentTarget).parents('tr').fadeOut().remove()

      $.ajax $(evt.currentTarget).attr('href'),
        type: 'delete'
        success: =>
          alertify.success('Successfully removed coin.')
        error: =>
          alertify.error('Hmm. Something awful has happened.')

