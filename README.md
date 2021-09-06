# VR Flight Sim
Updated: September 6th, 2021

## About
This is a testbed for a research project conducted by SHINE Lab and Aptima. This repo is (currently) open-sourced, available to anyone to study for development or use in their own research attempts. The testbed features a series of 'game-like' levels where a user is asked to fly through series of gates in order to advance to the next level. Between each, there are surveys evaluating the participant's symptoms of sim-sickness as well as percieved cognitive-load.<br>
The application features:
- Intro - an introduction level to give the participant in-game context of the 'game'
- Level 1 (Straight) - 6 gates where the participant is challenged to fly in a straight-like path
- Level 2 (Minor turns) - 6 gates where minor turns between each are involved
- Level 3 (180s) - 6 gates where large directional changes are required
- Level 4 (Loops) - 6 Gates with audio-prompted loops
- Level 5 (Barrel Rolls) - 6 gates with audio-prompted Barrel rolling maneuvers
- Level 6 (Gaze Switches) - 6 gates with audio-prompts to switch gaze to near/far sight


## Files
This section briefly summarizes the contents of this repository
- inputs - External script components run in FSUIPC that are necessary to interact with the UI
    - focusNextUI.lua - Focuses on next UI element
    - focusPrevUI.lua - Focuses on previous UI element
    - selectUI.lua - Selects the current UI element
- TOME_Testbed - A directory that is placed under 'Documents/Prepar3D Files/', which packages the entire testbed together
    - datastore - Directory for data saving
    - src
        - html - HTML resource Directory
        - img - HTML IMG resource directory
        - scripts - Backend (lua) and frontend scripts (js)
            - data-utils.lua - functions for saving data locally
            - events.lua - functions that are called from prepar3D at certain events
        - sims - Simulation resource directory (All built simulations besides the load screen are in here)
    - CONFIG.lua - The configuration file that affects how data is stored
- P3D_PROJECT_PATH.txt - An optional file that can be placed under 'Lockheed Martin/ Prepar3D v5/', which points to the testbed path (above directory)


## Setup
To setup the following testbed, ensure the following:
1. Download entire repo and place directories in appropriate places on host machine
    - **TOME_Testbed** should be placed under **Documents/Prepar3D v5 Files/** (aim to keep directory name the same, changing it requires using P3D_PROJECT_PATH)
    - All scripts/ files in **inputs** should be placed under **Documents/Prepar3D v5 Add-ons/FSUIPC6/** (or equivalent fsuipc6 addon directory)
    - **P3D_PROJECT_PATH.txt** should be placed under **/Programs/Lockheed Martin/Prepar3D v5/** (or equivalent for prepar3d v5 source code)
2. Open prepar3D to default scenario, and open Add-ons -> FSUIPC6. A window (rough graphics) should appear with 10ish tabs. Under 'Buttons & switches', set the customized inputs by:
    1. Press intended button
    2. Under the first scroll, find Lua &gt;script name for control&lt;. Select it.
3. Load the loadout simulation from the main Prepar3D menu (if it does not appear, then the TOME_Testbed was not placed in the right directory)
4. If a UI menu does not load then, inside **P3D_PROJECT_PATH.txt**, write the absolute file path of the directory originally named **TOME_Testbed** on its own line. If it still does not load, contact me, the developer


## Settings / Configurations
Any implemented settings can be found under **TOME_Testbed/CONFIG.lua**. These configurations mostly deal with how data is saved.


## Dependencies
This testbed requires various software/ packages to run:
- Prepar3D v5: Platform testbed application is run on and powered by
    - https://www.prepar3d.com/purchased_downloads/
- FSUIPC6 [WITH LICENSE]: P3D add-on which extends user input to directly change the simulation state/ environment
    - https://secure.simmarket.com/john-dowson-fsuipc6-for-p3dv4-5.phtml
- T45C Boeing: Plane model used in the testbed application
    - https://flyawaysimulation.com/downloads/files/5638/fsx-boeing-bae-t-45c-goshawk/


## Developer Cautions
**CAUTION:** to Prepar3D Developers,<br>
I wanted to point out a few pitfalls in implementing the above concepts in Prepar3D. This is purely my documentation on my experience with Prepar3D v5.1, I may not be fully correct or these may change in future versions. This section is to only caution developers on previously tricky areas, so that small prototypes can be made before large design choices that may add on hours of work.
- Caching behaviour: When working with html content to be rendered in the 3D, prepar3D will cache this content even in SimDirector. This is not workflow wise- because to see changes on html rendered content, the entire application must be exited and restarted. Lua scripts do not cache behaviour
- Lua Scripting: Prepar3D allows lua scripts to run in its environment dynamically, however it in no way makes this developer friendly. The code editor is a non-sizeable 300x100px text editor, and does not have an in-house importing feature. I circumvented this by developing a custom require function to load in an external script, and run functions from that instead. Any editing after this code has been put into p3d, can be done on the external scripts. Useful for on event to call one function.
- Javascript powers: Allow marketed that javascript scripts rendered on html content has a VarSet() function, it doesn't. Javascript should only read state - having lua read user input and write to state while javascript displays its view of the simulation state is an effective design.

