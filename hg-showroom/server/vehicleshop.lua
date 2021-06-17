local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vehicleshop")

vRPvehicleshop = {}
Tunnel.bindInterface("hugo_vehicleshop",vRPvehicleshop)
vRPvehicleshopcl = Tunnel.getInterface("hugo_vehicleshop_client", "hugo_vehicleshop_inclient")
local Categories, Vehicles, Panama, TestSession = {}, {}, {}, {}
local br = 0
TestSession['car'], TestSession['boat'] = 0, 0

function vRPvehicleshop.getVip()
    local user_id = vRP.getUserId({source})
    local ok 
	if vRP.hasPermission({user_id, "admin.E"}) then
        return true
	else
		return false
	end
end

function vRPvehicleshop.checkTestSession(key, currentCoords, model)
    local _source = source
    if TestSession[key] == 3 then
        TriggerClientEvent('panama_notifikacije:sendFloatingText', _source, 'Test Drive-ul a inceput deja, incercati mai tarziu!')
        Citizen.Wait(3000)
        TriggerClientEvent('panama_notifikacije:sendFloatingText', _source)
    else
        TriggerClientEvent('panama_autosalon:spawnTestVehicle', _source, model, key, currentCoords)
    end
end
function vRPvehicleshop.startSession(key, vehicleId, oldCoords)
    local _source = source
    local vehicle = vehicleId
    Citizen.CreateThread(function()
        vRPclient.mnotify(_source,{"Ai inceput test drive-ul! Ai la dispozitie 2 minute"})
        Citizen.Wait(30000)
        vRPclient.mnotify(_source,{"Mai ai la dispozitie 1:30 minute"})
        Citizen.Wait(30000)
        vRPclient.mnotify(_source,{"Mai ai la dispozitie 1 minut"})
        Citizen.Wait(30000)
        vRPclient.mnotify(_source,{"Mai ai la dispozitie 30 secunde"})
        Citizen.Wait(30000)
        vRPclient.mnotify(_source,{"Test drive-ul s-a terminat!"})
        TriggerClientEvent('panama_autosalon:deleteVehicle', -1, vehicleId)
        TriggerClientEvent('panama_autosalon:setCoords', _source, Config.Shops['car'].entering)
    end)
end


Citizen.CreateThread(function()
	local char = Config.PlateLetters
	char = char + Config.PlateNumbers
	if char > 8 then
		print(('panama_vehicleshop: ^1WARNING^7 plate character count reached, %s/8 characters.'):format(char))
	end
	
end)

