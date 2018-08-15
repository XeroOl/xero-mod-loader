local ease = {}

local function tomodstring(startpercent,endpercent,progress,mod) return'*9999 '..help.interpolate(startpercent,endpercent,progress)..' '..mod end
function ease.ease(...)
	local startbeat = arg[1]
	local length = arg[2]
	local count = 3
	-- holdlength is optional
	local holdlength
	if type(arg[3])=='number' then
		holdlength = arg[3]
		count = count + 1
	end
	local myfunction = arg[count]
	if type(arg[count+1])=='number' then
		xero.add_mod(startbeat,length,function(x)
			return tomodstring(arg[count+1],arg[count+2],myfunction(x/length,0,1,1),arg[count+3])
		end,arg[count+4])
		if holdlength then
			local val = tomodstring(arg[count+1],arg[count+2],myfunction(1,0,1,1),arg[count+3])
			xero.add_mod(startbeat+length,holdlength,val,arg[count+4])
		end
	else
		local mytable = arg[count+1]
		xero.add_mod(startbeat,length,function(x)
			local table2 = {}
			local count2 = 1
			for i,v in pairs(mytable) do 
				table2[count2]=tomodstring(v[1],v[2],myfunction(x/length,0,1,1),v[3])
				count2 = count2 + 1
			end
			return table.concat(table2,',')
		end,arg[count+2])
		if holdlength then
			local table2 = {}
			local count2 = 1
			for i,v in pairs(mytable) do 
				table2[count2]=tomodstring(v[1],v[2],myfunction(1,0,1,1),v[3])
				count2 = count2 + 1
			end
			local val = table.concat(table2,',')
			xero.add_mod(startbeat+length,holdlength,val,arg[count+2])
		end
	end
end
--------------------BASIC EASES---------------------
function ease.linear(x)return x end
function ease.cubic(x)return 3*x*x-2*x*x*x end
function ease.accelerate(x)return x*x end
function ease.decelerate(x)return -x*x+2*x end
function ease.push(x)return 27/4*x*(1-x)*(1-x)end
function ease.slam(x)return 27/4*x*x*(1-x)end
function ease.bounce(x)return 4*x*(1-x)end
function ease.sleep(x)return x>=1 and 1 or 0 end
function ease.bell(x)return ease.cubic(1-2*math.abs(x-0.5))end
function ease.half(x)return x>=0.5 and 1 or 0 end
function ease.jerk(x)return x*x*x end
function ease.jounce(x)return x*x*x*x end --the correct name
function ease.spike(x)return 1-math.abs(2*ease.cubic(x)-1)end
function ease.tan(x)return math.tan(x*math.pi)*3*ease.bounce(x)end
function ease.tan_accelerate(x)return ease.tan(x*0.5)end
function ease.tan_decelerate(x)return 1+ease.tan(0.5+x*0.5)end
function ease.inverse(x)return x*x*(1-x)*(1-x)/(x-0.5)end
--------------------ADVANCED EASES---------------------
function ease.decelerate_options(intensity)return function(x)return 1-math.pow(1-x,intensity)end end
function ease.cosine(cycles)return function(x)return 0.5-0.5*math.cos(x*6.2831853*cycles)end end
function ease.sine(cycles)return function(x)return math.sin(x*6.2831853*cycles)end end
-------------------------------------------EASE-BUILDERS-----------------------------------
function ease.loop(myfunction,cycles)return function(x)return myfunction(math.mod(x*cycles,1))end end

return ease