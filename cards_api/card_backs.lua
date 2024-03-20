--[[pod_format="raw",created="2024-03-20 14:39:52",modified="2024-03-20 17:25:51",revision=577]]


-- todo, fetch cards in folder in appdata

-- sprite can be a number or userdata
--[[ !!! warning !!! 
While sprite card backs are usually 45x60,
They will likely become 100x100 sprites without the card boarder.
This is so that a card back can be generated for most card sizes
]]

-- id can be a number or string, just make sure it doesn't match any other card's
-- used to save card back selected
card_back_info = {
	{ 
		sprite = 10, artist = "Werxzy", id = 1,
		lore = "Picotron Icon"
	},
	{ 
		sprite = 18, artist = "Werxzy", id = 2,
		lore = "Zep's Jelpi from Pico-8"
	},
	{ 
		sprite = 19, artist = "Werxzy", id = 3,
		lore = "Box from SokoCode by Werxzy"
	},
	{ 
		sprite = 1, artist = "Werxzy", id = 4,
		lore = "The first card back!"
	},
	{ 
		sprite = 35, artist = "Werxzy", id = 5,
		lore = "Card back created from there being too many blue card backs."
	},
	{ 
		sprite = 36, artist = "Werxzy", id = 6,
		lore = "Referenced from Window's original solitaire card back."
	},
	{ 
		sprite = 21, artist = "Werxzy", id = 7,
		lore = "Referenced from Window's original solitaire card back."
	}
}

