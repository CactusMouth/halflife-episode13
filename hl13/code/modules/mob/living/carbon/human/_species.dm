/// Returns the species' agony sound, basically the amped up scream
/datum/species/proc/get_agony_sound(mob/living/carbon/human/human)
	return

/datum/species/human/get_agony_sound(mob/living/carbon/human/human)
	if(human.physique == MALE)
		return pick(
			'hl13/sound/voice/human/agony/man_pain1.ogg',
			'hl13/sound/voice/human/agony/man_pain2.ogg',
			'hl13/sound/voice/human/agony/man_pain3.ogg',
		)

	return pick(
		'hl13/sound/voice/human/agony/woman_pain1.ogg',
		'hl13/sound/voice/human/agony/woman_pain2.ogg',
		'hl13/sound/voice/human/agony/woman_pain3.ogg',
		'hl13/sound/voice/human/agony/woman_pain4.ogg',
	)

/datum/emote/living/carbon/human/agony
	key = "agony"
	key_third_person = "screams in agony"
	message = "screams in agony!"
	message_mime = "acts out a painful scream!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE
	specific_emote_audio_cooldown = 15 SECONDS
	vary = TRUE

/datum/emote/living/carbon/human/agony/can_run_emote(mob/user, status_check = TRUE , intentional, params)
	if(!intentional && HAS_TRAIT(user, TRAIT_ANALGESIA))
		return FALSE
	return ..()

/datum/emote/living/carbon/human/agony/get_sound(mob/living/carbon/human/user)
	if(!istype(user))
		return
	var/obj/item/clothing/mask/gas/civilprotection/cpmask = user.get_item_by_slot(ITEM_SLOT_MASK)
	if(istype(cpmask, /obj/item/clothing/mask/gas/civilprotection))
		if(cpmask.overwatch)
			return pick(
				'hl13/sound/voice/otavoicelines/pain1.ogg',
				'hl13/sound/voice/otavoicelines/pain2.ogg',
				'hl13/sound/voice/otavoicelines/pain3.ogg',
			)
		else
			return pick(
				'hl13/sound/voice/cpvoicelines/pain1.ogg',
				'hl13/sound/voice/cpvoicelines/pain2.ogg',
				'hl13/sound/voice/cpvoicelines/pain3.ogg',
				'hl13/sound/voice/cpvoicelines/pain4.ogg',
			)
	else
		return user.dna.species.get_agony_sound(user)
