--[[pod_format="raw",created="2024-03-21 03:40:46",modified="2024-03-24 21:46:20",revision=2444]]
--[[

0.1.0	
function card backs?
	if a card has a function, then call that function instead of just 
pull game mode scripts from appdata?
title image

? rect to rect collision instead of point to rect

use local instead of putting everything in game_load()?
switch to userdata for some of the structures (it's much faster)

0.2.0?
transition
	use pget to sample colors and then use circfill to grow and fill the screen

Add script dedicated to card sprite generation.
	use nine_slice to generate base
	make a cut out of the card backs
		they should be 100x100 pixels each
		focusing on 41x56 pixels in the center being the normal sprite
		
Add face card sprites

stack on_highlight rule function
	per card and per 
	
stack highlight_check function
	essentially determines if the stack triggers the highlight rule
	should be able to handle a held stack

(highlight rule and check are going to be used for managing a hand)








]]