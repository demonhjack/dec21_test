$(document).ready(function(){
    $('#login_btn').click(function() {
        return false;
    });

    $('button').click(function() {
        event.preventDefault();
        $.ajax({
            method: "POST",
            url: "/auth",
            data: { req : $('form').serialize() }
        }).done(function(msg) {
            if (!msg || msg == 'failed') {
                $('#alert').addClass('d-flex');
                setTimeout(function() {
                    $('#alert').removeClass('d-flex');
                }, 3000);
            } else {
                ans = $.parseJSON(msg);
                if (ans.time == '') {
                    Cookies.set('remember', ans.data);
                } else {
                    Cookies.set('remember', ans.data, { expires: parseInt(ans.time)});
                }

                window.location.href = "list.html";
            }
        });
    });
});