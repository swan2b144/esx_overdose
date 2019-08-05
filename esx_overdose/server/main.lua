ESX = nil


TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterUsableItem('weed', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('weed', 1)
	TriggerClientEvent('esx_status:add', _source, 'drug', 166000)
	TriggerClientEvent('esx_overdose:onWeed', source)
end)

ESX.RegisterUsableItem('opium', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('opium', 1)
	TriggerClientEvent('esx_status:add', _source, 'drug', 249000)
	TriggerClientEvent('esx_overdose:onOpium', source)
end)

ESX.RegisterUsableItem('meth', function(source)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('meth', 1)
	TriggerClientEvent('esx_status:add', _source, 'drug', 333000)
	TriggerClientEvent('esx_overdose:onMeth', source)
end)

ESX.RegisterUsableItem('coke', function(source) 
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('coke', 1)
	TriggerClientEvent('esx_status:add', _source, 'drug', 499000)
	TriggerClientEvent('esx_overdose:onCoke', source)
end)

ESX.RegisterUsableItem('naloxone', function(source) 
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('naloxone', 1)
	TriggerClientEvent('esx_status:remove', _source, 'drug', 249000)
end)
