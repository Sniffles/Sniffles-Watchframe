--[[
	Sniffles Watchframe Mover
--]]

--[[
	Config
--]]

local overwritefonts = true -- Overwrite Font?
-- /!\ ATTENTION /!\
-- Some other Fonts on Frames will change, too!

local font = "Fonts\\ARIALN.ttf"
local fsize = 12
local foutline = 'OUTLINE' 

--[[
 Config End
--]]

local function dummy() end

local function SetandClearPoints(f, anchor, parent, anchor, x, y)
	f:ClearAllPoints()
	f.ClearAllPoints = dummy
	f:SetPoint(anchor, parent, anchor, x, y)
	f.SetPoint = dummy
end

local wfmove = false

local movey = CreateFrame("Frame", "Watchframe Mover", UIParent)
movey:SetMovable(true)
movey:SetUserPlaced(true)
movey:SetSize(200, 10)
movey:SetPoint("TOPLEFT", UIParent, 20, -20)
movey:SetBackdrop({
	bgFile = "Interface\\Buttons\\WHITE8x8", 
})
movey:SetBackdropColor(0,0,0,0)

local function MOVEING()
	if wfmove == false then
		wfmove = true
		movey:EnableMouse(true)
		movey:RegisterForDrag("LeftButton")
		movey:SetScript("OnDragStart", movey.StartMoving)
		movey:SetScript("OnDragStop", movey.StopMovingOrSizing)
		movey:SetBackdropColor(0,0,0,1)
		movey:SetBackdropBorderColor(0,0,0,1)
		print("Watchframe |cff00ff00unlocked|r")
	elseif wfmove == true then
		wfmove = false
		movey:EnableMouse(false)
		movey:SetBackdropColor(0,0,0,0)
		movey:SetBackdropBorderColor(0,0,0,0)
		print("Watchframe |cffff0000locked|r")
	end
end

SLASH_MOVEING1 = "/wf"
SlashCmdList["MOVEING"] = MOVEING

WatchFrameHeader:SetAlpha(0)

SetandClearPoints(WatchFrame, "BOTTOM", movey, "BOTTOM", 0, -20)

WatchFrameCollapseExpandButton:ClearAllPoints()
WatchFrameCollapseExpandButton:SetPoint("TOPRIGHT", movey, "TOPRIGHT", 20, 15)

if overwritefonts == true then
	for _, WFFont in pairs({
		_G['GameFontHighlight'],
		_G['GameFontNormal'],	
	}) do
		WFFont:SetFont(font, fsize, foutline)
	end
end