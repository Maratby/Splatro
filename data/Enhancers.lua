---yes hi hello


---Golden Egg Seal and support

SMODS.Seal({
    name = "Golden Egg",
    key = "goldenegg",
    badge_colour = HEX("FFFF00"),
    config = { extra = { chips = 5, xchips = 0.05 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.chips, 1 + self.config.extra.xchips } }
    end,
    atlas = "SplatEnhancers",
    pos = { x = 2, y = 0 },
    calculate = function(self, card, context)
        if not context.repetition_only and context.main_scoring and context.cardarea == G.play then
            local seals = 0
            for index, value in ipairs(G.play.cards) do
                if value:get_seal() == "splat_goldenegg" then
                    seals = seals + 1
                end
            end
            return {
                chips = self.config.extra.chips * seals,
                x_chips = 1 + (self.config.extra.xchips * seals)
            }
        end
    end,
})

SMODS.Joker {
    key = "the_company",
    name = "The Company",
    rarity = 2,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    pos = { x = 1, y = 0 },
    atlas = "Splatro",
    cost = 9,
    config = {},
    ability_name = "The Company",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "golden_s_egg" }
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.after and (G.GAME.chips + hand_chips * mult) > G.GAME.blind.chips then
            local text, disp_text, poker_hands, scoring_hand, non_loc_disp_text = G.FUNCS.get_poker_hand_info(G.play
                .cards)
            local loops = math.min(G.GAME.current_round.hands_left, #scoring_hand)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3,
                blockable = true,
                blocking = true,
                func = function()
                    for index = 1, loops do
                        if not scoring_hand[index].debuff and scoring_hand[index]:get_seal() ~= "splat_goldenegg" then
                            scoring_hand[index]:set_seal("splat_goldenegg")
                            card:juice_up()
                        end
                    end
                    return true;
                end
            }))
        end
    end
}

SMODS.Consumable {
    set = "Spectral",
    key = "overtime",
    name = "Overtime",
    config = {
        max_highlighted = 2,
        extra = 'splat_goldenegg',
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "golden_s_egg" }
        return { vars = { (card.ability or self.config).max_highlighted } }
    end,
    cost = 6,
    atlas = "SplatConsumables",
    pos = { x = 3, y = 0 },
    use = function(self, card, area, copier)
        for i = 1, math.min(#G.hand.highlighted, card.ability.max_highlighted) do
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i]:set_seal(card.ability.extra, nil, true)
                    return true
                end
            }))

            delay(0.5)
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all(); return true
            end
        }))
    end
}

---Mammalized Enhancement and support

SMODS.Joker {
    key = "subject_3",
    name = "Subject n°3",
    rarity = 2,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    pos = { x = 2, y = 0 },
    atlas = "Splatro",
    cost = 9,
    config = { rounds = 0 },
    ability_name = "Subject 3",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_splat_mammalized
        return { vars = { card.ability.rounds } }
    end,
    calculate = function(self, card, context)
        if not context.blueprint then
            if context.end_of_round and context.main_eval then
                card.ability.rounds = card.ability.rounds + 1
                return {
                    message = card.ability.rounds .. "/2"
                }
            end
            if context.selling_card and context.card == card and card.ability.rounds >= 2 and G.hand then
                for i = 1, #G.hand.cards do
                    if not G.hand.cards[i].debuffed then
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.15,
                            func = function()
                                local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
                                G.hand.cards[i]:flip(); play_sound('card1', percent); G.hand.cards[i]:juice_up(0.3, 0.3)
                                G.hand.cards[i]:set_ability(G.P_CENTERS.m_splat_mammalized, true, false)
                                return true
                            end
                        }))
                    end
                end
                for i = 1, #G.hand.cards do
                    if not G.hand.cards[i].debuffed then
                        local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.15,
                            func = function()
                                G.hand.cards[i]:flip(); play_sound('tarot2', percent, 0.6); G.hand.cards[i]:juice_up(0.3,
                                    0.3); return true
                            end
                        }))
                    end
                end
            end
        end
    end
}

SMODS.Enhancement({
    name = "Mammalized",
    key = "mammalized",
    badge_colour = HEX("FFFF00"),
    config = {},
    weight = 2,
    atlas = "SplatEnhancers",
    pos = { x = 1, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.repetition then
            local tempreps = 0
            for index, value in ipairs(G.hand.cards) do
                if SMODS.has_enhancement(value, "m_splat_mammalized") then
                    tempreps = tempreps + 1
                end
            end
            return {
                message = localize("k_again_ex"),
                repetitions = tempreps,
                card = card,
            }
        end
    end,
})

SMODS.Consumable {
    set = "Tarot",
    name = "Apocalypse",
    key = "apocalypse",
    order = 1,
    pos = { x = 0, y = 0 },
    config = { mod_conv = "m_splat_mammalized", max_highlighted = 2 },
    atlas = "SplatConsumables",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_splat_mammalized
        return { vars = { card and card.ability.max_highlighted or self.config.max_highlighted } }
    end,
}

---Sanitized Enhancement and supporrt

SMODS.Enhancement({
    name = "Sanitized",
    key = "sanitized",
    badge_colour = HEX("27e097"),
    config = { x_chips = 1.3, expire = 5 },
    weight = 5,
    atlas = "SplatEnhancers",
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.x_chips, card.ability.expire } }
    end,
    calculate = function(self, card, context)
        if context.after and context.cardarea == G.play and not card.debuff then
            card.ability.expire = card.ability.expire - 1
        end
        if context.destroying_card then
            if context.destroying_card == card and card.ability.expire <= 1 then
                return {
                    remove = true
                }
            end
        end
    end,
})

