CONFIG_CKEDITOR = {
    config_mini: {
        toolbar_mini : [
            ["Bold", "Italic", "Underline", "Strike", "-"],
            ['BulletedList', 'NumberedList'], ['Outdent', 'Indent'],
        ],
        toolbar : "mini",
        removePlugins : 'elementspath',
        removePlugins : 'elementspath'
    },
    config_poll: {
        toolbarGroups: [
            {"name":"basicstyles","groups":["basicstyles"]},
            {"name":"links","groups":["links"]},
            {"name":"paragraph","groups":["list","blocks"]},
            {"name":"document","groups":["mode"]},
            {"name":"insert","groups":["insert"]},
            {"name":"styles","groups":["styles"]},
        ],
        removeButtons: 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar'
    }
}
