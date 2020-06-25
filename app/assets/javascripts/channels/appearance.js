
App.cable = ActionCable.createConsumer("/cable");
App.notifications = App.cable.subscriptions.create("AppearanceChannel", {
    connected: function() {
        // Called when the subscription is ready for use on the server
        return this.appear();
    },

    disconnected: function() {
        return this.uninstall();
    },

    received: function(data) {
        console.log(data)
        json_to_table(data, "data-active-participant");
    },
    appear: function() {
        return this.perform("appear", {
            appearing_on: $("main").data("appearing-on")
        });
    },
    uninstall: function() {
    }
});
function json_to_table(data, sellector) {
    var tbl_body = "";
        $.each(data.active_participants, function(k , v) {
            tbl_row = "";
            id = k;
            tbl_row += "<td>"+k+"</td>";
            tbl_row += "<td>"+v+"</td>";
            tbl_body += "<tr id=\""+ id +"\">"+tbl_row+"</tr>";
        })

    $("#"+ sellector).html(tbl_body);
}
