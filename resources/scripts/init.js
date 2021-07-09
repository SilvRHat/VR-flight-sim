// Web Testing Functions
// For testing Prepar3d defined functions in web browsers
function IsVRActive_WEBTESTING() {
    return GetVar('vrenabled','no')=='true';
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

    $('body').trigger('Stepped', [runtime, step]);
    window.requestAnimationFrame(animFrameStep);

};

function main() {
    window.requestAnimationFrame(animFrameStep); 
}
$.when( $.ready ).then( main );
window['isPrepar3D'] = false;

