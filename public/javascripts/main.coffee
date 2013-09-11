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

members = $("#members")
# 個人資料
members.delegate '.member-meta1', 'webkitAnimationEnd mozAnimationEnd msAnimationEnd oAnimationEnd animationend', (e)->
  parent = $(@).parent()
  if parent.hasClass('animate-step4')
    parent.find('.member-meta2').css
      position: ''
      left: ''
      top: ''
    parent.removeClass('animate-step1 animate-step2 animate-step3 animate-step4')
  else
    parent.addClass('animate-step1')
members.delegate '.member-meta2', 'webkitAnimationEnd mozAnimationEnd msAnimationEnd oAnimationEnd animationend', (e)->
  parent = $(@).parent()
  if parent.hasClass('animate-step3')
    parent.addClass('animate-step4')
  else
    parent.addClass('animate-step2')
    $this = $(@)
    offset = $this.offset()
    console.dir offset
    $this.css
      position: 'absolute'
      left: offset.left
      top: offset.top - 140
      zIndex: 8
    $this.data 'offset', 
      left: offset.left
      top: offset.top - 140
members.delegate 'li[data-member]', 'mouseenter', (e)->
  $(@).data('hover', true)
members.delegate 'li[data-member]', 'mouseleave', (e)->
  $this = $(@)
  $this.data('hover', false)
  timeout = $this.data('timeout')
  if timeout?
    clearTimeout timeout
  $this.data 'timeout', setTimeout =>
    $this.addClass 'animate-step3' if $this.hasClass('animate-step2') and $this.data('hover') is false and !$this.find('.member-meta2').hasClass('active')
  , 3000
# 顯示個人資料
members.delegate '.member-meta2:not(.active)', 'click', (e)->
  # 資訊
  infobox = $("<div>")
    .addClass('infobox')
    .appendTo("body")
  # 動畫
  $this = $(@)
  scale = Math.ceil((window.outerWidth - 200) / 150)
  $this.addClass 'active'
  $this.css
    position: 'fixed'
    left: '46%'
    top: '50%'
    '-ms-transform': "scale(#{scale})"
    '-o-transform': "scale(#{scale})"
    '-moz-transform': "scale(#{scale})"
    '-webkit-transform': "scale(#{scale})"
    'transform': "scale(#{scale})"
    zIndex: 999
  members.data 'activeInfo', $this
members.delegate '.member-meta2.active', 'webkitTransitionEnd transitionend', (e)->
  $(@).addClass 'actived'
$("body").on 'click', (e)->
  activeInfo = members.data('activeInfo')
  if activeInfo? and activeInfo.hasClass('actived') and e.target is document.body
    offset = activeInfo.data 'offset'
    # 收回定位
    activeInfo.on 'webkitTransitionEnd transitionend', ->
      offset = activeInfo.data 'offset'
      activeInfo.css
        zIndex: ''
        position: 'absolute'
        left: offset.left
        top: offset.top
        '-ms-transform': ''
        '-o-transform': ''
        '-moz-transform': ''
        '-webkit-transform': ''
        'transform': ''
      activeInfo.removeClass 'active actived'
      activeInfo.off 'webkitTransitionEnd transitionend'
    # 準備定位
    activeInfo.css
      left: offset.left
      top: offset.top
      zIndex: 8
      position: 'fixed'
      '-ms-transform': 'scale(1)'
      '-o-transform': 'scale(1)'
      '-moz-transform': 'scale(1)'
      '-webkit-transform': 'scale(1)'
      'transform': 'scale(1)'
    members.removeData('activeInfo')