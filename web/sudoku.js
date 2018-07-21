function validateAndGenerateSudokuGrid() {
    const regex = /^[1-9]$|^$/;
    let isValid = true;
    let sudokuGrid = "";
    $('tr').each(function() {
        let tr = $(this);
        tr.find("input").each(function() {
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

function update_grid(raw_grid) {
	grid = raw_grid.split(/,|\n/g);

	$('tr').each(function(i) {
        let tr = $(this);
        tr.find("input").each(function(j) {
		$(this).val(grid[i*9+j]);
        })
    });
}

function sendAjax(sudokuGrid) {
        $.ajax({url: 'http://irevoire.ovh:8888',
        type: 'POST', 
        data: "|" + sudokuGrid + "|",
        success: function(data) {
            res = JSON.parse(data);
		if(res.state == "KO")
			$("#answer").text("La grille n'est pas solvable").css("color", "red");
		else
		{
			$("#answer").text("Grille résolue").css("color", "green");
			update_grid(res.grid);
		}
        }
	})
}

$(document).ready(function() {
        $('#submit').click(function() {
            let sudokuGrid = validateAndGenerateSudokuGrid();

            if (undefined !== sudokuGrid)
                sendAjax(sudokuGrid);
        })
    }
);
