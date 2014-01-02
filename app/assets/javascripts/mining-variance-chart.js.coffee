class @MiningVarianceChart
  constructor: ->
    @chartContainer = $('#chart-container')
    $.ajax "/coins/#{@chartContainer.data('coin-id')}/daily_summary",
      dataType: 'json'
      success: (data) =>
        @chartContainer.highcharts(@options(data))

  options: (data) =>
    chart: { type: 'line', zoomType: 'x' }
    title: { text: 'Daily Mining Totals' }
    xAxis:
      type: 'datetime'
    yAxis: { title: { text: null } }
    tooltip:
      crosshairs: true
      shared: true
    legend:
      enabled: false
    series: [{
      name: @chartContainer.data('coin-name')
      data: data,
    }]
