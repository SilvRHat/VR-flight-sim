window.onload = function() {
    // Start Button dynamic
    var startbutton = document.getElementById('startbutton');
    var startbuttonColorDefault = startbutton.style.backgroundColor
    startbutton.onmouseover = function() {
        startbutton.style.backgroundColor = "rgba(200,200,200)";
    };
    startbutton.onmouseout = function() {
        startbutton.style.backgroundColor = startbuttonColorDefault;
    };
    startbutton.onclick = function () {
        startbutton.innerHTML = VarGet("P:SIM PAUSED", "Bool");
        VarSet("P:SIM PAUSED", "false");
    };
};
