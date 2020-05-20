WCTTileList = {}

do
	local frame = nil
	local editFrame = nil
	local options = nil
	local tileName = nil
	local tileAction = nil
	local chatType = nil
	local applyButton = nil
	local frames = {}
	local hide = false
	
	
	local function UpdateTile(id)
		options.tiles[id] = {}
		options.tiles[id].title = tileName:GetText()
		options.tiles[id].action = tileAction:GetText()
		options.tiles[id].group = chatType:GetValue()
		WCTTileList.Update()
	end
	
	local function OnClick(item, click)
		local tile = options.tiles[item.id]
		if click == "RightButton" then
			if tile ~= nil then
				tileName:SetText(tile.title)
				tileAction:SetText(tile.action)
				chatType:SetValue(tile.group)
			else
				tileName:SetText("")
				tileAction:SetText("")
				chatType:SetValue("PARTY")
			end
			applyButton:SetCallback("OnClick", function() 
				UpdateTile(item.id)
			end)
			editFrame:Show()
		else
			if tile then
				if tile.group:sub(1,-2)  == "CHANNEL" then
					--print(tile.action.. " On Ch ".. tile.group:sub(-1))
					SendChatMessage(tile.action,"CHANNEL", nil, tile.group:sub(-1))
				else
					--print(tile.action.. " On ".. tile.group)
					SendChatMessage(tile.action, tile.group)
				end
			end
		end
	end
	
	local function Update()
		local cols = options.cols
		local rows = options.rows
		
		if hide then
			cols = 0
			rows = 0
			frame:SetWidth(60 + 4)
			frame:SetHeight(22)
		else
			frame:SetWidth(cols * 60 + 4)
			frame:SetHeight(rows * 18 + 22)
		end
		
		
		for k,v in pairs(frames) do
			v:Hide()
		end
		
		for x =0,rows-1 do
			for y = 0,cols-1 do
				local id = x.."."..y
				if frames[id] == nil then
					frames[id] = CreateFrame("Button", nil, frame, "WCTTile")
					frames[id]:RegisterForClicks("LeftButtonUp","RightButtonUp")
					frames[id]:SetScript("OnClick", OnClick)
					frames[id].id = id
				end
				frames[id]:SetPoint("TOPLEFT", 2 + y*60, -x*18 - 18)
				if options.tiles[id] == nil then
					frames[id].Text:SetText("")
				else
					frames[id].Text:SetText(options.tiles[id].title)
				end
				
				frames[id]:Show()
				
			end
		end
	end
	
	local function Init()
		options = WCTOptions.char
		frame = CreateFrame("Frame", nil, UIParent, "WCTList")
		frame:SetPoint("TOPLEFT", options.screenX, -options.screenY, "TOPLEFT")
		frame:Show()
		frame.statusBar:HookScript("OnDragStop", function(self)
				options.screenX = self:GetParent():GetLeft()
				options.screenY = GetScreenHeight() - self:GetParent():GetTop()
		end)
		frame.ShowHide:SetScript("OnClick", function() 
			hide = not hide 
			Update()
		end);
		Update()
		
		
		-- Create edit frame
		editFrame = LibStub("AceGUI-3.0"):Create("Frame")
		editFrame:SetTitle("Chaty edit")
		editFrame:SetLayout("Flow")
		editFrame:SetWidth(250)
		editFrame:SetHeight(167)
		editFrame:Hide()
		
		tileName = LibStub("AceGUI-3.0"):Create("EditBox")
		tileName:SetLabel("Tile name:")
		tileName:SetWidth(100)
		tileName:DisableButton(true)
		editFrame:AddChild(tileName)
		
		chatType = LibStub("AceGUI-3.0"):Create("Dropdown")
		chatType:SetList({SAY="Say", PARTY="Party", GUILD="Guild", RAID="Raid", CHANNEL1="Ch 1", CHANNEL2="Ch 2",CHANNEL3="Ch 3"})
		chatType:SetLabel("ChatType:")
		chatType:SetWidth(80)
		editFrame:AddChild(chatType)
		
		
		tileAction = LibStub("AceGUI-3.0"):Create("EditBox")
		tileAction:SetLabel("Chat action:")
		tileAction:SetWidth(200)
		tileAction:DisableButton(true)
		editFrame:AddChild(tileAction)
		
		applyButton = LibStub("AceGUI-3.0"):Create("Button")
		applyButton:SetText("Apply")
		applyButton:SetWidth(100)
		applyButton:SetHeight(20)
		editFrame:AddChild(applyButton)
		
		
	end	

	WCTTileList.Init = Init
	WCTTileList.Update = Update

end

return WCTTileList