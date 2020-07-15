$(document).ready(function(){
    console.log("sddddddddddd")
  var event_id = $('body').data('params-id');
  $('.participant-tab li a').click(function() {
    console.log($(this).attr('href'))
    switch($(this).attr('href')){
      case '#all-participant':
        loadParticipant('all');
      break;
    }
  });
  

});

function loadParticipant(option = '') {
  $.ajax({
    url:  'participants/',
    type: 'get',
    dataType: "script",
    data: {
      authenticity_token: $('[name="csrf-token"]')[0].content,
      filter: option,
    },
  });
}
