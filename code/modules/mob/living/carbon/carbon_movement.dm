/mob/living/carbon/slip(knockdown_amount, obj/slipped_on, lube_flags, paralyze, force_drop = FALSE)
	if(movement_type & MOVETYPES_NOT_TOUCHING_GROUND)
		return FALSE
	if(!(lube_flags & SLIDE_ICE))
		log_combat(src, (slipped_on || get_turf(src)), "slipped on the", null, ((lube_flags & SLIDE) ? "(SLIDING)" : null))
	..()
	return loc.handle_slip(src, knockdown_amount, slipped_on, lube_flags, paralyze, force_drop)

/mob/living/carbon/Move(NewLoc, direct)
	. = ..()
	if(!. || (movement_type & FLOATING)) //floating is easy
		return
	if(nutrition <= 0 || stat == DEAD)
		return
	var/hunger_loss = HUNGER_FACTOR / 8
	if(move_intent == MOVE_INTENT_RUN)
		hunger_loss *= 2
		var/staminatolose = 1.1
		if(ishuman(src))
			var/mob/living/carbon/human/H = src
			var/athletics_skill = H.mind?.get_skill_level(/datum/skill/athletics)

			staminatolose -= (athletics_skill * 0.05) //each level of athletics skill reduces stamina drain by 0.05, with up to 0.35 less at legendary athletics

			if(H.w_uniform)
				if(H.w_uniform.powered_suit && H.w_uniform.suit_power > 0) //a powered suit lessens the fatigue of running
					H.w_uniform.adjust_suitpower(1, TRUE)
					staminatolose -= 0.2

		// having high spirits helps us run longer, poor mood hurts instead
		if(mob_mood)
			switch(mob_mood.sanity_level)
				if(SANITY_LEVEL_GREAT || SANITY_MAXIMUM)
					staminatolose -= 0.2
				if(SANITY_LEVEL_UNSTABLE || SANITY_LEVEL_CRAZY)
					staminatolose += 0.1
				if(SANITY_LEVEL_INSANE)
					staminatolose += -0.2

		if(HAS_TRAIT(src, TRAIT_ATHLETIC)) //Athletic skillchip lets you run for longer
			staminatolose -= 0.2

		if(TIREDNESS_SLEEPY_THRESHOLD < tiredness)
			if(!HAS_TRAIT(src, TRAIT_SPARTAN))
				staminatolose += 0.4
			else
				staminatolose += 0.2 //spartan trait holders take less of a run stamina penalty

		adjustStaminaLoss(staminatolose)
		if(getStaminaLoss() > 60) //automatically stop running once you're very tired.
			toggle_move_intent()

	adjust_nutrition(-1 * hunger_loss)
	adjust_hydration(-3 * hunger_loss)

/mob/living/carbon/set_usable_legs(new_value)
	. = ..()
	if(isnull(.))
		return
	if(. == 0)
		if(usable_legs != 0) //From having no usable legs to having some.
			REMOVE_TRAIT(src, TRAIT_FLOORED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)
			REMOVE_TRAIT(src, TRAIT_IMMOBILIZED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)
	else if(usable_legs == 0 && !(movement_type & (FLYING | FLOATING))) //From having usable legs to no longer having them.
		ADD_TRAIT(src, TRAIT_FLOORED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)
		if(!usable_hands)
			ADD_TRAIT(src, TRAIT_IMMOBILIZED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)


/mob/living/carbon/set_usable_hands(new_value)
	. = ..()
	if(isnull(.))
		return
	if(. == 0)
		REMOVE_TRAIT(src, TRAIT_HANDS_BLOCKED, LACKING_MANIPULATION_APPENDAGES_TRAIT)
		if(usable_hands != 0) //From having no usable hands to having some.
			REMOVE_TRAIT(src, TRAIT_IMMOBILIZED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)
	else if(usable_hands == 0 && default_num_hands > 0) //From having usable hands to no longer having them.
		ADD_TRAIT(src, TRAIT_HANDS_BLOCKED, LACKING_MANIPULATION_APPENDAGES_TRAIT)
		if(!usable_legs && !(movement_type & (FLYING | FLOATING)))
			ADD_TRAIT(src, TRAIT_IMMOBILIZED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)

/mob/living/carbon/on_movement_type_flag_enabled(datum/source, flag, old_movement_type)
	. = ..()
	if(movement_type & (FLYING | FLOATING) && !(old_movement_type & (FLYING | FLOATING)))
		remove_movespeed_modifier(/datum/movespeed_modifier/limbless)
		remove_traits(list(TRAIT_FLOORED, TRAIT_IMMOBILIZED), LACKING_LOCOMOTION_APPENDAGES_TRAIT)

/mob/living/carbon/on_movement_type_flag_disabled(datum/source, flag, old_movement_type)
	. = ..()
	if(old_movement_type & (FLYING | FLOATING) && !(movement_type & (FLYING | FLOATING)))
		var/limbless_slowdown = 0
		if(usable_legs < default_num_legs)
			limbless_slowdown += (default_num_legs - usable_legs) * 3
			if(!usable_legs)
				ADD_TRAIT(src, TRAIT_FLOORED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)
				if(usable_hands < default_num_hands)
					limbless_slowdown += (default_num_hands - usable_hands) * 3
					if(!usable_hands)
						ADD_TRAIT(src, TRAIT_IMMOBILIZED, LACKING_LOCOMOTION_APPENDAGES_TRAIT)
		if(limbless_slowdown)
			add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/limbless, multiplicative_slowdown = limbless_slowdown)
		else
			remove_movespeed_modifier(/datum/movespeed_modifier/limbless)
