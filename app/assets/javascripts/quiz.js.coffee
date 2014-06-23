window.Quiz =
  init: ->
    @q = 1
    @initListeners()
    @quizFlow()
    @startQuiz()

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
          @finishQuiz(app.e*2, app.i*2, app.s, app.n, app.t, app.f, app.j, app.p)

  finishQuiz: (e, i, s, n, t, f, j, p) ->
    personality_type = app.personality_type(e, i, s, n, t, f, j, p)
    $("#personality-type").html personality_type
    $(".md-close").click()
    Quiz.scrollToAnchor "results", ->
      $(".results").slideDown 400, ->
        $("#myChart").html JST["templates/results"]()
    $.post("/scores",
      data: {e: e, f: f, i: i, j: j, n: n, p: p, s: s, t: t, personality_type: personality_type}
    )

  scrollToAnchor: (anchor, func) ->
    aTag = $("a[name='" + anchor + "']")
    $("html,body").animate
      scrollTop: aTag.offset().top
    , "slow", "swing", func

  initListeners: ->
    $('#about').click =>
      @scrollToAnchor 'about'
    $('#find-friends').click =>
      @getFriends()

  getFriends: ->
    $("#find-friends").hide()
    $("#loading").show()
    $.get("/friends.json").done (data) ->
      $("#loading").hide()
      window.friends = data
      for friend, i in friends
        $("#friends").append "<a id='#{i}' href='#' class='friend-link' onclick='return false;''><img src='#{friend.image}'><div>#{friend.name} (#{friend.score.personality_type})</div></a>"
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
      $('#next').click()

jQuery ->
  Quiz.init()
