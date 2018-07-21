function validateAndGenerateSudokuGrid() {
    const regex = /^[1-9]$|^$/;
    let isValid = true;
    let sudokuGrid = "";
    $('tr').each(function() {
        let tr = $(this);
        tr.find("input").each(function() {
            console.log($(this));
            if (!regex.test($(this).val()))  {
                $(this).addClass('error');
                isValid = false;
                sudokuGrid += '_';
            }
            else {
                $(this).removeClass('error');
                sudokuGrid += $(this).val() === '' ? '_' : $(this).val();
            }
            sudokuGrid += ',';
        })
        sudokuGrid = sudokuGrid.slice(0, -1) + '\n';
    });

    return isValid ? sudokuGrid : undefined;
}

function sendAjax() {
    console.log("J'ai envoyé la grille !");
}

$(document).ready(function() {
        $('#submit').click(function() {
            let sudokuGrid = validateAndGenerateSudokuGrid();

            console.log(sudokuGrid);

            if (undefined !== sudokuGrid)
                sendAjax();
        })
    }
);
