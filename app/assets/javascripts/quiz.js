// $(document).ready(function(){
//     $('#start_button').on('click', function(event){
//         debugger
//         event.preventDefault();
//         $(".md-trigger").click();
//         $.ajax({
//             url: '/quiz',
//             method: 'GET'
//         }).done(function(data){
//             console.log(data);
//             var question = data;
//             var question1 = question[:q_num][1]
//               var update_form;
//               update_form = JST["templates/questions"](question1);
//               return $("#question_content").append(update_form);
//         });
//     });
// });

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

var update_form_again;

$("#next").click(function(e){
  if ($(".answer1").is(":checked") === false && $(".answer2").is(":checked") === false) {
      e.preventDefault();
      alert("Please choose one answer");
  } else {
      e.preventDefault();
      $(".md-close").click();
      $(".md-trigger").click();
      answer_a = $(".answer1").is(":checked");
      app.score(q, answer_a);
      q++;
      params = { e: app.e, f: app.f, i: app.i, j: app.j, n: app.n, p: app.p, s: app.s, t: app.t};
      if (q <= 70) {
        update_form_again = JST["templates/questions"](quiz[q-1]);
        $("#question_content").html(update_form_again);
      } else {
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