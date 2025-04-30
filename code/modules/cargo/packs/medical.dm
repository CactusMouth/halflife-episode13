/datum/supply_pack/medical
	group = "Medical"
	access_view = ACCESS_MEDICAL

/datum/supply_pack/medical/bloodpacks
	name = "Blood Pack Variety Crate"
	desc = "Contains ten different blood packs for reintroducing blood to patients."
	cost = CARGO_CRATE_VALUE * 7
	contains = list(/obj/item/reagent_containers/blood = 2,
					/obj/item/reagent_containers/blood/a_plus,
					/obj/item/reagent_containers/blood/a_minus,
					/obj/item/reagent_containers/blood/b_plus,
					/obj/item/reagent_containers/blood/b_minus,
					/obj/item/reagent_containers/blood/o_plus,
					/obj/item/reagent_containers/blood/o_minus,
				)
	crate_name = "blood freezer"
	crate_type = /obj/structure/closet/crate/freezer/halflife

/datum/supply_pack/medical/coroner_crate
	name = "Autopsy Kit"
	desc = "Contains an autopsy scanner, when you lose your own and really \
		need to complete your dissection experiments."
	cost = CARGO_CRATE_VALUE * 2.5
	contains = list(
		/obj/item/autopsy_scanner = 1,
		/obj/item/storage/medkit/coroner = 1,
	)
	crate_name = "autopsy kit crate"

/datum/supply_pack/medical/chemical
	name = "Chemical Starter Kit Crate"
	desc = "Contains thirteen different chemicals, for all the fun experiments you can make."
	cost = CARGO_CRATE_VALUE * 2.6
	contains = list(/obj/item/reagent_containers/cup/bottle/hydrogen,
					/obj/item/reagent_containers/cup/bottle/carbon,
					/obj/item/reagent_containers/cup/bottle/nitrogen,
					/obj/item/reagent_containers/cup/bottle/oxygen,
					/obj/item/reagent_containers/cup/bottle/fluorine,
					/obj/item/reagent_containers/cup/bottle/phosphorus,
					/obj/item/reagent_containers/cup/bottle/silicon,
					/obj/item/reagent_containers/cup/bottle/chlorine,
					/obj/item/reagent_containers/cup/bottle/radium,
					/obj/item/reagent_containers/cup/bottle/sacid,
					/obj/item/reagent_containers/cup/bottle/ethanol,
					/obj/item/reagent_containers/cup/bottle/potassium,
					/obj/item/reagent_containers/cup/bottle/sugar,
					/obj/item/clothing/glasses/science,
					/obj/item/reagent_containers/dropper,
					/obj/item/storage/box/beakers,
				)
	crate_name = "chemical crate"

/datum/supply_pack/medical/defibs
	name = "Defibrillator Crate"
	desc = "Contains two defibrillators for bringing the recently deceased back to life."
	cost = CARGO_CRATE_VALUE * 5
	contains = list(/obj/item/defibrillator/loaded = 2)
	crate_name = "defibrillator crate"

/datum/supply_pack/medical/iv_drip
	name = "IV Drip Crate"
	desc = "Contains a single IV drip for administering blood to patients."
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/machinery/iv_drip)
	crate_name = "iv drip crate"

/datum/supply_pack/medical/supplies
	name = "Medical Supplies Crate"
	desc = "Contains a random assortment of medical supplies. German doctor not included."
	cost = CARGO_CRATE_VALUE * 4.5
	contains = list(/obj/item/reagent_containers/cup/bottle/multiver,
					/obj/item/reagent_containers/cup/bottle/epinephrine,
					/obj/item/reagent_containers/cup/bottle/morphine,
					/obj/item/reagent_containers/cup/bottle/toxin,
					/obj/item/reagent_containers/cup/beaker/large,
					/obj/item/reagent_containers/pill/insulin,
					/obj/item/stack/medical/gauze,
					/obj/item/storage/box/bandages,
					/obj/item/storage/box/beakers,
					/obj/item/storage/box/medigels,
					/obj/item/storage/box/syringes,
					/obj/item/storage/box/bodybags,
					/obj/item/storage/medkit/regular,
					/obj/item/storage/medkit/o2,
					/obj/item/storage/medkit/toxin,
					/obj/item/storage/medkit/brute,
					/obj/item/storage/medkit/fire,
					/obj/item/defibrillator/loaded,
					/obj/item/reagent_containers/blood/o_minus,
					/obj/item/storage/pill_bottle/mining,
					/obj/item/reagent_containers/pill/neurine,
					/obj/item/stack/medical/bone_gel = 2,
					/obj/item/vending_refill/medical,
					/obj/item/vending_refill/drugs,
				)
	crate_name = "medical supplies crate"

