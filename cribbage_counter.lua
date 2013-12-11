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

function cribbage_counter.countFlush(hand,scores)
	local suits = {}
	local scores = scores
	for k,v in pairs(hand) do
		if(suits[v:getSuit()] == nil) then
			suits[v:getSuit()] = {}
		end
		table.insert( suits[v:getSuit()], v )
	end

	for k,v in pairs(suits) do
		if (#v > 2) then
			local score = ScoreItem:new("flush",#v,v)
			table.insert( scores, score )
		end
	end

	return scores
end


function cribbage_counter.countRuns(hand,scores)
	local tree = {}
	local scores = scores

	-- First create a new tree in numberical order and insert the cards that matched
	for k,v in pairs(hand) do
		local int = tonumber(v:getOrder())
		if(tree[int] == nil) then
			tree[int] = {}
		end
		table.insert(tree[int],v)
	end

	local sequenceCount = 1

	-- Then check for any cards that are in order by looking at the values
	for i = 1,13 do
		local currentValue = tree[i]
		local forwardValue = tree[i+1]
		
		if(currentValue ~= nil) then
			-- If we have a value in front of us we have a new run sequence
			if(forwardValue ~= nil) then
				sequenceCount = sequenceCount + 1
			else
				-- if more than 2 cards have been counted in order, we have a run
				if(sequenceCount > 2) then
					
					local scoringHand = {}
					local index = sequenceCount - 1
					local cardCount = 1

					-- for each card in the run
					for x = index,i do
						cardCount = cardCount*#tree[x]
						-- for each duplicated card in the run
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

function cribbage_counter.scoreHand(hand)

	local deckmaker = require "deckmaker"
	local c = deckmaker.generateKnownHand(hand)
	for k,v in ipairs(c) do
		print(v:getTextualRep())
	end
	print("")
	local scores = cribbage_counter.countPairs(c)
	local fifteens = cribbage_counter.countFifteens(c,scores)
	local runs = cribbage_counter.countRuns(c,fifteens)
	local flush = cribbage_counter.countFlush(c,runs)

	local total = 0
	for k,v in ipairs(runs) do
		print(v:getTextualRep())
		total=total + v.value
		print("-----------------------")
		
	end
	print(total .. " point hand")
end



return cribbage_counter