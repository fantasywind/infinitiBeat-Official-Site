class Beat
  constructor: ->
    logo = $("#logo")
    offset = logo.offset()
    @paper = Raphael offset.left + 133 , offset.top - 73, 225, 270
    @animating = false

    interval = setInterval =>
      if !@animating
        @donzDaz()
    , 12000

    setTimeout =>
      @donzDaz()
    , 1200

  donzDaz: ->
    @times = 4
    @animating = true
    @donz()

  donz: ->
    circle = @paper.circle 112, 109, 27
    circle.attr
      stroke: 'rgb(70, 169, 201)'
      fill: 'transparent'
      'stroke-width': 7
    circle.animate
      r: 65
      stroke: '#CCC'
      opacity: 0
    , 2800, 'ease-out'

    circle2 = @paper.circle 101, 177, 27
    circle2.attr
      stroke: 'rgb(70, 169, 201)'
      fill: 'transparent'
      'stroke-width': 7
    circle2.animate
      r: 65
      stroke: '#CCC'
      opacity: 0
    , 2800, 'ease-out'

    if @times
      @times -= 1
      setTimeout =>
        @donz()
      , 300 * (@times)
    else
      @animating = false

beat = new Beat

# 個人資料
$("#members").delegate '.member-meta1', 'webkitAnimationEnd mozAnimationEnd msAnimationEnd oAnimationEnd animationend', (e)->
  $(@).parent().addClass('animate-step1')
$("#members").delegate '.member-meta2', 'webkitAnimationEnd mozAnimationEnd msAnimationEnd oAnimationEnd animationend', (e)->
  $(@).parent().addClass('animate-step2')