local on_roshan_hook
local kill_time = 0
local hook

function SendRoshanPopup(kill_time)
  dota.SFHudOverlay.GetInstance():SendRoshanPopup(false, kill_time + 600)  
end

function OnRoshanKill()
  kill_time = dota.GameRules.GetInstance():GetGameTime()
  SendRoshanPopup(kill_time)
end

function OnPaint()
  if kill_time == 0 then
    return
  end
  local current_time = dota.GameRules.GetInstance():GetGameTime()
  local difference = math.floor(current_time - kill_time)
  
  if difference == 480 then
    SendRoshanPopup(kill_time)
    kill_time = kill_time - 1
  elseif difference == 570 then
    SendRoshanPopup(kill_time)
    kill_time = kill_time - 1
  elseif difference >= 600 then
    SendRoshanPopup(kill_time)
    kill_time = 0
  end
end

function Initialize()
  on_roshan_hook = dota.AddEventListener("dota_roshan_kill", OnRoshanKill)
  hook = dota.AddPaintHook(OnPaint)
end