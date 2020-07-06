$(document).ready(function () {
  var event_id = $('body').data('params-id');
  $('.event-tab li a').click(function () {
    console.log($(this).attr('href'))
    switch ($(this).attr('href')) {
      case '#tabs-note':
        loadData('notes');
        break;

      case '#tabs-poll':
        loadData('polls');
        break;

      case '#tabs-question':
        loadData('questions');
        break;

      case '#tabs-document':
        loadData('documents');
        break;
    }
  });


});

function loadData(model = '') {
  $.ajax({
    url: $('body').attr("data-params-id") + '/' + model,
    type: 'get',
    dataType: "script",
    data: {
      authenticity_token: $('[name="csrf-token"]')[0].content,
    },
  });
}
