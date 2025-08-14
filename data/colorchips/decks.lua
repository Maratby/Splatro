SMODS.Back {
	key = "spire_deck",
	pos = { x = 0, y = 0 },
    atlas = "SplatDecks",
	unlocked = true,
	discovered = true,
	config = { rounds = 3, tally = 0 },
	loc_vars = function(self)
		return { vars = { self.config.rounds } }
	end,
	apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.win_ante = G.GAME.win_ante + 1
				G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
				G.GAME.used_vouchers.v_splat_palette = true
				---splat_redeem_voucher("v_splat_palette", 0.3)
				return true
			end
		}))
	end,
    calculate = function(self,card,context)
        if context.end_of_round and context.beat_boss and context.main_eval then
            self.config.tally = self.config.tally + 1
            if self.config.tally >= self.config.rounds then
                G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
                self.config.tally = 0
            end
        end
    end,
}