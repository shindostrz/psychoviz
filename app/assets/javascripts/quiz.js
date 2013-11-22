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
