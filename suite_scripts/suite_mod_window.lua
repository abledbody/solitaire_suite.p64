--[[pod_format="raw",created="2024-07-01 20:21:05",modified="2024-07-02 00:45:58",revision=1008]]

local game_list_buttons = {}
local game_list_y_start = 0
local game_list_width = 150
local game_sel_buttons = {}
local game_sel_desc = ""
local game_sel_current = nil

local game_list_all = {
	{name = "test game"},
	{name = "test game 2"},
}

local function save_game_list()
	store("/appdata/solitaire_suite/mod_list.pod", game_list_all)
end

local function cull_version(id)
	return split(id, "-")[1]
end

local function find_game_by_id(id)
	id = cull_version(id)
	
	for g in all(game_list_all) do
		if cull_version(g.id) == id then
			return g
		end
	end
end

local function attempt_add_game(id)
	-- TODO search current list for game
	-- if already exists, remove it
	
	-- TODO fetch game
	-- check game is valid
	
	-- be careful of loading own games from #solitaire_suite
	
	-- can't do individual games since there are card backs that can be added
	add(game_list_all, {
		id = id, -- id cart is loaded
		name = "aaa", -- name of game?
		author = "bbb", -- author(s) of game
		games_path = "",
		card_backs_path = "",
	})

	save_game_list()
end


function suite_open_mod_manager()
	game_list_all = fetch("/appdata/solitaire_suite/mod_list.pod") or {}
	save_game_list()

	suite_window_init("Mod Manager")
	
	game_sel_desc = ""
	game_list_buttons = {}
	game_sel_buttons = {}
	game_sel_current = nil
	
	add_games_list()

	add_text_field()

	suite_window_footer("Exit Mod Manager")
end

	
local function destroy_button_list(list)
	for b in all(list) do
		b:destroy()
		del(list, b)
		del(suite_window_buttons)
	end
end

local function game_list_button_draw(b)
	b.t = max(b.t - 0.1)
	local x2, y2 = b.x + b.width-1, b.y + b.height-1
	local yt = b.t > 0 and 1 or 0
	
	rectfill(b.x, y2, x2, y2, 20)
	rectfill(b.x, b.y+yt, x2, y2+yt-1, (b.highlight or b.text == game_sel_current) and 31 or 4)
		
	print(b.text, b.x+5, b.y+5+yt, 20)
	print(b.text, b.x+5, b.y+4+yt, 7)
end

local function game_list_button_on_click(b)
	b.t = 1
	game_sel_desc = b.text
	game_sel_current = b.text
	
	destroy_button_list(game_sel_buttons)
	
	set_suite_window_layout_y(game_list_y_start + 110)
	
	local buttons = suite_window_add_buttons({
			{"Update", function()end},
			{"Remove", function()end}
		}, true)
		
	for b in all(buttons) do
		add(game_sel_buttons, b)
	end
end

local function update_game_list()
	destroy_button_list(game_list_buttons)
	
	local y = game_list_y_start+1
	local h = 17	

	for i = 1,#game_list_all do
		local g = game_list_all[i]
		
		local b = button_new({
			x = 10,
			y = y,
			width = game_list_width, height = h,
			draw = game_list_button_draw,
			on_click = game_list_button_on_click,
			group = 3,
			always_active = true
		})
		
		b.text = g.name
		b.t = 0
		y += h
		
		suite_window_button_add(b)
	end
end
	
function add_games_list()
	local y = get_suite_window_layout_y()

	game_list_width = 150
	game_list_y_start = y
	
	update_game_list()
	
	add(suite_window_elements, function()
		
	--	rect(10, 10, 9+game_list_width, 140, 6)
		-- inside
		rectfill(9, 9, 10+game_list_width, 141, 21)
		rect(9, 9, 10+game_list_width, 9, 20)	
	
		-- border
		rect(8, 8, 11+game_list_width, 142, 4)
		rect(7, 7, 12+game_list_width, 143, 4)
		rect(6, 6, 13+game_list_width, 144, 4)
		
		-- outline
		rect(5, 6, 5, 145, 20)
		rect(14+game_list_width, 6, 14+game_list_width, 145, 20)
		rect(6, 5, 13+game_list_width, 5, 20)
		
		-- bottom
		rect(6, 145, 13+game_list_width, 145, 20)
		rect(6, 146, 13+game_list_width, 146, 21)
		
		print(game_sel_desc, game_list_width + 20, game_list_y_start + 5)
	
	end)
	
	y += 140
	set_suite_window_layout_y(y)
end

function add_text_field()

	local y = get_suite_window_layout_y()
	
	local g = create_gui()
	local w, h = 117, 13
	local nav_text = g:attach_text_editor{
		x=10,y=4+y,
		width=w,
		height=h,
		max_lines = 1,	
		key_callback = { 
			enter = function()end,
			tab = function()end
		},
		bgcol = 21,
		fgcol = 6,
	}
			
	add(suite_window_elements, function()	

		rectfill(9, 3+y, 10+w, 3+y, 20)
		rect(9, 2+y, 10+w, 4+y+h, 4)
		rect(8, 1+y, 11+w, 5+y+h, 20)
		rectfill(8, 6+y+h, 11+w, 6+y+h, 21)

		-- due to the text field not being affected by camera()
		local cx, cy = camera()
		g.x, g.y = -cx, -cy
		camera(cx, cy)	

		g:update_all()
		g:draw_all()
		
		if #nav_text.get_text()[1] == 0 then
			print("Input cart ID...", 14, y+7, 4)
		end
	end)

	local b = suite_window_add_buttons({{"Add", function()
			notify("TODO: add " .. tostr(nav_text.get_text()[1]))
		end}}, true)
	
	b[1].base_x -= 131
	b[1].base_y += 1

	set_suite_window_layout_y(y+21)
end
