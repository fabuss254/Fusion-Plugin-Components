--[[
  This module let you retrieve studio theme colors more easily

  Theme:Get(Name: String, Modifier: String) -> State | Give the state of a specific theme
  Theme:Update() -> nil | Update the currently used Theme (must be updated on theme changes) 
--]]
local Fusion = require(script.Parent.Parent.Libs.Fusion) -- Path to fusion
local State = Fusion.State

local Theme = {_ = {}}

function Theme:Get(Name, Modifier)
	if not Modifier then Modifier = "Default" end
	if not self._[Name .. "|" .. Modifier] then
		self._[Name .. "|" .. Modifier] = State(self.CurrentTheme:GetColor(Enum.StudioStyleGuideColor[Name], Enum.StudioStyleGuideModifier[Modifier]))
	end
	
	return self._[Name .. "|" .. Modifier]
end

function Theme:Update()
	self.CurrentTheme = settings().Studio.Theme
	
	for Id,_ in pairs(self._) do
		local Data = Id:split("|")
		local Name, Modifier = Data[1], Data[2]
		self:Get(Name):set(self.CurrentTheme:GetColor(Enum.StudioStyleGuideColor[Name], Enum.StudioStyleGuideModifier[Modifier]))
	end
end

Theme:Update()
return Theme
