// Generated by CoffeeScript 1.6.3
(function() {
  var Beat, beat;

  Beat = (function() {
    function Beat() {
      var logo, offset,
        _this = this;
      logo = $("#logo");
      offset = logo.offset();
      this.paper = Raphael(offset.left + 133, offset.top - 73, 225, 270);
      this.donzDaz();
      setInterval(function() {
        return requestAnimationFrame(function() {
          return _this.donzDaz();
        });
      }, 12000);
    }

    Beat.prototype.donzDaz = function() {
      this.times = 4;
      return this.donz();
    };

    Beat.prototype.donz = function() {
      var circle, circle2,
        _this = this;
      circle = this.paper.circle(112, 109, 27);
      circle.attr({
        stroke: 'rgb(70, 169, 201)',
        fill: 'transparent',
        'stroke-width': 7
      });
      circle.animate({
        r: 65,
        stroke: '#CCC',
        opacity: 0
      }, 2800, 'ease-out');
      circle2 = this.paper.circle(101, 177, 27);
      circle2.attr({
        stroke: 'rgb(70, 169, 201)',
        fill: 'transparent',
        'stroke-width': 7
      });
      circle2.animate({
        r: 65,
        stroke: '#CCC',
        opacity: 0
      }, 2800, 'ease-out');
      if (this.times) {
        this.times -= 1;
        return setTimeout(function() {
          return requestAnimationFrame(function() {
            return _this.donz();
          });
        }, 300 * this.times);
      }
    };

    return Beat;

  })();

  beat = new Beat;

  $("#members").delegate('.member-meta1', 'webkitAnimationEnd mozAnimationEnd msAnimationEnd oAnimationEnd animationend', function(e) {
    return $(this).parent().addClass('animate-step1');
  });

  $("#members").delegate('.member-meta2', 'webkitAnimationEnd mozAnimationEnd msAnimationEnd oAnimationEnd animationend', function(e) {
    return $(this).parent().addClass('animate-step2');
  });

}).call(this);
