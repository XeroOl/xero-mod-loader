local xero = {}
----------------------------------------------BASIC-HELPERS------------
function xero.interpolate(value0,value1,amount)
	return value0+(value1-value0)*amount
end
-- adds an ease entry to the mod with the power of closures
-- ex: xero_ease(0,10,xero_linear,{{0,100,dizzy}})
---------------------------------------------BASIC-EASES---------------------------
function xero.linear(x)return x	end
function xero.cubic(x)return 3*x*x-2*x*x*x end
function xero.accelerate(x)return x*x end
function xero.decelerate(x)return -x*x+2*x end
function xero.push(x)return 27/4*x*(1-x)*(1-x)end
function xero.slam(x)return 27/4*x*x*(1-x)end
function xero.bounce(x)return 4*x*(1-x)end
function xero.sleep(x)return x>=1 and 1 or 0 end
function xero.bell(x)return xero_cubic(1-2*math.abs(x-0.5))end
function xero.half(x)return x>=0.5 and 1 or 0 end
function xero.jerk(x)return x*x*x end
function xero.jounce(x)return x*x*x*x end --the correct name
function xero.spike(x)return 1-math.abs(2*xero_cubic(x)-1)end
function xero.tan(x)return math.tan(x*math.pi)*3*xero_bounce(x)end
function xero.tan_accelerate(x)return xero_tan(x*0.5)end
function xero.tan_decelerate(x)return 1+xero_tan(0.5+x*0.5)end

-------------------------------------------ADVANCED-EASES---------------------------------
function xero.decelerate_options(intensity)return function(x)return 1-math.pow(1-x,intensity)end end
function xero.cosine(cycles)return function(x)return 0.5-0.5*math.cos(x*6.2831853*cycles)end end
function xero.sine(cycles)return function(x)return math.sin(x*6.2831853*cycles)end end

-------------------------------------------EASE-BUILDERS-----------------------------------
function xero.loop(ease,cycles)return function(x)return ease(math.mod(x*cycles,1))end end

-------------------HELPFUL-PRE_BUILTS--------------------------
function xero.reverse(a,b,c,d)return'*9999 '..a..' reverse,*9999 '..(-a+b-c+d)*0.5 ..' alternate,*9999 '..(-a+b+c-d)*0.5 ..' cross,*9999 '..(-a-b+c+d)*0.5 ..' split'end
-------------------HELFUL-BOIS---------------------------------

return xero