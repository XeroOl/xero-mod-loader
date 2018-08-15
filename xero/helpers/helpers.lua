local help = {}
----------------------------------------------BASIC-HELPERS------------
function help.interpolate(value0,value1,amount)
	return value0+(value1-value0)*amount
end
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

return help