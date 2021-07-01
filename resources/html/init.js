// Init Script
// Sets up environment; should be called from all html objects using prepar3D

// Gavin Zimmerman | SHINE lab


// Signal Class - abstracts signals
let signal = class {
    constructor() {
        this._connections = [];
    }

    Connect(func) {
        this._connections.push(func);
    }
    Disconnect(disfunc) {
        this._connections.forEach(function (funci, i, arr) {
            if (disfunc==funci) 
                this._connections.splice(i, 1);
        });
    }
    Fire() {
        this._connections.forEach(function (func, i, arr) {
            func(arguments);
        });
    }
    Destroy() {
        this._connections = [];
    }
}


// Web Testing Functions
// For testing Prepar3d defined functions in web browsers
function IsVRActive_WEBTESTING() {
    return true;
}
function IsSimPaused_WEBTESTING() {
    return true;
}
function SetVar_WEBTESTING(name, value) {
    window.vars[name] = value;
}
function GetVar_WEBTESTING(name, units) {
    return window.vars[name];
}
// Mapping: Function name to web-replica-function
WEBTEST_FUNCS = {
    'IsVRActive':IsVRActive_WEBTESTING,
    'IsSimPaused':IsSimPaused_WEBTESTING,
    'GetVar':GetVar_WEBTESTING,
    'SetVar':SetVar_WEBTESTING
}


// animFrameStep - Wrapper function for an animation loop
    // @param timestamp - Timestamp paramater passed into callback; in milliseconds
let firststep, laststep;
function animFrameStep(timestamp) {
    if (firststep === undefined) {
        firststep = timestamp;
        laststep = timestamp;
    }
    const runtime = (timestamp - firststep) * 1000; // In seconds
    const step = (timestamp - laststep) * 1000;
    laststep = timestamp;

    window.onStepped.Fire(runtime, step);
    window.requestAnimationFrame(animFrameStep);
};


// init - Main function which initializes environment
function init() {
    // Check if running in Prepar3D
    try {IsVRActive()}
    catch(error) {
        window['isPrepar3D'] = false;
        
        // Connext Web testing functionality
        window.vars={};
        for (prepar3d_func_name in WEBTEST_FUNCS){
            window[prepar3d_func_name] = WEBTEST_FUNCS[prepar3d_func_name]
        };
    }
    finally {
        window['isPrepar3D'] = true;
    };

    window.requestAnimationFrame(animFrameStep); 
    window.oninit.Fire();
}


// Main Setup Source
window['isPrepar3D'] = false;

window.onload = init;
window.oninit = new signal;     // Signal fires after environment initialized
window.onStepped = new signal;  // Signal fires every step on animation loop
