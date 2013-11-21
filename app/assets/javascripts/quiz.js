$(document).ready(function(){
    $('#button').on('click', function(){
        $.ajax({
            url: '/quiz',
            method: 'GET'
        }).done(function(data){
            console.log(data);
        });
    });
});

$(function(){
  $("#next").click(function(){
    $(".md-close").click();
    setTimeout(function(){
      $(".md-trigger").click();
    }, 500);
  });
});
