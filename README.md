# VR Flight Sim
## About
The following project is a developed series of challenges designed for research purposes.
It showcases a series of levels with variously positioned gates to fly through on a Boeing T45C. This project focuses on interacting with the user through providing instructions and questionaires to assist in a user-responsive vector for data collection.

## Project Structure
- resources - Directory contains various resources used in the scenarios
    - html - HTML Directory
    - scripts - Javascript & Lua Directory
- sims - Directory contains various scenario files representing levels


## PREPAR3D DEVELOPER CAUTIONS
HTML RENDERING ISSUES
- Rendering issue on initial load; for the first scenario, Prepar3D will fail loading HTML. Reseting the scenario or having a proxy scenario which loads another one is likely the best user fix.
    - Scaleform objects can also be an alternative.
- Prepar3D will cache resource files; thus when editing and saving the local file, changes do not register back to Prepar3D. I've found the best workflow to be testing the html functionality outside of SimDirector and quickly restarting/ loading a scenario with a camera pointed at the html file in testing.
- Web requests outside of prepar3d's domain are filtered. This is (as of written) undocumented behaviour - and the extent of filtering is unknown.
    - However, the image object exists with its original dimensions. Interestingly knowing aspect ratio - but nonetheless will not render. This could be a bug of its caching system mentioned above.

SCENARIO ISSUES
- SetPauseAction objects do NOT prevent other actions from executing, including other SetPauseActionObjects. 
    - Their documentation is misleading in this behavior "When paused, can only unpause system if given user input such as mouse click. Using timing won't work, system is paused and not simulating".
    - Delay actions use simulation running time; so the second senstence may be truthful. But script triggers register every frame still, so a lua script can use os.clock to resume after an arbitrary time.
- Where possible; avoid the visualization window. Its a node programming interface but the graphs are not user friendly.