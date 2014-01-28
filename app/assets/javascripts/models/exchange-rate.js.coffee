App.ExchangeRate = DS.Model.extend
  coin: DS.belongsTo("coin")
  exchange: DS.attr("string")
  market: DS.attr("string")
  occurredAt: DS.attr("date")
  rate: DS.attr("number")
