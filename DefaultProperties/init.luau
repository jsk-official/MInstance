local ReflectionService = game:GetService("ReflectionService")
local Cache = {}
local DefaultProperties = {}

DefaultProperties.GetPropertiesOfClass = function(ClassName)
	if Cache[ClassName] then return Cache[ClassName] end

	local Properties = ReflectionService:GetPropertiesOfClass(ClassName, {
		["ExcludeDisplay"] = true,
		["Security"] = SecurityCapabilities.fromCurrent(),
	})
	
	local RetTbl = {}

	for _,v in pairs(Properties) do
		if v.Permits.Write and v.Permits.Read then
			table.insert(RetTbl, v)
		end
	end

	Cache[ClassName] = RetTbl

	return RetTbl
end

DefaultProperties.GetClasses = function()
	return ReflectionService:GetClasses()
end

return DefaultProperties