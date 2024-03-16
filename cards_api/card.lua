--[[pod_format="raw",created="2024-03-16 12:26:44",modified="2024-03-16 16:56:43",revision=1080]]

all_suits = {
	--"Spades",
	--"Hearts",
	--"Clubs",
	--"Diamonds"
	"\|f\^:081c3e7f7f36081c",
	"\|g\^:00367f7f3e1c0800",
	"\|f\^:001c1c7f7f77081c",
	"\|g\^:081c3e7f3e1c0800"
}

all_suit_colors = {
	16,
	8,
	27,
	25
	
}

all_ranks = {
	"A",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"10",
	"J",
	"Q",
	"K"
}

card_width = 45
card_height = 60
card_gap = 4

cards_all = {}

function card_new(sprite, x, y, a)
	x = x or 0
	y = y or 0
	a = a or 0
	return add(cards_all, {
		x = smooth_val(x, 0.7, 0.1), 
		y = smooth_val(y, 0.7, 0.1), 
		a = smooth_angle(a, 0.9, 0.2),
		x_to = x,
		y_to = y,
		a_to = a,
		sprite = sprite
		})
end

function card_draw(c)
	local sprite, x, y, width, height, angle = c.a_to == 0.5 and 1 or c.sprite, c.x(), c.y(), card_width, card_height, c.x"vel" / -60 + c.a()
	local dx, dy = cos(angle), -sin(angle)*0.5
	if dx < 0 then
		sprite = 1
	end
	
	y -= dy * width / 2
		
	if abs(dy*card_width) < 1 then
		sspr(sprite, 0, 0, width, height, x, y)
	else
		local x = x - dx*width/2 + width/2
		local sx = 0
		
		local last_drawn = -999
		for x2 = 0,width - 1 do
			-- only draw one vertical slice at a time
			-- could do this mathmatically, but nah :)
			if x\1 ~= last_drawn then
				sspr(sprite, sx, 0, 1, height, x, y)
				last_drawn = x\1
			end
			sx += 1
			x += dx
			y += dy
		end
	end
end

function card_update(c)
	c.x(c.x_to)
	c.y(c.y_to)
	c.a(c.a_to)
end

function card_to_top(c)
	add(cards_all, del(cards_all, c))
end
