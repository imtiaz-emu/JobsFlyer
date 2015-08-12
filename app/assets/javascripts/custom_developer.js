$(document).ready(function(){
    $('.comment-body .delete-comment').tooltip();
    $('.comment-body .editing-comment').tooltip();
    $('#profile_city').tokenInput('/home/load_cities.json', {
        crossDomain: false,
        tokenLimit: 1,
        searchText: 'search city'
    });
})

function focus_text_field_on_edit(evnt){

}