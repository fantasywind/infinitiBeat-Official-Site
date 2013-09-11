# 個人資料
profile =
  chaiyupai:
    name: '白家宇'
    title: '原始碼產生器'
    educational: [
      '國立臺北大學金融與合作經營學系 97'
      '台北市立南湖高中 97'
    ]
    experience: [
      'infinitiBeat 網頁前端工程師'
      'Shock! 三峽客 發行人暨數位媒體部長'
      'Shock! 三峽客官方網站、內部工作流程系統'
      'NTPUStar 官方宣傳網站、投票系統'
      #'styleinns 架構工程師、前端工程師'
      #'styletrip 專案經理、前端工程師'
    ]
  gs:
    name: '石展丞'
    title: '心靈混合魔法師'
    educational: [
      '國立臺北大學金融與合作經營學系 95' 
      '國立臺南第一高級中學 95'
    ]
    experience: [
      'infinitiBeat 行銷副總'
      'Shock! 三峽客 行銷總監'
      '臺北大學排球聯盟第一屆聯盟長'
      '2008 全國大專院校北部經濟相關科系體育聯賽 副總召'
      '世界流浪者競賽已完成全球24國走訪'
      '中國大陸、亞美利堅實習經驗、會展經驗'
      '國際獅子會300B2北大分會 第二副會長'
    ]
  eric:
    name: '白昌永'
    title: '增壓引擎肌肉男'
    educational: [
      '國立臺北大學資訊工程系 95'
      '台北市立明倫高中 95'
    ]
    experience: [
      'infinitiBeat 演算法工程師'
      '新竹縣政府縣長室資訊專員'
      '韋德汽車 總經理特別助理'
      #'styletrip 後端引擎、演算法設計師'
    ]
  blue:
    name: '藍鼎鈞'
    title: '設計概念聚合物'
    educational: [
      '大葉大學工業設計系輔休閒事業管理系 98'
      '國立台南第一高級中學 95'  
    ]
    experience: [
      'infinitiBeat 設計鏢局總舵主'
      '101年華語導遊、華語領隊合格'
      '飲料調製丙級技術士'
      '救國團探索教育中心執行訓練員'
      '台灣外展教育基金會訓練員實習生'
      'CREGATHERTIVE聚創 品牌設計總監'
    ]
  yswu:
    name: '吳昱昇'
    title: '國軍水電技師'
    educational: [
      '國立臺北大學資訊工程研究所 100'
      '國立臺北大學資訊工程系 96'
      '台北市立成功高中 96'
    ]
    experience: [
      'infinitiBeat 硬體系統工程師'
      'Surceilance System 保全監控系統'
      'NFC 裝置運用設計'
      '3D 校園導覽系統'
      '火災模擬起火點、撤退路線設計'
    ]
# Beat動畫
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

scale = Math.ceil((window.outerWidth - 200) / 150)
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
  $this = $(@)
  # 資訊
  member = $this.parents('li').data('member')
  content = _.template $("#infobox-tmpl").html(),
    name: profile[member].name
    title: profile[member].title
    educational: _.map(profile[member].educational, (text)->
      return "<p>#{text}</p>"
    ).join('')
    experience: _.map(profile[member].experience, (text)->
      return "<p>#{text}</p>"
    ).join('')
  infobox = $("<div>")
    .addClass('infobox')
    .html(content)
    .appendTo("body")
  # 動畫
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
  $(".infobox").addClass 'active'

trigger = false
  
$(window).on 'keyup', (e)->
  key = e.which || e.keyCode
  if key is 27
    trigger = true
    $("body").trigger 'click'

# 點擊最外
$("body").on 'click', (e)->
  activeInfo = members.data('activeInfo')
  if activeInfo? and activeInfo.hasClass('actived') 
    cc = members.data('circleCenter')
    if cc is undefined
      offset = $(".member-meta2.active").offset()
      cc = 
        x: offset.left + 150 * scale / 2
        y: offset.top + 150 * scale / 2
      members.data('circleCenter', cc)
    distance = Math.sqrt(Math.pow(e.clientX - cc.x, 2) + Math.pow(e.clientY - cc.y, 2))
    if distance > scale / 2 * 150 or trigger is true
      trigger = false
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
        $(".infobox").remove()
        activeInfo.off 'webkitTransitionEnd transitionend'
      # 準備定位
      $(".infobox").removeClass 'active'
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