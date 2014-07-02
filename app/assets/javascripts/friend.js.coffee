window.Friend =

  getFriends: ->
    $("#find-friends").hide()
    $(".loading").show()
    $.get("/friends.json").done (data) ->
      $(".loading").hide()
      window.friends = data
      $("#friends").html JST["templates/friends"]()
      Friend.formatLayout()
      Friend.compareFriend()

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
        Friend.addFriendToChart(clickedFriendScore)

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

  setCanvasSize: ->
    if ($(window).width() < 768)
      $("#myChart").attr(
        width: $(window).width(),
        height: $(window).width()
        )
      $("#results").removeClass("column_10 offset_1").css("margin-top", "10px");
      $("#results").parent().css("width", "100%");
    else
      $("#myChart").attr(
        width: "500px",
        height: "500px"
        )
  formatLayout: ->
    if $(window).width() >= 960
        Quiz.scrollToAnchor 'results'
        $("#results").animate
          width: "608px",
          "margin-left": "0"
          1000
          ->
            $("#friends").slideDown()
    else if (768 < $(window).width() < 960)
      Quiz.scrollToAnchor("results")
      $("#results").animate
        width: "500px",
        "margin": "0"
        600
        ->
          $("#friends").slideDown()
    else if ($(window).width() < 768)
      $("#results").removeClass("column_10 offset_1").css("margin-top", "10px")
      $("#results").parent().css("width", "100%")
      $("#friends").slideDown()