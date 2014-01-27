App.Transaction = DS.Model.extend
  coin: DS.belongsTo("coin")
  account: DS.attr("string")
  address: DS.attr("string")
  transactionId: DS.attr("string")
  amount: DS.attr("number")
  category: DS.attr("string")
  occurredAt: DS.attr("date")
