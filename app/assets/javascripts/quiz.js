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
