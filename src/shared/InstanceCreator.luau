return function(ClassName : string, InstanceName : string, Parent : Instance)
	if not ClassName or not InstanceName or not Parent then error("One of the given arguments are nil!") return end
	local OBJ = Instance.new(ClassName)
	OBJ.Name = InstanceName
	OBJ.Parent = Parent
	return OBJ
end