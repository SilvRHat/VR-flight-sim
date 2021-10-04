This is the default directory for local data saving on Prepar3D testbed application

## About Data Saving
Data saving functionality embedded in prepar3D applications are made possible through lua scripts.
Lua is run within the prepar3D process and allows developers to script complex behavior not possible using prepar3D's in-house node programming interface.

## About Lua Scripts
There are two types of lua scripts in this application: embedded and imported. Embedded scripts live inside the P3D scenario files - they are run at very specific events (when a gate is passed, level is loaded, etc.) These cannot live by good programming practices like the DRY principle - Prepar3D will just run code given to it for very specific instances. This inspires importable scripts, where instead of embedded scripts having functionality, these scripts import other lua scripts with useful functions. This allows for developers to develop with the DRY principle, since only one function per many events can exist in an importable script.

## About lastdatafolder
This file contains the name of the current directory used for writing data. It is a necessary component, since the data files are accessed at many points independent of when the directory is created. Simply checking for the right directory with the highest number appended name is insufficient for several reasons if directories or naming schemes were to change. Thus if the developer wants data saving to be performed on an old directory, they can edit the contents of the file to that name.

## Configuration
### Change Folder where data is saved
Go into the configuration file in the projet directory and change the variable named 'data_folder'. To resolve it to a different location, the path must be relative like: '../../../new_data_folder'. If the directory does not exist, the path will fail.

### Change subfolder naming convention
Go into the configuration file in the projet directory and change the variable named 'data_subfolder_name'. Please note that this is a single name which cannot contain the character '/'

### Change variables logged by prepar3D
Go into the configuration file in the projet directory and append/ remove contents in the CONFIG.SIMVARS table. This table acts as an array of simple class objects defined as 'P3D_Var', which takes 2 parameters and an optional 3rd parameter describing the variable to read from prepar3D.

### Change seperator for csv files
Go into the configuration file in the projet directory and change the variable named 'seperator'.