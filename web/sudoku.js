function validateSudokuGrid() {
    const regex = /^[1-9]$/;
    let ret = true;
    $('input').each(function() {
        if (!regex.test($(this).val()))  {
            $(this).addClass('error');
            ret = false;
        }
        else $(this).removeClass('error');
    });

    return ret;
}

function sendAjax() {
    $.ajax('URL VERS LE SERVEUR', data : tableau, success : function() {

    });
}

$(document).ready(function() {
    $('#submit').click(function() {
        if (validateSudokuGrid())
            sendAjax();
    })
}
);
