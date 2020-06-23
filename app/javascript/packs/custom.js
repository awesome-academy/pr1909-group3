function show_modal(partial, title = '', size) {
    $("#notice-form").html("")
    $("#modal-body").html(partial)
    $("#modal-title").html(title)
    $("#modal-shared").modal("toggle");
    // Turn off automatic editor creation first.
    init_editor_inline();

}

function init_editor_inline() {
    var elements = CKEDITOR.document.find('.editor-inline'),
        i = 0,
        element;

    while ((element = elements.getItem(i++))) {
        CKEDITOR.inline(element,
            CONFIG_CKEDITOR.config_poll
        );
    }
}

function add_fields(link, association, content) {
    var new_id = new Date().getTime();

    // find the new_ + "association" that was defined in Rails helper
    var regexp = new RegExp("new_" + association, "g");

    // find the container and append in the sub field content
    $(link).prev().append(content.replace(regexp, new_id));
    return false;
}

function removeField(link) {
    $(link).parent().prev("input[type=hidden]").val("true");
    $(link).closest(".fields").fadeOut();
}

function scrollToBot(id) {
    var element = document.getElementById(id);
    element.scrollTop = element.scrollHeight;
}

jQuery.timeago.settings.allowFuture = true;

// Su dung cho phan dat cau hoi
function toast_success(text, heading = 'Success') {
    $.toast({
        heading: heading,
        text: text,
        icon: 'success'
    })
}

function toast_warning(text, heading = 'Success') {
    $.toast({
        heading: heading,
        text: text,
        icon: 'warning'
    })
}

function toast_top_right(text, heading = 'Success', icon = 'success') {
    $.toast({
        heading: heading,
        text: text,
        icon: icon,
        position: 'top-right',
    })
}

String.prototype.capitalize = function () {
    return this.charAt(0).toUpperCase() + this.slice(1);
}


$(document).ready(function () {
    $('.select2-option').select2();
});

function makeid(length) {
    var result = '';
    var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var charactersLength = characters.length;
    for (var i = 0; i < length; i++) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
}

