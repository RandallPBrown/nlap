  jQuery(function() {
  var agents;
  agents = $('#entry_agent_id').html();
  console.log(agents);
  return $('#entry_dept').change(function() {
    var department, options;
    department = $('#entry_dept :selected').text();
    options = $(agents).filter("optgroup[label=" + department + "]").html();
    console.log(options);
    if (options) {
      return $('#entry_agent_id').html(options);
    } else {
      return $('#entry_agent_id').empty();
    }
  });
});

  var chart_labels = <%= raw @chart_labels_today %>;
var chart_data = <%= raw @chart_data_today %>;
var dataset_label = "Today";
var chart_type = 'bar';
var ctx = document.getElementById("occurrenceChart").getContext('2d');
var config = {
    type: 'bar',
    data: {
        labels: chart_labels,
        datasets: [{
            type: chart_type,
            label: dataset_label,
            yAxisID: "y-axis-0",
            fill: true,
            data: chart_data,
            backgroundColor: [
                'rgba(54, 162, 235, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(54, 162, 235, 0.2)'
            ],
            borderColor: [
                'rgba(54, 162, 235, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(54, 162, 235, 1)'
            ],
            borderWidth: 1
        },]
    },
    options: {
        scales: {
            yAxes: [{
                position: "left",
                "id": "y-axis-0",
                ticks: {
                  beginAtZero: true
                }
            }]
        }
    }
};
var occurrence_chart = new Chart(ctx, config);
$("#chartToday").click(function() {
    var chart_labels = <%= raw @chart_labels_today %>;
    var chart_data = <%= raw @chart_data_today %>;
    var dataset_label = "Today";
    var data = occurrence_chart.config.data;
    data.datasets[0].data = chart_data;
    data.labels = chart_labels;
    data.datasets[0].label = dataset_label;
    occurrence_chart.update();
});
$("#chart90Day").click(function() {
    var chart_labels = <%= raw @chart_labels_effective %>;
    var chart_data = <%= raw @chart_data_effective %>;
    var dataset_label = "90 Days";
    var data = occurrence_chart.config.data;
    data.datasets[0].data = chart_data;
    data.labels = chart_labels;
    data.datasets[0].label = dataset_label;
    occurrence_chart.update();
});
$("#chartBar").click(function() {
    var chart_type = 'bar';
    var data = occurrence_chart.config.data;
    data.datasets[0].type = chart_type;
    occurrence_chart.update();
});
$("#chartLine").click(function() {
    var data = occurrence_chart.config.data;
    var chart_type = 'line';
    data.datasets[0].type = chart_type;
    occurrence_chart.update();
});