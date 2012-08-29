--
-- $Date $Revision$
--

NP = LibStub("AceAddon-3.0"):NewAddon(
    "NADTParty",
    "AceConsole-3.0",
	"AceEvent-3.0"
)

local playerName = UnitName("player")

function NP:OnEnable()

	-- change loot to FFA
	if NP_DB.setffaloot then
		self:RegisterEvent("PARTY_MEMBERS_CHANGED")
	end

	-- accept invites
	if NP_DB.acceptinvite then
		self:RegisterEvent("PARTY_INVITE_REQUEST")
	end
	
	self:Print("NADTParty initialized")
	
end

function NP:PARTY_INVITE_REQUEST(event, sender)
	if NTL:IsUnitTrusted(sender) then
		local d = StaticPopup_Visible("PARTY_INVITE")
		if d then
			_G[d.. "Button1"]:Click()
		end
	else
		self:Print("cannot accept invite from untrusted sender", sender)
	end
end

function NP:PARTY_MEMBERS_CHANGED(event)
	
	local current = GetLootMethod()
	
	if current == "freeforall" then return end
	if GetNumGroupMembers() == 0 then return end
	
	if( UnitIsGroupLeader("player") ) then
		if NTL:IsGroupTrusted() then
			SetLootMethod("freeforall")
		else
			self:Print("cannot set FFA loot - not everyone is trusted")
		end
	end

end

--
-- EOF
