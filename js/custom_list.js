function getUrlParameter(sParam) {
    var sPageURL = window.location.search.substring(1),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
        }
    }
    return false;
};

$(document).ready(function(){
    if (Cookies.get('remember')) {
        $.ajax({
            method: "POST",
            url: "/auth",
            data: { req : 'cookie='+encodeURIComponent(Cookies.get('remember')) }
        }).done(function(msg) {
            if (!msg || msg == 'failed') {
                window.location.href = "login.html";
            }
        });
    } else {
        window.location.href = "login.html";
    }

    $('#logout_link').click(function() {
        $.ajax({
            method: "DELETE",
            url: "/auth"
        }).done(function(msg) {
            if (msg && msg != 'failed') {
                Cookies.remove('remember');
                window.location.href = "login.html";
            }
        });
        return false;
    });

    var page = getUrlParameter('page');
    if (page && parseInt(page)) {
        get_data = { page : page };
    } else {
        get_data = {};
    }

    $('#logout_link').click(function() {
        return false;
    });

    $('.page-link').click(function() {
        return false;
    });

    $('.page-link-next').click(function() {
        link = parseInt(page) + 1;
        if (parseInt(page)) {
            window.location.href = window.location.pathname+"?page="+link;
        } else {
            window.location.href = window.location.pathname+"?page=2";
        }
    });

    $('.page-link-prev').click(function() {
        link = parseInt(page) - 1;
        if (parseInt(page)) {
            window.location.href = window.location.pathname+"?page="+link;
        }
    });

    $.ajax({
        method: "GET",
        url: "/users",
        data: get_data,
        cache: false
    }).done(function(msg) {
        if (msg) {
            ans = $.parseJSON(msg);
            if ($.isArray(ans)) {
                $('#userlist tbody *').remove();
                $.each(ans, function (ind, el) {
                    $('#userlist tbody').append('<tr><td><i class="bi bi-check-circle-fill"></i></td><td><div class="user_login">'+el.login+'</div><div class="user_name">'+el.name+'</div></td><td><div><i class="bi bi-dash-lg"></i></div><div>'+el.group+'</div></td></tr>');
                });
            }
        }
    });

    $.ajax({
        method: "GET",
        url: "/count",
        cache: false
    }).done(function(msg) {
        if (msg) {
            ans = parseInt(msg);
            if (ans > 0) {
                $('.pagination .page-link-inner').remove();
                html = '';
                i = 1;
                while (ans > 0) {
                    if (i == 1) {
                        html += '<li class="page-item"><a class="page-link page-link-inner" href="'+window.location.pathname+'">'+i+'</a></li>';
                    } else {
                        html += '<li class="page-item"><a class="page-link page-link-inner" href="?page='+i+'">'+i+'</a></li>';
                    }
                    i++;
                    ans = parseInt(ans) - 5;
                }

                if (html != '') {
                    $('.pagination .page-item').eq(0).after(html);
                    if (!page || parseInt(page) == 1) {
                        $('.pagination .page-link').eq(0).hide();
                        $('.pagination .page-link-inner').eq(0).parent().addClass('active');
                    }

                    if (parseInt(page) == parseInt(i) - 1) {
                        $('.pagination .page-link').last().hide();
                    }

                    if (parseInt(page)) {
                        $('.pagination .page-link-inner').eq(parseInt(page) - 1).parent().addClass('active');
                    }
                }
            }
        }
    });
});