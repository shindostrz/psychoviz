window.Quiz =
  init: ->
    @previousUser()
    @q = 1
    @initListeners()
    @quizFlow()
    @startQuiz()

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
      @getFriends()

  updateModal: ->
    $("#question_content").html JST["templates/questions"](Quiz.quiz[@q - 1])

  startQuiz: ->
    $("#start_button").click  ->
      Score.init()
      Quiz.init()
      $.get("/quiz.json").done (data) ->
        Quiz.quiz = data["quiz"]
        Quiz.updateModal()

  quizFlow: ->
    $("#next").click =>
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

  getFriends: ->
    $("#find-friends").hide()
    $(".loading").show()
    $.get("/friends.json").done (data) ->
      $(".loading").hide()
      window.friends = data
      Quiz.scrollToAnchor 'results'
      $("#friends").html JST["templates/friends"]()
      $("#results").animate
        width: "608px",
        "margin-left": "0"
        1000
        ->
          $("#friends").slideDown()
      Quiz.compareFriend()

  compareFriend: ->
    $(".friend-link").click ()->
      # Highlight only the clicked friend link
      if $(this).css("color") is "rgb(26, 188, 156)" and Score.chartSettings.datasets.length == 2
        $(this).css("color", "#fff")
        Score.chartSettings.datasets.pop()
      else
        $(this).css 'color', 'rgb(26, 188, 156)'
        $(".friend-link:not(##{this.id})").css 'color', '#fff'
        clickedFriendScore = friends[this.id]["score"]
        Quiz.addFriendToChart(clickedFriendScore)

      Score.setChart(Score.chartSettings)

  addFriendToChart: (score)->
    if Score.chartSettings.datasets.length is 2 then Score.chartSettings.datasets.pop()
    Score.chartSettings.datasets.push({
     fillColor : "rgba(26, 188, 156,0.5)",
     strokeColor : "rgba(26, 188, 156,1)",
     pointColor : "rgba(26, 188, 156,1)",
     pointStrokeColor : "#fff",
     data : [score["e"], score["i"], score["s"], score["n"], score["t"], score["f"], score["j"], score["p"]]
    });

  # Moves the test to the end with the default answer selected
  devTest: ->
    for i in [0...69]
      if Math.random() > 0.5 then $(".answer1").click() else $(".answer2").click()
      $('#next').click()

$ ->
  Score.init()
  Quiz.init()