Panama.Vozila = {
    {brand = "Classic", name = 'Avarus', model = 'avarus',price = 400000, category = 'motor', imgsrc = 'https://i.imgur.com/D8MKk7j.png', content = {'3.5', '180', '5'}},
    {brand = "Classic", name = 'Baller2', model = 'baller2',price = 300000, category = 'kupei', imgsrc = 'https://imgur.com/Ago6u3t.png', content = {'5.5', '190', '5'}},
    {brand = "Classic", name = 'Banshee', model = 'banshee',price = 250500, category = 'kupei', imgsrc = 'https://imgur.com/uUfPkAp.png', content = {'2.5', '300', '5'}},
    {brand = "Classic", name = 'Bestiagts', model = 'bestiagts',price = 370000, category = 'kupei', imgsrc = 'https://imgur.com/oG1EmAD.png', content = {'3.5', '250', '5'}},
    {brand = "Classic", name = 'Btype', model = 'btype',price = 1650000, category = 'kupei', imgsrc = 'https://imgur.com/ERnS84j.png', content = {'6.5', '150', '5'}}, 
    {brand = "Classic", name = 'Buffalo', model = 'buffalo',price = 150000, category = 'kupei', imgsrc = 'https://imgur.com/ofhqfmu.png', content = {'3.5', '220', '5'}},
    {brand = "Classic", name = 'Burrito3', model = 'burrito3',price = 500000, category = 'kupei', imgsrc = 'https://imgur.com/cGwRWxm.png', content = {'5.5', '180', '6'}},
    {brand = "Classic", name = 'Carbonizzare', model = 'carbonizzare',price = 550000, category = 'kupei', imgsrc = 'https://imgur.com/LSec6ON.png', content = {'3.5', '290', '6'}},
    {brand = "Classic", name = 'Carbonrs', model = 'carbonrs',price = 700000, category = 'motor', imgsrc = 'https://imgur.com/Pvm6Mku.png', content = {'4.5', '200', '6'}},
    {brand = "Classic", name = 'Cog55', model = 'cog55',price = 350000, category = 'kupei', imgsrc = 'https://imgur.com/LSec6ON.png', content = {'6.5', '200', '6'}},
    {brand = "Classic", name = 'Cognoscenti', model = 'cognoscenti',price = 400000, category = 'kupei', imgsrc = 'https://imgur.com/QyDkTR5.png', content = {'5.5', '250', '6'}},
    {brand = "Classic", name = 'Comet5', model = 'comet5',price = 650000, category = 'kupei', imgsrc = 'https://imgur.com/lshcJdD.png', content = {'2.8', '300', '5'}},
    {brand = "Classic", name = 'Dominator', model = 'dominator',price = 450000, category = 'kupei', imgsrc = 'https://imgur.com/0Tcb0fp.png', content = {'4.5', '250', '5'}},
    {brand = "Classic", name = 'Double', model = 'double',price = 700000, category = 'motor', imgsrc = 'https://imgur.com/J9mmyEA.png', content = {'3.5', '190', '5'}},
    {brand = "Classic", name = 'Drafter', model = 'drafter',price = 650000, category = 'kupei', imgsrc = 'https://imgur.com/pHcTysj.png', content = {'5.5', '200', '5'}},
    {brand = "Classic", name = 'F620', model = 'f620',price = 700000, category = 'kupei', imgsrc = 'https://imgur.com/XNEMMJi.png', content = {'5.5', '240', '5'}}, 
    {brand = "Classic", name = 'Faction3', model = 'faction3',price = 4500000, category = 'kupei', imgsrc = 'https://imgur.com/gkY3eA7.png', content = {'5.5', '250', '5'}},
    {brand = "Classic", name = 'Faggio2', model = 'faggio2',price = 7000, category = 'motor', imgsrc = 'https://imgur.com/VVmMl07.png', content = {'5.5', '150', '6'}},
    {brand = "Classic", name = 'Felon2', model = 'felon2',price = 400000, category = 'kupei', imgsrc = 'https://imgur.com/KJuHzoj.png', content = {'5.5', '200', '6'}},
    {brand = "Classic", name = 'Feltzer3', model = 'Feltzer3',price = 820000, category = 'kupei', imgsrc = 'https://imgur.com/6cbkucS.png', content = {'5.5', '200', '6'}},
    {brand = "Classic", name = 'Fmj', model = 'fmj',price = 4000000, category = 'kupei', imgsrc = 'https://imgur.com/NaKeakK.png', content = {'4.5', '250', '6'}},
    {brand = "Classic", name = 'Granger', model = 'granger',price = 320000, category = 'kupei', imgsrc = 'https://imgur.com/NZS1MMu.png', content = {'5.5', '200', '6'}},
    {brand = "Classic", name = 'Hotknife', model = 'hotknife',price = 1500000, category = 'kupei', imgsrc = 'https://imgur.com/vG8ERGh.png', content = {'4.5', '290', '6'}},
    {brand = "Classic", name = 'Huntley', model = 'huntley',price = 330000, category = 'kupei', imgsrc = 'https://imgur.com/RKndyjv.png', content = {'6.5', '190', '6'}},
    {brand = "Classic", name = 'Nightshade', model = 'nightshade',price = 390000, category = 'kupei', imgsrc = 'https://imgur.com/iCVEujJ.png', content = {'4.5', '290', '6'}},
    {brand = "Classic", name = 'Ninef', model = 'ninef',price = 750000, category = 'kupei', imgsrc = 'https://imgur.com/4FqoqIC.png', content = {'5.5', '200', '5'}},
    {brand = "Classic", name = 'Ninef2', model = 'ninef2',price = 800000, category = 'kupei', imgsrc = 'https://imgur.com/Pa3K8EE.png', content = {'5.5', '200', '5'}},
    {brand = "Classic", name = 'Reaper', model = 'reaper',price = 3500000, category = 'kupei', imgsrc = 'https://imgur.com/rFpQmYz.png', content = {'5.5', '200', '5'}},
    {brand = "Classic", name = 'Retinue', model = 'retinue',price = 190000, category = 'kupei', imgsrc = 'https://imgur.com/m5tMGUx.png', content = {'6.5', '250', '5'}},
    {brand = "Classic", name = 'Rhapsody', model = 'rhapsody',price = 220000, category = 'kupei', imgsrc = 'https://imgur.com/MoMZ7Vp.png', content = {'9.5', '150', '5'}},
    {brand = "Classic", name = 'Sabregt', model = 'sabregt',price = 365000, category = 'kupei', imgsrc = 'https://imgur.com/a9vfaBB.png', content = {'10.5', '170', '6'}},
    {brand = "Classic", name = 'Sentinel', model = 'sentinel',price = 398000, category = 'kupei', imgsrc = 'https://imgur.com/2UD9Bpj.png', content = {'8.5', '240', '6'}},
    {brand = "Classic", name = 'Sentinel2', model = 'sentinel2',price = 285000, category = 'kupei', imgsrc = 'https://imgur.com/S05Sins.png', content = {'8.5', '260', '6'}},
    {brand = "Classic", name = 'Sultan', model = 'sultan',price = 800000, category = 'kupei', imgsrc = 'https://imgur.com/nKWn3j4.png', content = {'8.5', '300', '6'}}, 
    {brand = "Classic", name = 'Superd', model = 'superd',price = 480000, category = 'kupei', imgsrc = 'https://imgur.com/OqoSZvB.png', content = {'8.5', '250', '6'}},
    {brand = "Classic", name = 'Toros', model = 'toros',price = 1400000, category = 'kupei', imgsrc = 'https://imgur.com/19IgV2L.png', content = {'5.5', '300', '6'}},
    {brand = "Classic", name = 'Turismor', model = 'turismor',price = 3500000, category = 'kupei', imgsrc = 'https://imgur.com/753zwkO.png', content = {'5.5', '250', '6'}},
    {brand = "Classic", name = 'Warrener', model = 'warrener',price = 220000, category = 'kupei', imgsrc = 'https://imgur.com/3CXxlfs.png', content = {'15.5', '190', '6'}},
    {brand = "Classic", name = 'Windsor', model = 'windsor',price = 450000, category = 'kupei', imgsrc = 'https://imgur.com/PQ9XA8U.png', content = {'8.5', '200', '6'}},
    {brand = "Classic", name = 'Windsor2', model = 'windsor2',price = 470000, category = 'kupei', imgsrc = 'https://imgur.com/oc50OKD.png', content = {'7.5', '200', '6'}},
    {brand = "Classic", name = 'Wolfsbane', model = 'wolfsbane',price = 390000, category = 'motor', imgsrc = 'https://imgur.com/7GH34MB.png', content = {'6.5', '250', '6'}},
    {brand = "Classic", name = 'Xls', model = 'xls',price = 360000, category = 'kupei', imgsrc = 'https://imgur.com/StbMHE5.png', content = {'7.5', '190', '6'}},
    {brand = "Classic", name = 'Zentorno', model = 'zentorno',price = 5000000, category = 'kupei', imgsrc = 'https://imgur.com/dhKQ3la.png', content = {'6.5', '250', '5'}},
    {brand = "Classic", name = 'Ztype', model = 'ztype',price = 1900000, category = 'kupei', imgsrc = 'https://imgur.com/e0rucMc.png', content = {'9.5', '195', '5'}},
    {brand = "Classic", name = 'Blazer', model = 'blazer',price = 350000, category = 'motor', imgsrc = 'https://imgur.com/D4u8URd.png', content = {'15.5', '195', '5'}},
    {brand = "Classic", name = 'Bifta', model = 'bifta',price = 550000, category = 'motor', imgsrc = 'https://imgur.com/3BtRZwb.png', content = {'13.5', '195', '5'}},
    {brand = "Classic", name = 'Trophytruck', model = 'trophytruck',price = 1900000, category = 'dzipovi', imgsrc = 'https://imgur.com/LbAAzKs.png', content = {'15.5', '195', '5'}},
}
--5.5 od 0 do 100
Panama.VipVozila = {
    {brand = "BMW", name = 'BMW M6', model = 'm6prior',price = 1500000, category = 'kupei', imgsrc = 'https://imgur.com/yABhsSw.png', content = {'2.5', '285', '6'}},
    {brand = "BMW", name = 'BMW M2', model = 'm2',price = 870000, category = 'kupei', imgsrc = 'https://imgur.com/U4bCTmI.png', content = {'3.0', '220', '6'}},
    {brand = "BMW", name = 'BMW M5', model = 'bmci',price = 1110000, category = 'kupei', imgsrc = 'https://imgur.com/NJt5si2.png', content = {'3.0', '245', '6'}},
    {brand = "BMW", name = 'BMW 745le', model = '745le',price = 1250000, category = 'kupei', imgsrc = 'https://imgur.com/Sw6u2I6.png', content = {'3.0', '250', '6'}},
    {brand = "BMW", name = 'BMW 17m760i', model = '17m760i',price = 800000, category = 'kupei', imgsrc = 'https://imgur.com/Osa06KU.png', content = {'3.0', '270', '6'}},
    {brand = "BMW", name = 'BMW S1000R', model = 'bmws',price = 1800000, category = 'motori', imgsrc = 'https://imgur.com/daN99zg.png', content = {'3.0', '280', '6'}},
    {brand = "BMW", name = 'BMW X6', model = 'rmodx6',price = 2000000, category = 'dzipovi', imgsrc = 'https://imgur.com/gvoNo1y.png', content = {'2.8', '280', '6'}},
    {brand = "BMW", name = 'BMW E36', model = 'e36a',price = 300000, category = 'kupei', imgsrc = 'https://imgur.com/Y94hLpc.png', content = {'3.0', '200', '6'}},
    {brand = "BMW", name = 'BMW E60', model = 'e60',price = 560000, category = 'kupei', imgsrc = 'https://imgur.com/9sPLxbl.png', content = {'3.5', '280', '6'}},
    {brand = "BMW", name = 'BMW i8', model = 'i8',price = 2000000, category = 'kupei', imgsrc = 'https://imgur.com/D3LECf0.png', content = {'3.0', '250', '6'}},
    {brand = "BMW", name = 'BMW E46', model = 'm3e46',price = 380000, category = 'kupei', imgsrc = 'https://imgur.com/wFtPbTO.png', content = {'2.5', '250', '6'}},
    {brand = "BMW", name = 'BMW F80', model = 'm3f80',price = 550000, category = 'kupei', imgsrc = 'https://imgur.com/1s09mBP.png', content = {'2.5', '290', '6'}},
    {brand = "BMW", name = 'BMW M8', model = 'bmwm8',price = 2150000, category = 'kupei', imgsrc = 'https://imgur.com/YtcccuX.png', content = {'3.5', '290', '6'}},
    {brand = "BMW", name = 'BMW X4', model = '18X4',price = 500000, category = 'dzipovi', imgsrc = 'https://imgur.com/S0uL3bm.png', content = {'11.5', '190', '6'}},
    {brand = "BMW", name = 'BMW M4GTS', model = 'rmodm4gts',price = 1100000, category = 'kupei', imgsrc = 'https://imgur.com/AHECksP.png', content = {'5.5', '300', '6'}},
    {brand = "Mercedes", name = 'Mercedes AMG GTR', model = 'amggtr',price = 900000, category = 'kupei', imgsrc = 'https://imgur.com/M0PUelX.png', content = {'5.5', '290', '6'}},
    {brand = "Mercedes", name = 'Mercedes CLS', model = 'cls2015',price = 1200000, category = 'kupei', imgsrc = 'https://imgur.com/JTkXCAh.png', content = {'5.5', '290', '6'}},
    {brand = "Mercedes", name = 'Mercedes E63 AMG', model = 'e63amg',price = 1800000, category = 'kupei', imgsrc = 'https://imgur.com/AjbuYI5.png', content = {'5.5', '290', '6'}},
    {brand = "Mercedes", name = 'Mercedes G65 AMG', model = 'g65amg',price = 1900000, category = 'dzipovi', imgsrc = 'https://imgur.com/byqfMZB.png', content = {'5.5', '300', '6'}},
    {brand = "Mercedes", name = 'Mercedes G770', model = 'g770',price = 2500000, category = 'dzipovi', imgsrc = 'https://imgur.com/VdRWG9H.png', content = {'5.5', '350', '6'}},
    {brand = "Mercedes", name = 'Mercedes GTS', model = 'amggts2016',price = 4000000, category = 'kupei', imgsrc = 'https://imgur.com/EQBHvP4.png', content = {'5.5', '310', '6'}},
    {brand = "Mercedes", name = 'Mercedes C63 AMG', model = 'mbc63',price = 1150000, category = 'kupei', imgsrc = 'https://imgur.com/q6ci7jS.png', content = {'5.5', '290', '6'}},
    {brand = "Mercedes", name = 'Mercedes S63 AMG', model = 'mers63c',price = 1200000, category = 'kupei', imgsrc = 'https://imgur.com/ZuweBZY.png', content = {'5.5', '300', '6'}},
    {brand = "Mercedes", name = 'Mercedes GT63 AMG', model = 'rmodgt63',price = 2400000, category = 'kupei', imgsrc = 'https://imgur.com/wnMGKlO.png', content = {'5.5', '290', '6'}},
    {brand = "Mercedes", name = 'Mercedes S63C217', model = 's63c217',price = 1500000, category = 'kupei', imgsrc = 'https://imgur.com/PYoMLVM.png', content = {'5.5', '290', '6'}},
    {brand = "Mercedes", name = 'Mercedes S600W220', model = 's600w220',price = 350000, category = 'kupei', imgsrc = 'https://imgur.com/EOMWBqS.png', content = {'5.5', '250', '6'},
	{brand = "Mercedes", name = 'Mercedes A45 AMG', model = 'a45amg',price = 450000, category = 'kupei', imgsrc = 'https://imgur.com/r3CLw3I.png', content = {'5.5', '290', '6'}},},
    {brand = "Mercedes", name = 'Mercedes SLK55', model = 'slk55',price = 1300000, category = 'kupei', imgsrc = 'https://imgur.com/uJi69JU.png', content = {'5.5', '300', '6'}},
    {brand = "Mercedes", name = 'Mercedes ML Brabus', model = 'MLBRABUS',price = 360000, category = 'dzipovi', imgsrc = 'https://imgur.com/0mcId6H.png', content = {'5.5', '200', '6'}},
    {brand = "Audi", name = 'Audi S3', model = '2015s3',price = 560000, category = 'kupei', imgsrc = 'https://imgur.com/v6RtzhB.png', content = {'5.5', '290', '6'}},
    {brand = "Audi", name = 'Audi RS7R', model = 'rs7r',price = 900000, category = 'kupei', imgsrc = 'https://imgur.com/r8P9oBv.png', content = {'5.5', '300', '6'}},
    {brand = "Audi", name = 'Audi A8 2007', model = 'a8audi',price = 850000, category = 'kupei', imgsrc = 'https://imgur.com/sxPayAK.png', content = {'5.5', '290', '6'}},
    {brand = "Audi", name = 'Audi A8 2017', model = 'a8fsi',price = 1200000, category = 'kupei', imgsrc = 'https://imgur.com/i4dBF5s.png', content = {'5.5', '300', '6'}},
    {brand = "Audi", name = 'Audi Q8 PRIOR', model = 'q8prior',price = 1580000, category = 'dzipovi', imgsrc = 'https://imgur.com/fiwTVDf.png', content = {'5.5', '300', '6'}},
    {brand = "Audi", name = 'Audi RS3', model = 'rs3',price = 700000, category = 'kupei', imgsrc = 'https://imgur.com/L1OgAZ6.png', content = {'5.5', '300', '6'}},
    {brand = "Audi", name = 'Audi RS4', model = 'rs4avant',price = 850000, category = 'kupei', imgsrc = 'https://imgur.com/Qh4BFpW.png', content = {'5.5', '300', '6'}},
    {brand = "Audi", name = 'Audi RS5', model = 'rs5',price = 1200000, category = 'kupei', imgsrc = 'https://imgur.com/jldkUxI.png', content = {'5.5', '300', '6'}},
    {brand = "Audi", name = 'Audi RS6', model = 'rs6',price = 1500000, category = 'kupei', imgsrc = 'https://imgur.com/Bb3Ayib.png', content = {'5.5', '300', '6'}},
    {brand = "Audi", name = 'Audi SQ7', model = 'SQ72016',price = 1200000, category = 'dzipovi', imgsrc = 'https://imgur.com/t9Grjzl.png', content = {'5.5', '280', '6'}},
    {brand = "Audi", name = 'Audi R8', model = 'R8v10',price = 3500000, category = 'sportski', imgsrc = 'https://imgur.com/KimH7ij.png', content = {'3.5', '290', '6'}},
    {brand = "Land Rover", name = 'Land Rover Autobiography', model = 'rrst',price = 1200000, category = 'dzipovi', imgsrc = 'https://imgur.com/jAEJKpC.png', content = {'3.5', '290', '6'}},
    {brand = "Lamborghini", name = 'Lamborghini Huracan', model = '18performante',price = 3800000, category = 'kupei', imgsrc = 'https://imgur.com/BTGsYzd.png', content = {'5.5', '350', '6'}},
    {brand = "Lamborghini", name = 'Lamborghini Urus', model = 'urus',price = 1500000, category = 'kupei', imgsrc = 'https://imgur.com/vllD4Gf.png', content = {'5.5', '300', '6'}},
    {brand = "Lamborghini", name = 'Lamborghini Sian', model = 'rmodsian',price = 3900000, category = 'kupei', imgsrc = 'https://imgur.com/Ssc5bgz.png', content = {'5.5', '350', '6'}},
    {brand = "Ferrari", name = 'Ferrari 488', model = '488',price = 5600000, category = 'sportski', imgsrc = 'https://imgur.com/reoe8L6.png', content = {'3.0', '260', '6'}}, 
    {brand = "Ferrari", name = 'Ferrari Pista', model = 'pista',price = 4200000, category = 'kupei', imgsrc = 'https://imgur.com/oXO8XhZ.png', content = {'3.5', '260', '6'}},
    {brand = "Porsche", name = 'Porsche 911S', model = '911turbos',price = 980000, category = 'sportski', imgsrc = 'https://imgur.com/DRJeaX7.png', content = {'4.0', '300', '6'}},
    {brand = "Porsche", name = 'Porsche GT2R', model = 'gt2rsmr',price = 900000, category = 'sportski', imgsrc = 'https://imgur.com/4A7JVgk.png', content = {'3.5', '280', '6'}},
    {brand = "Porsche", name = 'Porsche Panamera Mansory', model = 'pstmansory',price = 1200000, category = 'limuzine', imgsrc = 'https://imgur.com/Wli4n33.png', content = {'2.5', '300', '6'}},
    {brand = "Porsche", name = 'Porsche Panamera Turbo', model = 'panamera19turbo',price = 950000, category = 'limuzine', imgsrc = 'https://imgur.com/5FqHmm7.png', content = {'2.7', '280', '6'}},
    {brand = "Chevrolet", name = 'Dodge Charger', model = '69charger',price = 650000, category = 'oldtimer', imgsrc = 'https://imgur.com/uWKTM6r.png', content = {'3.4', '290', '6'}},
    {brand = "Chevrolet", name = 'Chevrolet Challenger', model = '16challenger',price = 560000, category = 'muscle', imgsrc = 'https://imgur.com/r6tTgiR.png', content = {'3.0', '300', '6'}},
    {brand = "Chevrolet", name = 'Chevrolet SS', model = '2020ss',price = 450000, category = 'muscle', imgsrc = 'https://imgur.com/RinhwDk.png', content = {'3.0', '250', '6'}}, 
    {brand = "Chevrolet", name = 'Chevrolet Camaro SS', model = 'camaro_ss',price = 500000, category = 'oldtimer', imgsrc = 'https://imgur.com/Mzj0DGP.png', content = {'7.5', '290', '5'}},
    {brand = "Chevrolet", name = 'Chevrolet G20C', model = 'g20c',price = 2000000, category = 'dzipovi', imgsrc = 'https://imgur.com/XnBUIUm.png', content = {'7.5', '200', '5'}},
    {brand = "Chevrolet", name = 'Chevrolet Z2879', model = 'z2879',price = 150000, category = 'muscle', imgsrc = 'https://imgur.com/HGGvqK2.png', content = {'10.5', '250', '6'}},
    {brand = "Nissan", name = 'Nissan 350Z', model = 'DK350Z',price = 800000, category = 'kupei', imgsrc = 'https://imgur.com/Lp3qb3w.png', content = {'3.5', '350', '6'}},
    {brand = "Nissan", name = 'Nissan 370Z', model = '370z',price = 560000, category = 'kupei', imgsrc = 'https://imgur.com/mBsILMS.png', content = {'3.9', '290', '6'}},   
    {brand = "Nissan", name = 'Nissan Titan', model = 'nissantitan17',price = 490000, category = 'dzipovi', imgsrc = 'https://imgur.com/3o9MFhR.png', content = {'6.5', '220', '6'}},
    {brand = "Nissan", name = 'Nissan Skyline', model = 'skyline',price = 350000, category = 'kupei', imgsrc = 'https://imgur.com/XHIeptP.png', content = {'4.5', '260', '6'}},
    {brand = "Nissan", name = 'Nissan GTR99', model = 'BNSGTR99',price = 360000, category = 'sportski', imgsrc = 'https://imgur.com/KTEEWwJ.png', content = {'4.5', '200', '6'}},
    {brand = "Volkswagen", name = 'Volkswagen Golf 7r', model = 'golf7gti',price = 880000, category = 'hedzbek', imgsrc = 'https://imgur.com/LuY55Dq.png', content = {'6.5', '300', '6'}},
    {brand = "Volkswagen", name = 'Volkswagen Golf MK6', model = 'golfmk6',price = 700000, category = 'hedzbek', imgsrc = 'https://imgur.com/KoGnSyY.png', content = {'3.5', '220', '6'}},
    {brand = "Corvette", name = 'Corvette ZR1', model = '19zr1',price = 810000, category = 'sportski', imgsrc = 'https://imgur.com/tXIOyMt.png', content = {'3.5', '300', '6'}},
    {brand = "Ford", name = 'Ford Shelby', model = 'mst',price = 460000, category = 'kupei', imgsrc = 'https://imgur.com/yNmaKRK.png', content = {'5.5', '300', '6'}},
    {brand = "Ford", name = 'Ford Raptor', model = 'raptor150',price = 670000, category = 'dzipovi', imgsrc = 'https://imgur.com/q0BkI7P.png', content = {'4.5', '240', '5'}}, 
    {brand = "Ford", name = 'Mustang Shelby', model = 'manssupersnake',price = 400000, category = 'kupei', imgsrc = 'https://imgur.com/nbvHxXR.png', content = {'4.5', '300', '6'}}, 
    {brand = "Ford", name = 'Ford Escort', model = 'fe86',price = 50000, category = 'kupei', imgsrc = 'https://imgur.com/cZsB1Wb.png', content = {'5.5', '210', '6'}},
    {brand = "Jaguar", name = 'Jaguar XKGT', model = 'XKGT',price = 650000, category = 'kupei', imgsrc = 'https://imgur.com/752TCxA.png', content = {'5.5', '250', '6'}},
    {brand = "Peugeot", name = 'Peugeot 205', model = '205',price = 130000, category = 'kupei', imgsrc = 'https://imgur.com/WHz1nws.png', content = {'5.5', '230', '5'}},
    {brand = "Peugeot", name = 'Peugeot 206', model = '206',price = 170000, category = 'kupei', imgsrc = 'https://imgur.com/NunRtTp.png', content = {'5.5', '200', '5'}},
    {brand = "Toyota", name = 'Toyota Supra', model = 'a80',price = 380000, category = 'sportski', imgsrc = 'https://imgur.com/h95yqH2.png', content = {'3.5', '300', '6'}}, 
    {brand = "Toyota", name = 'Toyota Camry', model = 'cam8tun',price = 420000, category = 'sportski', imgsrc = 'https://imgur.com/iJennBN.png', content = {'4.5', '290', '6'}}, 
    {brand = "Honda", name = 'Honda Africa Twin', model = 'africat',price = 500000, category = 'motori', imgsrc = 'https://imgur.com/wWejlkA.png', content = {'5.5', '210', '5'}}, 
    {brand = "Honda", name = 'Honda CB500X', model = 'cb500x',price = 200000, category = 'motori', imgsrc = 'https://imgur.com/Mzj0DGP.png', content = {'5.5', '210', '5'}}, 
    {brand = "Honda", name = 'Honda CBR', model = 'hcbr17',price = 850000, category = 'motori', imgsrc = 'https://imgur.com/PRzuUUJ.png', content = {'4.5', '250', '6'}}, 
    {brand = "Mitsubishi", name = 'Mitsubishi Eclipse', model = 'eclipsegt06',price = 120000, category = 'kupei', imgsrc = 'https://imgur.com/p8oJlDN.png', content = {'4.5', '250', '6'}},  
    {brand = "Mitsubishi", name = 'Mitsubishi EVO9', model = 'evo9',price = 300000, category = 'kupei', imgsrc = 'https://imgur.com/mRkxgLH.png', content = {'6.5', '240', '6'}},    
    {brand = "Hummer", name = 'Hummer H6', model = 'h6',price = 950000, category = 'kamionet', imgsrc = 'https://imgur.com/4A7JVgk.png', content = {'10.5', '200', '6'}}, 
    {brand = "Kia", name = 'Kia Stinger', model = 'kiagt',price = 490000, category = 'limuzine', imgsrc = 'https://imgur.com/xbUX2N3.png', content = {'4.5', '300', '6'}}, 
    {brand = "Cadillac", name = 'Cadillac', model = 'limoxts',price = 450000, category = 'limuzine', imgsrc = 'https://imgur.com/A4wWuvH.png', content = {'15.5', '190', '6'}}, 
    {brand = "Jeep", name = 'Jeep Hawk', model = 'trhawk',price = 395069, category = 'limuzine', imgsrc = 'https://imgur.com/vKcZzdK.png', content = {'4.5', '290', '6'}}, 
    {brand = "Hyundai", name = 'Hyundai Veloster', model = 'veln',price = 150000, category = 'sportski', imgsrc = 'https://imgur.com/E6yzpnK.png', content = {'3.5', '300', '6'}}, 
    {brand = "Volvo", name = 'Volvo 850', model = 'VOLVO850R',price = 39000, category = 'limuzine', imgsrc = 'https://imgur.com/HKOGfk2.png', content = {'5.5', '250', '5'}},
    {brand = "Jaguar", name = 'Jaguar XKGT', model = 'XKGT',price = 650000, category = 'sportski', imgsrc = 'https://imgur.com/752TCxA.png', content = {'5.5', '250', '6'}},
    {brand = "Zastava", name = 'Zastava Yugo', model = 'yugo',price = 9600, category = 'kupei', imgsrc = 'https://imgur.com/OVgmWRc.png', content = {'15.5', '190', '5'}},  
}

