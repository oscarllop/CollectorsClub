// Circle Slider
(function ($) {

    'use strict';

    if ($.isFunction($.fn.flipshow)) {
        var circleContainer = $('#fcSlideshow');

        if (circleContainer.get(0)) {
            circleContainer.flipshow();

            setTimeout(function circleFlip() {
                circleContainer.data().flipshow._navigate(circleContainer.find('div.fc-right span:first'), 'right');
                setTimeout(circleFlip, 3000);
            }, 3000);
        }
    }

}).apply(this, [jQuery]);