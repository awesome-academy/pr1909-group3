$(function () {
    var max_value = $(".tasks-sub-form .fields").length;
    $("#poll_multi_vote").attr({
        "max" : max_value,
    });

    $(".add-task").click( function (e) {
        var max_value = $(".tasks-sub-form .fields:not(:hidden)").length;
        $("#poll_multi_vote").attr({
            "max" : max_value,
        });
    });

    $(".remove-link-button").click( function (e) {
        var max_value = $(".tasks-sub-form .fields:not(:hidden)").length;
        if(parseInt($("#poll_multi_vote").val()) > max_value){
            $("#poll_multi_vote").val(1);
        }

    });

    $("#poll_multi_vote").change(function() {
        var max_value = $(".tasks-sub-form .fields:not(:hidden)").length;
        if(parseInt($("#poll_multi_vote").val()) > max_value){
            $("#poll_multi_vote").val(1);
        }
    });
});
