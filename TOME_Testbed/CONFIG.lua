--[[
    Configuration file
    SHINE Lab & Aptima | Collaborative VR Flight Sim Research Project

    This configuration file contains a variety of settable options which affect how data is stored
]]


-- CUSTOM OBJECT TYPES //
-- Represents a prepar3d variable by name and units used
local P3D_Var = {} 
P3D_Var.__index = P3D_Var

-- Constructor
function P3D_Var.new(var_name, var_units, short_name)
    local self = setmetatable({}, P3D_Var)

    self.Label = short_name
    self.Name = var_name
    self.Units = var_units

    return self
end


-- MAIN CONFIGURABLE SETTINGS //
    -- [IMPORTANT] Relative paths are resolved relative to the parent directory of the 'src' directory!
local CONFIG = {
    -- DATA SAVING
    data_folder = 'datastore';                           -- Location of folder to write data files to; IMPORTANT (if set, path must end with '/' character)
    data_filenames_prefix = 'participant1_';                -- Appends to start of every data filename (allows for convenient file iteration)
    event_log_filename = 'event_data.csv';                  -- Name of file to store timestamped event logs (Tracks when gates are hit and when scenarios are loaded)
    simvar_log_filename = 'simulation_data.csv';            -- Name of file to store polled variables (position, speed, etc)
    survey_log_filename = 'survey_data.csv';                -- Name of file to store survey data
    
    seperator = ', ';                                   -- String seperating data
    max_gates = 6;                                      -- Number of gates to track if hit in data

    -- DATA POLLING
    simvar_poll_rate = 2;       -- Poll simulation variables every x seconds
    poll_while_paused = false;  -- Poll if simulation is paused

    -- UI
    max_ui_options = 15;        -- How many selectable options can exist in a UI question
}


-- A list of simulation variables to poll
-- Dictionary of objects:
    -- Key: Name of variable to log in file
    -- Value: A simple object made of the variable name and its units in prepar3d

    -- Full list of sim vars available at: https://www.prepar3d.com/SDKv5/LearningCenter.php
CONFIG.SIMVARS = {
    P3D_Var.new('A:GROUND VELOCITY', 'Knots', 'ground_vel');
    P3D_Var.new('A:TOTAL WORLD VELOCITY','Feet per second', 'total_world_vel');
    P3D_Var.new('A:VELOCITY BODY Z','Feet per second', 'body_vel_x');
    P3D_Var.new('A:VELOCITY BODY X','Feet per second', 'body_vel_y');
    P3D_Var.new('A:VELOCITY BODY Y','Feet per second', 'body_vel_z');
}


return CONFIG