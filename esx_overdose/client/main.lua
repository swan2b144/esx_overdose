ESX                  = nil
local IsAlreadyHigh = false
local HighLevel     = -1

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

AddEventHandler('esx_status:loaded', function(status)
  TriggerEvent('esx_status:registerStatus', 'drug', 0, '#9ec617', 
    function(status)
      if status.val > 0 then
        return true
      else
        return false
      end
    end,
    function(status)
      status.remove(1500)
    end
  )

	Citizen.CreateThread(function()
		while true do
			Wait(1000)
			TriggerEvent('esx_status:getStatus', 'drug', function(status)
				if status.val > 0 then					
          local start = true
          if IsAlreadyHigh then
            start = false
          end
          local level = 0
          if status.val <= 999999 then
            level = 0
          else
            overdose()
          end

          if level ~= HighLevel then
          end

          IsAlreadyHigh = true
          HighLevel     = level
				end

				if status.val == 0 then
          if IsAlreadyHigh then
            Normal()
          end
          IsAlreadyHigh = false
          HighLevel     = -1
				end
			end)
		end
	end)
end)

function Normal()
  Citizen.CreateThread(function()
    local playerPed = GetPlayerPed(-1)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    SetPedIsDrug(playerPed, false)
    SetPedMotionBlur(playerPed, false)
  end)
end


function overdose()
  Citizen.CreateThread(function()
    local playerPed = GetPlayerPed(-1)
    SetEntityHealth(playerPed, 0)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(playerPed, 0)
    SetPedIsDrug(playerPed, false)
    SetPedMotionBlur(playerPed, false)
  end)
end

--Meth
RegisterNetEvent('esx_overdose:onMeth')
AddEventHandler('esx_overdose:onMeth', function()
  local playerPed = GetPlayerPed(-1)
  RequestAnimSet("move_m@hipster@a") 
  while not HasAnimSetLoaded("move_m@hipster@a") do
    Citizen.Wait(0)
  end    
  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
  Citizen.Wait(3000)
  ClearPedTasksImmediately(playerPed)
  SetTimecycleModifier("spectator5")
  SetPedMotionBlur(playerPed, true)
  SetPedMovementClipset(playerPed, "move_m@hipster@a", true)
  SetPedIsDrunk(playerPed, true)
  local player = PlayerId()
  SetRunSprintMultiplierForPlayer(player, 1.3)  
  Wait(300000)
  SetRunSprintMultiplierForPlayer(player, 1.0)		
end)

--Opium
RegisterNetEvent('esx_overdose:onOpium')
AddEventHandler('esx_overdose:onOpium', function()
  local playerPed = GetPlayerPed(-1)
  RequestAnimSet("move_m@drunk@moderatedrunk") 
  while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
    Citizen.Wait(0)
  end    
  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
  Citizen.Wait(3000)
  ClearPedTasksImmediately(playerPed)
  SetTimecycleModifier("spectator5")
  SetPedMotionBlur(playerPed, true)
  SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
  SetPedIsDrunk(playerPed, true)
  local player = PlayerId()
  SetRunSprintMultiplierForPlayer(player, 1.2)
  SetSwimMultiplierForPlayer(player, 1.3)
  Wait(520000)
  SetRunSprintMultiplierForPlayer(player, 1.0)
  SetSwimMultiplierForPlayer(player, 1.0)
end)

--weed
RegisterNetEvent('esx_overdose:onWeed')
AddEventHandler('esx_overdose:onWeed', function() 
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)
  RequestAnimSet("move_injured_generic") 
  while not HasAnimSetLoaded("move_injured_generic") do
    Citizen.Wait(0)
  end    
  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
  Citizen.Wait(3000)
  ClearPedTasksImmediately(playerPed)
  SetTimecycleModifier("spectator5")
  SetPedMotionBlur(playerPed, false)
  SetPedMovementClipset(playerPed, "move_injured_generic", false)
  SetPedIsDrunk(playerPed, false)
  local player = PlayerId()  
  local health = GetEntityHealth(playerPed)
  local newHealth = math.min(maxHealth , math.floor(health + maxHealth/8))
  SetEntityHealth(playerPed, newHealth)   
