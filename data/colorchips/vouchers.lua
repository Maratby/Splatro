SMODS.Voucher {
	key = "palette",
	cost = 10,
	discovered = false,
	unlocked = true,
	pos = { x = 0, y = 0 },
	atlas = "SplatVouchers",
	config = { rarity = 1, slots = 1 },
	requires = {},
	loc_vars = function(self, info_queue)
		return { vars = { self.config.slots } }
	end,
	redeem = function(self)
		G.consumeables.config.card_limit = G.consumeables.config.card_limit + self.config.slots
	end,
	---cryptid trade spectral compatibility (purely because it was really easy to do)
	unredeem = function(self)
		G.consumeables.config.card_limit = G.consumeables.config.card_limit - self.config.slots
	end
}

SMODS.Voucher {
	key = "acht",
	cost = 15,
	discovered = false,
	unlocked = true,
	pos = { x = 0, y = 1 },
	atlas = "SplatVouchers",
	---rarity compatibility with Betmma Vouchers purely because it was really easy to do
	config = { rarity = 3 },
	requires = {"v_splat_palette"},
	redeem = function(self)
		local exist = true
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and context.beat_boss then
			local has_chip = false
			local validchoices = {}
			for index, value in ipairs(G.consumeables.cards) do
				if value.ability.set == "c_chip" then
					has_chip = true
				end
			end
			if has_chip then
				for index, value in ipairs(G.consumeables.cards) do
					if value.ability.set == "c_chip" and not (value.edition and value.edition.negative) then
						validchoices[#validchoices + 1] = index
					end
				end
				if #validchoices > 0 then
					G.consumeables.cards[pseudorandom_element(validchoices)]:set_edition({ negative = true }, nil)
				end
			end
		end
	end
}

SMODS.Voucher {
	key = "cipher",
	cost = 10,
	discovered = false,
	unlocked = true,
	pos = { x = 1, y = 0 },
	atlas = "SplatVouchers",
	config = { rarity = 1, extra = 2 },
	requires = {},
	loc_vars = function(self, info_queue)
		return { vars = { self.config.slots } }
	end,
	redeem = function(self)
		G.GAME.c_chip_rate = self.config.extra
	end,
	---cryptid trade spectral compatibility (purely because it was really easy to do)
	unredeem = function(self)
		G.GAME.c_chip_rate = 0
	end
}

SMODS.Voucher {
	key = "lockers",
	cost = 15,
	discovered = false,
	unlocked = true,
	pos = { x = 1, y = 1 },
	atlas = "SplatVouchers",
	config = { rarity = 1, extra = 2 },
	requires = {"v_splat_cipher"},
	loc_vars = function(self, info_queue)
		return { vars = { self.config.slots } }
	end,
	redeem = function(self)
		G.GAME.c_chip_rate = self.config.extra
	end,
	unredeem = function(self)
		G.GAME.c_chip_rate = 0
	end
}

--- thanks N' from JoyousSpring and other mods


--- 1 Week after writing this code (2 months after writing color chip code) I have realised that I did not need to
--- manually add the pearl drone G.GAME.drone_tally incrementing to the individual add_to_deck of every color chip
--- I could've done it like I did this, but now I'm too lazy to remove it.
local set_ability_ref = Card.set_ability
function Card:set_ability(...)
    local ret = set_ability_ref(self, ...)
    if G.GAME.used_vouchers.v_splat_lockers and (self.ability and self.ability.set) and self.ability.set == "c_chip" and self.area then
		self:set_edition(poll_edition("splattack", nil, true, true, { "e_foil", "e_holo", "e_polychrome", "e_negative" }))
	end
    return ret
end