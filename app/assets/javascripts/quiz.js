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
      answer_b = $("#answer_b").val();
      app.score(q, answer_a);
      q++;
      if (q-1 < 70) {
        update_form_again = JST["templates/questions"](quiz[q-1]);
        $("#question_content").html(update_form_again);
      } else {
        $.post( "/scores", { e: app.e, f: app.f, i: app.i, j: app.j, n: app.n, p: app.p, s: app.s, t: app.t } ).done(function(){
        $('#some_div').append('#chart_div');
        $(".md-close").click();
        });
      }
    }
  });
});