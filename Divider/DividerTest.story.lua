--!nocheck
-- This is an example of usage for the Divider lib
local Divider = require(script.Parent.Divider)
local Fusion = require(script.Parent.Parent.Parent.Libs.Fusion)

local New = Fusion.New
local Children = Fusion.Children

return function(p)
	local ss = p:FindFirstAncestorWhichIsA("LayerCollector")
	if ss then ss.ZIndexBehavior = Enum.ZIndexBehavior.Global end
	
	local UI = New "Frame" {
		Size = UDim2.new(1, -1, 1, -1),
		
		[Children] = Divider(
			"Y",
			{UDim.new(0, 20)},
			{UDim.new(1, -40), Divider(
				"X",
				{UDim.new(0.5, 0)},
				{UDim.new(0.5, 0)}
			)},
			{UDim.new(0, 20)}
		)
	}
	
	print("RUN")
	UI.Parent = p
	return function()
		UI:Destroy()
	end
end
