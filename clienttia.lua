local cJ = false
local IsPlayerUnjailed = false


--ESX base

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent("esx_jb_jailer:JailInStation")
AddEventHandler("esx_jb_jailer:JailInStation", function(Station, JailTime)
	jailing(Station, JailTime)
end)

function jailing(Station, JailTime)
	if cJ == true then
		return
	end
	local PlayerPed = GetPlayerPed(-1)
	if DoesEntityExist(PlayerPed) then
		
		Citizen.CreateThread(function()
			local spawnloccoords = {}
			SetJailClothes()
			spawnloccoords = SetPlayerSpawnLocationjail(Station)
			SetEntityCoords(PlayerPed, spawnloccoords.x,spawnloccoords.y, spawnloccoords.z )
			cJ = true
			IsPlayerUnjailed = false
			while JailTime > 0 and not IsPlayerUnjailed do
				local remainingjailseconds = JailTime/ 60
				local jailseconds =  math.floor(JailTime) % 60 
				local remainingjailminutes = remainingjailseconds / 60
				local jailminutes =  math.floor(remainingjailseconds) % 60
				local remainingjailhours = remainingjailminutes / 24
				local jailhours =  math.floor(remainingjailminutes) % 24
				local remainingjaildays = remainingjailhours / 365 
				local jaildays =  math.floor(remainingjailhours) % 365

				
				PlayerPed = GetPlayerPed(-1)
				RemoveAllPedWeapons(PlayerPed, true)
				SetEntityInvincible(PlayerPed, true)
				if IsPedInAnyVehicle(PlayerPed, false) then
					ClearPedTasksImmediately(PlayerPed)
				end
				if JailTime % 10 == 0 then
					if JailTime % 30 == 0 then
						TriggerEvent('chatMessage', 'SYSTEM', { 0, 0, 0 }, math.floor(jaildays).." päivää, "..math.floor(jailhours).." tuntia,"..math.floor(jailminutes).." minuuttia, "..math.floor(jailseconds).." sekuntia vapautumiseen.")
					end
				end
				Citizen.Wait(1000)
				local pL = GetEntityCoords(PlayerPed, true)
				local D = Vdist(spawnloccoords.x,spawnloccoords.y, spawnloccoords.z, pL['x'], pL['y'], pL['z'])
				if D > spawnloccoords.distance then -- distance#######################################################################################
					SetEntityCoords(PlayerPed, spawnloccoords.x,spawnloccoords.y, spawnloccoords.z)
				end
				JailTime = JailTime - 1.0
			end
			TriggerServerEvent('chatMessageEntered', "SYSTEM", { 0, 0, 0 }, GetPlayerName(PlayerId()) .." on vapautettu.")
			TriggerServerEvent('esx_jb_jailer:UnJailplayer2')
			local outsidecoords = {}
			outsidecoords = SetPlayerSpawnLocationoutsidejail(Station)
			SetEntityCoords(PlayerPed, outsidecoords.x,outsidecoords.y,outsidecoords.z )
			cJ = false
			SetEntityInvincible(PlayerPed, false)
			TriggerEvent('esx_society:getPlayerSkin')
		end)
	end
end

function SetPlayerSpawnLocationjail(location)
	if location == 'JailPoliceStation1' then
		return {x=459.55, y=-994.46, z=23.91, distance = 2}  --ETELÄ--

	elseif location == 'JailPoliceStation2' then
		return {x=458.41,y=-997.93,z=23.91, distance = 2} --ETELÄ--

	elseif location == 'JailPoliceStation3' then
		return {x=458.29,y=-1001.55,z=23.91, distance = 3} --ETELÄ--


	elseif location == 'FederalJail' then
		return {x=1737.06,y=2578.00,z=45.56, distance = 20}
	end
end

function SetPlayerSpawnLocationoutsidejail(location)
	if location == 'JailPoliceStation1' then
		return {x=432.95864868164,y=-981.41455078125,z=29.710334777832} --ETELÄ--

	elseif location == 'JailPoliceStation2' then 
		return {x=432.95864868164,y=-981.41455078125,z=29.710334777832} --ETELÄ--

	elseif location == 'JailPoliceStation3' then
		return {x=432.95864868164,y=-981.41455078125,z=29.710334777832} --ETELÄ--


	elseif location == 'FederalJail' then
		return {x = 1848.02, y = 2585.958, z = 45.672}
	end
end

RegisterNetEvent("esx_jb_jailer:UnJail")
AddEventHandler("esx_jb_jailer:UnJail", function()
	IsPlayerUnjailed = true
end)

local malevaate = {
	['tshirt_1'] = 15, ['tshirt_2'] = 0,
	['torso_1'] = 146, ['torso_2'] = 0,
	['decals_1'] = 0, ['decals_2'] = 0,
	['arms'] = 0,
	['pants_1'] = 3, ['pants_2'] = 7,
	['shoes_1'] = 12, ['shoes_2'] = 12,
	['chain_1'] = 50, ['chain_2'] = 0
}
local femalevaate = {
	['tshirt_1'] = 3, ['tshirt_2'] = 0,
	['torso_1'] = 38, ['torso_2'] = 3,
	['decals_1'] = 0, ['decals_2'] = 0,
	['arms'] = 2,
	['pants_1'] = 3, ['pants_2'] = 15,
	['shoes_1'] = 66, ['shoes_2'] = 5,
	['chain_1'] = 0, ['chain_2'] = 2
}

function SetJailClothes()
local playerPed = GetPlayerPed(-1)
  TriggerEvent('skinchanger:getSkin', function(skin)
     if skin.sex == 0 then
      if malevaate ~= nil then
        TriggerEvent('skinchanger:loadClothes', skin, malevaate)
      else
        ESX.ShowNotification('no_outfit')
      end
    else
      if femalevaate ~= nil then
        TriggerEvent('skinchanger:loadClothes', skin, femalevaate)
      else
        ESX.ShowNotification('no_outfit')
      end
    end
  end)
  Citizen.Wait(1000)
	TriggerEvent('skinchanger:getSkin', function(skin)
		TriggerServerEvent('esx_skin:save', skin)
	end)
end


