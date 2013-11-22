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

  q = 0;

  var update_form;

  $("#start_button").click(function(){
    $.get('/quiz.json').done(function(data){
      quiz = data["quiz"];
      // $("#question_content").prepend(quiz[q]["question"]);
      update_form = JST["templates/questions"](quiz[q]);
      $("#question_content").html(update_form);
      $("#next").click(function(e){
        e.preventDefault();
        if (q < 70) {
          q++;
          update_form = JST["templates/questions"](quiz[q]);
          $("#question_content").html(update_form);
        }
      });
      });
    });
});
