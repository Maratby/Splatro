SMODS.Blind {
    key = "overlorder",
    discovered = true,
    unlocked = true,
    dollars = 5,
    mult = 1.5,
    pos = { x = 0, y = 0 },
    boss = { min = 3 },
    atlas = "SplatBlinds",
    boss_colour = HEX("f4e1d7"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.setting_blind then
                self.config.original_score = self.config.original_score or G.GAME.blind.chips
                for i = 1, #G.consumeables.cards do
                    G.GAME.blind.chips = G.GAME.blind.chips * 1.5
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                end
            end
            if context.using_consumeable then
                self.config.original_score = self.config.original_score or G.GAME.blind.chips
                G.GAME.blind.chips = G.GAME.blind.chips * 1.5
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            end
        end
        if context.blind_disabled then
            G.GAME.blind.chips = self.config.original_score or G.GAME.blind.chips
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        end
    end
}
