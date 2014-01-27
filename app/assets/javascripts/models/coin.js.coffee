App.Coin = DS.Model.extend
  name: DS.attr("string")
  ticker: DS.attr("string")
  lastSyncedAt: DS.attr("date")
  user: DS.belongsTo("user")
  transactions: DS.hasMany("transaction")
  exchangeRates: DS.hasMany("exchangeRate")
