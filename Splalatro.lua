----------------------------------------------
------------MOD CODE -------------------------

Splalatro = {}
Splalatro_Mod = SMODS.current_mod
Splalatro_Config = Splalatro_Mod.config


SMODS.Atlas {
    key = "Splalatro",
    path = "jokers.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
	key = "modicon",
	path = "SplalatroIcon.png",
	px = 34,
	py = 34,
}

SMODS.Atlas {
    key = "SplatEnhancers",
    ---too lazy to change file name :yawn:
    path = "seals.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "SplatConsumables",
    path = "Consumables.png",
    px = 71,
    py = 95,
}

if Splalatro_Config.SplalatroToggle then
	SMODS.load_file("data/Jokers.lua")()
end

if Splalatro_Config.SplatEnhancers then
	SMODS.load_file("data/Enhancers.lua")()
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

---Config UI

Splalatro_Mod.config_tab = function()
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
							create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = Splalatro_Config, ref_value = "SplalatroToggle" },
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
							create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = Splalatro_Config, ref_value = "SplatEnhancers" },
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
							create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = Splalatro_Config, ref_value = "value3" },
						}
					},
					{
						n = G.UIT.C,
						config = { align = "c", padding = 0 },
						nodes = {
							{ n = G.UIT.T, config = { text = "Placeholder", scale = 0.3, colour = G.C.UI.TEXT_LIGHT } },
						}
					},
				}
			},


		}
	}
end

----------------------------------------------
------------MOD CODE END----------------------