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

function cribbage_counter.countRuns(hand,scores)
	local tree = {}
	local scores = scores

	for k,v in pairs(hand) do
		local int = tonumber(v:getOrder())
		if(tree[int] == nil) then
			tree[int] = {}
		end
		table.insert(tree[int],v)
	end

	local sequenceCount = 1

	for i = 1,13 do
		local currentValue = tree[i]
		local forwardValue = tree[i+1]
		
		if(currentValue ~= nil) then
			if(forwardValue ~= nil) then
				--print("sequence "..sequenceCount)
				sequenceCount = sequenceCount + 1
			else
				if(sequenceCount > 2) then
					--print("score!! "..sequenceCount)
					local scoringHand = {}
					local index = sequenceCount - 1
					local cardCount = 1

					for x = index,i do
						cardCount = cardCount*#tree[x]
						for y = 1,#tree[x] do	
							table.insert( scoringHand, tree[x][y] )
						end
					end

					local score = ScoreItem:new("run",sequenceCount*cardCount,scoringHand)
					table.insert( scores, score )
					
					sequenceCount = 0
				else
					--print("run was broken at "..sequenceCount)
					sequenceCount = 0
				end
			end
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