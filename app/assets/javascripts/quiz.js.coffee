window.Quiz =
  init: ->
    @previousUser()
    @q = 1
    @initListeners()
    @quizFlow()

  previousUser: ->
    if gon.personalityType?
      $('#previous-results').show()
      $('#previous-results').click (e) ->
        # This stops the chart from loading multiple times after taking the test againand clicking
        # previous-results again. Still don't know why it's calling Score.setChart twice though.
        e.stopImmediatePropagation()
        Score.init()
        Quiz.finishQuiz(gon.personalityType)

  initListeners: ->
    $('#about').click =>
      @scrollToAnchor 'about'
    $('#find-friends').click =>
      Friend.getFriends()
    $("#start_button").click =>
      unless Quiz.quiz?
        $.get("/quiz.json").done (data) ->
          Quiz.quiz = data["quiz"]
          Quiz.updateModal()

  updateModal: ->
    $("#question_content").html JST["templates/questions"](Quiz.quiz[@q - 1])

  quizFlow: ->
    $("#next").click (e)=>
      e.stopImmediatePropagation()
      if $(".answer1").is(":checked") is false and $(".answer2").is(":checked") is false
        alert "Please choose one answer"
      else
        answer_a = $(".answer1").is(":checked")
        Score.runningScore @q, answer_a
        if @q < 70
          @q++
        else
          finalScore = {e: Score.e*2, i: Score.i*2, s: Score.s, n: Score.n, t: Score.t, f: Score.f, j: Score.j, p: Score.p}
          personalityType = Score.personalityType(finalScore)
          @finishQuiz(personalityType)
          @postScores(finalScore, personalityType)
          Quiz.init()
        @updateModal()

  finishQuiz: (personalityType) ->
    $("#personality-type").html personalityType
    $(".md-close").click()
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
      if Math.random() > 0.5 then $(".answer1").click() else $(".answer2").click()
      $('#next').click()

$ ->
  Score.init()
  Quiz.init()
  Friend.calculateLayout()