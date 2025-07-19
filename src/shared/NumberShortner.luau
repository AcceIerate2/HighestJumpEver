local T = {"K","M","B","T","q","Q","s","S","O","N","d","U","D"}
return function(n)
	if not tonumber(n) then return n end
	if n < 10000 then return math.floor(n) end
	local d = math.floor(math.log10(n)/3)*3
	local s = tostring(n/(10^d)):sub(1,5)
	return s.." "..tostring(T[math.floor(d/3)])
end