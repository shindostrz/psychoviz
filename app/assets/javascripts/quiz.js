$(function(){
  $("#next").click(function(){
    $(".md-close").click()
    setTimeout(function(){
      $(".md-trigger").click()
    }, 500)
  })
})