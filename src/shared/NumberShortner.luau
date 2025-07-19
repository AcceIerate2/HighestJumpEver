local T = {
	"K",
	"M",
	"B",
	"T",
	"q",
	"Q",
	"s",
	"S",
	"O",
	"N",
	"d",
	"U",
	"D",
	"Td",
	"qd",
	"Qd",
	"sd",
	"Sd",
	"Od",
	"Nd",
	"V",
	"c",
	"Cv",
	"Dc",
	"Ud",
	"Du",
	"Tr",
	"Qt",
	"Qn",
	"Sx",
	"Sp",
	"Oc",
	"No",
	"Ce",
	"UnCe",
	"DuCe",
	"TrCe",
	"QtCe",
	"QnCe",
	"SxCe",
	"SpCe",
	"OcCe",
	"NoCe",
	"Mi",
	"UnMi",
	"DuMi",
	"TrMi",
	"QtMi",
	"QnMi",
	"SxMi",
	"SpMi",
	"OcMi",
	"NoMi",
}

return function(n)
	if not tonumber(n) then
		return n
	end
	n = tonumber(n)

	if n < 10000 then
		return math.floor(n)
	end

	local d = math.floor(math.log10(n) / 3)
	local suffix = T[d] or ("e" .. tostring(d * 3)) -- fallback to scientific if out of suffixes
	local short = tostring(n / (10 ^ (d * 3))):sub(1, 5)

	return short .. " " .. suffix
end
