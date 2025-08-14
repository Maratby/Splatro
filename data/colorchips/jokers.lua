SMODS.Joker {
    key = 'free_association',
    name = "Free Association",
    atlas = "Splatro",
    config = { extra = { mult = 0, gain = 3 } },
    pos = { x = 0, y = 2 },
    cost = 3,
    rarity = 1,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    perishable_compat = false,
    ability_name = "Free Association",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.gain } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.blueprint then
            local flag = false
            for index, value in ipairs(G.consumeables.cards) do
                if value.ability.set == "c_chip" then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.gain
                    flag = true
                end
            end
            if flag == true then
                return {
                    message = localize("k_upgrade_ex")
                }
            end
        end
        if context.joker_main and card.ability.extra.mult > 0 then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
}


SMODS.Joker {
    key = 'saturation',
    name = "Saturation",
    atlas = "Splatro",
    config = {},
    pos = { x = 1, y = 2 },
    cost = 8,
    rarity = 2,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    perishable_compat = true,
    ability_name = "Saturation",
    calculate = function(self, card, context)
        if context.after and (G.GAME.chips + hand_chips * mult) > G.GAME.blind.chips and next(context.poker_hands["Flush"]) and #G.consumeables.cards < G.consumeables.config.card_limit then
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
    end,
}

SMODS.Joker {
    key = 'vending_machine',
    name = "Vending Machine",
    atlas = "Splatro",
    config = { dollars = 6 },
    pos = { x = 2, y = 2 },
    cost = 7,
    rarity = 2,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.dollars } }
    end,
    ability_name = "Vending Machine",
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and context.beat_boss and #G.consumeables.cards >= 1 and (G.consumeables.cards[1].edition == nil or G.consumeables.cards[1].edition.key ~= "e_negative") and to_big(G.GAME.dollars) >= to_big(card.ability.dollars) then
            G.E_MANAGER:add_event(Event({
                blockable = true,
                blocking = true,
                func = (function()
                    G.consumeables.cards[1]:set_edition({ negative = true }, nil)
                    card:juice_up()
                    ease_dollars(-card.ability.dollars)
                    return true
                end)
            }))
        end
    end
}

SMODS.Joker {
    key = 'turbine',
    name = "Turbine Tower",
    atlas = "Splatro",
    config = { dollars = 8, flag = false },
    pos = { x = 4, y = 2 },
    cost = 8,
    rarity = 2,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.dollars } }
    end,
    calc_dollar_bonus = function(self, card)
        local bonus = card.ability.dollars
        if bonus > 0 and card.ability.flag == true then
            return bonus
        end
    end,
    ability_name = "Turbine Tower",
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.blueprint then
            card.ability.flag = false
            if to_big(G.GAME.blind.chips) * to_big(1.333333333333) <= to_big(G.GAME.chips) then
                card.ability.flag = true
            else
                card.ability.flag = false
            end
        end
    end
}

SMODS.Joker {
    key = 'infinity_ball',
    name = "Infinity Ball",
    atlas = "Splatro",
    config = { chips = 0, chipgain = 15 },
    pos = { x = 3, y = 2 },
    cost = 6,
    rarity = 1,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    perishable_compat = true,
    ability_name = "Infinity Ball",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.chips, card.ability.chipgain } }
    end,
    calculate = function(self, card, context)
        if context.before then
            card.ability.chips = card.ability.chips + card.ability.chipgain
            return {
                message = localize("k_upgrade_ex")
            }
        end
        if context.discard then
            card.ability.chips = 0
            return {
                message = localize("k_reset")
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.chips
            }
        end
    end,
}

SMODS.Joker {
    key = 'spire_hack',
    name = 'Spire Hack',
    atlas = "Splatro",
    rarity = 3,
    cost = 8,
    pos = { x = 5, y = 2 },
    config = { odds = 3 },
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.odds,
            'Splatro-Spire-Hack')
        return { vars = { new_numerator, new_denominator } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and #G.consumeables.cards > 1 then
            local editions_list = {}
            for index, value in ipairs(G.consumeables.cards) do
                print("ran1")
                if value.ability.set ~= "c_chip"
                    and SMODS.pseudorandom_probability(card, 'seedle', 1, card.ability.odds, 'Splatro-Spire-Hack') then
                        print("ran2")
                    if value.edition then
                        table.insert(editions_list, value.edition)
                    else
                        table.insert(editions_list, "None")
                    end
                    value:start_dissolve()
                    print(tprint(editions_list))
                end
            end
            for i = 1, #editions_list do
                print("ran3")
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local _card = create_card('c_chip', G.consumeables, nil, nil, nil, nil, nil, nil)
                        _card:add_to_deck()
                        if editions_list[i] ~= "None" then
                            _card:set_edition(editions_list[i])
                        end
                        G.consumeables:emplace(_card)
                        return true
                    end
                }))
            end
        end
    end
}

SMODS.Joker {
    key = 'pearl_drone',
    name = "Pearl Drone",
    atlas = "Splatro",
    config = { extra = { slots = 0 } },
    pos = { x = 0, y = 3 },
    soul_pos = { x = 0, y = 4 },
    cost = 20,
    rarity = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    ability_name = "Pearl Drone",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.slots } }
    end,
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.slots = G.GAME.drone_tally or 0
    end,
    add_to_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.slots
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.slots
    end,
    calculate = function(self, card, context)
        if G.jokers and G.GAME.drone_tally and G.GAME.drone_tally > card.ability.extra.slots and not context.blueprint then
            G.consumeables.config.card_limit = G.consumeables.config.card_limit +
                (G.GAME.drone_tally - card.ability.extra.slots)
            card.ability.extra.slots = G.GAME.drone_tally
        end
    end,
}
