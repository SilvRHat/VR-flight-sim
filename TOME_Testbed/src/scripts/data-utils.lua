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
function require(filename)local user=os.getenv('USERNAME');local paths={'',string.format('C:\\Users\\%s\\Documents\\Prepar3D v5 Files\\TOME_Testbed\\',user)};local fileexts={'','.lua'};local PATHFILE_EXT='P3D_PROJECT_PATH.txt';local pathfile=io.open(PATHFILE_EXT);if pathfile then;for line in io.lines(PATHFILE_EXT) do table.insert(paths,line) end;pathfile:close();end;for _,path in ipairs(paths) do;for _,ext in ipairs(fileexts)do;local f=io.open(string.format("%s%s%s",path,filename,ext),'r');if f then;local src=f:read('*a');f:close();return load(src)(),path;end;end;end;end;
local CONFIG, srcpath = require('CONFIG.lua')



-- Library
local DATA_UTILS = {}


-- initVars - In prepar3D, lua scripts can read/write 'local' (Globally accesible) variables
    -- This function is called to initialize a set of variables used specifically for this application
function DATA_UTILS.initVars()
    if varget() then
        return end
    
    -- Set vars to default
end


-- setUIState - Sets variables describing the state of the user interface
    -- @param options - How many interactable elements there are on the UI
    -- @param multichoice - If the UI is multichoice
    -- @param focus - The element to focus on
function DATA_UTILS.setUIState(options, multichoice, focus)
    varset('L:_ui_multichoice', multichoice and '1' or '0')
    varset('L:_ui_options', tostring(options) or 1)
    varset('L:_ui_focuson', tostring((100*options) + (focus or 1) - 1))
end


-- clearToggles - Clears toggles describing if UI elements are selected or not
function DATA_UTILS.clearToggles()
    for i = 0, CONFIG.max_ui_options do
        varset(string.format('L:_ui_toggle%d', i), tostring(0)) end
    varset('L:_continue', '0')
end


-- saveTogglesTo - Saves the toggle values to a different set of variables
    -- @param var_prefix - Prefix of variable to save toggles to (_ui_toggle1 -> <var_prefix>1)
function DATA_UTILS.saveTogglesTo(var_prefix)
    for i = 0, CONFIG.max_ui_options - 1 do
        varset(
            string.format('L:%s%d', var_prefix, i), 
            tostring(varget(string.format('L:_ui_toggle%d', i), 'number'))
        ) 
    end
end


-- saveSurvey - Saves survey data to file
    --@param surveyID - The id number of the survey
function DATA_UTILS.saveSurvey(surveyId)
    local path = string.format('%s%s/%s%s', srcpath, CONFIG.data_folder, CONFIG.data_filenames_prefix, CONFIG.survey_log_filename)
    
    local f = io.open(path, 'r')
    if not f then  -- Test if file exists
        -- Create file
        f = io.open(path, 'a+')

        -- Write Data entries
        local datacolumns = {   -- In order
            'survey_id',
            'mental_demand',
            'general_discomfort',
            'fatigue', 
            'eyestrain',
            'difficulty_focusing',
            'headache',
            'fulness_of_head',
            'blurred_vision',
            'dizzy',
            'vertigo'
        }
        
        for i=1,CONFIG.max_gates do
            table.insert(datacolumns, string.format('hit_gate%d', i))
        end
        
        for i, col in ipairs(datacolumns) do
            f:write(string.format("%s%s", col, i<#datacolumns and CONFIG.seperator or ''))
        end f:write('\n')
    else
        f:close()
        f = io.open(path, 'a+')
    end
    
    -- Save data
    local data = {
        surveyId,
    }
    
    -- Save data from question 2
    local mental_demand = -1
    for i=0, CONFIG.max_ui_options do
        if varget(string.format('L:_surveyq2%d', i), 'number')==1 then
            mental_demand = i + 1
            break
        end
    end
    table.insert(data, mental_demand)
    
    -- Save data from question 1
    for i=0, 8 do
        table.insert(data, varget(string.format('L:_surveyq1%d', i), 'number') or -1)
    end
    
    -- Save data from gates
    for i=1, CONFIG.max_gates do
        table.insert(data, varget(string.format('L:_hitgate%d', i), 'number') or -1)
    end
    
    -- Save data
    for i, col in ipairs(data) do
        f:write(string.format("%s%s", col, i<#data and CONFIG.seperator or ''))
    end f:write('\n')
    f:close()
end


-- logEvent - Will timestamp an event
    -- @param event - Event message to timestamp on log file
function DATA_UTILS.logEvent(event)
    local path = string.format('%s%s/%s%s', srcpath, CONFIG.data_folder, CONFIG.data_filenames_prefix, CONFIG.event_log_filename)
    
    local f = io.open(path, 'r')
    if not f then  -- Test if file exists
        -- Create file
        f = io.open(path, 'a+')

        -- Write Data entries
        local datacolumns = {   -- In order
            'timestamp',
            'event',
        }
        
        for i, col in ipairs(datacolumns) do
            f:write(string.format("%s%s", col, i<#datacolumns and CONFIG.seperator or ''))
        end f:write('\n')
    else
        f:close()
        f = io.open(path, 'a+')
    end

    -- Construct data
    local data = {
        os.clock(),
        event
    }

    -- Save data
    for i, col in ipairs(data) do
        f:write(string.format("%s%s", col, i<#data and CONFIG.seperator or ''))
    end f:write('\n')
    f:close()
end


-- pollP3D - Polls prepar3D for a list of simulation variables
    -- List of variables is set in CONFIG file
function DATA_UTILS.pollP3D()
    -- Limit Polling
    if (not CONFIG.poll_while_paused) and (varget('P:SIM PAUSED','Bool')==1) then
        return end
    if (os.clock() - (tonumber(varget('L:_lastpollclock','number')) or 0))<CONFIG.simvar_poll_rate then
        return end
    varset('L:_lastpollclock', os.clock())
    
    local path = string.format('%s%s/%s%s', srcpath, CONFIG.data_folder, CONFIG.data_filenames_prefix, CONFIG.simvar_log_filename)
    
    local f = io.open(path, 'r')
    if not f then  -- Test if file exists
        -- Create file
        f = io.open(path, 'a+')

        -- Write Data entries
        local datacolumns = {
            'timestamp'
        }
        for _, var in ipairs(CONFIG.SIMVARS) do
            table.insert(datacolumns, var.Label or var.Name or 'untitled') end
        
        for i, col in ipairs(datacolumns) do
            f:write(string.format("%s%s", col, i<#datacolumns and CONFIG.seperator or ''))
        end f:write('\n')
    else
        f:close()
        f = io.open(path, 'a+')
    end


    -- Get Simvars
    local data = {
        os.clock()
    }
    for _, var in ipairs(CONFIG.SIMVARS) do
        table.insert(data, varget(var.Name or '', var.Units or '') or -1) end


    -- Save data
    for i, col in ipairs(data) do
        f:write(string.format("%s%s", col, i<#data and CONFIG.seperator or ''))
    end f:write('\n')
    f:close()
    
end


function DATA_UTILS.clearFiles()
    local filenames = {CONFIG.event_log_filename, CONFIG.simvar_log_filename, CONFIG.survey_log_filename}
    
end


return DATA_UTILS