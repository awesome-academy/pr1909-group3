App.cable = ActionCable.createConsumer("/cable");
App.notifications = App.cable.subscriptions.create(
  {
    channel: 'DashboardTimelineChannel',
    id: gon.event.id
  },
  {
    connected: function () {
    },

    disconnected: function () {
    },

    received: function (data) {
      console.log(data)
      updateDataTimeline(data);
      updateDataTab(data);
      toast_dashboard_notification(data);
    }
  });

function updateDataTab(data) {
  var current_tab = $("#dashboard-event-tab li.active span:hidden").text();
  if (current_tab != data.type) {
    return;
  } else {
    switch (data.action) {
      case 'create':
        $(`#tabs-${data.type} table tbody`).prepend(data.tab_html);
        break;

      case 'update_content':
        console.log(data.tab_html)
        $(`#el-${data.type}-${data.id}`).replaceWith(data.tab_html);
        break;

      case 'delete':
        $(`#el-${data.type}-${data.id}`).remove();
        break;

      case 'enable_time_line':
        $(`#el-${data.type}-${data.id}`).replaceWith(data.tab_html);
        break;

      case 'disable_time_line':
        $(`#el-${data.type}-${data.id}`).replaceWith(data.tab_html);
        break;
      default:
    }
  }
}

function updateDataTimeline(data) {
  switch (data.action) {
    case 'update_content':
      console.log(data.timeline_html)
      html = data.timeline_html;
      $(`#admin-timeline #${data.type}-tl-${data.id}`).replaceWith(html);
      break;

    case 'delete':
      $(`#${data.type}-tl-${data.id}`).remove();
      break;

    case 'enable_time_line':
      $(`#admin-timeline`).prepend(data.timeline_html);
      break;

    case 'disable_time_line':
      $(`#admin-timeline #${data.type}-tl-${data.id}`).remove();
      break;
    default:
  }
  update_time();
}

function toast_dashboard_notification(data) {
  switch (data.action) {
    case 'create':
      toast_top_right(
        `${data.title} has created`,
        `${data.type.capitalize()} created`
      );
      break;
    case 'update_content':
      toast_top_right(
        `${data.title} has updated`,
        `${data.type.capitalize()} updated content`
      );
      break;

    case 'delete':
      toast_top_right(
        `${data.title} has delete`,
        `${data.type.capitalize()} deleted`,
        'warning'
      );
      break;

    case 'enable_time_line':
      toast_top_right(
        `${data.title} active to timeline`,
        `${data.type.capitalize()} actived to timeline`,
        'success'
      );
      break;

    case 'disable_time_line':
      toast_top_right(
        `${data.title} active to timeline`,
        `${data.type.capitalize()} inactived to timeline`,
        'warning'
      );
      break;
    default:
  }
}

function update_time() {
  $("time.timeago").timeago();
}