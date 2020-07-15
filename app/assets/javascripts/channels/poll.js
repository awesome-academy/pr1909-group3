function createPollChannel(chart) {
  App.cable = ActionCable.createConsumer("/cable");
  App.messages = App.cable.subscriptions.create(
    {
      channel: 'PollChannel',
      id: gon.poll.id
    },
    {
      received: function (data) {
        console.log(data);
        console.log(loadDataColumm(data.options));
        updateDataChart(chart,loadDataColumm(data.options))
      },
    }
  );
}
