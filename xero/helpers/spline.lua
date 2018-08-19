--[[
This file is part of XeroOl's Mod Loader, which is covered by The MIT License (MIT).
You can read about the license in license.txt
]]

local spline = {}

function spline.spline_tool(start,length,mysplinefunc,myspeedmod,offsetwindow,maxsplinecount)
	myspeedmod = myspeedmod or 1 -- default is 1x
	maxsplinecount = maxsplinecount or 30 -- don't set to above 38
	offsetwindow = offsetwindow or 20
	for i,v in pairs(xero.plr) do
		local pn = i
		local Player = v
		Player:PushNoteData('xero_prefix_notedata',start,start+length)
		local mytable = xero_prefix_notedata
		xero_prefix_notedata = nil
		xero.add_mod(start,function()Player:NoClearSplines(true)end)
		xero.add_mod(start,length,function(x)
			local which = {}
			local curbeat = start+x
			for i = 0,3 do
				local offset = 0
				local receptortable = mysplinefunc(offset,{curbeat,i,-1},x+start,pn)
				for splinetype,modpercent in pairs(receptortable) do
					which[splinetype..i]=0
					Player['Set'..splinetype..'Spline'](Player,which[splinetype..i],i,modpercent,0.001,-1)
				end
			end
			for num,note in mytable do
				if note[1] >= curbeat then
					local offset = (note[1] - curbeat) * 100 * myspeedmod
					
					-- pass in a table {X=(the x amount),Y=(the y amount),Stealth=... etc}
					local resulttable = mysplinefunc(offset,note,x+start,pn)-- this is the interface
					
					for splinetype,modpercent in pairs(resulttable) do
						if(which[splinetype..note[2]]<maxsplinecount)then 
							which[splinetype..note[2]]=which[splinetype..note[2]]+1
							Player['Set'..splinetype..'Spline'](Player,which[splinetype..note[2]],note[2],modpercent,math.max(offset-offsetwindow,0.002),-1)
							which[splinetype..note[2]]=which[splinetype..note[2]]+1
							Player['Set'..splinetype..'Spline'](Player,which[splinetype..note[2]],note[2],modpercent,offset,-1)
						end
					end
				end
			end
			
		end,i)
		
	end
end

return spline