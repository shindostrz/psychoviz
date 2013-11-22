$(function(){

  $("#start_button").click(function(){
    $.get('/quiz.json').done(function(data){
      console.log(data);
    });
  });

  $("#end_button").click(function(){
    $.post( "/", { e: e, f: f, i: i, j: j, n: n, p: p, s: s, t: t } ).done(function(){
      $('#some_div').append('#chart_div');
      $(".md-close").click();
    });
  });

  $("#next").click(function(){
    $(".md-close").click();
    setTimeout(function(){
      $(".md-trigger").click();
    }, 500);
  });

});

