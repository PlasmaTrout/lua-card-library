cribbage_counter = {}
require "score_item"

local permutations = {
	{ 1,2 },{ 1,3 },{ 1,4 },{ 1,5 },{ 2,3 },{ 2,4 },{ 2,5 },{ 3,4 },{ 3,5 },{ 4,5 },
	{ 1,2,3 },{ 1,2,4 },{ 1,2,5 },{ 1,3,4 },{ 1,3,5 },{ 2,3,4 },{ 2,3,5 },{ 2,4,5 },{ 3,4,5 },
	{ 1,2,3,4 }, { 1,2,3,5 },{ 1,3,4,5 },{ 2,3,4,5 }
}

function cribbage_counter.countPairs(hand)
	local dupes = {}
	local scores = {}
	local scoreSheet = {0,2,6,12}

	for k,v in pairs(hand) do
		if(dupes[v:getName()] == nil) then
			dupes[v:getName()] = {}
		end
		table.insert(dupes[v:getName()],v)
	end

	for k,v in pairs(dupes) do
		if(#dupes[k] > 1) then
			local defaultScore = scoreSheet[#dupes[k]]
			table.insert(scores, ScoreItem:new("pair",defaultScore,dupes[k]))
		end
	end

	return scores
end

function cribbage_counter.countFifteens(hand,scores)
	
	for k,v in ipairs( permutations ) do
		local total = 0
		local cards = {}
		for n,index in ipairs(v) do
			total = total + hand[index]:getValue()
			table.insert(cards,hand[index])
		end
		
		if(total == 15) then
			local score = ScoreItem:new("fifteen",2,cards)
			table.insert(scores,score)
		end
		
		--print(total)
	end

	return scores
end



return cribbage_counter