end)

--Coke
RegisterNetEvent('esx_overdose:onCoke')
AddEventHandler('esx_overdose:onCoke', function()
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)
  RequestAnimSet("move_m@hurry_butch@a") 
  while not HasAnimSetLoaded("move_m@hurry_butch@a") do
    Citizen.Wait(0)
  end    
  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
  Citizen.Wait(3000)
  ClearPedTasksImmediately(playerPed)
  SetTimecycleModifier("spectator5")
  SetPedMotionBlur(playerPed, true)
  SetPedMovementClipset(playerPed, "move_m@hurry_butch@a", true)
  SetPedIsDrunk(playerPed, true)
  local player = PlayerId()
  AddArmourToPed(playerPed, 100)
  local health = GetEntityHealth(playerPed)
  local newHealth = math.min(maxHealth , math.floor(health + maxHealth/6))
  SetEntityHealth(playerPed, newHealth)
end)

--Crack
RegisterNetEvent('esx_overdose:onCrack')
AddEventHandler('esx_overdose:onCrack', function()
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)
  RequestAnimSet("move_m@hurry_butch@a") 
  while not HasAnimSetLoaded("move_m@hurry_butch@a") do
    Citizen.Wait(0)
  end    
  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
  Citizen.Wait(3000)
  ClearPedTasksImmediately(playerPed)
  SetTimecycleModifier("spectator5")
  SetPedMotionBlur(playerPed, true)
  SetPedMovementClipset(playerPed, "move_m@hurry_butch@a", true)
  SetPedIsDrunk(playerPed, true)
  local player = PlayerId()
  AddArmourToPed(playerPed, 100)
  local health = GetEntityHealth(playerPed)
  local newHealth = math.min(maxHealth , math.floor(health + maxHealth/6))
  SetEntityHealth(playerPed, newHealth)
end)

--Heroine
RegisterNetEvent('esx_overdose:onHeroine')
AddEventHandler('esx_overdose:onHeroine', function()
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)
  RequestAnimSet("move_m@hurry_butch@a") 
  while not HasAnimSetLoaded("move_m@hurry_butch@a") do
    Citizen.Wait(0)
  end    
  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
  Citizen.Wait(3000)
  ClearPedTasksImmediately(playerPed)
  SetTimecycleModifier("spectator5")
  SetPedMotionBlur(playerPed, true)
  SetPedMovementClipset(playerPed, "move_m@hurry_butch@a", true)
  SetPedIsDrunk(playerPed, true)
  local player = PlayerId()
  SetPedSuffersCriticalHits(playerPed, true)
  local health = GetEntityHealth(playerPed)
  local newHealth = math.min(maxHealth , math.floor(health - maxHealth/6))
  SetEntityHealth(playerPed, newHealth)
end)

--Poppy
RegisterNetEvent('esx_overdose:onPoppy')
AddEventHandler('esx_overdose:onPoppy', function()
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)
  RequestAnimSet("move_m@hurry_butch@a") 
  while not HasAnimSetLoaded("move_m@hurry_butch@a") do
    Citizen.Wait(0)
  end    
  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
  Citizen.Wait(3000)
  ClearPedTasksImmediately(playerPed)
  SetTimecycleModifier("spectator5")
  SetPedMotionBlur(playerPed, true)
  SetPedMovementClipset(playerPed, "move_m@hurry_butch@a", true)
  SetPedIsDrunk(playerPed, true)
  local player = PlayerId()
  AddArmourToPed(playerPed, 100)
  local health = GetEntityHealth(playerPed)
  local newHealth = math.min(maxHealth , math.floor(health + maxHealth/6))
  SetEntityHealth(playerPed, newHealth)
end)

