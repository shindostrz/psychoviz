window.Quiz =
  init: ->
    window.q = 1
    @initListeners()
    @quizFlow()
    @finalResultsParams = {e: app.e, f: app.f, i: app.i, j: app.j, n: app.n, p: app.p, s: app.s, t: app.t}
    @startQuiz()

  updateModal: (questions)->
    question = JST["templates/questions"](window.quiz[window.q - 1])
    $("#question_content").html question

  startQuiz: =>
    $("#start_button").click  =>
      $.get("/quiz.json").done (data) ->
        window.quiz = data["quiz"]
        console.log quiz
        question = JST["templates/questions"](window.quiz[window.q - 1])
        $("#question_content").html question

  nextQuestion: =>
    $(".md-close").click()
    $(".md-trigger").click()
    answer_a = $(".answer1").is(":checked")
    app.score window.q, answer_a
    window.q++
    console.log window.q
    question = JST["templates/questions"](window.quiz[window.q - 1])
    $("#question_content").html question

  quizFlow: ->
    $("#next").click =>
      if $(".answer1").is(":checked") is false and $(".answer2").is(":checked") is false
        alert "Please choose one answer"
      else
        if window.q <= 70
          @nextQuestion()
        else
          @finishQuiz()

  scrollToAnchor: (anchor) ->
    aTag = $("a[name='" + anchor + "']")
    $("html,body").animate
      scrollTop: aTag.offset().top
    , "slow"

  finishQuiz: ->
    $.post("/scores",
      data: @finalResultsParams
    ).done ->
      $(".md-close").click()
      scrollToAnchor "results"
      results_display = JST["templates/results"]()
      $("#myChart").html results_display

  initListeners: ->
    # About button
    $('#about').click =>
      @scrollToAnchor 'about'

jQuery ->
  Quiz.init()
