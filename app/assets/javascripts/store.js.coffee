App.Store = DS.Store.extend
  adapter: '_ams'

DS.RESTAdapter.reopen
  namespace: 'api/v1'
