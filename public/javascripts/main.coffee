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
  parent = $(@).parent()
  if parent.hasClass('animate-step4')
    parent.removeClass('animate-step1 animate-step2 animate-step3 animate-step4')
  else
    parent.addClass('animate-step1')
$("#members").delegate '.member-meta2', 'webkitAnimationEnd mozAnimationEnd msAnimationEnd oAnimationEnd animationend', (e)->
  parent = $(@).parent()
  if parent.hasClass('animate-step3')
    parent.addClass('animate-step4')
  else
    parent.addClass('animate-step2')
$("#members").delegate 'li[data-member]', 'mouseenter', (e)->
  $(@).data('hover', true)
$("#members").delegate 'li[data-member]', 'mouseleave', (e)->
  $this = $(@)
  $this.data('hover', false)
  timeout = $this.data('timeout')
  if timeout?
    clearTimeout timeout
  $this.data 'timeout', setTimeout =>
    $this.addClass 'animate-step3' if $this.hasClass('animate-step2') and $this.data('hover') is false
  , 3000