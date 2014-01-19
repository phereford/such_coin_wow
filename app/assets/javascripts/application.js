//= require jquery
//= require handlebars
//= require ember
//= require ember-data
//= require highcharts.com/js/highcharts.src.js
//= require highcharts.com/js/highcharts-more.src.js
//= require highcharts.com/js/modules/exporting.src.js
//= require alertify
//= require sync-transaction
//= require remove-object
//= require hstore
//= require mining-variance-chart
//= require_self
//= require such_coin_wow

App = Ember.Application.create({
  LOG_TRANSITIONS: true,
  LOG_TRANSITIONS_INTERNAL: true,
  rootElement: '#content-container'
});