Panama.DonVozila = {
    {brand = "Bugatti", name = 'Bugatti Chiron', model = '2019chiron',price = 999999999, category = 'kupei', imgsrc = 'https://imgur.com/hP4OEAg.png', content = {'2.9', '350', '9'}},
    {brand = "Bugatti", name = 'Bugatti', model = 'bugatti',price = 999999999, category = 'kupei', imgsrc = 'https://imgur.com/1Xd0zJP.png', content = {'3.2', '320', '9'}},
    {brand = "Mercedes", name = 'Mercedes Brabus 850', model = 'brabus850',price = 999999999, category = 'kupei', imgsrc = 'https://imgur.com/ANQIzhT.png', content = {'5.5', '300', '9'}},
    {brand = "Mercedes", name = 'Mercedes Brabus 500', model = 'brabus500',price = 999999999, category = 'kupei', imgsrc = 'https://imgur.com/NywgU2A.png', content = {'5.5', '300', '9'}},
    {brand = "Mercedes", name = 'Mercedes 6x6', model = 'brabus700',price = 999999999, category = 'dzipovi', imgsrc = 'https://imgur.com/pP6HkUv.png', content = {'5.5', '250', '9'}},
    {brand = "Doge", name = 'Doge Chelenger 69', model = '69chardzer',price = 999999999, category = 'muscle', imgsrc = 'https://imgur.com/6gQSh10.png', content = {'5.5', '300', '7'}},
    {brand = "Lamborghini", name = 'Lamborghini LP700R', model = 'lp700r',price = 999999999, category = 'kupei', imgsrc = 'https://imgur.com/2Jd2Z5U.png', content = {'5.5', '400', '7'}},  
    {brand = "Bentley", name = 'Bentley Continental', model = 'contgt13',price = 999999999, category = 'kupei', imgsrc = 'https://imgur.com/f3jPDHl.png', content = {'4.5', '300', '7'}},
    {brand = "Rolls Royce", name = 'Rolls Royce', model = 'dawnonjx',price = 999999999, category = 'kupei', imgsrc = 'https://imgur.com/Y3WVvJn.png', content = {'4.5', '320', '7'}},
    {brand = "Rolls Royce", name = 'Rolls Royce', model = 'dawnonjx2',price = 999999999, category = 'kupei', imgsrc = 'https://imgur.com/VDRnNig.png', content = {'4.5', '320', '7'}},
}

