--- Chip Color

local splatlc = loc_colour
function loc_colour(_c, _default)
    if not G.ARGS.LOC_COLOURS then
        splatlc()
    end
    G.ARGS.LOC_COLOURS.splat_chip = HEX("e5c8b4")

    return splatlc(_c, _default)
end

---I couldn't define this value in a context or it broke
local tempxmult = 1

SMODS.ColorChip {
    key = 'power_CC',
    name = 'Power-CC',
    atlas = "color_chips",
    pos = { x = 0, y = 0 },
    config = { xmult = 0.2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.xmult } }
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
    calculate = function(self, card, context)
        if context.before then
            tempxmult = 1 + (card.ability.xmult * #G.play.cards)
        end
        if context.joker_main then
            return {
                x_mult = tempxmult
            }
        end
    end
}

SMODS.ColorChip {
    key = 'power_D4',
    name = 'Power-D4',
    atlas = "color_chips",
    pos = { x = 1, y = 0 },
    config = { mult = 3 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.mult } }
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local tally = 0
            for index, value in ipairs(G.consumeables.cards) do
                if value.ability.set == "c_chip" then
                    tally = tally + 1
                end
            end
            if context.other_card:get_id() == 3 or context.other_card:get_id() == 8 then
                card:juice_up()
                return {
                    mult = card.ability.mult * tally,
                    card = context.other_card
                }
            end
        end
    end
}

SMODS.ColorChip {
    key = 'power_E3',
    name = 'Power-E3',
    atlas = "color_chips",
    pos = { x = 2, y = 0 },
    config = { chips = 100 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.chips } }
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.blind.chips and G.GAME.chips and to_big(G.GAME.chips) < (to_big(G.GAME.blind.chips) / 2) then
            return {
                chips = card.ability.chips
            }
        end
    end
}

SMODS.ColorChip {
    key = 'mobility_FF',
    name = 'Mobility_FF',
    atlas = "color_chips",
    pos = { x = 3, y = 0 },
    config = { extra = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra } }
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local eval = function() return G.GAME.current_round.hands_played == 0 and G.GAME.current_round.discards_used == 0 end
            juice_card_until(card, eval, true)
        end
        if context.before and (G.GAME.current_round.discards_used == 0 and G.GAME.current_round.hands_played == 0) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    ease_discard(card.ability.extra)
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                        {
                            message = localize { type = 'variable', key = 'a_discard', vars = { card.ability.extra } },
                            colour =
                                G.C.RED
                        })
                    return true
                end
            }))
        elseif context.pre_discard and (G.GAME.current_round.discards_used == 0 and G.GAME.current_round.hands_played == 0) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    ease_hands_played(card.ability.extra)
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                        {
                            message = localize { type = 'variable', key = 'a_hand', vars = { card.ability.extra } },
                            colour =
                                G.C.BLUE
                        })
                    return true
                end
            }))
        end
    end
}

SMODS.ColorChip {
    key = 'mobility_A3',
    name = 'Mobility_A3',
    atlas = "color_chips",
    pos = { x = 4, y = 0 },
    config = { tally = 0, max = 5 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.tally, card.ability.max } }
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
    calculate = function(self, card, context)
        if context.skip_blind then
            card:juice_up()
            card.ability.tally = card.ability.tally + 1
            if card.ability.tally >= card.ability.max then
                card.ability.tally = card.ability.tally - card.ability.max
                ease_ante(-1)
            end
        end
    end
}

SMODS.ColorChip {
    key = 'mobility_6A',
    name = 'Mobility_6A',
    atlas = "color_chips",
    pos = { x = 5, y = 0 },
    config = { money_per_hand = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.money_per_hand } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.modifiers.money_per_hand = (G.GAME.modifiers.money_per_hand or 1) + card.ability.money_per_hand
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.modifiers.money_per_hand = G.GAME.modifiers.money_per_hand - card.ability.money_per_hand
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
}

SMODS.ColorChip {
    key = 'lucky_FF',
    name = 'Lucky-FF',
    atlas = "color_chips",
    pos = { x = 0, y = 1 },
    config = { odds = 4 },
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.odds, 'Splatro-Lucky-FF')
        return { vars = { new_numerator, new_denominator } }
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, 'IdleDeathGamble', 1, card.ability.odds, 'Splatro-Lucky-FF') then
                return {
                    dollars = 3
                }
            end
        end
    end
}

