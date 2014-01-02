class @Hstore
  constructor: (@hstoreContainer) ->
    for hstoreInput in @hstoreContainer.find('.dynamicAttribute')
      hstoreInput = $(hstoreInput)
      fieldValue = hstoreInput.val()
      valueField = hstoreInput.parents('tr').find('.dynamicAttributeValue')
      valueFieldName = valueField.attr('name')+"[#{fieldValue}]"
      valueField.attr('name', valueFieldName)
      hstoreInput.change(@updateKeyField)

    addFieldsButton = @hstoreContainer.find('a.add-attribute')
    removeFieldsButton = @hstoreContainer.find('a.remove-attribute')
    fieldsMonitored = @hstoreContainer.find('.dynamicAttribute')

    @addFieldsButtonClicked(addFieldsButton)
    @removeFieldsButtonClicked(removeFieldsButton)
    @trackFieldChanges(fieldsMonitored)

  addFieldsButtonClicked: (button) =>
    $(button).on('click', @addAttributeValueFields)

  addAttributeValueFields: (evt) =>
    evt.preventDefault()
    $(evt.currentTarget)
      .parents('table tbody')
      .append(
        $(evt.currentTarget).data('insertion-form')
      )

    # Have to add new click event to the newly added removeButton
    parent = $(evt.currentTarget)
      .parents('tbody')
      .find('tr')
      .last()
    removeButton = $(parent).find('a.remove-attribute')
    fieldTracked = $(parent).find('input.dynamicAttribute')
    @removeFieldsButtonClicked(removeButton)
    @trackFieldChanges(fieldTracked)
    fieldTracked.change(@updateKeyField)

  removeFieldsButtonClicked: (button) =>
    $(button).on('click', @removeAttributeValueFields)

  removeAttributeValueFields: (evt) =>
    evt.preventDefault()
    $(evt.target)
      .parents('tr')
      .remove()

  trackFieldChanges: (fields) =>
    $(fields).on('change', @setFieldValue)

  setFieldValue: (evt) =>
    newAttribute = $(evt.currentTarget).val()
    parent = $(evt.currentTarget).parents('tr')
    valueField = $(parent).find('input').last()

    # When the key of an hstore is dynamically changed, we have to change the
    # hstore's value name attribute to reflect the new key.
    # Changing: { 'asd' => '123' } to { 'test' => '456' }
    # would change the name from reviewables[x][asd] to reviewables[x][test]
    hasNameRegexp = /\]\[(.*?)\]$/
    if $(valueField).attr('name').match(hasNameRegexp)
      $(valueField).attr(
        'name',
        $(valueField).attr('name').replace(hasNameRegexp, "][#{newAttribute}]")
      )
    else
      $(valueField).attr(
        'name',
        $(valueField).attr('name')+"[#{newAttribute}]"
      )

  # This function takes the hstore's key input field and will change the html
  # value and the data-hstore-key values to match the new value in the input
  updateKeyField: (evt) ->
    evt.preventDefault()
    hstoreKeyField = $(evt.currentTarget)
    hstoreKeyField.attr('value', $(evt.currentTarget).val())
    hstoreKeyField.attr('data-hstore-key', hstoreKeyField.val())