Panama.Kategorije = {
    [1] = {name = 'dzipovi',label =  'Dzipovi'},
    [2] = {name = 'hedzbek',label =  'Hedzbek'},
    [3] = {name = 'kabrioleti',label =  'Kabrioleti'},
    [4] = {name = 'kamionet',label =  'Kamionet'},
    [5] = {name = 'kombiji', label = 'Kombiji'},
    [6] = {name = 'kompaktni', label = 'Kompaktni'},
    [7] = {name = 'kupei', label = 'Kupei'},
    [8] = {name = 'limuzine', label = 'Limuzine'},
    [9] = {name = 'motor', label = 'Motor'},
    [10] = {name = 'motori', label = 'Motori'},
    [11] = {name = 'muscle', label = 'Muscle'},
    [12] = {name = 'offroad', label = 'Off Road'},
    [13] = {name = 'oldtimer',label =  'Oldtajmer'},
    [14] = {name = 'pickup',label =  'Pickup'},
    [15] = {name = 'sportski',label =  'Sportski'},
    [16] = {name = 'sportskiklasicni', label =  'Sportski Klasicnni'},
    [17] = {name = 'super', label = 'Super'},
}

--Brodovi--
Panama.Brodovi = {
    {brand = "Brod", name = 'Squalo', model = 'squalo',price = 850000, category = 'gliser', imgsrc = 'https://imgur.com/3nAM7Ce.png', content = {'10.5', '190', '3'}},
    {brand = "Brod", name = 'Suntrap', model = 'suntrap',price = 900000, category = 'gliser', imgsrc = 'https://imgur.com/JylnZLp.png', content = {'10.0', '190', '4'}},
    {brand = "Brod", name = 'Jetmax', model = 'jetmax',price = 700000, category = 'gliser', imgsrc = 'https://imgur.com/O0V1ssw.png', content = {'3.0', '190', '4'}},
    {brand = "Brod", name = 'Dinghy', model = 'Dinghy',price = 950000, category = 'gliser', imgsrc = 'https://imgur.com/M0So5nS.png', content = {'3.0', '190', '4'}},
}

