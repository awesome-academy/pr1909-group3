function show_modal(partial, title = '', size) {
    $("#notice-form").html("")
    $("#modal-body").html(partial)
    $("#modal-title").html(title)
    $("#modal-shared").modal("toggle");
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

jQuery.timeago.settings.allowFuture = true;

String.prototype.capitalize = function () {
    return this.charAt(0).toUpperCase() + this.slice(1);
}

function makeid(length) {
    var result = '';
    var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var charactersLength = characters.length;
    for (var i = 0; i < length; i++) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
}
