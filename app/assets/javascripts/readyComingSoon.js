 function coming_soon(str) {
    if (str == undefined) { str = gon.event.starts_on }
    var date = moment(str);
    var dateComponent = date.utc().format('YYYY-MM-DD HH:mm:ss');
    $('.js-countdown').countdown(dateComponent, function(event) {
        $(this).html(event.strftime('<div class="row">'
                + '<div class="col-xs-6 col-sm-3 countdown-con"><div class="countdown-num">%-D</div><div class="countdown-info">DAYS</div></div>'
                + '<div class="col-xs-6 col-sm-3 countdown-con"><div class="countdown-num">%H</div><div class="countdown-info">HOURS</div></div>'
                + '<div class="col-xs-6 col-sm-3 countdown-con"><div class="countdown-num">%M</div><div class="countdown-info">MINUTES</div></div>'
                + '<div class="col-xs-6 col-sm-3 countdown-con"><div class="countdown-num">%S</div><div class="countdown-info">SECONDS</div></div>'
                + '</div>'
        ));
    });
};
