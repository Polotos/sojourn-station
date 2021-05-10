/obj/item/weapon/gun/projectile/revolver/lemant
	name = "\"Pilgrim\" magnum revolver"
	desc = "Once a legendary frontier weapon on old earth, hailing from its second greatest empire, this signature weapon holds nine .40 rounds and one single action underslung 20mm shell. \
	This particular model is crafted by the New Testament, having good utility and plenty of shots, but is painstaking to reload since it requires removing each spent shell individually."
	icon = 'icons/obj/guns/projectile/lemant.dmi'
	icon_state = "lemant"
	item_state = "lemant"
	caliber = CAL_MAGNUM
	drawChargeMeter = FALSE
	origin_tech = list(TECH_COMBAT = 3, TECH_MATERIAL = 3)
	max_shells = 9
	matter = list(MATERIAL_PLASTEEL = 15, MATERIAL_PLASTIC = 8)
	price_tag = 450
	damage_multiplier = 1.2
	penetration_multiplier = 1.1
	recoil_buildup = 4
	gun_tags = list(GUN_PROJECTILE, GUN_INTERNAL_MAG, GUN_REVOLVER)

	init_firemodes = list(
		SEMI_AUTO_NODELAY,
		list(mode_name="fire 20mm shell",  burst=null, fire_delay=null, move_delay=null,  icon="grenade", use_launcher=1)
		)

	var/obj/item/weapon/gun/projectile/underslung_shotgun/shotgun

//Defined here, may be used elsewhere but for now its only used here. -Kaz
/obj/item/weapon/gun/projectile/underslung_shotgun
	name = "underslung shotgun"
	desc = "Not much more than a tube and a firing mechanism, this shotgun is designed to be fitted to another gun."
	fire_sound = 'sound/weapons/guns/fire/shotgunp_fire.ogg'
	bulletinsert_sound = 'sound/weapons/guns/interact/shotgun_insert.ogg'
	w_class = ITEM_SIZE_NORMAL
	matter = null
	force = 5
	max_shells = 1
	safety = FALSE
	twohanded = FALSE
	caliber = CAL_SHOTGUN
	handle_casings = EJECT_CASINGS

/obj/item/weapon/gun/projectile/underslung_shotgun/attack_self()
	return

/obj/item/weapon/gun/projectile/revolver/lemant/Initialize()
	. = ..()
	shotgun = new(src)

/obj/item/weapon/gun/projectile/revolver/lemant/attackby(obj/item/I, mob/user)
	if((istype(I, /obj/item/ammo_casing/shotgun)))
		shotgun.load_ammo(I, user)
	else
		..()

/obj/item/weapon/gun/projectile/revolver/lemant/attack_hand(mob/user)
	var/datum/firemode/cur_mode = firemodes[sel_mode]

	if(user.get_inactive_hand() == src && cur_mode.settings["use_launcher"])
		shotgun.unload_ammo(user)
	else
		..()

/obj/item/weapon/gun/projectile/revolver/lemant/Fire(atom/target, mob/living/user, params, pointblank=0, reflex=0)
	var/datum/firemode/cur_mode = firemodes[sel_mode]

	if(cur_mode.settings["use_launcher"])
		shotgun.Fire(target, user, params, pointblank, reflex)
		if(!shotgun.chambered)
			switch_firemodes() //switch back automatically
	else
		..()

/obj/item/weapon/gun/projectile/revolver/lemant/examine(mob/user)
	..()
	if(shotgun.loaded.len)
		to_chat(user, "\The [shotgun] has \a [shotgun.chambered] loaded.")
	else
		to_chat(user, "\The [shotgun] is empty.")

/obj/item/weapon/gun/projectile/revolver/lemant/deacon
	name = "\"Deacon\" kurtz revolver"
	desc = "An anomalous weapon created by an unknown person (or group?), their work marked by a blue cross, these weapons are known to vanish and reappear when left alone. \
	Some pilgrims find what they are looking for..."
	icon_state = "lemant_blue"
	item_state = "lemant_blue"
	caliber = CAL_50
	var/obj/item/weapon/gun/projectile/underslung/launcher
	init_firemodes = list(
		SEMI_AUTO_NODELAY,
		list(mode_name="fire grenades",  burst=null, fire_delay=null, move_delay=null,  icon="grenade", use_launcher=1)
		)