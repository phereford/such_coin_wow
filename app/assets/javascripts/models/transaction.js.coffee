App.Transaction = DS.Model.extend
  coin: DS.belongsTo('coin')
  address: DS.attr('string')
  transactionId: DS.attr('string')
  amount: DS.attr('number')
  category: DS.attr('string')
