local help = xero.loadfile('lua/xero/helpers.lua')
xero.add_mod(0,help.for_each_plr(function(i,v)v:x(SCREEN_CENTER_X)end))
do
	local timings = {2,2.75,3.5,4,5.5,5.75,6,6.5,7,8,8.25,8.75,9,9.5,10,10.75,11.5,12,12.75,13.5,13.75,14,14.5,15,16}
	local index = 1 local parity = 1
	xero.add_mod(0,16,function(x)while x>timings[index] do index=index+1 parity=-parity end x=timings[index]-x return'*9999 '..
		parity*x*200 ..' confusionoffset,*9999 '..
		100-200*x ..' stealth,*9999 '..
		100-100*x ..' dark,*9999 '..
		50*x ..' tornado,*9999 '..
		math.min(200,300*x-100) ..' tiny,*9999 '..
		math.max(0.01,2-x) ..'x'
	end)
end
do
	xero.add_mod(16,16,function(x)return'*9999 3x,*9999 '.. 200*math.exp(-x) ..' mini,*9999 no tiny'end)
	local mytable = {{},{}}
	help.for_each_note(16,16,function(beat,column,notetype,length,pn)
		if mytable[pn][column]==nil then mytable[pn][column]=beat else 
			xero.add_mod(mytable[pn][column],0.75,function(x)return '*9999 '.. 100*help.decelerate(x*1.333) ..' reverse'..column end,pn)
			xero.add_mod(mytable[pn][column]+0.75,beat-mytable[pn][column]-0.75,'reverse'..column,pn)
			xero.add_mod(beat,0.75,function(x)return'*9999 '.. 100-100*help.decelerate(x*1.333) ..' reverse'..column end,pn)
			mytable[pn][column]=nil
		end
	end)
	xero.add_mod(31.5,1.5,function(x)return '*9999 '.. 100*x ..' stealth,*9999 '.. 100*x ..' dark'end)
	help.spline_tool(33,100,function(offset,note,beat,pn)
		return {
		X = (offset/70-300/70-(offset/100-3)^3/3)*(20)+50*(note[2]),
		Y = (40-3*note[2])*(offset/100+1)*(offset/100-5),
		Stealth = offset-(20*(80-beat))-200
		}
	end,3,30)
	xero.add_mod(80,function()for i,v in xero.plr do v:NoClearSplines(false) end end)
	xero.add_mod(33,47,'*9999 straightholds,*9999 spiralholds,stealthpastreceptors,*9999 -100 drawsizeback,*9999 3x,*9999 100 drawsize,*999 50 flip,*999 50 reverse,*9999 no stealth,beat')
	xero.add_mod(80,50,'arrowpath,3x')
end
help.ease(0,10,30,help.cubic,{{0,50,'stealth'},{0,100,'invert'}})