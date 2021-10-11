--[[
    Events
    SHINE Lab & Aptima | Collaborative VR Flight Sim Research Project

    Tables of functions to be executed when certain 'events' occur
    This allows complex coding on scenario environment to be done outside of prepar3D Application
]]

function print(str)
    local out = io.open('output.txt', 'a+')
    out:write(string.format('%s\n',str))
    out:close()
end

-- Compatibility
    -- Prepar3D Funcs
    varget = varget or function(varname, _) return _G[varname] end
    varset = varset or function(varname, val) _G[varname]=val end

    -- Lua 5.1
    io = io or {}
    load = load or loadstring or {}


-- Dependencies
-- Minature Require
function require(filename)local user=os.getenv('USERNAME');local paths={'',string.format('C:\\Users\\%s\\Documents\\Prepar3D v5 Files\\TOME_Testbed\\',user)};local fileexts={'','.lua'};local PATHFILE_EXT='P3D_PROJECT_PATH.txt';local pathfile=io.open(PATHFILE_EXT);if pathfile then;for line in io.lines(PATHFILE_EXT) do table.insert(paths,line) end;pathfile:close();end;for _,path in ipairs(paths) do;for _,ext in ipairs(fileexts)do;local f=io.open(string.format("%s%s%s",path,filename,ext),'r');if f then;local src=f:read('*a');f:close();return load(src)(),path;end;end;end;end;
local CONFIG, srcpath = require('CONFIG.lua')


local DATA_UTILS = require('src\\scripts\\data-utils.lua')

-- Module
local EVENTS = {}




-- EVENT HANDLERS ---------------------------------------------------------------
-- Loadout Scenario events
-- loadout_init - Fires when the testbed application is started from the loadout scenario
function EVENTS.loadout_init()
    --DATA_UTILS.logEvent(string.format('Level: Loadout; Testbed application loaded'))
    DATA_UTILS.setUIState(3, true, 1)
    varset('L:_ui_toggle2', '1')        -- Set default to create new data folder
    return true
end

-- loadout_loadLvl - Sinks when the user selects the option to load from the beginning
function EVENTS.loadout_loadNew()
    local selected = varget('L:_ui_toggle0','number')==1
    if not selected then
        return false end

    -- Check if files should be cleared
    if varget('L:_ui_toggle2','number')==1 then
        DATA_UTILS.createDataDirectory()
    end
    DATA_UTILS.logEvent(string.format('Level: Loadout; User began game from beginning'))
    return true
end

-- loadout_loadLvl - Sinks when the user selects the option to load from a specific scenario
function EVENTS.loadout_loadLvl()
    local selected = varget('L:_ui_toggle1','number')==1
    if not selected then
        return false end

    -- Check if files should be cleared
    if varget('L:_ui_toggle2','number')==1 then
        DATA_UTILS.createDataDirectory()
    end

    DATA_UTILS.clearToggles()
    DATA_UTILS.setUIState(7, false, 1)
    DATA_UTILS.logEvent(string.format('Level: Loadout; User began game from specific level'))
    return true
end



-- Intro Scenario events
-- intro_init - Fires when intro level is loaded
function EVENTS.intro_init()
    DATA_UTILS.setUIState(1, true, 1)
    DATA_UTILS.clearToggles()
    DATA_UTILS.logEvent(string.format('Level: Intro; Loaded'))
    return true
end

-- intro_firstLvl - In intro level, Sinks when user clicks button to load first level
function EVENTS.intro_firstLvl()
    local selected = varget('L:_continue','number')==1
    if not selected then
        return false end

    return true
end




-- Level-based Scenario events
-- lvl_init - Fires when a level is loaded
function EVENTS.lvl_init(lvl)
    DATA_UTILS.setUIState(1, true, 1)
    DATA_UTILS.clearToggles()

    DATA_UTILS.logEvent(string.format('Level: %s; Loaded',lvl))
    return true
end

-- lvl_start - Sinks when a user clicks start after the level introduction
function EVENTS.lvl_start(lvl)
    local selected = varget('L:_continue','number')==1
    if not selected then
        return false end
    
    DATA_UTILS.logEvent(string.format('Level: %s; Started',lvl))
    DATA_UTILS.clearToggles()
    return true
end

-- lvl_gatePassed - Fires after a gate is passed (uses outer hit box)
function EVENTS.lvl_gatePassed(lvl, gate)
    DATA_UTILS.logEvent(string.format('Level: %s; %d gate passed',lvl, gate))
    return true
