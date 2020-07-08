function createQuesionChannel(question_id, current_participant_id) {
  App.cable = ActionCable.createConsumer("/cable");
  subscription = App.cable.subscriptions.create(
    {
      channel: 'QuestionChannel',
      id: question_id
    },
    {
      received: function (data) {
        console.log(data);
        console.log(current_participant_id);
        update_question_box(data, current_participant_id);
      },
    }
  );

  return subscription;
}

function update_question_box(data, current_participant_id) {
  if (data.participant_id == current_participant_id) {
    $("#chatui-message").val("");
    ReadyChat.addAnswer(data.answer_html)
  } else {
    ReadyChat.addOthersAnswer(data.other_answer_html)
  }
}
