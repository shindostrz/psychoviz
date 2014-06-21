window.Quiz =
  init: ->
    @q = 1
    @initListeners()
    @quizFlow()
    @finalResultsParams = {e: app.e, f: app.f, i: app.i, j: app.j, n: app.n, p: app.p, s: app.s, t: app.t}
    @startQuiz()

  updateModal: ->
    $("#question_content").html JST["templates/questions"](Quiz.quiz[@q - 1])

  startQuiz: ->
    $("#start_button").click  ->
      $.get("/quiz.json").done (data) ->
        Quiz.quiz = data["quiz"]
        Quiz.updateModal()

  nextQuestion: ->
    answer_a = $(".answer1").is(":checked")
    app.score @q, answer_a
    @q++
    @updateModal()

  quizFlow: ->
    $("#next").click =>
      if $(".answer1").is(":checked") is false and $(".answer2").is(":checked") is false
        alert "Please choose one answer"
      else
        if @q <= 70
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