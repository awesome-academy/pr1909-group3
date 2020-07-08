$(document).ready(function () {
  console.log("sddddddddddd")
  $('.dashboard-tab li a').click(function () {
    console.log($(this).attr('href'))
    switch ($(this).attr('href')) {
      case '#dashboard-events':
        loadDashboard('events');
        break;
      case '#dashboard-contacts':
        loadDashboard('contacts');
        break;
      case '#dashboard-invited_events':
        loadDashboard('events/invited');
        break;
    }
  });


});

function loadDashboard(option = '') {
  $.ajax({
    url: 'dashboard/' + option,
    type: 'get',
    dataType: "script",
    data: {
      authenticity_token: $('[name="csrf-token"]')[0].content,
    },
  });
}
