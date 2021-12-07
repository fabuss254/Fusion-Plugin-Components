--[[
	This function will divide the frame into multiple sub-frames which contain studio plugin like corners.
	Arguments:
		- Axis:String Must be 'X' or 'Y'
		- Data:table { Size:UDim2, Children:table, FrameProperties:table } Define the size of this specific subframe.
		- Data2... This function is variadic, It can contain as much subframe as you want.

  Requirement:
    - Fusion
    - A theme library (Check Theme lib inside the repo for example)
--]]
local Fusion = require(script.Parent.Parent.Parent.Libs.Fusion) -- Add your own fusion path here
local Theme = require(script.Parent.Parent.Theme) -- Add your own theme lib here

local New = Fusion.New
local State = Fusion.State
local Computed = Fusion.Computed
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

local ZeroUDim = UDim.new(0, 0)
local OneUDim2 = UDim2.fromOffset(1, 1)
local TwoUDim2 = UDim2.fromOffset(2, 2)

function AxisUDim2(Axis, uDim)
	return (Axis == "X" and UDim2.new(uDim, ZeroUDim)) or UDim2.new(ZeroUDim, uDim)
end

return function(Axis, ...)
	assert(Axis == "X" or Axis == "Y", "Axis must be 'X' or 'Y'.")
	
	local Arr = {...}
	
	local Out = {}
	local CurPos = UDim2.new()
	for i,Data in pairs(Arr) do
		assert(Data[1], string.format("Missing Size for argument #%i", i))
		local Size = Axis == "Y" and UDim2.new(UDim.new(1, 0), Data[1]) or UDim2.new(Data[1], UDim.new(1, 0))
		
		local Properties = {
			Position = CurPos - OneUDim2,
			Size = Size + TwoUDim2,

			BorderColor3 = Theme:Get("Border"),
			BorderSizePixel = 1,
			BorderMode = Enum.BorderMode.Inset,

			BackgroundColor3 = Theme:Get("MainBackground"),
			BackgroundTransparency = 0,

			[Children] = Data[2] or {},
		}
		
		if Data[3] then
			for i,v in pairs(Data[3]) do
				Properties[i] = v
			end
		end
		
		table.insert(Out, New("Frame")(Properties))
		CurPos += AxisUDim2(Axis, Data[1])
	end
	
	return Out
end