SMODS.Joker {
    name = "Savior",
    key = "savior",
    rarity = 2,
    atlas = "Splatro",
    discovered = true,
    blueprint_compat = false,
    config = { extra = { suit = "Hearts" } },
    pos = { x = 3, y = 0 },
    cost = 9,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_splat_sanitized
        return { vars = { card.ability.extra.suit, colours = { G.C.SUITS[card.ability.extra.suit] } } }
    end,
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.suit = splat_randsuits(1)
    end,
    calculate = function(self, card, context)
        if not context.blueprint then
            if context.after and G.GAME.current_round.hands_played == 0 then
                for index, value in ipairs(G.play.cards) do
                    if not value.debuff and value:is_suit(card.ability.extra.suit) then
                        value:set_ability(G.P_CENTERS.m_splat_sanitized, nil, true)
                        value.ability.expire = value.ability.expire + 1
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                value:juice_up()
                                card:juice_up()
                                return true
                            end
                        }))
                    end
                end
            end
            if context.end_of_round and context.main_eval then
                card.ability.extra.suit = splat_randsuits(1)
            end
        end
    end
}

SMODS.Consumable {
    set = "Tarot",
    name = "Cleansing",
    key = "cleansing",
    order = 1,
    pos = { x = 1, y = 0 },
    config = { mod_conv = "m_splat_sanitized", max_highlighted = 2 },
    atlas = "SplatConsumables",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_splat_sanitized
        return { vars = { card and card.ability.max_highlighted or self.config.max_highlighted } }
    end,
}

---Order Seal and support

SMODS.Seal({
    name = "Order",
    key = "order",
    badge_colour = HEX("907970"),
    config = { extra = { xmult = 1.25 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.xmult } }
    end,
    atlas = "SplatEnhancers",
    pos = { x = 3, y = 0 },
    calculate = function(self, card, context)
        if not context.repetition_only and context.main_scoring and context.cardarea == G.play then
            if next(context.poker_hands["Straight"]) or next(context.poker_hands["Flush"]) then
                return {
                    x_mult = self.config.extra.xmult
                }
            end
        end
    end,
})

SMODS.Consumable {
    set = "Spectral",
    key = "conformity",
    name = "Conformity",
    config = {
        max_highlighted = 2,
        extra = 'splat_order',
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "splat_s_conformity" }
        return { vars = { (card.ability or self.config).max_highlighted } }
    end,
    cost = 6,
    atlas = "SplatConsumables",
    pos = { x = 4, y = 0 },
    use = function(self, card, area, copier)
        for i = 1, math.min(#G.hand.highlighted, card.ability.max_highlighted) do
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i]:set_seal(card.ability.extra, nil, true)
                    return true
                end
            }))

            delay(0.5)
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all(); return true
            end
        }))
    end
}

SMODS.Joker {
    key = "portal",
    name = "Portal",
    rarity = 2,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    pos = { x = 4, y = 0 },
    atlas = "Splatro",
    cost = 9,
    config = {},
    ability_name = "Portal",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "splat_s_conformity" }
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if not context.blueprint then
            if context.after then
                local cardranks = {
                }
                ---Collect ranks of playijng cards
                for index, value in ipairs(G.play.cards) do
                    if value:get_id() ~= nil and not SMODS.has_no_rank(value) then
                        if cardranks["rank_" .. value:get_id()] == nil then
                            ---Preventing a crash by setting dummy values beforehand
                            cardranks["rank_" .. value:get_id()] = {
                                count = 0,
                                rank = -1
                            }
                        end
                        cardranks["rank_" .. value:get_id()].count = (cardranks["rank_" .. value:get_id()].count + 1) or
                            0
                        cardranks["rank_" .. value:get_id()].rank = value:get_id()
                    end
                end
                local largest = {
                    ---Setting dummy values for largest stored.
                    count = 0,
                    rank = -1
                }
                ---Checks if current recorded Largest either
                ---1. Has a smaller Count value than the current entry in Cardranks (aka, more frequently appearing rank than current stored largest
                ---2. Has an equal count value to the current entry in Cardranks AND has a higher Rank value,, prioritising higher Ranked cards if two ranks are equal
                for index, value in pairs(cardranks) do
                    if cardranks[index].count > largest.count or (cardranks[index].count == largest.count and cardranks[index].rank > largest.rank) then
                        largest = cardranks[index]
                    end
                end
                for index, value in ipairs(G.play.cards) do
                    if value:get_id() == largest.rank and not SMODS.has_no_rank(value) then
                        G.E_MANAGER:add_event(Event({
                            blockable = true,
                            blocking = true,
                            func = function()
                                if not value.debuff and value:get_seal() ~= "splat_order" then
                                    value:set_seal("splat_order")
                                    card:juice_up()
                                end
                                return true;
                            end
                        }))
                    end
                end
            end
        end
    end
}