Panama.VipBrodovi = {
    {brand = "Brod", name = 'Tropic', model = 'tropic',price = 1000000, category = 'gliser', imgsrc = 'https://imgur.com/GBDMuk6.png', content = {'10.5', '190', '5'}},
    {brand = "Jetski", name = 'Seashark', model = 'seashark3',price = 750000, category = 'jetski', imgsrc = 'https://imgur.com/oPKISUY.png', content = {'10.5', '190', '2'}},
}

Panama.DonBrodovi = {
    {brand = "Brod", name = 'Toro', model = 'toro',price = 1500000, category = 'gliser', imgsrc = 'https://imgur.com/fvTUO81.png', content = {'10.0', '190', '4'}},
}
Panama.KategorijeBrodova = {
    [1] = {name = 'gliser', label = 'Gliser'},
    [2] = {name = 'jetski', label = 'Skuter na vodi'},
    [3] = {name = 'jahta' , label = 'Jahta'},
    [4] = {name = 'camac',label = 'Camac'},
}

LoadNormalVehicles = function()
    local vozila = Panama.Vozila
    local kategorije = Panama.Kategorije
    for i=1, #vozila, 1 do
        local vozilo = vozila[i]
        for j=1, #kategorije, 1 do
           if kategorije[j].name == vozilo.category then
            vozilo.categoryLabel = kategorije[j].label
            br = br + 1
            break
           end
        end
        table.insert(vozila, vozilo)
    end
    TriggerClientEvent('panama_autosalon:sendCategories', -1, Panama.Kategorije)
    TriggerClientEvent('panama_autosalon:sendVehicles', -1, vozila)
