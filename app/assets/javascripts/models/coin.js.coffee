App.Coin = DS.Model.extend
  name: DS.attr('string')
  ticker: DS.attr('string')
  user: DS.belongsTo('user')
  transactions: DS.hasMany('transaction')
