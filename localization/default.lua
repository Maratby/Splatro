return {
	["misc"] = {
		["labels"] = {
			["splat_goldenegg_seal"] = "Golden Egg Seal",
			["splat_order_seal"] = "Order Seal",
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
			["pref_placeholder_seal"] = {
				["label"] = "Seal Name",
				["name"] = "Seal Name",
				["text"] = {
					"Seal {C:attention}Effect",
					"{C:inactive}(must have room)",
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
		},
	},
}
