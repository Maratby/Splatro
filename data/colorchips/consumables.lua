SMODS.Consumable {
    key = 'mission',
    set = 'Tarot',
    discovered = false,
    attributes = { "generation", },
    cost = 4,
    pos = { x = 6, y = 0 },
    atlas = "SplatConsumables",
    config = { extra = { cards = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards } }
    end,
    use = function(self, card, area, copier)
        if #G.consumeables.cards < G.consumeables.config.card_limit then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        SMODS.add_card({ set = 'c_chip' })
                        card:juice_up(0.3, 0.5)
                    end
                    return true
                end
            }))
        end
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G
            .consumeables
    end
}

SMODS.Consumable {
    key = "smollusk",
    set = 'Spectral',
    pos = { x = 2, y = 0 },
    atlas = "SplatConsumables",
    name = "Smollusk",
    attributes = { "destroy_card", "modify_card", "editions" },
    discovered = false,
    cost = 8,
    can_use = function(self, card)
        return (G.jokers.highlighted ~= nil and #G.jokers.highlighted == 1) and G.jokers.highlighted[1].edition == nil
    end,
    can_bulk_use = false,
    use = function(self, card, area, copier)
        local used_consumable = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                G.jokers.highlighted[1]:set_edition(poll_edition("bubble", nil, true, true,
                    { "e_foil", "e_holo", "e_polychrome" }))
                SMODS.destroy_cards(G.consumeables.cards, nil, nil)
                return true
            end,
        }))
        delay(0.6)
    end,
}

SMODS.Consumable {
    key = "ricochet",
    set = 'Spectral',
    pos = { x = 5, y = 0 },
    atlas = "SplatConsumables",
    name = "Ricochet",
    attributes = { "destroy_card", "generation" },
    discovered = false,
    cost = 8,
    can_use = function(self, card)
        return (G.consumeables.highlighted ~= nil and #G.consumeables.highlighted == 2)
    end,
    can_bulk_use = false,
    use = function(self, card, area, copier)
        local used_consumable = copier or card
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                local victim = G.consumeables.cards[1]
                if victim == card then
                    victim = G.consumeables.cards[2]
                end
                local result = pseudorandom("big run", 1, 2)
                if result == 2 then
                    local card = SMODS.copy_card(victim)
                    card:set_edition("e_negative")
                else
                    SMODS.destroy_cards(victim, nil, nil)
                end
                return true
            end,
        }))
        delay(0.6)
    end,
}
