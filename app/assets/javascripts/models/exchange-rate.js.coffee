App.ExchangeRate = DS.Model.extend
  coin: DS.belongsTo("coin")
  market: DS.attr("string")
  marketType: DS.attr("string")
  occurredAt: DS.attr("date")
  rate: DS.attr("number")
