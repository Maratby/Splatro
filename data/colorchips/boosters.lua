
SMODS.Booster{
    key = 'chip_normal_1',
    name = 'Chip Pack',
    pos = {x = 0, y = 1},
    cost = 3,
    config = {extra = 3, choose = 1},
    group_key = 'k_c_chip_pack',
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.choose, self.config.extra } }
    end,
    create_card = function(self, card, i)
        return {set = "c_chip", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "spl"}
    end,
    weight = 0.5,
    kind = 'c_chip',
    atlas = "SplatConsumables"
}

SMODS.Booster{
    key = 'chip_normal_2',
    name = 'Chip Pack',
    pos = {x = 1, y = 1},
    cost = 3,
    config = {extra = 3, choose = 1},
    group_key = 'k_c_chip_pack',
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.choose, self.config.extra } }
    end,
    create_card = function(self, card, i)
        return {set = "c_chip", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "spl"}
    end,
    weight = 0.5,
    kind = 'c_chip',
    atlas = "SplatConsumables"
}

SMODS.Booster{
    key = 'chip_jumbo_1',
    name = 'Jumbo Chip Pack',
    pos = {x = 2, y = 1},
    cost = 6,
    config = {extra = 4, choose = 1},
    group_key = 'k_c_chip_pack',
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.choose, self.config.extra } }
    end,
    create_card = function(self, card, i)
        return {set = "c_chip", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "spl"}
    end,
    weight = 0.21,
    kind = 'c_chip',
    atlas = "SplatConsumables"
}

SMODS.Booster{
    key = 'chip_jumbo_2',
    name = 'Jumbo Chip Pack',
    pos = {x = 3, y = 1},
    cost = 6,
    config = {extra = 4, choose = 1},
    group_key = 'k_c_chip_pack',
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.choose, self.config.extra } }
    end,
    create_card = function(self, card, i)
        return {set = "c_chip", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "spl"}
    end,
    weight = 0.21,
    kind = 'c_chip',
    atlas = "SplatConsumables"
}

SMODS.Booster{
    key = 'chip_mega_1',
    name = 'Mega Chip Pack',
    pos = {x = 4, y = 1},
    cost = 9,
    config = {extra = 6, choose = 2},
    group_key = 'k_c_chip_pack',
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.choose, self.config.extra } }
    end,
    create_card = function(self, card, i)
        return {set = "c_chip", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "spl"}
    end,
    weight = 0.14,
    kind = 'c_chip',
    atlas = "SplatConsumables"
}

---tags are in here too

SMODS.Tag {
    key = "chip_tag",
    min_ante = 0,
    discovered = false,
    atlas = "SplatTags",
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_splat_chip_mega_1
    end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.SECONDARY_SET.Spectral, function()
                local booster = SMODS.create_card { key = 'p_splat_chip_mega_1', area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}