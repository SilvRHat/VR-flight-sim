# VR Flight Sim
## About
The following project is a developed series of challenges designed for research purposes.
It showcases a series of levels with variously positioned gates to fly through on a Boeing T45C. This project focuses on interacting with the user through providing instructions and questionaires to assist in a user-responsive vector for data collection.

## Contents
- datastore - This directory is the default folder for saving data


## Setup
Unfortunately, the setup to run the testbed includes a variety of manual steps, which are outlined below:
- Place the project directory under Prepar3D Files (typically located in documents)
- Download the software FSCUIPC 6 (with license). This is responsible for handling user input, since prepar3D doesn't provide their own way of running lua scripts on user input.
    - Then under the FSUIPC 6 directory (defaultly placed in Documents), copy over the scripts found in the 'src/inputs' directory.
    - Finally, open prepar3d-> add ons -> FSUIPC, and under the 'buttons / switches' tab, map the scripts to appropriate joystick buttons. (These interact with selecting UI components and are outlined more in the contents section)
- Configure the file 'P3D_PROJECT_PATH.txt' to a list of pathnames to locate the project directory (seperated by new lines)
    - Place this under the application directory for prepar3d.
    - Lua scripts are run under the application directory, this allows prepar3d to easily locate script assets to import. Overall, importing scripts this way greatly improves workflow as prepar3D scripting interface is a 300x100 pixel text editor.