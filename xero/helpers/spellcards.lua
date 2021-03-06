--[[
This file is part of XeroOl's Mod Loader, which is covered by The MIT License (MIT).
You can read about the license in license.txt
]]

local spellcards = {}

if not FUCK_EXE or tonumber(GAMESTATE:GetVersionDate()) < 20170714 then

	spellcards.is_supported = false
	function spellcards.add_spellcard() --[[don't do anything if in OpenITG]] end

else

	spellcards.is_supported = true
	local function flush_spellcards()
		local s = GAMESTATE:GetCurrentSong()
		s:SetNumSpellCards(spellcards.n)
		for i=0,spellcards.n-1 do
			print(i,spellcards[i])
			local mycard = spellcards[i]
			local start_beat = mycard[1]
			local length = mycard[2]
			local name = mycard[3]
			local difficulty = mycard[4]
			local color = mycard[5]
			s:SetSpellCardTiming(i,start_beat,start_beat+length)
			s:SetSpellCardName(i,name)
			s:SetSpellCardDifficulty(i,difficulty)
			s:SetSpellCardColor(i,color[1],color[2],color[3],color[4])
			spellcards[i]=nil
		end
	end
	
	function spellcards.add_spellcard(start_beat,length,name,difficulty,color)
		if not spellcards.n then
			spellcards.n=0
			xero.add_mod(0,flush_spellcards)
		end
		spellcards[spellcards.n]={start_beat,length,name,difficulty,color}
		spellcards.n=spellcards.n+1
	end
	
end
return spellcards