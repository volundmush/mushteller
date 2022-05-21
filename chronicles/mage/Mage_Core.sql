INSERT INTO vol_story_templates
	(template_id,template_name,template_power_stat_name)
VALUES
	(4,"Mage","Gnosis")
ON DUPLICATE KEY UPDATE template_name=VALUES(template_name);

/* Splat Data */
INSERT INTO vol_story_template_sub
	(template_sub_id,template_id,template_sub_name,template_sub_slot)
VALUES
	(40000,4,"Path",0),
	(40001,4,"Order",1),
	(40002,4,"Legacy",2)
ON DUPLICATE KEY UPDATE template_id=VALUES(template_id),template_sub_name=VALUES(template_sub_name),template_sub_slot=VALUES(template_sub_slot);

INSERT INTO vol_story_template_sub_choices
	(template_sub_choice_id,template_sub_id,template_sub_choice_name)
VALUES 
	/* Mage X Splats - Paths */
	(40000,40000,"Acanthus"),
	(40001,40000,"Mastigos"),
	(40002,40000,"Moros"),
	(40003,40000,"Obrimos"),
	(40004,40000,"Thyrsus"),
	
	/* Mage Y Splats - Orders */
	(40005,40001,"Adamantine Arrow"),
	(40006,40001,"Guardians of the Veil"),
	(40007,40001,"Mysterium"),
	(40008,40001,"Silver Ladder"),
	(40009,40001,"Free Council"),
	(40010,40001,"Seers of the Throne")
ON DUPLICATE KEY UPDATE template_sub_id=VALUES(template_sub_id),template_sub_choice_name=VALUES(template_sub_choice_name);

/* Field Data - Mages use Mortal stuff! */
INSERT INTO vol_story_template_fields
	(tlink_id,field_id,template_id)
VALUES	
	/* Mage - Virtue and Vice */
	(40000,0,4),
	(40000,1,4)
ON DUPLICATE KEY UPDATE field_id=VALUES(field_id),template_id=VALUES(template_id);

/* Advantages */
INSERT INTO vol_story_stats
	(stat_id,template_id,stat_name,stat_plural,stat_can_set)
VALUES
	/* Mage - Template ID 4 */
	(40000,4,"Arcana","Arcana",0),
	(40001,4,"Rote","Rotes",0),

	(40007,4,"Mage Merit","Mage Merits",0),
	(40008,4,"Mage Flaw","Mage Flaws",0),
	(40009,4,"Mage Style","Mage Styles",0)
ON DUPLICATE KEY UPDATE template_id=VALUES(template_id),stat_name=VALUES(stat_name),stat_plural=VALUES(stat_plural),stat_can_set=VALUES(stat_can_set);

INSERT INTO vol_story_stats_ids
    (stat_id,stat_id_minimum,stat_id_maximum)
VALUES
    (40007,47000,47999),
    (40008,48000,48999),
    (40009,49000,49999)
ON DUPLICATE KEY UPDATE stat_id_minimum=VALUES(stat_id_minimum),stat_id_maximum=VALUES(stat_id_maximum);

INSERT INTO vol_story_stats
	(stat_parent,template_id,stat_id,stat_name,stat_can_set)
VALUES
	/* Mage - Arcana */
	(40000,4,40010,"Death",1),
	(40000,4,40011,"Fate",1),
	(40000,4,40012,"Forces",1),
	(40000,4,40013,"Life",1),
	(40000,4,40014,"Matter",1),
	(40000,4,40015,"Mind",1),
	(40000,4,40016,"Prime",1),
	(40000,4,40017,"Space",1),
	(40000,4,40018,"Spirit",1),
	(40000,4,40019,"Time",1),
	
	(40001,4,40020,"Death",0),
	(40001,4,40021,"Fate",0),
	(40001,4,40022,"Forces",0),
	(40001,4,40023,"Life",0),
	(40001,4,40024,"Matter",0),
	(40001,4,40025,"Mind",0),
	(40001,4,40026,"Prime",0),
	(40001,4,40027,"Space",0),
	(40001,4,40028,"Spirit",0),
	(40001,4,40029,"Time",0)
	
ON DUPLICATE KEY UPDATE stat_name=VALUES(stat_name);

INSERT INTO vol_story_stats
	(stat_parent,template_id,stat_id,stat_name,stat_rank)
