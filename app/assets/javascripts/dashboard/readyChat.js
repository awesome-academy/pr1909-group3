/*
 *  Document   : readyChat.js
 *  Author     : pixelcave
 *  Description: Custom javascript code used in Chat page
 */

var ReadyChat = function () {
  var chatHeight = 400; // Default chat container height in large screens
  var chatHeightSmall = 200; // Default chat components (talk & people) height in small screens

  /* Cache some often used variables */
  var chatCon = $('.chatui-container');
  var chatTalk = $('.chatui-talk');
  var chatTalkScroll = $('.chatui-talk-scroll');

  var chatPeople = $('.chatui-people');
  var chatPeopleScroll = $('.chatui-people-scroll');

  var chatInput = $('.chatui-input');
  var chatMsg = '';
  var submitButton = $('span.input-group-addon');

  /* Updates chat UI components height */
  var updateChatHeight = function () {
    var windowW = window.innerWidth
      || document.documentElement.clientWidth
      || document.body.clientWidth;

    if (windowW < 768) { // On small screens
      chatCon
        .css('height', (chatHeightSmall * 2) + chatInput.outerHeight());

      chatTalk
        .add(chatTalkScroll)
        .add(chatTalkScroll.parent())
        .add(chatPeople)
        .add(chatPeopleScroll)
        .add(chatPeopleScroll.parent())
        .css('height', '90%');
    }
    else if (windowW > 767) { // On large screens
      chatCon
        .css('height', chatHeight);

      chatTalk
        .add(chatTalkScroll)
        .add(chatTalkScroll.parent())
        .css('height', chatHeight - chatInput.outerHeight());

      chatPeople
        .add(chatPeopleScroll)
        .add(chatPeopleScroll.parent())
        .css('height', chatHeight);
    }
  };

  return {
    init: function () {
      // Initialize default chat height
      updateChatHeight();
      // Update chat UI components height on window resize
      $(window).resize(function () {
        updateChatHeight();
      });
      // Initialize scrolling on chat talk + people
      // chatTalkScroll
      //   .slimScroll({
      //     height: chatTalk.outerHeight(),
      //     color: '#000',
      //     size: '3px',
      //     position: 'right',
      //     touchScrollStep: 100
      //   });
      //
      // chatPeopleScroll
      //   .slimScroll({
      //     height: chatPeople.outerHeight(),
      //     color: '#fff',
      //     size: '3px',
      //     position: 'right',
      //     touchScrollStep: 100
      //   });

      submitButton.click(function (e) {
        var form = $('#form-answer');
        var url = form.attr('action');

        $.ajax({
          type: "POST",
          url: url,
          data: form.serialize(), // serializes the form's elements.
          success: function (data) {
          }
        });

        e.preventDefault();
      });

      $('#form-answer')
        .submit(function (e) {
          e.preventDefault();
        });
    },
    addAnswer: function (chatMsg) {
      // If the user typed a message
      if (chatMsg) {
        // Add it to the message list
        chatTalk
          .find('ul')
          .append(chatMsg);

        // Scroll the message list to the bottom
        chatTalkScroll
          .animate({ scrollTop: chatTalkScroll[0].scrollHeight }, 150);
      }
    },
    addOthersAnswer: function (chatMsg) {
      // If the user typed a message
      if (chatMsg) {
        // Add it to the message list
        chatTalk
          .find('ul')
          .append(chatMsg);

        // Scroll the message list to the bottom
        chatTalkScroll
          .animate({ scrollTop: chatTalkScroll[0].scrollHeight }, 150);
      }
    }

  };
}();
