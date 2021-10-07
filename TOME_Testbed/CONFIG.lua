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
    -- @param var_name - Name of variable in prepar3D
    -- @param var_units - The unit of variable in prepar3D
    -- @param short_name (optional) - A name to use in csv files
function P3D_Var.new(var_name, var_units, short_name)
    local self = setmetatable({}, P3D_Var)

    self.Label = short_name or var_name
    self.Name = var_name
    self.Units = var_units

    return self
end


-- MAIN CONFIGURABLE SETTINGS //
    -- [IMPORTANT] Relative paths are resolved relative to the parent directory of the 'src' directory!
local CONFIG = {
    -- DATA SAVING
    data_folder = 'datastore';                           -- Location of folder to write data files to; Resolved relatively or absolutely
    
    data_subfolder_name ='tome_run';            -- Name of directory under data folder or data to be named.
    data_filenames_prefix = '';                 -- Appends to start of every data filename (allows for convenient file iteration)
    
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
-- Array of objects:
    -- Value: A simple object made of the variable name, its units in prepar3d, and a name to call it in csv files

    -- Full list of sim vars available at: https://www.prepar3d.com/SDKv5/LearningCenter.php
CONFIG.SIMVARS = {
    P3D_Var.new('A:GROUND VELOCITY', 'Knots', 'ground_vel');
    P3D_Var.new('A:INCIDENCE ALPHA', 'Radians', 'angle_of_attack_rad');
    P3D_Var.new('A:INCIDENCE BETA', 'Radians', 'sideslip_angle_rad');
    P3D_Var.new('A:ROTATION VELOCITY BODY X', 'Radians per second', 'rot_vel_x');
    P3D_Var.new('A:ROTATION VELOCITY BODY Y', 'Radians per second', 'rot_vel_y');
    P3D_Var.new('A:ROTATION VELOCITY BODY Z', 'Radians per second', 'rot_vel_z');
    P3D_Var.new('A:G FORCE', 'GForce', 'g_force');
    P3D_Var.new('A:STALL WARNING', 'Bool', 'stall_warning');
    P3D_Var.new('A:ANGLE OF ATTACK INDICATOR', 'Radians', 'aoa_indicator');
    P3D_Var.new('A:STALL WARNING', 'Bool', 'stall_warning');
    P3D_Var.new('A:YOKE Y POSITION', 'Position', 'yoke_y');
    P3D_Var.new('A:YOKE X POSITION', 'Position', 'yoke_x');
}


return CONFIG