end

function vRPvehicleshop.setVehicleOwner(plate, type, img, name, brand,model)
    local _source = source
    local user_id = vRP.getUserId({source})
    local description = {}
    description = {['img'] = img, ["name"] = name, ["brand"] = brand}
    exports['GHMattiMySQL']:QueryAsync("INSERT INTO vrp_user_vehicles (user_id, vehicle, vehicle_plate, veh_type) VALUES (@user_id, @vehicle, @vehicle_plate, @veh_type)", {['user_id'] = user_id, ['vehicle'] = model, ['vehicle_plate'] = plate, ['veh_type'] = type}, function()end)
end


function vRPvehicleshop.getCategories()
    return Panama.Kategorije
end

function vRPvehicleshop.getVehicles()
    local data = {
        normal = Panama.Vozila,
        vip = Panama.VipVozila,
        donator = Panama.DonVozila
    }
	return data
end

function vRPvehicleshop.getBoatCategories()
    return Panama.Kategorije
end
function vRPvehicleshop.getBoats()
    local data = {
        normal = Panama.Brodovi,
        vip = Panama.VipBrodovi,
        donator = Panama.DonBrodovi
    }
	return data
end
function vRPvehicleshop.buyVehicle(price)
    local user_id = vRP.getUserId({source})
    if vRP.tryFullPayment({user_id, price}) then
		return true
	else
		return false
    end
end

function vRPvehicleshop.isPlateTaken(price)
    local rezultat
    exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM `vrp_user_vehicles` WHERE `vehicle_plate` = @plate",{['plate'] = plate}, function(rows) 
		if rows[1] ~= nil then
            rezultat = rows[1]
        else
            rezultat = 0
        end
    end)
    while rezultat ~= nil do
        Wait(1)
    end
    return rezultat
end