local appName = "Classic Warrior Execute Sound "
local CWESFrame = CreateFrame("FRAME")
CWESFrame:Hide()

local lastExecuteTime = 0
local executeThrottle = 0.1

function CWESFrame:ADDON_LOADED(arg1)
	if arg1 ~= "CWES" then
		return
	end
	self:UnregisterEvent("ADDON_LOADED")
	print("|cFFFFD700[CWES]|r " .. appName .. "Loaded")
end

local executeSpellIDs = {
	163201,
	5308,
	217955,
	217956,
	260798,
	280735,
	262833,
	280849,
	281000,
	20661,
	20662,
	25236,
	20647
}

function CWESFrame:UNIT_SPELLCAST_SUCCEEDED(unitID, lineID, spellID)
	if unitID == "player" then
		for _, executeID in ipairs(executeSpellIDs) do
			if spellID == executeID then
				local currentTime = GetTime()
				if currentTime - lastExecuteTime > executeThrottle then
					PlaySoundFile("Interface\\Addons\\CWES\\Sounds\\FireShield.ogg", "SFX")
					lastExecuteTime = currentTime
				end
				break
			end
		end
	end
end

CWESFrame:SetScript("OnEvent", function(self, event, ...) 
	return self[event](self, ...) 
end)

CWESFrame:RegisterEvent("ADDON_LOADED")
CWESFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

