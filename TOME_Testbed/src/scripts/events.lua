--[[
    Main
    SHINE Lab & Aptima | Collaborative VR Flight Sim Research Project

    Class which abstracts logic for data saving
]]


-- Compatibility
    -- Prepar3D Funcs
    varget = varget or function(varname, _) return _G[varname] end
    varset = varset or function(varname, val) _G[varname]=val end

    -- Lua 5.1
    io = io or {}
    load = load or loadstring or {}

-- Dependencies
-- Minature Require
function require(filename)local user=os.getenv('USERNAME');local paths={'',string.format('C:\\Users\\%s\\Documents\\Prepar3D v5 Files\\TOME_Testbed\\',user)};local fileexts={'','.lua'};local PATHFILE_EXT='P3D_PROJECT_PATH.txt';local pathfile=io.open(PATHFILE_EXT);if pathfile then;for line in io.lines(PATHFILE_EXT) do table.insert(paths,line) end;pathfile:close();end;for _,path in ipairs(paths) do;for _,ext in ipairs(fileexts)do;local f=io.open(string.format("%s%s%s",path,filename,ext),'r');if f then;local src=f:read('*a');f:close();return load(src)(),path;end;end;end;end;local CONFIG, srcpath = require('CONFIG.lua')
local DATA_UTILS = require('src\\scripts\\data-utils.lua')


local EVENTS = {}


-- Triggers
function EVENTS.loadout_init()
    -- Initialize variables

    DATA_UTILS.setUIState(3, true, 1)
    varset('L:_ui_toggle2', '1')
    return true
end

function EVENTS.loadout_loadNew()
    local selected = varget('L:_ui_toggle0','number')==1
    if not selected then
        return false end

    -- Check if files should be cleared
    if varget('L:_ui_toggle2','number')==1 then
        DATA_UTILS.clearFiles()
    end
    return true
end

function EVENTS.loadout_loadLvl()
    local selected = varget('L:_ui_toggle1','number')==1
    if not selected then
        return false end

    -- Check if files should be cleared
    if varget('L:_ui_toggle2','number')==1 then
        DATA_UTILS.clearFiles()
    end

    DATA_UTILS.clearToggles()
    DATA_UTILS.setUIState(7, false, 1)
    return true
end



function EVENTS.intro_init()
    DATA_UTILS.setUIState(1, true, 1)
    DATA_UTILS.clearToggles()
    return true
end

function EVENTS.intro_firstLvl()
    local selected = varget('L:_continue','number')==1
    if not selected then
        return false end

    return true
end



function EVENTS.lvl_init(lvl)
    DATA_UTILS.setUIState(1, true, 1)
    DATA_UTILS.clearToggles()


    return true
end

function EVENTS.lvl_start(lvl)
    local selected = varget('L:_continue','number')==1
    if not selected then
        return false end

    DATA_UTILS.clearToggles()
    return true
end


function EVENTS.lvl_gatePassed(lvl, gate)
    
    return true
end

function EVENTS.lvl_surveyQ1Answered(lvl)
    local answered = varget('L:_continue','number')==1
    if not answered then
        return false end

    DATA_UTILS.saveTogglesTo('_surveyq1')
    return true
end

function EVENTS.lvl_surveyQ2Answered(lvl)
    local answered = varget('L:_continue','number')==1
    if not answered then
        return false end

    DATA_UTILS.saveTogglesTo('_surveyq2')
    DATA_UTILS.saveSurvey(lvl)
    return true
end


-- Actions
function EVENTS.lvl_gateHit(lvl, gate)
    varset(string.format('L:_hitgate%d', gate), '1')
end

function EVENTS.lvl_surveyQ1(lvl)
    DATA_UTILS.clearToggles()
    DATA_UTILS.setUIState(11, true, 1)
end

function EVENTS.lvl_surveyQ2(lvl)
    DATA_UTILS.setUIState(11, false, 5)
    DATA_UTILS.clearToggles()
    varset('L:_ui_toggle4', '1')
end

function EVENTS.lvl_pollData(lvl)
    DATA_UTILS.pollP3D()
    return false
end

-- WORK AREA
--[[
!lua
local lvl='template'
function require(filename)local user=os.getenv('USERNAME');local paths={'',string.format('C:\\Users\\%s\\Documents\\Prepar3D v5 Files\\TOME_Testbed\\',user)};local fileexts={'','.lua'};local PATHFILE_EXT='P3D_PROJECT_PATH.txt';local pathfile=io.open(PATHFILE_EXT);if pathfile then;for line in io.lines(PATHFILE_EXT) do table.insert(paths,line) end;pathfile:close();end;for _,path in ipairs(paths) do;for _,ext in ipairs(fileexts)do;local f=io.open(string.format("%s%s%s",path,filename,ext),'r');if f then;local src=f:read('*a');f:close();return load(src)(),path;end;end;end;end;local CONFIG, srcpath = require('CONFIG.lua')

local EVENTS=require('src\\scripts\\events')
return EVENTS.lvl_pollData(lvl)
]]

return EVENTS
