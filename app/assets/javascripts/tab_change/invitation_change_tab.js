$(document).ready(function(){
    console.log("sddddddddddd")
  var event_id = $('body').data('params-id');
  $('.invite-tab li a').click(function() {
    console.log($(this).attr('href'))
    switch($(this).attr('href')){
      case '#invitation-unconfirmed':
        loadInvitation('unconfirmed');
      break;
      
      case '#invitation-confirmed':
        loadInvitation('confirmed');
      break;
    }
  });
  

});

function loadInvitation(option = '') {
  $.ajax({
    url:  'invitations/',
    type: 'get',
    dataType: "script",
    data: {
      authenticity_token: $('[name="csrf-token"]')[0].content,
      filter: option,
    },
  });
}
