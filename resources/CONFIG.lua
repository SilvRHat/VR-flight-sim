--[[
    Configuration file
    SHINE Lab & Aptima | Collaborative VR Flight Sim Research Project

    This configuration file contains a variety of settable options which affect how data is stored
]]

-- Main configuration settings
local CONFIG = {
    -- CURRENT DIRECTORY
    project_path = '';         -- Resource path (ABSOLUTE PATH)
    script_path = 'resources/scripts/';

    -- DATA SAVING
    data_folder = '../data_sink';                           -- Location of folder to write data files to; IMPORTANT (if set, path must end with '/' character)
    event_log_filename = 'event_data.csv';                  -- Name of file to store timestamped event logs (Tracks when gates are hit and when scenarios are loaded)
    simvar_log_filename = 'simulation_data.csv';            -- Name of file to store polled variables (position, speed, etc)
    survey_log_filename = 'survey_data.csv';                -- Name of file to store survey data
    seperator = ', ';                                       -- String seperating data

    -- DATA POLLING
    simvar_poll_rate = 1;       -- Poll simulation variables every x seconds
    poll_while_paused = false;  -- Poll if simulation is paused

    -- UI
    max_ui_options = 15;        -- How many selectable options can exist in a UI question
}



-- A list of simulation variables to poll
-- Array of objects:
    -- { Var name in prepar3d, Units of item, (optional) alias name to appear in .csv file}
CONFIG.SIMVARS = {
    {'A:GROUND VELOCITY', 'Knots'};
    {'A:TOTAL WORLD VELOCITY','Feet per second'};
    {'A:VELOCITY BODY Z','Feet per second'};
    {'A:VELOCITY BODY X','Feet per second'};
    {'A:VELOCITY BODY Y','Feet per second'};
    {'A:ACCELERATION BODY X','Feet per second squared'};
    {'A:ACCELERATION BODY Y','Feet per second squared'};
    {'A:ACCELERATION BODY Z','Feet per second squared'};
    {'A:ROTATION VELOCITY BODY X','Radians per second'};
    {'A:ROTATION VELOCITY BODY Y','Radians per second'};
    {'A:ROTATION VELOCITY BODY Z','Radians per second'};
}

return CONFIG