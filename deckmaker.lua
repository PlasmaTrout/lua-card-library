local deckmaker = {}
require "score_item"

function deckmaker.generateOrderedDeck()
	require "card"
	local cards = {}
	local counter = 1
	for i = 1,13 do
		for s = 1,4 do
			local card = Card:new(i,s)
			cards[counter] = card
			counter = counter + 1
		end
	end
	return cards
end

function deckmaker.generateKnownHand(hand)
	require "card"
	local cards = {}
	for k,v in ipairs(hand) do
		local card = Card:new(v.number,v.suit)
		table.insert(cards,card)
	end
	return cards
end

return deckmaker

