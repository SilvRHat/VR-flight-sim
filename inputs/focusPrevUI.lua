--[[
    Prev Focus Element
    SHINE Lab & Aptima | Collaborative VR Flight Sim Research Project

    This changes element focused on
]]

ipc.writeLvar('L:_ui_focus_id', (ipc.readLvar('L:_ui_focus_id') or -1) + 1)