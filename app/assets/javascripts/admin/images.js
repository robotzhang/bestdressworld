$(document).ready(function(){
    $('.images li').click(function(){
        var id = $(this).find('img').data('id');
        var count = $(this).parent('.images').find('li').length;
        var url = '/admin/images/'+id+'/edit.js?count='+count;
        util.modal(url);
    });
});