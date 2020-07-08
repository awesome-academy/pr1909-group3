function loadDataColumm(data = []) {
  results = [];
  data.forEach(function (element, i) {
    mObject = {
      showInLegend: true,
      legendText: element.content,
      dataPoints: [{x: i++, y: element.votes_count}]
    }
    results.push(mObject);
  });
  return results;
}

function createColumnChart(name, data) {
  var chart = new CanvasJS.Chart("chartContainer",
    {
      title: {
        text: name
      },
      axisX: {
        title: "",
        tickLength: 0,
        margin: 0,
        lineThickness: 0,
        valueFormatString: " "
      },
      legend: {
        horizontalAlign: "left",
        verticalAlign: "bottom",
        fontSize: 15
      },
      data: data
    });
  
  chart.render();
  return chart;
}

function updateDataChart(chart, data) {
  chart.options.data = data;
  chart.render();
}
