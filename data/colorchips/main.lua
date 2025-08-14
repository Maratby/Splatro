
SMODS.UndiscoveredSprite {
    key = 'c_chip',
    atlas = 'color_chips',
    pos = {x = 0, y = 4}
}

SMODS.Atlas{
    key = "color_chips",
    path = "chips.png",
    px = 71,
    py = 95
}


SMODS.ConsumableType {
    key = 'c_chip',
    collection_rows = { 6, 6, 6 },
    primary_colour = HEX('ebebeb'),
    secondary_colour = HEX('e5c8b4'),
    loc_txt = {
        name = 'Color Chip',
 		collection = 'Color Chips',
        undiscovered = {
            name = 'Not Discovered',
            text = {
                "Obtain this chip",
                "in an unseeded",
                "run to learn",
                "what it does"
            },
        },
    },
    default = "c_splat_power_CC",
}

---Blacklisting Color Chips from being stacked by Overflow (They don't play well with being stacked)
if Overflow then
	Overflow.blacklist["c_chip"] = true
end

SMODS.ColorChip = SMODS.Consumable:extend({
    set = "c_chip",
    cost = 3,
    discovered = false,
    can_use = function(self, card, area, copier)
        return false
    end,
    atlas = "color_chips"
})


SMODS.load_file("data/colorchips/chips.lua")()
SMODS.load_file("data/colorchips/jokers.lua")()
SMODS.load_file("data/colorchips/consumables.lua")()
SMODS.load_file("data/colorchips/boosters.lua")()
SMODS.load_file("data/colorchips/decks.lua")()
SMODS.load_file("data/colorchips/vouchers.lua")()

--thank you betmma voucher!!!
G.FUNCS.can_pick_card = function(e)
    if #G.consumeables.cards < G.consumeables.config.card_limit then
        e.config.colour = G.C.GREEN
        e.config.button = 'pick_card'
    else
      e.config.colour = G.C.UI.BACKGROUND_INACTIVE
      e.config.button = nil
    end
end
G.FUNCS.pick_card = function(e)
    local c1 = e.config.ref_table
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
          c1.area:remove_card(c1)
          c1:add_to_deck()
          if c1.children.price then c1.children.price:remove() end
          c1.children.price = nil
          if c1.children.buy_button then c1.children.buy_button:remove() end
          c1.children.buy_button = nil
          remove_nils(c1.children)
          G.consumeables:emplace(c1)
          G.GAME.pack_choices = G.GAME.pack_choices - 1
          if G.GAME.pack_choices <= 0 then
            G.FUNCS.end_consumeable(nil, delay_fac)
          end
          return true
        end
    }))
end