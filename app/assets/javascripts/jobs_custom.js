$(document).ready(function(){
    //range sliders
    $("#salary-range").slider({});
    $("#experience-range").slider({});
    $("#age-range").slider({});
    $("#checkbox-negotiate").click(function() {
        if(this.checked) {
            $("#salary-range").slider("disable");
        }
        else {
            $("#salary-range").slider("enable");
        }
    });

    // job location js
    var url = "/dashboard/job_locations?company_id=" + $('#job_company_id').val();

    $.ajax({
        dataType: "script",
        type: "GET",
        url: url
    });
    $('#job_company_id').change(function(){
        var url = "/dashboard/job_locations?company_id=" + $(this).val();

        $.ajax({
            dataType: "script",
            type: "GET",
            url: url
        });
    })

    $("#job_anywhere_place").hide();
    if($("#checkbox-anywhere").prop('checked')) {
        $(".job-location-selection").hide();
        $("#job_anywhere_place").show();
    }
    $("#checkbox-anywhere").click(function() {
        if(this.checked) {
            $(".job-location-selection").hide();
            $("#job_anywhere_place").show();
        }
        else {
            $(".job-location-selection").show();
            $("#job_anywhere_place").hide();
            $("#job_anywhere_place").val('');
        }
    });

    $('#apply-instructions-textarea').wysihtml5({
        html: true,
        stylesheets: []
    });
    var dt = new Date();
    $( "#job_deadline" ).datepicker({
        minDate: dt,
        maxDate: dt.getDate() + 40,
        dateFormat: "dd-mm-yy"
    });

    // skills token


    $('#job_job_skills_attributes').tokenInput('/dashboard/skills.json', { crossDomain: false });

})