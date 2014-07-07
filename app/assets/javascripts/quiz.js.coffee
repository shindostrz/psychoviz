window.Quiz =
  init: ->
    @previousUser()
    @q = 1
    @initListeners()
    @quizFlow()
    @mobile = if $(window).width() < 768 then true else false
    $("#message-form").hide()

  previousUser: ->
    if gon.personalityType?
      $('#previous-results').show()
      $('#previous-results').click (e) ->
        # This stops the chart from loading multiple times after taking the test againand clicking
        # previous-results again. Still don't know why it's calling Score.setChart twice though.
        e.stopImmediatePropagation()
        $(".friend-link").css("color", "#fff")
        Score.init()
        Quiz.finishQuiz(gon.personalityType)

  initListeners: ->
    $('#about').click =>
      @scrollToAnchor 'about'
    $('#find-friends').click =>
      Friend.getFriends()
    $("#start_button").click =>
        Quiz.quizFlow()
    $("#modal-1").on "click", "#begin", ->
      Quiz.updateModal()
    $("#post-to-facebook").click ->
      $("#message-form").slideToggle ->
        $("#message-form textarea").html Score.message
        $("#message-form textarea").focus()
    $("#message-form").submit (e)->
      e.preventDefault()
      hiddenCtx = document.getElementById("hiddenCanvas").getContext("2d");
      hiddenCanvas = new Chart(hiddenCtx).Radar(Score.chartSettings, {animation:false, onAnimationComplete: ->
        postCanvasToFacebook($("#message-form textarea").val())
        })
    $("#devs").click =>
      @scrollToAnchor 'devs'
    $("a[name=disclaimer]").click (e)->
      e.preventDefault()
      $("#disclaimer").slideToggle()
    $(window).resize =>
      @mobile = if $(window).width() < 768 then true else false


  updateModal: ->
    $("#question_content").html JST["templates/questions"]()

  quizFlow: ->
    $("#modal-1").on "click", ".answer", (e)=>
      e.stopImmediatePropagation()
      if e.target.id == "answer_a" then answer_a = true else answer_a = false
      Score.runningScore @q, answer_a
      if @q < 70
        @q++
      else
        $(".md-close").trigger("click")
        finalScore = {e: Score.e*2, i: Score.i*2, s: Score.s, n: Score.n, t: Score.t, f: Score.f, j: Score.j, p: Score.p}
        personalityType = Score.personalityType(finalScore)
        @finishQuiz(personalityType)
        @postScores(finalScore, personalityType)
      @updateModal()

  finishQuiz: (personalityType) ->
    $("#personality-type").html personalityType
    personality = {personality: personalityType}
    $("#personality-info").html JST["templates/personalityTypes"](personality)
    $("#personality-type").click (e) ->
      e.stopImmediatePropagation()
      $("#personality-info").slideToggle()
    Quiz.scrollToAnchor "results", ->
      $(".results").slideDown 800, ->
        # Prevents the chart insertion from making the callback repeat - might be
        # unnecessary if the chart logic is changed
        $(this).clearQueue()
        Score.init()
        Score.setChart(Score.chartSettings)

  postScores: (finalScore, personalityType) ->
    $.post("/scores",
      data: {e: finalScore.e, f: finalScore.f, i: finalScore.i, j: finalScore.j, n: finalScore.n, p: finalScore.p, s: finalScore.s, t: finalScore.t, personalityType: personalityType}
    )

  scrollToAnchor: (anchor, func) ->
    aTag = $("a[name='" + anchor + "']")
    $("html,body").animate
      scrollTop: aTag.offset().top
    , "slow", "swing", func

  # Moves the test to the end with the default answer selected
  devTest: ->
    for i in [0...70]
      if Math.random() > 0.5 then $("#answer_a").click() else $("#answer_b").click()

$ ->
  Score.init()
  Quiz.init()
  Friend.setCanvasSize()