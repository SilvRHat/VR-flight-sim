/*
    Focus
    SHINE Lab & Aptima | Collaborative VR Flight Sim Research Project

    Reads scenario state to determine which UI elements are selected and focused on
*/

// Dependencies
    // jQuery


// updateVisuals - Will update which element is selected and focused on
function updateVisuals() {
    let n = VarGet('L:_ui_options','number')

    for (let i=0; i<=n; i++) {
        if (VarGet('L:_ui_toggle'.concat(i.toString()), 'number')>0) {
            $('#interactive'.concat(i.toString())).addClass('_selected');
            for (let j=1; j<4; j++) {
                if (VarGet('L:_ui_toggle'.concat(i.toString()), 'number')==j) {
                    $('#interactive'.concat(i.toString())).addClass('_rating'.concat(j.toString()));
                }
                else {
                    $('#interactive'.concat(i.toString())).removeClass('_rating'.concat(j.toString()));
                }
            }
        }
        else {
            $('#interactive'.concat(i.toString())).removeClass('_selected');
        }

        if (VarGet('L:_ui_focuson','number') % (n) == i) {
            $('#interactive'.concat(i.toString())).addClass('_focus');
        }
        else {
            $('#interactive'.concat(i.toString())).removeClass('_focus');
        }
    }
}

// Initializer - Sets up functionality
function mainLoop() {
    $('body').on('Stepped', updateVisuals)
}
$.when( $.ready ).then( mainLoop );
