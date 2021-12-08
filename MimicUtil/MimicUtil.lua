ModUtil.RegisterMod("MimicUtil")

function MimicUtil.isCosmeticProperty(propertyName)
	if string.find(propertyName, "Fx") or string.find(propertyName, "Graphic") or string.find(propertyName, "Animation") then
		return true
	else
		return false
	end
end