SMODS.ColorChip {
    key = 'lucky_AF',
    name = 'Lucky-AF',
    atlas = "color_chips",
    pos = { x = 1, y = 1 },
    config = { odds = 4 },
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.odds, 'Splatro-Lucky-AF')
        return { vars = { new_numerator, new_denominator } }
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
           if SMODS.pseudorandom_probability(card, 'seedling', 1, card.ability.odds, 'Splatro-Lucky-AF') and #G.consumeables.cards < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local _card = create_card('c_chip', G.consumeables, nil, nil, nil, nil, nil, nil)
                        _card:add_to_deck()
                        G.consumeables:emplace(_card)
                        G.GAME.consumeable_buffer = 0
                        card_eval_status_text(card, 'extra', nil, nil, nil,
                            { message = localize('k_plus_chip'), colour = G.C.splat_chip })
                        return true
                    end
                }))
            end
        end
    end
}

SMODS.ColorChip {
    key = 'lucky_78',
    name = 'Lucky-78',
    atlas = "color_chips",
    pos = { x = 1, y = 1 },
    config = { odds = 2, xmult = 2 },
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.odds, 'Splatro-Lucky-78')
        return { vars = { new_numerator, new_denominator, card.ability.xmult } }
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if SMODS.pseudorandom_probability(card, 'seedle', 1, card.ability.odds, 'Splatro-Lucky-78') then
                local prevxmult = card.ability.xmult
                card.ability.xmult = math.floor(pseudorandom("oddish", 1, 10))
                card.ability.odds = math.floor(pseudorandom("seedle", 1, 10))
                return {
                    x_mult = prevxmult
                }
            end
        end
    end
}

SMODS.ColorChip {
    key = 'drone_DD',
    name = 'Drone-DD',
    atlas = "color_chips",
    pos = { x = 3, y = 1 },
    config = { chips = 100 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.chips } }
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'drone')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    card:juice_up()
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                        { message = localize('k_plus_tarot'), colour = G.C.PURPLE })
                    return true
                end)
            }))
        end
    end
}
local _pokerhand

SMODS.ColorChip {
    key = 'drone_CA',
    name = 'Drone-CA',
    atlas = "color_chips",
    pos = { x = 4, y = 1 },
    config = { chips = 100 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.chips } }
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
    calculate = function(self, card, context)
        if context.after then
            _pokerhand = context.scoring_name
        end
        if context.end_of_round and context.main_eval and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (function()
                    if _pokerhand then
                        local _planet = 0
                        for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                            if v.config.hand_type == _pokerhand then
                                _planet = v.key
                            end
                        end
                        local card2 = create_card(card_type, G.consumeables, nil, nil, nil, nil, _planet, 'blusl')
                        card2:add_to_deck()
                        G.consumeables:emplace(card2)
                        G.GAME.consumeable_buffer = 0
                    end
                    return true
                end)
            }))
            card:juice_up()
            card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet })
        end
    end
}

SMODS.ColorChip {
    key = 'drone_F2',
    name = 'Drone-F2',
    atlas = "color_chips",
    pos = { x = 5, y = 1 },
    config = { chips = 100 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.chips } }
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and G.GAME.blind.boss and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'drone')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    card:juice_up()
                    card_eval_status_text(card, 'extra', nil, nil, nil,
                        { message = localize('k_plus_spectral'), colour = G.C.BLUE })
                    return true
                end)
            }))
        end
    end
}

SMODS.ColorChip {
    key = 'range_FC',
    name = 'Range-FC',
    atlas = "color_chips",
    pos = { x = 0, y = 2 },
    config = { handsize = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.handsize } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.handsize)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.handsize)
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
}

SMODS.ColorChip {
    key = 'range_9A',
    name = 'Range-9A)',
    atlas = "color_chips",
    pos = { x = 1, y = 2 },
    config = { extra = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra } }
    end,
    add_to_deck = function(self, card, from_debuff)
        change_shop_size(card.ability.extra)
    end,
    remove_from_deck = function(self, card, from_debuff)
        change_shop_size(-card.ability.extra)
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
}

SMODS.ColorChip {
    key = 'range_8F',
    name = 'Range-8F',
    atlas = "color_chips",
    pos = { x = 2, y = 2 },
    config = { cardselection = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.cardselection } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + card.ability.cardselection
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand.config.highlighted_limit = G.hand.config.highlighted_limit - card.ability.cardselection
        G.hand:unhighlight_all()
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
}

SMODS.ColorChip {
    key = 'support_FF',
    name = 'Support-FF',
    atlas = "color_chips",
    pos = { x = 4, y = 2 },
    config = { extra = 3 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra } }
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
    calc_dollar_bonus = function(self, card)
        local bonus = card.ability.extra
        return bonus
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and to_big(G.GAME.dollars) < to_big(0) then
            ease_dollars(-G.GAME.dollars)
        end
    end,

}

