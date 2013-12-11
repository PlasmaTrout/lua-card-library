local deckmaker = require "deckmaker"
local counter = require "cribbage_counter"

function testCardDeck()
	local c = deckmaker:generateOrderedDeck()
	for k,v in pairs(c) do
		print(v:getTextualRep())
	end
end

local hand = {
	{ number = 13, suit = 3 },
	{ number = 4, suit = 2 },
	{ number = 2, suit = 1 },
	{ number = 3, suit = 2 },
	{ number = 13, suit = 4 }
}

local hand2 = {
	{ number = 2, suit = 1 },
	{ number = 3, suit = 2 },
	{ number = 13, suit = 2 },
	{ number = 13, suit = 3 },
	{ number = 13, suit = 4 }
}

local hand3 = {
	{ number = 2, suit = 1 },
	{ number = 5, suit = 2 },
	{ number = 13, suit = 2 },
	{ number = 13, suit = 3 },
	{ number = 13, suit = 4 }
}

local hand4 = {
	{ number = 13, suit = 4 },
	{ number = 2, suit = 1 },
	{ number = 3, suit = 2 },
	{ number = 8, suit = 3 },
	{ number = 4, suit = 3 }
}


function testHand(hand)
	local c = deckmaker.generateKnownHand(hand)
	for k,v in ipairs(c) do
		print(v:getTextualRep())
	end

	print("counting pairs")
	print("-----------------------")
	local scores = counter.countPairs(c)

	print("counting fifteens")
	print("-----------------------")
	local fifteens = counter.countFifteens(c,scores)

	print("counting runs")
	print("-----------------------")
	local runs = counter.countRuns(c,fifteens)

	for k,v in ipairs(runs) do
		print(v:getTextualRep())
		print("-----------------------")
	end


	
end

--testCardDeck()
--testHand(hand)
--print("")
--testHand(hand2)
--print("")
--testHand(hand3)
--print("")
testHand(hand4)