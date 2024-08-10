extends Node

@export var item_resource: PackedScene = preload("res://Items/Item.tscn")
@export var weapon_resource: PackedScene = preload("res://Items/Weapon.tscn")
@export var armor_resource: PackedScene = preload("res://Items/Armor.tscn")
@export var wand_resource: PackedScene = preload("res://Items/Wand.tscn")
@export var spellrune_resource: PackedScene = preload("res://Items/SpellRune.tscn")
@export var cons_resource: PackedScene = preload("res://Items/Consumable.tscn")
@export var bauble_resource: PackedScene = preload("res://Items/Bauble.tscn")

var Master = {}
var Weapons
var Armors
var Wands
var SpellRunes
var Consumables
var Baubles
var enemy_weapons

func _init():
	Weapons = {
		"Iron Sword": weapon_resource.instantiate().init("Iron Sword", "A sword, as simple as it is deadly.", 4, 5, 5, 6, 25, 1.25, 0.02, 1),
		#"Iron Greatsword": weapon_resource.instance().init("Iron Greatsword", "A hefty weapon of battle, guaranteed to maim or better.", 6, 6, 7, 3, 33, 1.5, 0.02, 2),
		"Iron Dagger": weapon_resource.instantiate().init("Iron Dagger", "A conspirator's weapon of choice.", 1, 3, 3, 6, 15, 1.35, 0.1, 1),
		"Iron Mace": weapon_resource.instantiate().init("Iron Mace", "A blunt instrument for a blunt task.", 3, 4, 4, 6, 20, 1.4, 0.02, 1),
		"Steel Sword": weapon_resource.instantiate().init("Steel Sword", "A sword, as simple as it is deadly.", 4, 7, 6, 6, 25, 1.25, 0.02, 1),
		#"Steel Greatsword": weapon_resource.instance().init("Steel Greatsword", "A hefty weapon of battle, guaranteed to maim or better.", 6, 6, 7, 3, 33, 1.5, 0.02, 2),
		"Steel Dagger": weapon_resource.instantiate().init("Steel Dagger", "A conspirator's weapon of choice.", 1, 3, 3, 6, 15, 1.35, 0.1, 1),
		"Steel Mace": weapon_resource.instantiate().init("Steel Mace", "A blunt instrument for a blunt task.", 3, 4, 4, 6, 20, 1.4, 0.02, 1),
		"Orichalcum Sword": weapon_resource.instantiate().init("Orichalcum Sword", "A sword, as simple as it is deadly.", 4, 10, 8, 6, 25, 1.25, 0.02, 1),
		#"Orichalcum Greatsword": weapon_resource.instance().init("Orichalcum Greatsword", "A hefty weapon of battle, guaranteed to maim or better.", 6, 6, 7, 3, 33, 1.5, 0.02, 2),
		"Orichalcum Dagger": weapon_resource.instantiate().init("Orichalcum Dagger", "A conspirator's weapon of choice.", 1, 3, 3, 6, 15, 1.35, 0.1, 1),
		"Orichalcum Mace": weapon_resource.instantiate().init("Orichalcum Mace", "A blunt instrument for a blunt task.", 3, 4, 4, 6, 20, 1.4, 0.02, 1),
		#"Adamantine Sword": weapon_resource.instance().init("Adamantine Sword", "A sword, as simple as it is deadly.", 4, 5, 11, 6, 25, 1.25, 0.02, 1),
		#"Adamantine Greatsword": weapon_resource.instance().init("Adamantine Greatsword", "A hefty weapon of battle, guaranteed to maim or better.", 6, 6, 7, 3, 33, 1.5, 0.02, 2),
		#"Adamantine Dagger": weapon_resource.instance().init("Adamantine Dagger", "A conspirator's weapon of choice.", 1, 3, 3, 6, 15, 1.35, 0.04, 1),
		#"Adamantine Mace": weapon_resource.instance().init("Adamantine Mace", "A blunt instrument for a blunt task.", 3, 4, 4, 6, 20, 1.4, 0.02, 1),
		#"Mithril Sword": weapon_resource.instance().init("Mithril Sword", "A sword, as simple as it is deadly.", 4, 14, 15, 6, 25, 1.25, 0.02, 1),
		#"Mithril Greatsword": weapon_resource.instance().init("Mithril Greatsword", "A hefty weapon of battle, guaranteed to maim or better.", 6, 6, 7, 3, 33, 1.5, 0.02, 2),
		#"Mithril Dagger": weapon_resource.instance().init("Mithril Dagger", "A conspirator's weapon of choice.", 1, 3, 3, 6, 15, 1.35, 0.04, 1),
		#"Mithril Mace": weapon_resource.instance().init("Mithril Mace", "A blunt instrument for a blunt task.", 3, 4, 4, 6, 20, 1.4, 0.02, 1),
		}
	Armors = {
		"Leather Helmet": armor_resource.instantiate().init("Leather Helmet", "A simple helmet stitched together from hardened animal hide.", 2, 20, 2, "head"),
		"Leather Vambraces": armor_resource.instantiate().init("Leather Vambraces", "A simple pair of vambraces stitched together from hardened animal hide.", 1, 10, 1, "arms"),
		"Leather Breastplate": armor_resource.instantiate().init("Leather Breastplate", "A simple breastplate stitched together from hardened animal hide.", 4, 40, 4, "chest"),
		"Leather Leggings": armor_resource.instantiate().init("Leather Leggings", "A simple pair of leggings stitched together from hardened animal hide.", 2, 20, 2, "legs"),
		"Leather Greaves": armor_resource.instantiate().init("Leather Greaves", "A simple pair of boots stitched together from hardened animal hide.", 1, 10, 1, "feet"),
		"Studded Leather Helmet": armor_resource.instantiate().init("Studded Leather Helmet", "A reinforced leather helmet, strictly an upgrade from the plain leather variant.", 3, 30, 3, "head"),
		"Studded Leather Vambraces": armor_resource.instantiate().init("Studded Leather Vambraces", "A pair of reinforced leather vambraces, strictly an upgrade from the plain leather variant.", 2, 20, 2, "arms"),
		"Studded Leather Breastplate": armor_resource.instantiate().init("Studded Leather Breastplate", "A reinforced leather breastplate, strictly an upgrade from the plain leather variant.", 6, 60, 6, "chest"),
		"Studded Leather Leggings": armor_resource.instantiate().init("Studded Leather Leggings", "A pair of reinforced leather leggings, strictly an upgrade from the plain leather variant.", 3, 30, 3, "legs"),
		"Studded Leather Greaves": armor_resource.instantiate().init("Studded Leather Greaves", "A pair of reinforced leather boots, strictly an upgrade from the plain leather variant.", 1, 10, 1, "feet"),
		"Chainmail Helmet": armor_resource.instantiate().init("Chainmail Helmet", "A chainmail cap. Able to deflect physical attacks, and lighter than expected!", 5, 40, 4, "head"),
		"Chainmail Vambraces": armor_resource.instantiate().init("Chainmail Vambraces", "A pair of chainmail gloves. Able to deflect physical attacks, and lighter than expected!", 2, 20, 2, "arms"),
		"Chainmail Breastplate": armor_resource.instantiate().init("Chainmail Breastplate", "A chainmail shirt. Able to deflect physical attacks, and lighter than expected!", 11, 80, 8, "chest"),
		"Chainmail Leggings": armor_resource.instantiate().init("Chainmail Leggings", "A pair of chainmail leggings. Able to deflect physical attacks, and lighter than expected!", 5, 40, 4, "legs"),
		"Chainmail Greaves": armor_resource.instantiate().init("Chainmail Greaves", "A pair of chainmail shoes. Able to deflect physical attacks, and lighter than expected!", 2, 20, 2, "feet"),
		"Bronze Helmet": armor_resource.instantiate().init("Bronze Helmet", "A helmet, forged in bronze. Heavy, but protective.", 8, 50, 5, "head"),
		"Bronze Vambraces": armor_resource.instantiate().init("Bronze Vambraces", "A pair of gauntlets, forged in bronze. Heavy, but protective.", 4, 30, 3, "arms"),
		"Bronze Breastplate": armor_resource.instantiate().init("Bronze Breastplate", "A breastplate, forged in bronze. Heavy, but protective.", 16, 100, 10, "chest"),
		"Bronze Leggings": armor_resource.instantiate().init("Bronze Leggings", "A pair of leggings, forged in bronze. Heavy, but protective.", 8, 50, 5, "legs"),
		"Bronze Greaves": armor_resource.instantiate().init("Bronze Greaves", "A pair of boots, forged in bronze. Heavy, but protective.", 4, 20, 2, "feet"),
#		"Steel Helmet": armor_resource.instance().init("Steel Helmet", "", 2, 20, 6, "head"),
#		"Steel Vambraces": armor_resource.instance().init("Steel Vambraces", "", 2, 20, 3, "arms"),
#		"Steel Breastplate": armor_resource.instance().init("Steel Breastplate", "", 2, 20, 12, "chest"),
#		"Steel Leggings": armor_resource.instance().init("Steel Leggings", "", 2, 20, 6, "legs"),
#		"Steel Greaves": armor_resource.instance().init("Steel Greaves", "", 2, 20, 3, "feet"),
#		"Darksteel Helmet": armor_resource.instance().init("Darksteel Helmet", "", 2, 20, 7, "head"),
#		"Darksteel Vambraces": armor_resource.instance().init("Darksteel Vambraces", "", 2, 20, 4, "arms"),
#		"Darksteel Breastplate": armor_resource.instance().init("Darksteel Breastplate", "", 2, 20, 14, "chest"),
#		"Darksteel Leggings": armor_resource.instance().init("Darksteel Leggings", "", 2, 20, 7, "legs"),
#		"Darksteel Greaves": armor_resource.instance().init("Darksteel Greaves", "", 2, 20, 3, "feet"), #marcie takes a break here 1/30/23
#		"Adamantine Helmet": armor_resource.instance().init("Adamantine Helmet", "", 2, 20, 2, "head"),
#		"Adamantine Vambraces": armor_resource.instance().init("Adamantine Vambraces", "", 2, 20, 2, "arms"),
#		"Adamantine Breastplate": armor_resource.instance().init("Adamantine Breastplate", "", 2, 20, 2, "chest"),
#		"Adamantine Leggings": armor_resource.instance().init("Adamantine Leggings", "", 2, 20, 2, "legs"),
#		"Adamantine Greaves": armor_resource.instance().init("Adamantine Greaves", "", 2, 20, 2, "feet"),
#		"Mithril Helmet": armor_resource.instance().init("Mithril Helmet", "", 2, 20, 2, "head"),
#		"Mithril Vambraces": armor_resource.instance().init("Mithril Vambraces", "", 2, 20, 2, "arms"),
#		"Mithril Breastplate": armor_resource.instance().init("Mithril Breastplate", "", 2, 20, 2, "chest"),
#		"Mithril Leggings": armor_resource.instance().init("Mithril Leggings", "", 2, 20, 2, "legs"),
#		"Mithril Greaves": armor_resource.instance().init("Mithril Greaves", "", 2, 20, 2, "feet"),
#		"Dragon Scale Helmet": armor_resource.instance().init("Dragon Scale Helmet", "", 2, 20, 2, "head"),
#		"Dragon Scale Vambraces": armor_resource.instance().init("Dragon Scale Vambraces", "", 2, 20, 2, "arms"),
#		"Dragon Scale Breastplate": armor_resource.instance().init("Dragon Scale Breastplate", "", 2, 20, 2, "chest"),
#		"Dragon Scale Leggings": armor_resource.instance().init("Dragon Scale Leggings", "", 2, 20, 2, "legs"),
#		"Dragon Scale Greaves": armor_resource.instance().init("Dragon Scale Greaves", "", 2, 20, 2, "feet")
		}
	Wands = {
		"Magewood Wand": wand_resource.instantiate().init("Magewood Wand", "An excellent starter wand for an aspiring young mage.", 1.0, 20, 1.3, "None", 1, 3, 2),
#		"Magewood Scepter": wand_resource.instance().init("Magewood Scepter", "An excellent starter scepter for an aspiring young mage.", 3.0, 30, 1.3, "None", 1, 4, 2),
#		"Magewood Staff": wand_resource.instance().init("Magewood Staff", "An excellent starter staff for an aspiring young mage.", 1.0, 30, 1.5, "None", 1, 3, 2),
		"Sparktwig Wand": wand_resource.instantiate().init("Sparktwig Wand", "A wand crafted from a twig struck by a bolt of lightning.", 1.0, 20, 1.3, "Elemental", 1, 3, 2),
#		"Sparktwig Scepter": wand_resource.instance().init("Sparktwig Scepter", "A scepter crafted from a twig struck by a bolt of lightning.", 3.0, 30, 1.3, "Elemental", 1, 4, 2),
#		"Sparktwig Staff": wand_resource.instance().init("Sparktwig Staff", "A staff crafted from a twig struck by a bolt of lightning.", 1.0, 30, 1.5, "Elemental", 1, 3, 2),
		"Rat's Tail Wand": wand_resource.instantiate().init("Rat's Tail Wand", "Poor rat.", 1.0, 20, 1.3, "Wild", 1, 3, 2),
#		"Rat's Tail Scepter": wand_resource.instance().init("Rat's Tail Scepter", "Poor rat.", 3.0, 30, 1.3, "Wild", 1, 4, 2),
#		"Rat's Tail Staff": wand_resource.instance().init("Rat's Tail Staff", "Poor rat.", 1.0, 30, 1.5, "Wild", 1, 3, 2),
		"Hagfinger Wand": wand_resource.instantiate().init("Hagfinger Wand", "Crooked, no doubt like its former owner.", 1.0, 20, 1.3, "Cosmic", 1, 3, 2),
#		"Hagfinger Scepter": wand_resource.instance().init("Hagfinger Scepter", "Crooked, no doubt like its former owner.", 3.0, 30, 1.3, "Cosmic", 1, 4, 2),
#		"Hagfinger Staff": wand_resource.instance().init("Hagfinger Staff", "Crooked, no doubt like its former owner.", 1.0, 30, 1.5, "Cosmic", 1, 3, 2),
		"Dreamquartz Wand": wand_resource.instantiate().init("Dreamquartz Wand", "Cut from finest dreamquartz, this wand's facets swirl with color.", 2.0, 40, 1.6, "None", 2, 4, 2),
#		"Dreamquartz Scepter": wand_resource.instance().init("Dreamquartz Scepter", "Cut from finest dreamquartz, this scepter's facets swirl with color.", 3.0, 50, 1.6, "None", 2, 5, 2),
#		"Dreamquartz Staff": wand_resource.instance().init("Dreamquartz Staff", "Cut from finest dreamquartz, this staff's facets swirl with color.", 2.0, 50, 1.8, "None", 2, 4, 2),
		"Metajade Wand": wand_resource.instantiate().init("Metajade Wand", "Staring at this wand's omnidimensional fractal patterns makes your head feel funny.", 2.0, 40, 1.6, "Elemental", 2, 4, 2),
#		"Metajade Scepter": wand_resource.instance().init("Metajade Scepter", "Staring at this scepter's omnidimensional fractal patterns makes your head feel funny.", 3.0, 50, 1.6, "Elemental", 2, 5, 2),
#		"Metajade Staff": wand_resource.instance().init("Metajade Staff", "Staring at this staff's omnidimensional fractal patterns makes your head feel funny.", 2.0, 50, 1.8, "Elemental", 2, 4, 2),
		"Unicorn Horn Wand": wand_resource.instantiate().init("Unicorn Horn Wand", "You don't wanna know how this wand came to be.", 2.0, 40, 1.6, "Wild", 2, 4, 2),
#		"Unicorn Horn Scepter": wand_resource.instance().init("Unicorn Horn Scepter", "You don't wanna know how this scepter came to be.", 3.0, 50, 1.6, "Wild", 2, 5, 2),
#		"Unicorn Horn Staff": wand_resource.instance().init("Unicorn Horn Staff", "You don't wanna know how this staff came to be.", 2.0, 50, 1.8, "Wild", 2, 4, 2),
		"Astral Onyx Wand": wand_resource.instantiate().init("Astral Onyx Wand", "Dim points of light sparkle like starts within.", 2.0, 40, 1.6, "Cosmic", 2, 4, 2),
#		"Astral Onyx Scepter": wand_resource.instance().init("Astral Onyx Scepter", "Dim points of light sparkle like starts within.", 3.0, 50, 1.6, "Cosmic", 2, 5, 2),
#		"Astral Onyx Staff": wand_resource.instance().init("Astral Onyx Staff", "Dim points of light sparkle like starts within.", 2.0, 50, 1.8, "Cosmic", 2, 4, 2),
#		"Dragonbone Wand": wand_resource.instance().init("Dragonbone Wand", "", 2.0, 40, 1.9, "None", 3, 5, 2),
#		"Dragonbone Scepter": wand_resource.instance().init("Dragonbone Scepter", "Requires two hands to wield.", 2.0, 40, 1.9, "None", 3, 6, 2),
#		"Dragonbone Staff": wand_resource.instance().init("Dragonbone Staff", "Requires two hands to wield.", 2.0, 40, 2.1, "None", 3, 5, 2),
#		"Wildstone Wand": wand_resource.instance().init("Wildstone Wand", "", 2.0, 40, 1.9, "Elemental", 3, 5, 2),
#		"Wildstone Scepter": wand_resource.instance().init("Wildstone Scepter", "Requires two hands to wield.", 2.0, 40, 1.9, "Elemental", 3, 6, 2),
#		"Wildstone Staff": wand_resource.instance().init("Wildstone Staff", "Requires two hands to wield.", 2.0, 40, 2.1, "Elemental", 3, 5, 2),
#		"Petrified Lightning Wand": wand_resource.instance().init("Petrified Lightning Wand", "", 2.0, 40, 1.9, "Wild", 3, 5, 2),
#		"Petrified Lightning Scepter": wand_resource.instance().init("Petrified Lightning Scepter", "Requires two hands to wield.", 2.0, 40, 1.9, "Wild", 3, 6, 2),
#		"Petrified Lightning Staff": wand_resource.instance().init("Petrified Lightning Staff", "Requires two hands to wield.", 2.0, 40, 2.1, "Wild", 3, 5, 2),
#		"Worldtree Wand": wand_resource.instance().init("Worldtree Wand", "", 2.0, 40, 1.9, "Cosmic", 3, 5, 2),
#		"Worldtree Scepter": wand_resource.instance().init("Worldtree Scepter", "Requires two hands to wield.", 2.0, 40, 1.9, "Cosmic", 3, 6, 2),
#		"Worldtree Staff": wand_resource.instance().init("Worldtree Staff", "Requires two hands to wield.", 2.0, 40, 2.1, "Cosmic", 3, 5, 2),
	}
	SpellRunes = {
		"Magic Missile": spellrune_resource.instantiate().init("Spell Rune of Magic Missile", "A basic typeless damage spell, fit for any caster. Deals 5-10 damage base. Costs 5 less magicka than you regenerate per second", 0, 5, "RangedDamage", 5, 6, 0, 5),
		"Flaming Spear": spellrune_resource.instantiate().init("Spell Rune of Flaming Spear", "A fire-type damage spell that also deals burn damage over time.", 0, 10, "RangedFireDamage", 7, 6, 2, 30),
		"Frigid Blast": spellrune_resource.instantiate().init("Spell Rune of Frigid Blast", "A frost-type damage spell that also slows the target", 0, 10, "RangedFrostDamage", 7, 6, 2, 30),
		"Lightning Strike": spellrune_resource.instantiate().init("Spell Rune of Lightning Strike", "A lightning-type damage spell that also has a chance to arc to another target.", 0, 10, "RangedLightningDamage", 7, 6, 2, 30),
		"Caustic Bolt": spellrune_resource.instantiate().init("Spell Rune of Caustic Bolt", "An acid-type damage spell that also debuffs armor rating. Deals 7-12 damage base.", 0, 10, "RangedAcidDamage", 7, 6, 2, 30),
		"Vile Grasp": spellrune_resource.instantiate().init("Spell Rune of Vile Grasp", "An unholy-type damage spell that deals significant damage over time, but also buffs the target's damage output.", 0, 10, "RangedUnholyDamage", 7, 6, 2, 30),
		"Holy Lance": spellrune_resource.instantiate().init("Spell Rune of Holy Lance", "A holy-type damage spell that also has a chance to heal the user.", 0, 10, "RangedHolyDamage", 7, 6, 2, 30),
		"Summon Vulpite": spellrune_resource.instantiate().init("Spell Rune of Summon Vulpite", "Summons a fox-like spirit creature to aid you in battle.", 0, 10, "SummonVulpite", 3, 4, 2, 50)
	}
	Consumables = {
		"Healing Potion": cons_resource.instantiate().init("Healing Potion", "Heals you for 20 points on use.", 1.0, 0, "heal", 20, 0, 1),
		"Stamina Potion": cons_resource.instantiate().init("Stamina Potion", "Restores 10 stamina points on use.", 1.0, 0, "restore_stam", 10, 0, 1),
		"Magicka Potion": cons_resource.instantiate().init("Magicka Potion", "Restores 10 magicka points on use.", 1.0, 0, "restore_mag", 10, 0, 1),
	}
	Master.merge(Weapons, false)
	Master.merge(Armors, false)
	Master.merge(Wands, false)
	Master.merge(SpellRunes, false)
	Master.merge(Consumables, false)
	enemy_weapons = {
		"Fisticuffs": weapon_resource.instantiate().init("Fisticuffs", "", 4, 5, 5, 6, 25, 1.25, 0.02, 1)
	}
