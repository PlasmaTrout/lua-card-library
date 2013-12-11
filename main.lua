local deckmaker = require "deckmaker"
local counter = require "cribbage_counter"

function testCardDeck()
	local c = deckmaker.generateOrderedDeck()
	local shuf1 = deckmaker.shuffle(c,100)
	local hand = deckmaker.dealHand(shuf1,5)

	counter.scoreHand(hand)
end

local failcase1 = {
	{ number = 6, suit = 3 },
	{ number = 8, suit = 3 },
	{ number = 7, suit = 1 },
	{ number = 2, suit = 3 },
	{ number = 2, suit = 2 }
}




testCardDeck()
print("")
--counter.scoreHand(failcase1)
--testHand(hand)
--print("")
--testHand(hand2)
--print("")
--testHand(hand3)
--print("")
--counter.scoreHand(hand4)