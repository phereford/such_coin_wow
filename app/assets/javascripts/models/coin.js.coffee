App.Coin = DS.Model.extend
  name: DS.attr('string')
  ticker: DS.attr('string')
  lastSyncedAt: DS.attr('date')
  mined: DS.attr('boolean')
  user: DS.belongsTo('user')
  transactions: DS.hasMany('transaction')
