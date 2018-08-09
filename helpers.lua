local help = {}
----------------------------------------------BASIC-HELPERS------------
function help.interpolate(value0,value1,amount)
	return value0+(value1-value0)*amount
end
-- adds an ease entry to the mod with the power of closures
-- ex: help_ease(0,10,help_linear,{{0,100,dizzy}})
---------------------------------------------BASIC-EASES---------------------------
function help.linear(x)return x end
function help.cubic(x)return 3*x*x-2*x*x*x end
function help.accelerate(x)return x*x end
function help.decelerate(x)return -x*x+2*x end
function help.push(x)return 27/4*x*(1-x)*(1-x)end
function help.slam(x)return 27/4*x*x*(1-x)end
function help.bounce(x)return 4*x*(1-x)end
function help.sleep(x)return x>=1 and 1 or 0 end
function help.bell(x)return help.cubic(1-2*math.abs(x-0.5))end
function help.half(x)return x>=0.5 and 1 or 0 end
function help.jerk(x)return x*x*x end
function help.jounce(x)return x*x*x*x end --the correct name
function help.spike(x)return 1-math.abs(2*help.cubic(x)-1)end
function help.tan(x)return math.tan(x*math.pi)*3*help.bounce(x)end
function help.tan_accelerate(x)return help.tan(x*0.5)end
function help.tan_decelerate(x)return 1+help.tan(0.5+x*0.5)end
function help.inverse(x)return x*x*(1-x)*(1-x)/(x-0.5)end

-------------------------------------------ADVANCED-EASES---------------------------------
function help.decelerate_options(intensity)return function(x)return 1-math.pow(1-x,intensity)end end
function help.cosine(cycles)return function(x)return 0.5-0.5*math.cos(x*6.2831853*cycles)end end
function help.sine(cycles)return function(x)return math.sin(x*6.2831853*cycles)end end

-------------------------------------------EASE-BUILDERS-----------------------------------
function help.loop(ease,cycles)return function(x)return ease(math.mod(x*cycles,1))end end

-------------------HELPFUL-PRE_BUILTS--------------------------
function help.reverse(a,b,c,d)return'*9999 '..a..' reverse,*9999 '..(-a+b-c+d)*0.5 ..' alternate,*9999 '..(-a+b+c-d)*0.5 ..' cross,*9999 '..(-a-b+c+d)*0.5 ..' split'end
-------------------HELFUL-BOIS---------------------------------
function help.for_each_plr(func)
	return function(x)
		for i,v in pairs(xero.plr) do
			func(i,v,x)
		end
	end
end

function help.for_each_note(start,length,func)
	for i,v in pairs(xero.plr) do
		v:PushNoteData('xero_prefix_notedata',start,start+length)
		for num,note in ipairs(xero_prefix_notedata) do
			func(note[1],note[2],note[3],note.length,i)
		end
		xero_prefix_notedata=nil
	end
end

function help.spline_tool(start,length,mysplinefunc,myspeedmod,offsetwindow,maxsplinecount)
	myspeedmod = myspeedmod or 1 -- default is 1x
	maxsplinecount = maxsplinecount or 38 -- don't set to above 38
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

return help