/datum/supply_pack/medical/supplies/fill(obj/structure/closet/crate/C)
	for(var/i in 1 to 10)
		var/item = pick(contains)
		new item(C)

/datum/supply_pack/medical/experimentalmedicine
	name = "Experimental Medicine Crate"
	desc = "A crate containing the medication required for living with Hereditary Manifold Sickness, Sansufentanyl."
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/storage/pill_bottle/sansufentanyl = 2)
	crate_name = "experimental medicine crate"

/datum/supply_pack/medical/surgery
	name = "Surgical Supplies Crate"
	desc = "Do you want to perform surgery, but don't have one of those fancy \
		shmancy degrees? Just get started with this crate containing a DeForest surgery tray, \
		Sterilizine spray and collapsible roller bed."
	cost = CARGO_CRATE_VALUE * 6
	contains = list(
		/obj/item/surgery_tray/full,
		/obj/item/reagent_containers/medigel/sterilizine,
		/obj/item/emergency_bed,
	)
	crate_name = "surgical supplies crate"

/datum/supply_pack/medical/salglucanister
	name = "Heavy-Duty Saline Canister"
	desc = "Contains a bulk supply of saline-glucose condensed into a single canister that \
		should last several days, with a large pump to fill containers with. Direct injection \
		of saline should be left to medical professionals as the pump is capable of overdosing \
		patients."
	cost = CARGO_CRATE_VALUE * 6
	access = ACCESS_MEDICAL
	contains = list(/obj/machinery/iv_drip/saline)
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/medical/medvial
	name = "Medvials"
	desc = "Contains 5 biogel medvials for rapid healing. Heals less than a medkit, but is applied quicker, and is easier to carry."
	cost = CARGO_CRATE_VALUE * 2.1
	contains = list(/obj/item/reagent_containers/pill/patch/medkit/vial,
					/obj/item/reagent_containers/pill/patch/medkit/vial,
					/obj/item/reagent_containers/pill/patch/medkit/vial,
					/obj/item/reagent_containers/pill/patch/medkit/vial,
					/obj/item/reagent_containers/pill/patch/medkit/vial,
	)
	crate_name = "medvial crate"

/datum/supply_pack/medical/medkit
	name = "Medkits"
	desc = "Contains 5 biogel medkits for rapid healing."
	cost = CARGO_CRATE_VALUE * 3
	contains = list(/obj/item/reagent_containers/pill/patch/medkit,
					/obj/item/reagent_containers/pill/patch/medkit,
					/obj/item/reagent_containers/pill/patch/medkit,
					/obj/item/reagent_containers/pill/patch/medkit,
					/obj/item/reagent_containers/pill/patch/medkit,
	)
	crate_name = "medkit crate"

/datum/supply_pack/medical/healthpen
	name = "Healthpens"
	desc = "Contains 5 biogel healthpens, which heal all damage types slowly over time."
	cost = CARGO_CRATE_VALUE * 2.1
	contains = list(/obj/item/reagent_containers/hypospray/medipen/healthpen,
					/obj/item/reagent_containers/hypospray/medipen/healthpen,
					/obj/item/reagent_containers/hypospray/medipen/healthpen,
					/obj/item/reagent_containers/hypospray/medipen/healthpen,
					/obj/item/reagent_containers/hypospray/medipen/healthpen,
	)
	crate_name = "healthpen crate"
