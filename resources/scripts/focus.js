// Focus script (for when you need to focus)
// Gavin Zimmerman

// DEPENDENCIES
    // jQuery


// Focusable objects can be declared using 'Interactive'


// initFocusObjects - Initializes objects with class 'Interactive'
    // When mouse hovers onto it, the object is given a focus class
    // When mouse leaves, the object loses the focus class
function initFocusObjects() {
    $(".Interactive").each(function (_) {
        $(this).on('mouseenter', function () {
            $("._focus").removeClass('_focus');
            $(this).addClass('_focus');
        });
        $(this).on('mouseleave', function () {
            $(this).removeClass('_focus');
        });
    });
}


// Select - For a focused object, it toggles a select option and then fires a signal prompting an item was selected.
function Select() {
    let selected = $("._focus");
    selected.toggleClass('_selected');
    if (selected.hasClass('_selected')) {
        selected.trigger('onSelection', []);
    } else {
        selected.trigger('onDeselection', []);
    }
};

// updateVisuals - Will update which element is selected and focused on
function updateVisuals() {
    let n = VarGet('L:_options','number')

    for (let i=0; i<=n; i++) {
        if (VarGet('L:_toggle'.concat(i.toString()), 'number')>0) {
            $('#interactive'.concat(i.toString())).addClass('_selected');
        }
        else {
            $('#interactive'.concat(i.toString())).removeClass('_selected');
        }

        if (VarGet('L:_ui_focus_id','number') % (n+1) == i) {
            $('#interactive'.concat(i.toString())).addClass('_focus');
        }
        else {
            $('#interactive'.concat(i.toString())).removeClass('_focus');
        }
    }
}

// Initializer - Sets up functionality
function main() {
    //initFocusObjects();
    //document.body.addEventListener('click', Select, true);
    $('body').on('Stepped', updateVisuals)
}
$.when( $.ready ).then( main );
