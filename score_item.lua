ScoreItem = {}

function ScoreItem:new(type,value,cards)

	local scores = {}

	function scores:initialize()
		scores.value = value
		scores.cards = cards
		scores.type = type
	end

	function scores:getTextualRep()
		for k,v in pairs(cards) do
			io.write(v:getTextualRep().." ")
		end
		io.write(type.." scores "..value)
	end

	scores:initialize( )

	return scores

end