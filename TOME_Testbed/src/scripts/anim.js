/*
    Animation
    SHINE Lab & Aptima | Collaborative VR Flight Sim Research Project

    HTML Animation Loop
*/

// Dependencies
    // jQuery

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
