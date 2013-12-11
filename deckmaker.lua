local deckmaker = {}

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

function deckmaker.shuffle(deck,times)
	local result = deckmaker.shuffleDeck(deck)
	for i = 2,times do
		result = deckmaker.shuffleDeck(result)
	end

	return result
end

function deckmaker.dealHand(deck,cards)
	local hand = {}
	for i=1,cards do
		local card = table.remove( deck, 1 )
		table.insert( hand, card )
	end
	return hand
end

function deckmaker.shuffleDeck(deck)
	math.randomseed( os.time() )
	local cut = math.random(20,30)
	
	local side1 = {}
	local side2 = {}

	for i = 1,cut do
		table.insert(side1,deck[i])
	end

	for i = cut+1,52 do
		table.insert(side2,deck[i])
	end

	local shuffledDeck = {}

	--local indexToInsert = cut+1
	
	while(#side1 > 0) do
		local card = table.remove(side1,1)
		local position = math.random(1,#side2)
		--print(position)
		table.insert(side2,position,card)
	end


	return side2

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

