vRP = Proxy.getInterface("vRP")
vRPvehicleshopsv = Tunnel.getInterface("hugo_vehicleshop", "hugo_vehicleshop_inclient")
vRPvehicleshopclient = {}
Tunnel.bindInterface("hugo_vehicleshop_client", vRPvehicleshopclient)

local Categories, BoatCategories, Vehicles, Boats, NumberCharset, Charset, loaded = {}, {}, {}, {}, {}, {}, {}
loaded['car'], loaded['boat'], isVip = false, false, false
for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

RegisterNUICallback('buyvehicle', function(data, cb)
    local dataTable = data
	vRPvehicleshopsv.buyVehicle({dataTable.price}, function(hasEnoughMoney)
		if hasEnoughMoney then
			local newPlate = GeneratePlate()
			vRPvehicleshopsv.setVehicleOwner({newPlate, dataTable.vehicleType, dataTable.img, dataTable.name, dataTable.brand, dataTable.model}, function() end)
			vRP.mnotify({"Ai cumparat masina cu succes"})
		else
			vRP.mnotify({"Nu ai destui bani! Ai nevoie de: "..dataTable.price})
		end
	end)

end)

RegisterNUICallback('close', function()
	SetNuiFocus(false, false) 
end)

RegisterNetEvent('panama_autosalon:sendCategories')
AddEventHandler('panama_autosalon:sendCategories', function (categories)
	Categories = categories
end)

RegisterNetEvent('panama_autosalon:sendVehicles')
AddEventHandler('panama_autosalon:sendVehicles', function (vehicles)
	Vehicles = vehicles
end)


Citizen.CreateThread(function ()
	vRPvehicleshopsv.getVip({}, function(iss)
		isVip = iss
		print(isVip)
	end)
	Citizen.Wait(2000)
	print(isVip)
	print("=========================")
	vRPvehicleshopsv.getVehicles({}, function(vehicles)
		Vehicles = vehicles
		loaded['car'] = true
	end)

	vRPvehicleshopsv.getCategories({}, function(categories)
		Categories = categories
	end)

	vRPvehicleshopsv.getBoatCategories({}, function(categories)
		BoatCategories = categories
	end)

	vRPvehicleshopsv.getBoats({}, function(boats)
		Boats = boats
		loaded['boat'] = true
	end)
	Citizen.Wait(10000)
end)

RegisterNUICallback('testvehicle', function(data)
	vRPvehicleshopsv.checkTestSession({data.vehicleType, GetEntityCoords(PlayerPedId()), data.model}, function()end)
end)

RegisterNetEvent('panama_autosalon:spawnTestVehicle')
AddEventHandler('panama_autosalon:spawnTestVehicle', function(model, key, oldCoords)
	local hash = GetHashKey(model)
	RequestModel(hash)
		while not HasModelLoaded(hash) do
			Citizen.Wait(0)
		end
	vehicle = CreateVehicle(hash,-1733.25, -2901.43, 13.94,326,false,false) --60.962993621826
	SetModelAsNoLongerNeeded(hash)
	TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
	SetVehicleNumberPlateText(vehicle, "TESTDRIVE")
	vRPvehicleshopsv.startSession({key, vehicle, oldCoords}, function()end)
end)

RegisterNetEvent('panama_autosalon:setCoords', function(coords)
	SetEntityCoords(PlayerPedId(), coords, false, false, false, false)
end)

RegisterNetEvent('panama_autosalon:deleteVehicle')
AddEventHandler('panama_autosalon:deleteVehicle', function(vehicleId)
	DeleteVehicle(vehicleId)
end)

Citizen.CreateThread(function()
    for _, info in pairs(Config.Shops) do
      info.blip = AddBlipForCoord(info.entering)
      if _ == 'car' then
        SetBlipSprite(info.blip, 225)
      else
        SetBlipSprite(info.blip, 410)
      end
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.0)
      SetBlipColour(info.blip, 3)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.label)
      EndTextCommandSetBlipName(info.blip)
    end
end)

Citizen.CreateThread(function() 
	local showed = false;
	local key = nil;
	while true do 
		Citizen.Wait(0)
		letSleep = true
		if key == nil then 
			for k,v in pairs(Config.Shops) do
				local coords = GetEntityCoords(PlayerPedId())
				local distance = #(coords - v.entering)
				if distance <= 20.0 then
					letSleep = false
					DrawMarker(v.marker, v.entering, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0,0,120, 100, false, true, 2, true, false, false, false)
				end
				if distance <= 2.0 then
					key = k
				end
			end
		end
		if key then
			local coords = GetEntityCoords(PlayerPedId())
			local distance = #(coords - Config.Shops[key].entering)
			letSleep = true
			if distance <= 20.0 then
				letSleep = false
				DrawMarker(Config.Shops[key].marker, Config.Shops[key].entering, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0,0,120, 100, false, true, 2, true, false, false, false)
			end
			if distance <= 2.0 and not showed then
				showed = true
				vRP.mnotify({Config.Shops[key].hint})
			elseif distance > 2.0 and showed then
				TriggerEvent('panama_notifikacije:sendFloatingText')
				showed = false
				key = nil
			end
			if IsControlJustReleased(1,38) and showed then
				if key == 'car' then
					SendNUIMessage({action = 'show', vehicles = Vehicles, isLoaded = loaded['car'], vip = isVip, vehicleType = key})
					SetNuiFocus(true,true)
				elseif key == 'boat' then
					SendNUIMessage({action = 'show', vehicles = Boats, isLoaded = loaded['boat'], vip = isVip, vehicleType = key})
					SetNuiFocus(true,true)
				end
			end
		end
		if letSleep then
			Citizen.Wait(2000)
		end
	end
end)

--Resource Manifest------------------------------
AddEventHandler('onResourceStop', function()
	if (GetCurrentResourceName() ~= 'hg-showroom') then
	  return
	end
	SetNuiFocus(false, false)
end)

----------------------UTILIS-------------------------------
function GeneratePlate()
	local generatedPlate
	local doBreak = false
	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		generatedPlate = string.upper(GetRandomLetter(Config.PlateLetters) .. GetRandomNumber(Config.PlateNumbers))	
		vRPvehicleshopsv.isPlateTaken({generatedPlate}, function(isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end)

		if doBreak then
			break
		end
	end
	return generatedPlate
end

function IsPlateTaken(plate)
	local callback = 'waiting'
	vRPvehicleshopsv.isPlateTaken({plate}, function(isPlateTaken)
		callback = isPlateTaken
	end)

	while type(callback) == 'string' do
		Citizen.Wait(0)
	end

	return callback
end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end