end

-- lvl_surveyQ1Answered - Sinks after survey q1 is answered
function EVENTS.lvl_surveyQ1Answered(lvl)
    local answered = varget('L:_continue','number')==1
    if not answered then
        return false end

    DATA_UTILS.saveTogglesTo('_surveyq1')
    return true
end

-- lvl_surveyQ2Answered - Passed after survey q2 is answered
function EVENTS.lvl_surveyQ2Answered(lvl)
    local answered = varget('L:_continue','number')==1
    if not answered then
        return false end

    DATA_UTILS.saveTogglesTo('_surveyq2')
    DATA_UTILS.saveSurvey(lvl)
    DATA_UTILS.logEvent(string.format('Level: %s; Survey saved',lvl))
    return true
end

-- lvl_gateHit - Fires when the inner gate hit box is hit
function EVENTS.lvl_gateHit(lvl, gate)
    varset(string.format('L:_hitgate%d', gate), '1')
end

-- lvl_surveyQ2 - Fires when survey q1 is displayed
function EVENTS.lvl_surveyQ1(lvl)
    DATA_UTILS.clearToggles()
    DATA_UTILS.setUIState(11, true, 1)
    DATA_UTILS.logEvent(string.format('Level: %s; Survey started',lvl))
end

-- lvl_surveyQ2 - Fires when survey q2 is displayed
function EVENTS.lvl_surveyQ2(lvl)
    DATA_UTILS.setUIState(11, false, 5)
    DATA_UTILS.clearToggles()
    --varset('L:_ui_toggle4', '1')
end

-- lvl_pollData - Invokes the function to poll P3D data, saving simvars specified in CONFIG
function EVENTS.lvl_pollData(lvl)
    DATA_UTILS.pollP3D{lvl=lvl}
    return false
end



-- Input Scenario events
-- lvl_OR_resetLvl - Passes after researcher uses override button to reset level
function EVENTS.lvl_OR_resetLvl(lvl)
    local flag = varget('L:_override_resetlvl', 'number')==1
    if not flag then
        return false end
    
    DATA_UTILS.logEvent(string.format('Level: %s; Researcher reset level',lvl))
    return true
end

-- lvl_OR_nextLvl - Passes after researcher uses override button to skip to next level
function EVENTS.lvl_OR_nextLvl(lvl)
    local flag = varget('L:_override_nextlvl', 'number')==1
    if not flag then
        return false end
    
    DATA_UTILS.logEvent(string.format('Level: %s; Researcher skipped to next level',lvl))
    return true
end

-- lvl_OR_promptSurvey - Passes after researcher uses override button to skip to survey
function EVENTS.lvl_OR_promptSurvey (lvl)
    local flag = varget('L:_override_survey', 'number')==1
    varset('L:_override_survey', '0')
    if not flag then
        return false end
    
    DATA_UTILS.logEvent(string.format('Level: %s; Researcher skipped to survey',lvl))
    return true
end

-- lvl_OR_promptSurvey - Passes after researcher uses override button to skip to survey
function EVENTS.lvl_OR_menuLvl (lvl)
    local flag = varget('L:_override_menu', 'number')==1
    if not flag then
        return false end
    
    DATA_UTILS.logEvent(string.format('Level: %s; Researcher jumped to menu',lvl))
    return true
end

return EVENTS


-- TEMPLATE Prepar3D Script Format
-- This format of scripts are used to call functions from these imported files, improving workflow to lua developers to script outside P3D.

--[[
!lua
local lvl='intro'
local gate=1
function require(filename)local user=os.getenv('USERNAME');local paths={'',string.format('C:\\Users\\%s\\Documents\\Prepar3D v5 Files\\TOME_Testbed\\',user)};local fileexts={'','.lua'};local PATHFILE_EXT='P3D_PROJECT_PATH.txt';local pathfile=io.open(PATHFILE_EXT);if pathfile then;for line in io.lines(PATHFILE_EXT) do table.insert(paths,line) end;pathfile:close();end;for _,path in ipairs(paths) do;for _,ext in ipairs(fileexts)do;local f=io.open(string.format("%s%s%s",path,filename,ext),'r');if f then;local src=f:read('*a');f:close();return load(src)(),path;end;end;end;end;local CONFIG, srcpath = require('CONFIG.lua')

local EVENTS=require('src\\scripts\\events')
return EVENTS.lvl_OR_menuLvl (lvl)
]]