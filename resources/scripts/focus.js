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


// Initializer - Sets up functionality
function main() {
    initFocusObjects();
    document.body.addEventListener('click', Select, true); 
}
$.when( $.ready ).then( main );