--Ephedrine
RegisterNetEvent('esx_overdose:onEphedrine')
AddEventHandler('esx_overdose:onEphedrine', function()
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)
  RequestAnimSet("move_m@hurry_butch@a") 
  while not HasAnimSetLoaded("move_m@hurry_butch@a") do
    Citizen.Wait(0)
  end    
  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
  Citizen.Wait(3000)
  ClearPedTasksImmediately(playerPed)
  SetTimecycleModifier("spectator5")
  SetPedMotionBlur(playerPed, true)
  SetPedMovementClipset(playerPed, "move_m@hurry_butch@a", true)
  SetPedIsDrunk(playerPed, true)
  local player = PlayerId()
  AddArmourToPed(playerPed, 100)
  local health = GetEntityHealth(playerPed)
  local newHealth = math.min(maxHealth , math.floor(health + maxHealth/6))
  SetEntityHealth(playerPed, newHealth)
end)

--Pcp
RegisterNetEvent('esx_overdose:onPcp')
AddEventHandler('esx_overdose:onPcp', function()
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)
  RequestAnimSet("move_m@hurry_butch@a") 
  while not HasAnimSetLoaded("move_m@hurry_butch@a") do
    Citizen.Wait(0)
  end    
  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
  Citizen.Wait(3000)
  ClearPedTasksImmediately(playerPed)
  SetTimecycleModifier("spectator5")
  SetPedMotionBlur(playerPed, true)
  SetPedMovementClipset(playerPed, "move_m@hurry_butch@a", true)
  SetPedIsDrunk(playerPed, true)
  local player = PlayerId()
  AddArmourToPed(playerPed, 100)
  local health = GetEntityHealth(playerPed)
  local newHealth = math.min(maxHealth , math.floor(health + maxHealth/6))
  SetEntityHealth(playerPed, newHealth)
end)

--Dabs
RegisterNetEvent('esx_overdose:onDabs')
AddEventHandler('esx_overdose:onDabs', function()
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)
  RequestAnimSet("move_m@hurry_butch@a") 
  while not HasAnimSetLoaded("move_m@hurry_butch@a") do
    Citizen.Wait(0)
  end    
  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
  Citizen.Wait(3000)
  ClearPedTasksImmediately(playerPed)
  SetTimecycleModifier("spectator5")
  SetPedMotionBlur(playerPed, true)
  SetPedMovementClipset(playerPed, "move_m@hurry_butch@a", true)
  SetPedIsDrunk(playerPed, true)
  local player = PlayerId()
  AddArmourToPed(playerPed, 100)
  local health = GetEntityHealth(playerPed)
  local newHealth = math.min(maxHealth , math.floor(health + maxHealth/6))
  SetEntityHealth(playerPed, newHealth)
end)

--Painkiller
RegisterNetEvent('esx_overdose:onPainkiller')
AddEventHandler('esx_overdose:onPainkiller', function()
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)
  RequestAnimSet("move_m@hurry_butch@a") 
  while not HasAnimSetLoaded("move_m@hurry_butch@a") do
    Citizen.Wait(0)
  end    
  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
  Citizen.Wait(3000)
  ClearPedTasksImmediately(playerPed)
  SetTimecycleModifier("spectator5")
  SetPedMotionBlur(playerPed, true)
  SetPedMovementClipset(playerPed, "move_m@hurry_butch@a", true)
  SetPedIsDrunk(playerPed, true)
  local player = PlayerId()
  AddArmourToPed(playerPed, 100)
  local health = GetEntityHealth(playerPed)
  local newHealth = math.min(maxHealth , math.floor(health + maxHealth/6))
  SetEntityHealth(playerPed, newHealth)
end)

--Narcan
RegisterNetEvent('esx_overdose:onNarcan')
AddEventHandler('esx_overdose:onNarcan', function()
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)
  RequestAnimSet("move_m@hurry_butch@a") 
  while not HasAnimSetLoaded("move_m@hurry_butch@a") do
    Citizen.Wait(0)
  end    
  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
  Citizen.Wait(3000)
  ClearPedTasksImmediately(playerPed)
  SetTimecycleModifier("spectator5")
  SetPedMotionBlur(playerPed, true)
  SetPedMovementClipset(playerPed, "move_m@hurry_butch@a", true)
  SetPedIsDrunk(playerPed, true)
  local player = PlayerId()
  AddArmourToPed(playerPed, 100)
  local health = GetEntityHealth(playerPed)
  local newHealth = math.min(maxHealth , math.floor(health + maxHealth/6))
  SetEntityHealth(playerPed, newHealth)
end)
