lua-card-library
================

This small set of lua classes was originally created as a boilerplate for some Corona games that never got off the ground. Well, at least not yet.

The basic use is shown in the main.lua file which is only really used to test some scenarios:

```
local deckmaker = require "deckmaker"
local counter = require "cribbage_counter"

function testCardDeck()
	local c = deckmaker.generateOrderedDeck()
	local shuf1 = deckmaker.shuffle(c,100)
	local hand = deckmaker.dealHand(shuf1,5)

	counter.scoreHand(hand)
end
```
