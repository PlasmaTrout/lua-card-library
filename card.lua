
Card = {}

function Card:new(number,suit)

	local playingCard = {
		value = 0
	}

	local suits = { "♣","♦","♥","♠"}
	local labels = { "A","2","3","4","5","6","7","8","9","10","J","Q","K"}
	local order = {1,2,3,4,5,6,7,8,9,10,11,12,13}
	local values = { 1,2,3,4,5,6,7,8,9,10,10,10,10}

	function playingCard:initialize()
		playingCard.number= number
		playingCard.suit = suit
		playingCard.deckOrder = number+suit
		playingCard.suitChar = suits[suit]
	end

	function playingCard:getName()
		return labels[number]
	end

	function playingCard:getOrder()
		return number
	end

	function playingCard:getSuit()
		return suits[suit]
	end

	function playingCard:getValue()
		return values[number]
	end

	function playingCard:getTextualRep()
		return self:getName()..self:getSuit().." = "..self:getValue()
	end
	
	playingCard:initialize( )

	return playingCard

end