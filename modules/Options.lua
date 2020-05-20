
WCTOptions = {}

do

	-- Addon options
	local defaults = {
		char = {
			screenX = 0,
			screenY = 0,
			cols = 5,
			rows = 2,
			tiles = {},
		},
	}
	
	-- Addon ACE options
	local function GetOptionPanel()
		return {
			type = "group",
			name = "Chaty",
			desc = "Chaty Options",
			args = {
				cols = {
					type = "range",
					name = "Number of column",
					order = 1,
					min = 2,
					max = 20,
					step = 1,
					get = function () return WCTOptions.char.cols end,
					set = function (info, value)
						WCTOptions.char.cols = value
						WCTTileList:Update()
					end,
				},
				rows = {
					type = "range",
					name = "Number of rows",
					order = 1,
					min = 2,
					max = 20,
					step = 1,
					get = function () return WCTOptions.char.rows end,
					set = function (info, value)
						WCTOptions.char.rows = value
						WCTTileList:Update()
					end,
				},
			}
		}
	end
	
	local function Init(self)
		local options = LibStub("AceDB-3.0"):New("ChatyDB", defaults)
		WCTOptions.char = options.char
		
		LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("WCTPanel", GetOptionPanel())
		LibStub("AceConfigDialog-3.0"):AddToBlizOptions("WCTPanel", "Chaty")
	
	end
	
	WCTOptions.Init = Init
end

return WCTOptions