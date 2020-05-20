

local ADDON_NAME = "WCT"

SLASH_WCT1 = "/ct"
function SlashCmdList.WCT(msg)	
	LibStub("AceConfigDialog-3.0"):Open("WCTPanel")
	--print(Options.optionA)
	--Options.optionA = false
end


WCT = LibStub("AceAddon-3.0"):NewAddon("Chaty")

function WCT:OnEnable()
	WCTOptions.Init()
	WCTTileList.Init()
end