SMODS.ColorChip {
    key = 'support_AA',
    name = 'Support-AA',
    atlas = "color_chips",
    pos = { x = 4, y = 2 },
    config = { extra = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
}

SMODS.ColorChip {
    key = 'support_A5',
    name = 'Support-A5',
    atlas = "color_chips",
    pos = { x = 5, y = 2 },
    config = { extra = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
}

SMODS.ColorChip {
    key = 'power_S1',
    name = 'Power-S1',
    atlas = "color_chips",
    cost = 10,
    pos = { x = 0, y = 3 },
    config = { x = 2 },
    hidden = true,
    soul_rate = 0.002,
    soul_set = "c_chip",
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectrum_chip'), G.C.EDITION, G.C.WHITE, 1.2)
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.x } }
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
    calculate = function(self, card, context)
        if context.other_consumeable then
            return {
                x_mult = card.ability.x,
                x_chips = card.ability.x
            }
        end
    end
}

SMODS.ColorChip {
    key = 'mobility_S2',
    name = "Mobility-S2",
    atlas = "color_chips",
    config = { extra = { slots = 0 } },
    pos = { x = 1, y = 3 },
    cost = 10,
    unlocked = true,
    blueprint_compat = false,
    hidden = true,
    soul_rate = 0.002,
    soul_set = "c_chip",
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectrum_chip'), G.C.EDITION, G.C.WHITE, 1.2)
    end,
    ability_name = "Mobility-S2",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.slots } }
    end,
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.slots = G.GAME.skips or 0
    end,
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.slots)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.slots)
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
    calculate = function(self, card, context)
        if context.skip_blind then
            G.hand:change_size(1)
            card.ability.extra.slots = G.GAME.skips
        end
    end,
}

SMODS.ColorChip {
    key = 'lucky_S3',
    name = 'Lucky-S3',
    atlas = "color_chips",
    cost = 10,
    pos = { x = 2, y = 3 },
    config = { odds = 4, chancemod = 2 },
    hidden = true,
    soul_rate = 0.002,
    soul_set = "c_chip",
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectrum_chip'), G.C.EDITION, G.C.WHITE, 1.2)
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.odds } }
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.game_over then
            if pseudorandom("let's_go_gambling") < (1 / card.ability.odds) then
                card.ability.chancemod = card.ability.chancemod * 2
                play_sound("splat_probability_st", 1, 1.5)
                return {
                    message = localize("k_double_st"),
                    colour = G.C.splat_chip
                }
            else
                return {
                    message = localize("k_nope_ex"),
                    colour = G.C.RED
                }
            end
        end
        if context.mod_probability and not context.blueprint then
            return {
                numerator = context.numerator * card.ability.chancemod
            }
        end
    end
}

SMODS.ColorChip {
    key = 'drone_S4',
    name = 'Drone-S4',
    atlas = "color_chips",
    cost = 10,
    pos = { x = 3, y = 3 },
    config = {},
    hidden = true,
    soul_rate = 0.002,
    soul_set = "c_chip",
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectrum_chip'), G.C.EDITION, G.C.WHITE, 1.2)
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
        return {}
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.game_over then
            local self_pos = -1
            for index, value in ipairs(G.consumeables.cards) do
                if value == card then
                    self_pos = index
                end
            end
            if self_pos ~= -1 and G.consumeables.cards[self_pos - 1] then
                G.consumeables.cards[self_pos - 1]:set_edition({ negative = true }, nil)
            end
            if self_pos ~= -1 and G.consumeables.cards[self_pos + 1] then
                G.consumeables.cards[self_pos + 1]:set_edition({ negative = true }, nil)
            end
        end
    end
}

SMODS.ColorChip {
    key = 'range_S5',
    name = 'Range-S5',
    atlas = "color_chips",
    cost = 10,
    pos = { x = 4, y = 3 },
    config = {},
    hidden = true,
    soul_rate = 0.002,
    soul_set = "c_chip",
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectrum_chip'), G.C.EDITION, G.C.WHITE, 1.2)
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local tally = 0
            for index, value in ipairs(G.consumeables.cards) do
                if value.ability.set == "c_chip" then
                    tally = tally + 1
                end
            end
            return {
                repetitions = tally,
                card = card
            }
        end
    end
}

SMODS.ColorChip {
    key = 'support_S6',
    name = 'Support-S6',
    atlas = "color_chips",
    cost = 10,
    pos = { x = 5, y = 3 },
    config = { advance = false, number = 1, max = 2},
    hidden = true,
    soul_rate = 0.002,
    soul_set = "c_chip",
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_spectrum_chip'), G.C.EDITION, G.C.WHITE, 1.2)
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.number, card.ability.max } }
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            G.GAME.drone_tally = (G.GAME.drone_tally or 0) + 1
        end
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and G.GAME.blind.boss then
            if card.ability.advance == false then
                card.ability.advance = true
            else
                ease_ante(-card.ability.number)
                card.ability.advance = false
            end
        end
        if context.end_of_round and not context.game_over then
            local eval = function() return card.ability.advance == true end
            juice_card_until(card, eval, true)
        end
    end
}