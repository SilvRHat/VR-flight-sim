// VR Visibility
// Gavin Zimmerman

// DEPENDENCIES
    // jQuery

// Allows elements to only be visible with/ off VR
// html classes are 'VROnly' and 'WindowOnly'
$.when( $.ready ).then(function () {
    if (!IsVRActive) return;
    $('body').on('Stepped', function (runtime, step) {
        let vronly = (IsVRActive() ? 'visible': 'hidden'); 
        let windowonly = (!IsVRActive() ? 'visible': 'hidden'); 

        $('.VROnly').css('visibility', vronly);
        $('.WindowOnly').css('visibility', windowonly);
        last=IsVRActive();
    });
});