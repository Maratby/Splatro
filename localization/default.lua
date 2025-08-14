return {
	["misc"] = {
		["labels"] = {
			["splat_goldenegg_seal"] = "Golden Egg Seal",
			["splat_order_seal"] = "Order Seal",
		},
		["dictionary"] = {
			["k_plus_chip"] = "+1 Color Chip",
			["k_c_chip_pack"] = "Chip Pack",
			["k_spectrum_chip"] = "Spectrum Chip",
			["k_double_st"] = "Double!",
		},
	},
	["descriptions"] = {
		["Joker"] = {
			["j_splat_the_company"] = {
				["name"] = "The Company",
				["text"] = {
					"Applies {C:money}Golden Egg Seal{} to {C:attention}1 card{}",
					"in {C:attention}final hand of round",
					"for each {C:attention}remaining{} {C:chips}Hand"
				},
			},
			["j_splat_subject_3"] = {
				["name"] = "Subject n°3",
				["text"] = {
					"{C:money}Sell{} this card after {C:attention}2 Rounds{}",
					"to {C:attention}Enhance{} all cards {C:attention}held in hand{}",
					"into {C:attention}Mammalized Cards{}",
					"{C:inactive}(#1#/2)"
				},
			},
			["j_splat_savior"] = {
				["name"] = "Savior",
				["text"] = {
					"After {C:attention}First Hand{} of round,",
					"All played {V:1}#1#{}",
					"become {C:attention}Sanitized Cards{}",
					"{s:0.8}suit changes at end of round",
				},
			},
			["j_splat_portal"] = {
				["name"] = "Portal",
				["text"] = {
					"Applies {C:attention}Order Seal{} to",
					"All played cards sharing the",
					"{C:attention}most common{} played Rank",
					"{s:0.8}(e.g K,K,10,10,10 = all 10s gain seal)",
				},
			},

			["j_splat_free_association"] = {
				["name"] = "Free Association",
				["text"] = {
					"This joker gains {C:red}+#2#{} Mult",
					"for each held {C:splat_chip}Color Chip{}",
					"at {C:attention}end of round",
					"{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult"
				},
			},
			["j_splat_infinity_ball"] = {
				["name"] = "Infinity Ball",
				["text"] = {
					"This joker gains {C:chips}+#2#{} Chips",
					"after each {C:chips}Hand{} played",
					"{C:red}resets{} when a card is {C:red}discarded",
					"{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips"
				},
			},

			["j_splat_saturation"] = {
				["name"] = "Saturation",
				["text"] = {
					"Creates a random {C:splat_chip}Color Chip{}",
					"if {C:attention}final hand of round{}",
					"contains a {C:attention}Flush{}",
					"{C:inactive}(must have room)"
				},
			},

			["j_splat_vending_machine"] = {
				["name"] = "Vending Machine",
				["text"] = {
					"After {C:attention}Boss Blind{} is defeated,",
					"pay {C:money}$#1#{} to turn {C:attention}leftmost",
					"consumable {C:dark_edition}Negative",
					"{C:inactive,s:0.5}(Doesn't trigger if you're broke)"
				},
			},

			["j_splat_turbine"] = {
				["name"] = "Turbine Tower",
				["text"] = {
					"Earn {C:money}$#1#{} at {C:attention}end of round{}",
					"if {C:attention}Blind score{} exceeds {C:attention}133%{}",
					"of {C:attention}required score",
				},
			},

			["j_splat_spire_hack"] = {
				["name"] = "Spire Hack",
				["text"] = {
					"Each held {C:attention}Consumable{} has a ",
					"{C:green}#1# in #2#{} chance to turn into a",
					"{C:splat_chip}Color Chip{} at end of round",
					"{C:inactive}(editions transfer)",
				},
			},

			["j_splat_pearl_drone"] = {
				["name"] = "Pearl Drone",
				["text"] = {
					"Gives {C:dark_edition}+1{} Consumable Slot",
					"for each {C:splat_chip}Color Chip{}",
					"{C:money}sold{} or {C:red}destroyed{} this run",
					"{C:inactive}(Currently +#1# Slots)"
				},
			},
		},
		["Enhanced"] = {
			["m_splat_mammalized"] = {
				["name"] = "Mammalized Card",
				["text"] = {
					"{C:attention}Retriggers{} once for each",
					"{C:attention}Mammalized Card{} held in hand",
				},
			},
			["m_splat_sanitized"] = {
				["name"] = "Sanitized Card",
				["text"] = {
					"{X:chips,C:white}X#1#{} Chips",
					"{C:red}Destroyed{} after",
					"being played {C:attention}5{} times",
					"{C:inactive}(#2#/5)"
				},
			},
		},
		["Spectral"] = {
			["c_splat_overtime"] = {
				["name"] = "Overtime",
				["text"] = {
					"Applies {C:money}Golden Egg Seal{} to",
					"{C:attention}#1#{} selected cards",
				},
			},
			["c_splat_conformity"] = {
				["name"] = "Conformity",
				["text"] = {
					"Applies {C:attention}Order Seal{} to",
					"{C:attention}#1#{} selected cards",
				},
			},
		},
		["Tarot"] = {
			["c_splat_apocalypse"] = {
				["name"] = "The Apocalypse",
				["text"] = {
					"Enhances {C:attention}#1#{} selected",
                    "cards into {C:attention}Mammalized Cardss"
				},
			},
			["c_splat_cleansing"] = {
				["name"] = "The Cleansing",
				["text"] = {
					"Enhances {C:attention}#1#{} selected",
                    "cards into {C:attention}Sanitized Cards"
				},
			},
			["c_splat_mission"] = {
				["name"] = "The Mission",
				["text"] = {
					"Creates {C:attention}#1#{} {C:splat_chip}Color Chip",
                    "{C:inactive}(must have room){}"
				},
			},
		},
		["Back"] = {
			["b_splat_spire_deck"] = {
				["name"] = "Spire Deck",
				["text"] = {
					"Start with {C:splat_chip,T:v_splat_palette}Palette{} voucher",
                    "Gain {C:dark_edition}+1 Consumable Slot{} after",
					"each {C:attention}third{}",
					"defeated {C:attention}Boss Blind",
					"{C:attention}+1{} Ante to Win"
				},
			},
		},
		["Tag"] = {
			["tag_splat_chip_tag"] = {
				["name"] = "Chip Tag",
				["text"] = {
					"Creates a",
					"{C:splat_chip}Mega Chip Pack",
				},
			},
		},
		["Voucher"] = {
			["v_splat_palette"] = {
				["name"] = "Palette",
				["text"] = {
					"{C:dark_edition}+#1#{} Consumable Slot",
				},
			},

			["v_splat_acht"] = {
				["name"] = "Acht",
				["text"] = {
					"{C:attention}1{} random held",
					"{C:splat_chip}Color Chip{} becomes",
					"{C:dark_edition}Negative{} after {C:attention}Boss Blind",
					"is defeated",
				},
			},

			["v_splat_cipher"] = {
				["name"] = "Cipher",
				["text"] = {
					"{C:splat_chip}Color Chips{} can",
					"appear in the {C:money}Shop"
				},
			},

			["v_splat_lockers"] = {
				["name"] = "Lockers",
				["text"] = {
					"{C:splat_chip}Color Chips{} spawn",
					"with random {C:dark_edition}Editions"
				},
			},
		},
		["c_chip"] = {
			["c_splat_power_CC"] = {
				["name"] = "Power-CC",
				["text"] = {
					"Gives {X:mult,C:white}X1{} Mult",
					"plus {X:mult,C:white}X#1#{} Mult",
					"for each card in {C:attention}played hand{}",
					"{s:0.8}(e.g A,A,2,2 = X1.8 Mult)",
				},
			},
			["c_splat_power_D4"] = {
				["name"] = "Power-D4",
				["text"] = {
					"Each played {C:attention}3{} or {C:attention}8{}",
					"gives {C:mult}+#1#{} Mult",
					"for each held {C:splat_chip}Color Chip{}",
				},
			},
			["c_splat_power_E3"] = {
				["name"] = "Power-E3",
				["text"] = {
					"Gives {C:blue}+#1#{} Chips",
					"if chips scored are",
					"below {C:attention}50%{} of required score",
				},
			},

			["c_splat_mobility_FF"] = {
				["name"] = "Mobility-FF",
				["text"] = {
					"When your first {C:blue}Hand{} or {C:red}Discard{} is used",
					"gain {C:attention}+#1#{} of the other",
					"{C:inactive}(Effect works once per blind)"
				},
			},

			["c_splat_mobility_A3"] = {
				["name"] = "Mobility-A3",
				["text"] = {
					"Reduce {C:attention}Ante{} by {C:attention}1{}",
					"after {C:attention}skipping #2#{} Blinds",
					"{C:inactive}(#1#/#2#)"
				},
			},

			["c_splat_mobility_6A"] = {
				["name"] = "Mobility-6A",
				["text"] = {
					"Earn {C:money}+$#1#{}",
					"per remaining {C:blue}Hand{}",
					"at {C:attention}end of round"
				},
			},

			["c_splat_lucky_FF"] = {
				["name"] = "Lucky-FF",
				["text"] = {
					"{C:green}#1# in #2#{} chance for",
					"each played card to give {C:money}$3",
				},
			},

			["c_splat_lucky_AF"] = {
				["name"] = "Lucky-AF",
				["text"] = {
					"{C:green}#1# in #2#{} chance to",
					"create a random {C:splat_chip}Color Chip{}",
					"at {C:attention}end of round",
					"{C:inactive}(Must have room)"
				},
			},

			["c_splat_lucky_78"] = {
				["name"] = "Lucky-78",
				["text"] = {
					"{C:green}#1# in #2#{} chance to",
					"give {X:mult,C:white}X#3#{} Mult",
					"{C:inactive,S:0.7}Odds and payout change randomly after trigger"
				},
			},

			["c_splat_drone_DD"] = {
				["name"] = "Drone-DD",
				["text"] = {
					"Creates a {C:tarot}Tarot{} card",
                    "at {C:attention}end of round",
                    "{C:inactive}(Must have room)"
				},
			},
			["c_splat_drone_CA"] = {
				["name"] = "Drone-CA",
				["text"] = {
					"Creates a {C:planet}Planet{} card of",
					"last played {C:attention}Poker Hand{}",
                    "at {C:attention}end of round",
                    "{C:inactive}(Must have room)"
				},
			},
			["c_splat_drone_F2"] = {
				["name"] = "Drone-F2",
				["text"] = {
					"Creates a {C:spectral}Spectral{} card",
                    "at {C:attention}end of round",
                    "{C:inactive}(Must have room)"
				},
			},
			["c_splat_range_FC"] = {
				["name"] = "Range-FC",
				["text"] = {
					"{C:attention}+#1#{} Hand Size"
				},
			},

			["c_splat_range_9A"] = {
				["name"] = "Range-9A",
				["text"] = {
					"{C:attention}+1{} card slot",
                    "available in shop"
				},
			},

			["c_splat_range_8F"] = {
				["name"] = "Range-8F",
				["text"] = {
					"{C:attention}+#1#{} Card Selection Limit"
				},
			},

			["c_splat_support_FF"] = {
				["name"] = "Support-FF",
				["text"] = {
					"Clears {C:red}Debt{} and",
					"earns {C:money}+$#1#{}",
					"at {C:attention}end of round",
				},
			},

			["c_splat_support_AA"] = {
				["name"] = "Support-AA",
				["text"] = {
					"{C:dark_edition}+#1#{} Consumable Slot"
				},
			},

			["c_splat_support_A5"] = {
				["name"] = "Support-A5",
				["text"] = {
					"{C:dark_edition}+#1#{} Joker Slot"
				},
			},

			["c_splat_power_S1"] = {
				["name"] = "Power-S1",
				["text"] = {
					"Each held {C:attention}consumable{} gives",
					"{X:chips,C:white}X#1#{} Chips and {X:mult,C:white}X#1#{} Mult"
				},
			},

			["c_splat_mobility_S2"] = {
				["name"] = "Mobility-S2",
				["text"] = {
					"Gives {C:dark_edition}+1{} Hand Size",
					"per {C:attention}Blind{} Skipped this run",
					"{C:inactive}(Currently +#1# Hand Size)"
				},
			},

			["c_splat_lucky_S3"] = {
				["name"] = "Lucky-S3",
				["text"] = {
					"Doubles all {C:attention}listed {C:green,E:1,S:1.1}probabilities",
					"{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}2 in 3{C:inactive})",
					"{C:green}25%{} chance to double {C:green,E:1,S:1.1}probabilities{}",
					"again at {C:attention}end of round",
				},
			},

			["c_splat_drone_S4"] = {
				["name"] = "Drone-S4",
				["text"] = {
					"{C:attention}Adjacent{} Consumables become {C:dark_edition}Negative",
					"at {C:attention}end of round",
				},
			},

			["c_splat_range_S5"] = {
				["name"] = "Drone-S5",
				["text"] = {
					"{C:attention}Retrigger{} all played cards",
					"once for each held {C:splat_chip}Color Chip",
				},
			},

			["c_splat_support_S6"] = {
				["name"] = "Support-S6",
				["text"] = {
					"{C:dark_edition}-#1#{} Ante after",
					"defeating {C:attention}#2# Boss Blinds",
				},
			},
		},
		["Other"] = {
			["splat_goldenegg_seal"] = {
				["label"] = "Golden Egg Seal",
				["name"] = "Golden Egg Seal",
				["text"] = {
					"Gives {C:blue}+#1#{} chips and {X:chips,C:white}X#2#{} Chips",
					"for every",
					"{C:money}Golden Egg Seal{}",
					"in played hand",
				},
			},

			["golden_s_egg"] = {
				["name"] = "Golden Egg Seal",
				["text"] = {
					"Gives {C:blue}+5{} chips and {X:chips,C:white}X1.05{} Chips",
					"for every",
					"{C:money}Golden Egg Seal{}",
					"in played hand",
				},
			},
			["splat_order_seal"] = {
				["label"] = "Order Seal",
				["name"] = "Order Seal",
				["text"] = {
					"Gives {X:mult,C:white}X#1#{} Mult",
					"if {C:attention}played hand{} contains",
					"a {C:attention}Straight{} or {C:attention}Flush{}"
				},
			},
			["splat_s_conformity"] = {
				["label"] = "Order Seal",
				["name"] = "Order Seal",
				["text"] = {
					"Gives {X:mult,C:white}X1.25{} Mult",
					"if {C:attention}played hand{} contains",
					"a {C:attention}Straight{} or {C:attention}Flush{}"
				},
			},
			["p_splat_chip_normal_1"] = {
				["name"] = "Chip Pack",
				["text"] = {
					"Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2# {C:splat_chip}Color Chips{} to",
                    "add to your Consumables"
				},
			},
			["p_splat_chip_normal_2"] = {
				["name"] = "Chip Pack",
				["text"] = {
					"Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2# {C:splat_chip}Color Chips{} to",
                    "add to your Consumables"
				},
			},
			["p_splat_chip_jumbo_1"] = {
				["name"] = "Jumbo Chip Pack",
				["text"] = {
					"Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2# {C:splat_chip}Color Chips{} to",
                    "add to your Consumables"
				},
			},
			["p_splat_chip_jumbo_2"] = {
				["name"] = "Jumbo Chip Pack",
				["text"] = {
					"Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2# {C:splat_chip}Color Chips{} to",
                    "add to your Consumables"
				},
			},
			["p_splat_chip_mega_1"] = {
				["name"] = "Mega Chip Pack",
				["text"] = {
					"Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2# {C:splat_chip}Color Chips{} to",
                    "add to your Consumables"
				},
			},
		},
	},
}
