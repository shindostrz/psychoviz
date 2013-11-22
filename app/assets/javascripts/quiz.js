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

  $("#start_button").click(function(){
    $.get('/quiz.json').done(function(data){
      console.log(data)
    });
  })

  $("#next").click(function(){
    $(".md-close").click();
    setTimeout(function(){
      $(".md-trigger").click();
    }, 500);
  });

});
