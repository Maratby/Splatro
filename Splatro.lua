----------------------------------------------
------------MOD CODE -------------------------

Splatro = {}
Splatro_Mod = SMODS.current_mod
Splatro_Config = Splatro_Mod.config

---Define atlases
SMODS.Atlas {
    key = "Splatro",
    path = "jokers.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
	key = "modicon",
	path = "SplatroIcon.png",
	px = 34,
	py = 34,
}

SMODS.Atlas {
    key = "SplatTags",
    path = "tags.png",
	px = 34,
	py = 34,
}

SMODS.Atlas {
    key = "SplatEnhancers",
    ---too lazy to change internal file name :yawn:
    path = "seals.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "SplatConsumables",
    path = "stuff.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
	key = "SplatVouchers",
	path = "vouchers.png",
	px = 71,
	py = 95,
}

SMODS.Atlas {
	key = "SplatDecks",
	path = "decks.png",
	px = 71,
	py = 95,
}

---we have one sound

SMODS.Sound({
	key = "probability_st",
	path = "probability.ogg"
})

---Adds a dummy function that does nothing if Talisman isn't loaded, lets me avoid having Talisman be a dependency
---and avoid crashes if Talisman is loaded
to_big = to_big or function(num)
	return num
end

if Splatro_Config.SplatroToggle then
	SMODS.load_file("data/Jokers.lua")()
end

if Splatro_Config.SplatEnhancers then
	SMODS.load_file("data/Enhancers.lua")()
end

if Splatro_Config.ColorChips then
	SMODS.load_file("data/colorchips/main.lua")()
end
---A function for grabbing random vanilla or modded Suit(s)
function splat_randsuits(a)
	if a == 2 then
		local j = pseudorandom_element(SMODS.Suits, pseudoseed("something"))
		local k = pseudorandom_element(SMODS.Suits, pseudoseed("something"))
		return j.name, k.name
	else
		local j = pseudorandom_element(SMODS.Suits, pseudoseed("something"))
		return j.name
	end
end

---A function for redeeming vouchers easily

function splat_redeem_voucher(local_voucher, _delay)
	local voucher_card = SMODS.create_card({ area = G.play, key = local_voucher })
	voucher_card:start_materialize()
	voucher_card.cost = 0
	G.play:emplace(voucher_card)
	delay(0.3)
	voucher_card:redeem()
	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		delay = _delay or 0.8,
		func = function()
			voucher_card:start_dissolve()
			return true
		end
	}))
end

---Config UI

Splatro_Mod.config_tab = function()
	return {
		n = G.UIT.ROOT,
		config = { align = "m", r = 0.1, padding = 0.1, colour = G.C.BLACK, minw = 8, minh = 6 },
		nodes = {
			{ n = G.UIT.R, config = { align = "cl", padding = 0, minh = 0.1 }, nodes = {} },

			{
				n = G.UIT.R,
				config = { align = "cl", padding = 0 },
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cl", padding = 0.05 },
						nodes = {
							create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = Splatro_Config, ref_value = "SplatroToggle" },
						}
					},
					{
						n = G.UIT.C,
						config = { align = "c", padding = 0 },
						nodes = {
							{ n = G.UIT.T, config = { text = "Jokers (Currently does nothing)", scale = 0.45, colour = G.C.UI.TEXT_LIGHT } },
						}
					},
				}
			},

			{
				n = G.UIT.R,
				config = { align = "cl", padding = 0 },
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cl", padding = 0.05 },
						nodes = {
							create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = Splatro_Config, ref_value = "SplatEnhancers" },
						}
					},
					{
						n = G.UIT.C,
						config = { align = "c", padding = 0 },
						nodes = {
							{ n = G.UIT.T, config = { text = "Enhancements, Seals and Support", scale = 0.45, colour = G.C.UI.TEXT_LIGHT } },
						}
					},
				}
			},

			{
				n = G.UIT.R,
				config = { align = "cl", padding = 0 },
				nodes = {
					{
						n = G.UIT.C,
						config = { align = "cl", padding = 0.05 },
						nodes = {
							create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = Splatro_Config, ref_value = "ColorChips" },
						}
					},
					{
						n = G.UIT.C,
						config = { align = "c", padding = 0 },
						nodes = {
							{ n = G.UIT.T, config = { text = "Color Chips", scale = 0.3, colour = G.C.UI.TEXT_LIGHT } },
						}
					},
				}
			},


		}
	}
end

----------------------------------------------
------------MOD CODE END----------------------