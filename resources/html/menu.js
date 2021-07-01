// Menu Dynamics
// For interfacing with an html menu on Prepar3D

// Gavin Zimmerman | SHINE lab



// Runs every animation frame
function stepMenu(runtime, step) {
    // Set VR Indicator
    var vr_indicator = document.getElementById('vr_logo');
    if (vr_indicator)
        vr_indicator.style.visibility = IsVRActive() ? 'Visible' : 'Hidden';

};

function testJQuery() {
    let out = "Testing jquery on website<br>";
    let err=false;

    try {
        $.ajax({
        url: "https:silvrship.dev", 
        async: false,
        
        }).done(function (data) {
            if (data.search('Gavin Zimmerman')<0) {
                err=true;
                out=out.concat('&nbsp;[BAD] Unexpected response from webpage<br>');
            }
        }).fail(function () {
            err=true;
            out=out.concat('&nbsp;[BAD] Could not make web request<br>');
        }).always(function () {
            if (!err)
                out=out.concat('&nbsp;[YAY] No problems<br>');
        });
        out=out.concat('&nbsp;ran fine<br>');
    }
    catch (err){
        out=out.concat('&nbsp;err: ',err,'<br>');
    }
    finally {
        out=out.concat('&nbsp;complete<br>');
    }
    
    
    return out;
}


let tests = [testJQuery]
function runTests() {
    let outputObj = document.getElementById('output')
    tests.forEach(function (func) {
        let output = func()
        outputObj.innerHTML = outputObj.innerHTML.concat('<br>', output)
    })
}

let hover_cache = {}
function buttonFadeOnMouse(button) {
    button.onmouseenter = function () {
        hover_cache[button] = button.style.backgroundColor;
        button.style.backgroundColor = "rgb(150,150,150)";
    };
    button.onmouseleave = function () {
        button.style.backgroundColor = hover_cache[button];
    };
}

function startDemo() {
    document.getElementById('start_button').style.backgroundColor = "rgb(250,150,150)";
    VarSet('S:Continue', 'STRING', 'true')
}


// init - Intialization function that runs once after window has fully loaded
function initMenu() {
    // Connect Animation
    window.onStepped.Connect(stepMenu);

    // Make buttons do things
    let startbutton = document.getElementById('start_button');
    
    //VarSet('S:Continue', 'yielding')
    buttonFadeOnMouse(startbutton);
    startbutton.onclick = startDemo


    // run tests for prepar3d integration
    runTests();
};
window.oninit.Connect(initMenu);
