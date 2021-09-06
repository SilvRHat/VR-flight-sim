// Focus script (for when you need to focus)
// Gavin Zimmerman

// DEPENDENCIES
    // jQuery


// updateVisuals - Will update which element is selected and focused on
function updateVisuals() {
    let n = VarGet('L:_ui_options','number')

    for (let i=0; i<=n; i++) {
        if (VarGet('L:_ui_toggle'.concat(i.toString()), 'number')>0) {
            $('#interactive'.concat(i.toString())).addClass('_selected');
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
