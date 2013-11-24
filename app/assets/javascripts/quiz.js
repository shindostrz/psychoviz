$(function(){
  function scrollToAnchor(anchor){
    var aTag = $("a[name='"+ anchor +"']");
    $('html,body').animate({scrollTop: aTag.offset().top},'slow');
  }

  q = 1;

  var update_form;

  $("#start_button").click(function(e){
    $.get('/quiz.json').done(function(data){
      quiz = data["quiz"];
      // index = (q-1);
      // $("#question_content").prepend(quiz[q]["question"]);
      update_form = JST["templates/questions"](quiz[q-1]);
      // console.log(index);
      $("#question_content").html(update_form);
    });
  });

$("#next").click(function(e){
  if ($(".answer1").is(":checked") === false && $(".answer2").is(":checked") === false) {
      e.preventDefault();
      alert("Please choose one answer");
  } else {
      e.preventDefault();
      $(".md-close").click();
      $(".md-trigger").click();
      answer_a = $("#answer_a").val();
      app.score(q, answer_a);
      q++;
      if (q <= 70) {
        update_form_again = JST["templates/questions"](quiz[q-1]);
        $("#question_content").html(update_form_again);
      } else {
        params = { e: app.e, f: app.f, i: app.i, j: app.j, n: app.n, p: app.p, s: app.s, t: app.t};
        $.post( "/scores", { data: params }).done(function(){
        $(".md-close").click();
        scrollToAnchor('results');
        results_display = JST["templates/results"]();
        $('#myChart').html(results_display);

        });
      }
    }
  });
});