VALUES
    /* Mage - Arcana - Death */
	(40020,4,40100,"Ectoplasmic Shaping",1),
	(40020,4,40101,"Deepen Shadows",1),
	(40020,4,40102,"Forensic Gaze",1),
	(40020,4,40103,"Shadow Sculpting",1),
	(40020,4,40104,"Soul Marks",1),
	(40020,4,40105,"Speak with the Dead",1),
	(40020,4,40106,"Corpse Mask",2),
	(40020,4,40107,"Decay",2),
	(40020,4,40108,"Ectoplasm",2),
	(40020,4,40109,"Ghost Shield",2),
	(40020,4,40110,"Shape Ephemera",2),
	(40020,4,40111,"Soul Armor",2),
	(40020,4,40112,"Soul Jar",2),
	(40020,4,40113,"Suppress Aura",2),
	(40020,4,40114,"Suppress Life",2),
	(40020,4,40115,"Touch of the Grave",2),
	(40020,4,40116,"Without a Trace",2),
	(40020,4,40117,"Cold Snap",3),
	(40020,4,40118,"Damage Ghost",3),
	(40020,4,40119,"Devouring the Slain",3),
	(40020,4,40120,"Ghost Gate",3),
	(40020,4,40121,"Ghost Summons",3),
	(40020,4,40122,"Quicken Corpse",3),
	(40020,4,40123,"Quicken Ghost",3),
	(40020,4,40124,"Rotting Flesh",3),
	(40020,4,40125,"Sever Soul",3),
	(40020,4,40126,"Shadow Crafting",3),
	(40020,4,40127,"Enervation",4),
	(40020,4,40128,"Exorcism",4),
	(40020,4,40129,"Revenant",4),
	(40020,4,40130,"Shadow Flesh",4),
	(40020,4,40131,"Withering Death",4),
	(40020,4,40132,"Create Anchor",5),
	(40020,4,40133,"Create Ghost",5),
	(40020,4,40134,"Deny the Reaper",5),
	(40020,4,40135,"Empty Presence",5),
	(40020,4,40136,"Open Avernian Gate",5),
	(40020,4,40137,"Sever the Awakened Soul",5),
	
	/* Mage - Arcana - Fate */
	(40021,4,40300,"Interconnections",1),
	(40021,4,40301,"Oaths Fulfilled",1),
	(40021,4,40302,"Quantum Flux",1),
	(40021,4,40303,"Reading the Outmost Eddies",1),
	(40021,4,40304,"Serendipity",1),
	(40021,4,40305,"Exceptional Luck",2),
	(40021,4,40306,"Fabricate Fortunate",2),
	(40021,4,40307,"Fools Rush In",2),
	(40021,4,40308,"Lucky Number",2),
	(40021,4,40309,"Shifting the Odds",2),
	(40021,4,40310,"Warding Gesture",2),
	(40021,4,40311,"Grave Misfortune",3),
	(40021,4,40312,"Monkey's Paw",3),
	(40021,4,40313,"Shared Fate",3),
	(40021,4,40314,"Superlative Luck",3),
	(40021,4,40315,"Sworn Oaths",3),
	(40021,4,40316,"Atonement",4),
	(40021,4,40317,"Chaos Mastery",4),
	(40021,4,40318,"Divine Intervention",4),
	(40021,4,40319,"Strings of Fate",4),
	(40021,4,40320,"Sever Oaths",4),
	(40021,4,40321,"Forge Destiny",5),
	(40021,4,40322,"Pariah",5),
	(40021,4,40323,"Miracle",5),
	(40021,4,40324,"Swarm of Locusts",5),
	
	/* Mage - Arcana - Forces */
	(40022,4,40500,"Influence Electricity",1),
	(40022,4,40501,"Influence Fire",1),
	(40022,4,40502,"Kinetic Efficiency",1),
	(40022,4,40503,"Influence Heat",1),
	(40022,4,40504,"Nightvision",1),
	(40022,4,40505,"Receiver",1),
	(40022,4,40506,"Tune In",1),
	(40022,4,40507,"Control Electricity",2),
	(40022,4,40508,"Control Fire",2),
	(40022,4,40509,"Control Gravity",2),
	(40022,4,40510,"Control Heat",2),
	(40022,4,40511,"Control Light",2),
	(40022,4,40512,"Control Sound",2),
	(40022,4,40513,"Control Weather",2),
	(40022,4,40514,"Environmental Shield",2),
	(40022,4,40515,"Invisibility",2),
	(40022,4,40516,"Kinetic Blow",2),
	(40022,4,40517,"Transmission",2),
	(40022,4,40518,"Zoom In",2),
	(40022,4,40519,"Call Lightning",3),
	(40022,4,40520,"Gravitic Supremacy",3),
	(40022,4,40521,"Telekinesis",3),
	(40022,4,40522,"Telekinetic Strike",3),
	(40022,4,40523,"Turn Momentum",3),
	(40022,4,40524,"Velocity Control",3),
	(40022,4,40525,"Electromagnetic Pulse",4),
	(40022,4,40526,"Levitation",4),
	(40022,4,40527,"Rend Friction",4),
	(40022,4,40528,"Thunderbolt",4),
	(40022,4,40529,"Transform Energy",4),
	(40022,4,40530,"Adverse Weather",5),
	(40022,4,40531,"Create Energy",5),
	(40022,4,40532,"Eradicate Energy",5),
	(40022,4,40533,"Earthquake",5),
	
	/* Mage - Arcana - Life */
	(40023,4,40700,"Analyze Life",1),
	(40023,4,40701,"Cleanse the Body",1),
	(40023,4,40702,"Speak With Beasts",1),
	(40023,4,40703,"Web of Life",1),
	(40023,4,40704,"Body Control",2),
	(40023,4,40705,"Control Instincts",2),
	(40023,4,40706,"Heightened Senses",2),
	(40023,4,40707,"Lure and Repel",2),
	(40023,4,40708,"Mutable Mask",2),
	(40023,4,40709,"Purge Illness",2),
	(40023,4,40710,"Bruise Flesh",3),
	(40023,4,40711,"Degrading the Form",3),
	(40023,4,40712,"Honing the Form",3),
	(40023,4,40713,"Knit",3),
	(40023,4,40714,"Many Faces",3),
	(40023,4,40715,"Transform Life",3),
	(40023,4,40716,"Accelerate Growth",4),
	(40023,4,40717,"Animal Minion",4),
	(40023,4,40718,"Life-Force Assault",4),
	(40023,4,40719,"Mend",4),
	(40023,4,40720,"Regeneration",4),
	(40023,4,40721,"Shapechanging",4),
	(40023,4,40722,"Create Life",5),
	(40023,4,40723,"Contagion",5),
	(40023,4,40724,"Salt the Earth",5),
	
	/* Mage - Arcana - Matter */
	(40024,4,40900,"Craftsman's Eye",1),
	(40024,4,40901,"Detect Substance",1),
	(40024,4,40902,"Discern Composition",1),
	(40024,4,40903,"Lodestone",1),
	(40024,4,40904,"Remote Control",1),
	(40024,4,40905,"Alchemist's Touch",2),
	(40024,4,40906,"Find the Balance",2),
	(40024,4,40907,"Hidden Hoard",2),
	(40024,4,40908,"Machine Invisibility",2),
	(40024,4,40909,"Shaping",2),
	(40024,4,40910,"Aegis",3),
	(40024,4,40911,"Alter Conductivity",3),
	(40024,4,40912,"Alter Integrity",3),
	(40024,4,40913,"Crucible",3),
	(40024,4,40914,"Nigredo and Albedo",3),
	(40024,4,40915,"Shrink and Grow",3),
	(40024,4,40916,"State Change",3),
	(40024,4,40917,"Windstrike",3),
	(40024,4,40918,"Wonderful Machine",3),
	(40024,4,40919,"Ghostwall",4),
	(40024,4,40920,"Golem",4),
	(40024,4,40921,"Piercing Earth",4),
	(40024,4,40922,"Transubstantiation",4),
	(40024,4,40923,"Annihilate Matter",5),
	(40024,4,40924,"Ex Nihilo",5),
	(40024,4,40925,"Self-Repairing Machine",5),
	
	/* Mage - Arcana - Mind */
	(40025,4,41100,"Know Nature",1),
	(40025,4,41101,"Mental Scan",1),
	(40025,4,41102,"One Mind Two Thoughts",1),
	(40025,4,41103,"Perfect Recall",1),
	(40025,4,41104,"Alter Mental Pattern",2),
	(40025,4,41105,"Dream Reaching",2),
	(40025,4,41106,"Emotional Urging",2),
	(40025,4,41107,"First Impressions",2),
	(40025,4,41108,"Incognito Presence",2),
	(40025,4,41109,"Memory Hole",2),
	(40025,4,41110,"Mental Shield",2),
	(40025,4,41111,"Psychic Domination",2),
	(40025,4,41112,"Telepathy",2),
	(40025,4,41113,"Augment Mind",3),
	(40025,4,41114,"Clear Thoughts",3),
	(40025,4,41115,"Enhance Skill",3),
	(40025,4,41116,"Goetic Summons",3),
	(40025,4,41117,"Impostor",3),
	(40025,4,41118,"Psychic Assault",3),
	(40025,4,41119,"Sleep of the Just",3),
	(40025,4,41120,"Read the Depths",3),
	(40025,4,41121,"Universal Language",3),
	(40025,4,41122,"Befuddle",4),
	(40025,4,41123,"Gain Skill",4),
	(40025,4,41124,"Hallucination",4),
	(40025,4,41125,"Mind Flay",4),
	(40025,4,41126,"Psychic Projection",4),
	(40025,4,41127,"Psychic Reprogramming",4),
	(40025,4,41128,"Terrorize",4),
	(40025,4,41129,"Amorality",5),
	(40025,4,41130,"No Exit",5),
	(40025,4,41131,"Mind Wipe",5),
	(40025,4,41132,"Possession",5),
	(40025,4,41133,"Psychic Genesis",5),
	(40025,4,41134,"Social Networking",5),
	
	/* Mage - Arcana - Prime */
	(40026,4,41300,"Dispel Magic",1),
	(40026,4,41301,"Pierce Deception",1),
	(40026,4,41302,"Supernal Vision",1),
	(40026,4,41303,"Sacred Geometry",1),
	(40026,4,41304,"Scribe Grimoire",1),
	(40026,4,41305,"Word of Command",1),
	(40026,4,41306,"As Above So Below",2),
	(40026,4,41307,"Cloak Nimbus",2),
	(40026,4,41308,"Invisible Runes",2),
	(40026,4,41309,"Supernal Veil",2),
	(40026,4,41310,"Wards and Signs",2),
	(40026,4,41311,"Words of Truth",2),
	(40026,4,41312,"Aetheric Winds",3),
	(40026,4,41313,"Channel Mana",3),
	(40026,4,41314,"Cleanse Pattern",3),
	(40026,4,41315,"Display of Power",3),
	(40026,4,41316,"Ephemeral Enchantment",3),
	(40026,4,41317,"Geomancy",3),
	(40026,4,41318,"Platonic Form",3),
	(40026,4,41319,"Stealing Fire",3),
	(40026,4,41320,"Apocalypse",4),
	(40026,4,41321,"Celestial Fire",4),
	(40026,4,41322,"Destroy Tass",4),
	(40026,4,41323,"Hallow Dance",4),
	(40026,4,41324,"Supernal Dispellation",4),
	(40026,4,41325,"Blasphemy",5),
	(40026,4,41326,"Create Truth",5),
	(40026,4,41327,"Eidolon",5),
	(40026,4,41328,"Forge Purpose",5),
	(40026,4,41329,"Word of Unmaking",5),

	/* Mage - Arcana - Space */
	(40027,4,41500,"Correspondence",1),
	(40027,4,41501,"Ground-Eater",1),
	(40027,4,41502,"Locate Object",1),
	(40027,4,41503,"The Outward and Inward Eye",1),
	(40027,4,41504,"Borrow Threads",2),
	(40027,4,41505,"Break Boundary",2),
	(40027,4,41506,"Lying Maps",2),
	(40027,4,41507,"Scrying",2),
	(40027,4,41508,"Secret Door",2),
	(40027,4,41509,"Veil Sympathy",2),
	(40027,4,41510,"Ward",2),
	(40027,4,41511,"Ban",3),
	(40027,4,41512,"Co-Location",3),
	(40027,4,41513,"Perfect Sympathy",3),
	(40027,4,41514,"Warp",3),
	(40027,4,41515,"Web-Weaver",3),
	(40027,4,41516,"Alter Direction",4),
	(40027,4,41517,"Collapse",4),
	(40027,4,41518,"Cut Threads",4),
	(40027,4,41519,"Secret Room",4),
	(40027,4,41520,"Teleportation",4),
	(40027,4,41521,"Create Sympathy",5),
	(40027,4,41522,"Forge No Chains",5),
	(40027,4,41523,"Pocket Dimension",5),
	(40027,4,41524,"Quarantine",5),
	
	/* Mage - Arcana - Spirit */
	(40028,4,41700,"Coaxing the Spirits",1),
	(40028,4,41701,"Exorcist's Eye",1),
	(40028,4,41702,"Gremlins",1),
	(40028,4,41703,"Invoke Bane",1),
	(40028,4,41704,"Know Spirit",1),
	(40028,4,41705,"Cap the Well",2),
	(40028,4,41706,"Channel Essence",2),
	(40028,4,41707,"Command Spirit",2),
	(40028,4,41708,"Ephemeral Shield",2),
	(40028,4,41709,"Gossamer Touch",2),
	(40028,4,41710,"Opener of the Way",2),
	(40028,4,41711,"Shadow Walk",2),
	(40028,4,41712,"Slumber",2),
	(40028,4,41713,"Bolster Spirit",3),
	(40028,4,41714,"Erode Resonance",3),
	(40028,4,41715,"Howl From Beyond",3),
	(40028,4,41716,"Place of Power",3),
	(40028,4,41717,"Reaching",3),
	(40028,4,41718,"Rouse Spirit",3),
	(40028,4,41719,"Spirit Summons",3),
	(40028,4,41720,"Banishment",4),
	(40028,4,41721,"Bind Spirit",4),
	(40028,4,41722,"Craft Fetish",4),
	(40028,4,41723,"Familiar",4),
	(40028,4,41724,"Shape Spirit",4),
	(40028,4,41725,"Twilit Body",4),
	(40028,4,41726,"World Walker",4),
	(40028,4,41727,"Annihilate Spirit",5),
	(40028,4,41728,"Birth Spirit",5),
	(40028,4,41729,"Create Locus",5),
	(40028,4,41730,"Essence Foundation",5),
	(40028,4,41731,"Spirit Manse",5),

	/* Mage - Arcana - Time */
	(40029,4,41900,"Divination",1),
	(40029,4,41901,"Green Light Red Light",1),
	(40029,4,41902,"Momentary Flux",1),
	(40029,4,41903,"Perfect Timing",1),
	(40029,4,41904,"Postcognition",1),
	(40029,4,41905,"Choose the Thread",2),
	(40029,4,41906,"Constant Presence",2),
	(40029,4,41907,"Hung Spell",2),
	(40029,4,41908,"Shield of Chronos",2),
	(40029,4,41909,"Tipping the Hourglass",2),
	(40029,4,41910,"Veil of Moments",2),
	(40029,4,41911,"Acceleration",3),
	(40029,4,41912,"Chronos' Curse",3),
	(40029,4,41913,"Shifting Sands",3),
	(40029,4,41914,"Temporal Summoning",3),
	(40029,4,41915,"Weight of Years",3),
	(40029,4,41916,"Present as Past",4),
	(40029,4,41917,"Prophecy",4),
	(40029,4,41918,"Rend Lifespan",4),
	(40029,4,41919,"Rewrite History",4),
	(40029,4,41920,"Temporal Stutter",4),
	(40029,4,41921,"Blink of an Eye",5),
	(40029,4,41922,"Corridors of Time",5),
	(40029,4,41923,"Temporal Pocket",5)
ON DUPLICATE KEY UPDATE stat_name=VALUES(stat_name);

INSERT INTO vol_story_pools
	(pool_id,pool_category_id,pool_name,pool_unit_name,pool_single_name,pool_plural_name,pool_sort)
VALUES
	/* Mage */
	(9,1,"Mana","Mana","Point","Points",2),
	(10,2,"Wisdom","Wisdom","Dot","Dots",1)

ON DUPLICATE KEY UPDATE pool_category_id=VALUES(pool_category_id),pool_name=VALUES(pool_name),pool_single_name=VALUES(pool_single_name),pool_plural_name=VALUES(pool_plural_name),pool_sort=VALUES(pool_sort);