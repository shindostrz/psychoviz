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
      $('#previous-results').click ->
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
      $.get("/quiz.json").done (data) ->
        Quiz.quiz = data["quiz"]
        Quiz.updateModal()

  quizFlow: ->
    $("#next").click =>
      if $(".answer1").is(":checked") is false and $(".answer2").is(":checked") is false
        alert "Please choose one answer"
      else
        answer_a = $(".answer1").is(":checked")
        app.score @q, answer_a
        if @q < 70
          @q++
          @updateModal()
        else
          finalScore = {e: app.e*2, i: app.i*2, s: app.s, n: app.n, t: app.t, f: app.f, j: app.j, p: app.p}
          personalityType = app.personalityType(finalScore)
          @finishQuiz(personalityType)
          @postScores(finalScore, personalityType)

  finishQuiz: (personalityType) ->
    $("#personality-type").html personalityType
    $(".md-close").click()
    Quiz.scrollToAnchor "results", ->
      $(".results").slideDown 800, ->
        $("#myChart").html JST["templates/results"]()

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
    $("#loading").show()
    $.get("/friends.json").done (data) ->
      $("#loading").hide()
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
    $(".friend-link").click ->
      clickedFriendScore = friends[this.id]["score"]
      if data.datasets.length is 2 then data.datasets.pop()
      data.datasets.push({
       fillColor : "rgba(26, 188, 156,0.5)",
       strokeColor : "rgba(26, 188, 156,1)",
       pointColor : "rgba(26, 188, 156,1)",
       pointStrokeColor : "#fff",
       data : [clickedFriendScore["e"], clickedFriendScore["i"], clickedFriendScore["s"], clickedFriendScore["n"], clickedFriendScore["t"], clickedFriendScore["f"], clickedFriendScore["j"], clickedFriendScore["p"]]
      });
      myChart = new Chart(ctx).Radar(data);

  # Moves the test to the end with the default answer selected
  devTest: ->
    for i in [0...70]
      if Math.random() > 0.5 then $(".answer1").click() else $(".answer2").click()
      $('#next').click()

jQuery ->
  Quiz.init()
