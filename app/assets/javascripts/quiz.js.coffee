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
          @finishQuiz(app.e, app.i, app.s, app.n, app.t, app.f, app.j, app.p)

  finishQuiz: (e, i, s, n, t, f, j, p)->
    $(".md-close").click()
    [gon.e, gon.i, gon.s, gon.n, gon.t, gon.f, gon.j, gon.p] = [e*2, i*2, s, n, t, f, j, p]
    $.post("/scores",
      data: {e: e * 2, f: f, i: i * 2, j: j, n: n, p: p, s: s, t: t}
    ).done ->
      $(".md-close").click()
      Quiz.scrollToAnchor "results"
      $("#myChart").html JST["templates/results"]()

  scrollToAnchor: (anchor) ->
    aTag = $("a[name='" + anchor + "']")
    $("html,body").animate
      scrollTop: aTag.offset().top
    , "slow"

  initListeners: ->
    # About button
    $('#about').click =>
      @scrollToAnchor 'about'

jQuery ->
  Quiz.init()
