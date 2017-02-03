-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'PDT', 'MDT', 'Empyrian')-- 'MDT'
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT')-- 'HP', 'Reraise', 'Charm'
    state.MagicalDefenseMode:options('MDT')-- 'HP', 'Reraise', 'Charm'
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')

    update_defense_mode()
    
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
    send_command('bind @f10 gs c toggle EquipShield')
    send_command('bind @f11 gs c toggle EquipShield')

    select_default_macro_book()
end

function user_unload()
    send_command('unbind ^f11')
    send_command('unbind !f11')
    send_command('unbind @f10')
    send_command('unbind @f11')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = {legs="Cab. Breeches"}
    sets.precast.JA['Holy Circle'] = {feet="Reverence Leggings"}
    sets.precast.JA['Shield Bash'] = {hands="Cab. Gauntlets"}
    sets.precast.JA['Sentinel'] = {feet="Cab. Leggings +1"}
    sets.precast.JA['Rampart'] = {head="Cab. Coronet"}
    sets.precast.JA['Fealty'] = {body="Cab. Surcoat",head="Founder's Corona"}
    sets.precast.JA['Divine Emblem'] = {feet="Chev. Sabatons +1",ammo="Dosis Tathlum",waist="Asklepian Belt"}
    sets.precast.JA['Cover'] = {head="Reverence Coronet"}

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
		head="Jumalik Helm",ring1="Levia. Ring",ring2="Levia. Ring",ear1="Lifestorm Earring",ear2="Nourish. Earring +1",body="Cab. Gauntlets",hands="Sulev. Gauntlets +1",
		legs="Flamma Dirs",feet="Flam. Gambieras +1"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		head="Sulevia's Mask +1",neck="Unmoving Collar",ear1="Soil Pearl",ear2="Soil Pearl",
		body="Sulevia's Plate +1",hands="Sulev. Gauntlets +1",ring1="Titan Ring",ring2="Titan Ring",
		back="Iximulew Cape",waist="Chuq'aba Belt",legs="Sulevi. Cuisses +1",feet="Amm Greaves"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {waist="Anguinus Belt"}
    sets.precast.Flourish1 = {waist="Anguinus Belt"}

	
    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Impatiens",
		head="Carmine Mask",neck="Voltsurge Torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
		ring1="Weatherspoon Ring",ring2="Prolix Ring",body="Jumalik Mail",hands="Leyline Gloves",
		legs="Flamma Dirs",feet="Odyssean Greaves"}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Voltsurge Torque"})

	sets.precast.FC.Cure = set_combine(sets.precast.FC,
		{head="Carmine Mask",body="Jumalik Mail",ear2="Nourish. Earring +1",ear1="Mendi. Earring",hands="Leyline Gloves",
		ring1="Weatherspoon Ring",ring2="Prolix Ring",legs="Flamma Dirs",back="Rudianos's Mantle",waist="Chuq'aba Belt",feet="Odyssean Greaves"})
		--ear2="Loquacious Earring"/ Carmine Mask
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Amar Cluster",
        head="Valorous Mask",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Sulevia's Plate. +1",hands="Sulev. Gauntlets +1",ring1="Petrov Ring",ring2="Rajas Ring",
		back="Atheling Mantle",waist="Fotia Belt",legs="Sulevi. Cuisses +1",feet="Sulev. Leggings +1"}--Fotia Gorget/Fotia Belt/Phorcys Korazin
		
    sets.precast.WS.Acc = {ammo="Amar Cluster",
        head="Carmine Mask",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Jumalik Mail",hands="Sulev. Gauntlets +1",ring1="Petrov Ring",ring2="Ramuh Ring",
		back="Atheling Mantle",waist="Fotia Belt",legs="Sulevi. Cuisses +1",feet="Sulev. Leggings +1"}--body="Phorcys Korazin"
		
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ammo="Amar Cluster",ring1="Levia. Ring",ring2="Levia. Ring",back="Atheling Mantle",body="Sulevia's Plate. +1",feet="Sulev. Leggings +1",legs="Flamma Dirs",hands="Sulev. Gauntlets +1",head="Valorous Mask"})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {ring1="Levia. Ring"})

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {ammo="Amar Cluster",head="Valorous Mask",feet="Thereoid Greaves",body="Vatic Byrnie",ring1="Begrudging Ring",
	neck="Fotia Gorget",waist="Fotia Belt",hands="Sulevia's Gauntlets +1",
	back="Rudianos's Mantle",legs="Sulevi. Cuisses +1"})--Vatic Byrnie,Leyline Gloves,Sulevia's Plate,Odyssean Cuisses,Sulevia's Cuisses/Jukukik Feather/Argosy Mufflers/Sulevia's Gauntlets +1/Odyssean Cuisses
	
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {waist="Chuq'aba Belt"})

    sets.precast.WS['Sanguine Blade'] = {ammo="Amar Cluster",
		head="Jumalik Helm",neck="Fotia Gorget",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Jumalik Mail",hands="Sulev. Gauntlets +1",ring1="Weather. Ring",ring2="Locus Ring",
		back="Toro Cape",waist="Fotia Belt",legs="Flamma Dirs",feet="Founder's Greaves"}--Fenrir Ring +1 / Dosis Tathlum / Sancitity Necklace
    
    sets.precast.WS['Atonement'] = {ammo="Amar Cluster",
        head="Hero's Galea",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Jumalik Mail",hands="Souv. Handschuhs",ring1="Begrudging Ring",ring2="Supershear Ring",
        back="Rudianos's Mantle",waist="Fotia Belt",legs="Brontes Cuisses",feet="Chev. Sabatons +1"}--Chevalier's Sabatons
    
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {head="Valorous Mask",ear1="Ishvara Earring",feet="Sulev. Leggings +1",body="Phorcys Korazin"})
	
	-- Great Sword Weapon Skills
	
	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {head="Valorous Mask",ring2="Ifrit Ring",back="Atheling Mantle",legs="Flamma Dirs"})
	
	sets.precast.WS['Torcleaver'] = set_combine(sets.precast.WS, {hands="Sulev. Gauntlets +1",ring1="Titan Ring",ring2="Titan Ring",feet="Founder's Greaves",head="Jumalik Helm",body="Jumalik Mail",
	back="Iximulew Cape",waist="Fotia Belt",neck="Unmoving Collar",legs="Flamma Dirs"})--Souveran Schaller
	
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {ammo="Impatiens",
		head="Carmine Mask",neck="Voltsurge Torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
		ring1="Weatherspoon Ring",ring2="Prolix Ring",
		body="Jumalik Mail",hands="Leyline Gloves",
		waist="Zoran's Belt",legs="Flamma Dirs",feet="Odyssean Greaves"}--Carmine Mask
        
    sets.midcast.Enmity = {ammo="Amar Cluster",
		head="Hero's Galea",neck="Unmoving Collar",ear1="Friomisi Earring",
		body="Jumalik Mail",hands="Souv. Handschuhs",ring1="Begrudging Ring",ring2="Supershear Ring",
		back="Rudianos's Mantle",waist="Creed Baudrier",legs="Brontes Cuisses",feet="Chev. Sabatons +1"}--Chevalier's Cuisses / Chevalier's Sabatons / Brontes Cuisses

	sets.midcast.Provoke = {ammo="Amar Cluster",
		head="Hero's Galea",neck="Unmoving Collar",ear1="Friomisi Earring",
		body="Jumalik Mail",hands="Souv. Handschuhs",ring1="Begrudging Ring",ring2="Supershear Ring",
		back="Rudianos's Mantle",waist="Creed Baudrier",legs="Brontes Cuisses",feet="Chev. Sabatons +1"}--Chevalier's Cuisses / Chevalier's Sabatons / Brontes Cuisses
		
    sets.midcast.Flash = set_combine(sets.midcast.Enmity, {legs="Brontes Cuisses"})
    
    sets.midcast.Phalanx = set_combine(sets.midcast.FastRecast, {hands="Souv. Handschuhs",feet="Souveran Schuhs"})
    
    sets.midcast.Cure = {ammo="Impatiens",
		head="Carmine Mask",neck="Voltsurge Torque",ear2="Nourish. Earring +1",ear1="Mendi. Earring",
		body="Jumalik Mail",hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Rudianos's Mantle",waist="Chuq'aba Belt",legs="Flamma Dirs",feet="Odyssean Greaves"}--Incanter's Torque/Carmine Mask/Buremte Gloves/Enif Cosciales

    sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast,  {neck="Incanter's Torque",waist="Siegel Sash"})--Incanter's Torque/legs="Reverence Breeches"
    
	sets.midcast['Divine Magic'] = {ammo="Dosis Tathlum",
		head="Jumalik Helm",neck="Incanter's Torque",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Jumalik Mail",hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Locus Ring",
		back="Toro Cape",waist="Asklepian Belt",legs="Flamma Dirs",feet="Founder's Greaves"}--Sancitity Necklace/Incanter's Torque
	
    sets.midcast.Protect = set_combine(sets.midcast.FastRecast,  {ring1="Sheltered Ring"})
    sets.midcast.Shell = set_combine(sets.midcast.FastRecast, {ring1="Sheltered Ring"})
    
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
   --LV 99 WAR PLD DRK DRG
   
   --Sulevia's Mask +1 (DEF:118 HP+40 MP+40 STR+30 DEX+16 VIT+37 AGI+12 INT+11 MND+19 CHR+19 Accuracy+38 Attack+42 Evasion+27 Magic Evasion+43 "Magic Def. Bonus"+1 Haste+3% "Store TP"+8 Damage taken -5%)
   
   --Sulevia's Plate. +1 (DEF:148 HP+70 MP+70 STR+38 DEX+21 VIT+38 AGI+16 INT+16 MND+24 CHR+24 Accuracy+40 Attack+44 Evasion+36 Magic Evasion+59 "Magic Def. Bonus"+3 Haste+1% "Skillchain bonus" +6 Damage taken -8%)
   
   --Sulev. Gauntlets +1 (DEF:106 HP+30 MP+30 STR+20 DEX+31 VIT+42 INT+6 MND+29 CHR+24 Accuracy+37 Attack+41 Evasion+16 Magic Evasion+37 Haste+3% "Double Attack"+5% Damage taken -4%)
   
   --Sulevi. Cuisses +1 (DEF:130 HP+50 MP+50 STR+44 VIT+30 AGI+14 INT+24 MND+17 CHR+15 Accuracy+39 Attack+43 Evasion+16 Magic Evasion+75 "Magic Def. Bonus"+2 Haste+2% "Triple Attack"+3% Damage taken -6%)
   
   --Sulev. Leggings +1 (DEF:88 HP+20 MP+20 STR+26 DEX+16 VIT+26 AGI+26 MND+15 CHR+29 Accuracy+36 Attack+40 Evasion+44 Magic Evasion+75 "Magic Def. Bonus"+1 Haste+1% Weapon Skill damage +6% Damage taken -3%)
   
    
   --Flamma SET
   
   
	--Flamma Zucchetto (DEF:113 HP+80 MP+20 STR+25 DEX+21 VIT+24 AGI+16 INT+12 MND+12 CHR+12 Accuracy+26 Magic Accuracy+26 Evasion+49 Magic Evasion+53 "Magic Def. Bonus"+3 Haste+4% "Triple Attack"+2% "Store TP"+3)
	
	--Flamma Korazin (DEF:143 HP+140 MP+35 STR+32 DEX+28 VIT+32 AGI+20 INT+20 MND+20 CHR+20 Accuracy+28 Magic Accuracy+28 Evasion+55 Magic Evasion+69 "Magic Def. Bonus"+6 Haste+2% "Store TP"+5 "Subtle Blow"+10)
	
	--Flam. Manopolas +1 (DEF:106 HP+60 MP+15 STR+19 DEX+42 VIT+35 AGI+8 INT+7 MND+24 CHR+17 Accuracy+37 Magic Accuracy+37 Evasion+36 Magic Evasion+48 "Magic Def. Bonus"+2 Haste+4% "Store TP"+5 Critical hit rate +7%)
	
	--Flamma Dirs (DEF:125 HP+100 MP+25 STR+42 VIT+29 AGI+16 INT+24 MND+14 CHR+11 Accuracy+27 Magic Accuracy+27 Evasion+41 Magic Evasion+86 "Magic Def. Bonus"+5 Haste+4% "Store TP"+5 Potency of "Cure" effect received +5%)
	
	--Flam. Gambieras +1 (DEF:88 HP+40 MP+10 STR+27 DEX+30 VIT+20 AGI+26 MND+6 CHR+20 Accuracy+36 Magic Accuracy+36 Evasion+74 Magic Evasion+86 "Magic Def. Bonus"+5 Haste+2% "Double Attack"+5% "Store TP"+5)
   
   
   
   --head="Valorous Mask"
   
   --head="Valorous Mask"
   
	sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
 
    sets.resting = {head="Twilight Helm",neck="Lissome Necklace",ear1="Brutal Earring",
		body="Twilight Mail",legs="Crimson Cuisses",ring1="Paguroidea Ring",ring2="Sheltered Ring",
		back="Rudianos's Mantle",waist="Fucho-no-obi"}
    

    -- Idle sets
    sets.idle = {ammo="Ginsen",
		head="Valorous Mask",neck="Creed Collar",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Jumalik Mail",hands="Sulev. Gauntlets +1",ring1="Paguroidea Ring",ring2="Sheltered Ring",
		back="Rudianos's Mantle",waist="Fucho-no-obi",legs="Crimson Cuisses",feet="Sulev. Leggings +1"} --Homiliary / Weard Mantle / Fucho-no-obi

    sets.idle.Town = {main="Nixxer",sub="Aegis",ammo="Ginsen",
		head="Valorous Mask",neck="Creed Collar",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Jumalik Mail",hands="Sulev. Gauntlets +1",ring1="Paguroidea Ring",ring2="Sheltered Ring",
		back="Rudianos's Mantle",waist="Fucho-no-obi",legs="Crimson Cuisses",feet="Sulev. Leggings +1"} --Brilliance / Homiliary / Ochain / Aegis
    
    sets.idle.Weak = {ammo="Ginsen",
		head="Twilight Helm",neck="Creed Collar",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Twilight Mail",hands="Sulev. Gauntlets +1",ring1="Dark Ring",ring2="Sheltered Ring",
		back="Rudianos's Mantle",waist="Fucho-no-obi",legs="Crimson Cuisses",feet="Sulev. Leggings +1"}--Homiliary
    
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
    
    sets.Kiting = {legs="Crimson Cuisses"}

    sets.latent_refresh = {waist="Fucho-no-obi"}


    --------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {back="Impassive Mantle"}
    sets.MP = {neck="Creed Collar",waist="Nierenschutz"}
    sets.MP_Knockback = {neck="Creed Collar",waist="Nierenschutz",back="Impassive Mantle"}
    
    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {main="Nixxer",sub="Ochain"} -- Ochain
    sets.MagicalShield = {main="Nixxer",sub="Aegis"} -- Aegis/Emet Harness/Brilliance

    -- Basic defense sets.
        --					Damage Taken down:
		
		--head 						-5%
		--neck 						-5%
		--body 						-8%
		--hands 					-4%
		--Dark ring 				-5%
		--Defending Ring 			-10%
		--back 						-3%
		--waist 					-3%
		--legs 						-6%
		--feet 						-5%                    Amm Greaves
		-- Damage Taken 			-54% 		TOTAL 
		
    sets.defense.PDT = {sub="Ochain",ammo="Amar Cluster",
		head="Sulevia's Mask +1",neck="Twilight Torque",ear1="Thureous Earring",ear2="Cessance Earring",
		body="Sulevia's Plate. +1",hands="Sulev. Gauntlets +1",ring1="Dark ring",ring2="Defending Ring",
		back="Rudianos's Mantle",waist="Nierenschutz",legs="Sulevi. Cuisses +1",feet="Sulev. Leggings +1"} --Founder's Gauntlets/Colossus's Earring/Chevalier's Cuisses/Angha Gem

	sets.defense.HP = set_combine (sets.defense.PDT, {ring1="Rajas Ring",ring2="Defending Ring",hands="Souv. Handschuhs",feet="Souveran Schuhs",
		back="Rudianos's Mantle",waist="Creed Baudrier"})

    sets.defense.Reraise = {ammo="Amar Cluster",
        head="Twilight Helm",neck="Twilight Torque",ear1="Thureous Earring",ear2="Cessance Earring",
        body="Twilight Mail",hands="Sulev. Gauntlets +1",ring1="Dark Ring",ring2="Defending Ring",
        back="Rudianos's Mantle",waist="Nierenschutz",legs="Sulevi. Cuisses +1",feet="Amm Greaves"} --Amm Greaves
    
	sets.defense.Charm = {ammo="Amar Cluster",
        head="Twilight Helm",neck="Twilight Torque",ear1="Thureous Earring",ear2="Cessance Earring",
        body="Twilight Mail",hands="Sulev. Gauntlets +1",ring1="Dark Ring",ring2="Defending Ring",
        back="Rudianos's Mantle",waist="Nierenschutz",legs="Sulevi. Cuisses +1",feet="Amm Greaves"}
    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    
	sets.defense.MDT = {sub="Aegis",ammo="Amar Cluster",
		head="Sulevia's Mask +1",neck="Twilight Torque",ear1="Thureous Earring",ear2="Cessance Earring",
		body="Sulevia's Plate. +1",hands="Sulev. Gauntlets +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Rudianos's Mantle",waist="Nierenschutz",legs="Sulevi. Cuisses +1",feet="Sulev. Leggings +1"}--Jumalik Mail


    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    sets.engaged = {ammo="Ginsen",
		head="Flamma Zucchetto",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Flamma Korazin",hands="Sulev. Gauntlets +1",ring1="Petrov Ring",ring2="Rajas Ring",
		back="Atheling Mantle",waist="Zoran's Belt",legs="Flamma Dirs",feet="Flam. Gambieras +1"}--Founder's Corona / Found. Breastplate / Founder's Hose / Letalis Mantle / Loyalist Sabatons

    sets.engaged.Acc = {ammo="Amar Cluster",
		head="Carmine Mask",neck="Lissome Necklace",ear1="Digni. Earring",ear2="Cessance Earring",
		body="Flamma Korazin",hands="Sulev. Gauntlets +1",ring1="Begrudging Ring",ring2="Supershear Ring",
		back="Rudianos's Mantle",waist="Anguinus Belt",legs="Flamma Dirs",feet="Flam. Gambieras +1"} --Subtlety Spec.

	sets.engaged.PDT = {ammo="Amar Cluster",
		head="Sulevia's Mask +1",neck="Twilight Torque",ear1="Thureous Earring",ear2="Cessance Earring",
		body="Sulevia's Plate. +1",hands="Sulev. Gauntlets +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Rudianos's Mantle",waist="Nierenschutz",legs="Sulevi. Cuisses +1",feet="Amm Greaves"}--Sulevia's Plate. +1
		
	sets.engaged.Empyrian = set_combine(sets.engaged,   {head="Chevalier's Armet",body="Chev. Cuirass",hands="Chev. Gauntlets +1",legs="Chevalier's Cuisses",feet="Chev. Sabatons +1"})
		
	sets.engaged.MDT = {ammo="Amar Cluster",
		head="Sulevia's Mask +1",neck="Twilight Torque",ear1="Thureous Earring",ear2="Cessance Earring",
		body="Sulevia's Plate. +1",hands="Sulev. Gauntlets +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Rudianos's Mantle",waist="Nierenschutz",legs="Sulevi. Cuisses +1",feet="Sulev. Leggings +1"}
		
	sets.engaged.Reraise = {ammo="Amar Cluster",
		head="Twilight Helm",neck="Asperity Necklace",ear1="Thureous Earring",ear2="Cessance Earring",
		body="Twilight Mail",hands="Sulev. Gauntlets +1",ring1="Petrov Ring",ring2="Rajas Ring",
		back="Atheling Mantle",waist="Zoran's Belt",legs="Sulevi. Cuisses +1",feet="Flam. Gambieras +1"}
		
    sets.engaged.DW = {ammo="Ginsen",
		head="Flamma Zucchetto",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Flamma Korazin",hands="Sulev. Gauntlets +1",ring1="Petrov Ring",ring2="Rajas Ring",
		back="Atheling Mantle",waist="Zoran's Belt",legs="Flamma Dirs",feet="Flam. Gambieras +1"}

    sets.engaged.DW.Acc = {ammo="Amar Cluster",
		head="Carmine Mask",neck="Lissome Necklace",ear1="Digni. Earring",ear2="Cessance Earring",
		body="Sulevia's Plate. +1",hands="Sulev. Gauntlets +1",ring1="Begrudging Ring",ring2="Supershear Ring",
		back="Atheling Mantle",waist="Anguinus Belt",legs="Sulevi. Cuisses +1",feet="Flam. Gambieras +1"}--Subtlety Spec.

	sets.engaged.Empyrian = set_combine(sets.engaged.DW,   {head="Chevalier's Armet",body="Chev. Cuirass",hands="Chev. Gauntlets +1",legs="Chevalier's Cuisses",feet="Chev. Sabatons +1"})	
		
    sets.engaged.PDT = set_combine(sets.engaged, {ammo="Amar Cluster",
		head="Sulevia's Mask +1",neck="Twilight Torque",ear1="Thureous Earring",ear2="Cessance Earring",
		body="Sulevia's Plate. +1",hands="Sulev. Gauntlets +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Rudianos's Mantle",waist="Nierenschutz",legs="Sulevi. Cuisses +1",feet="Amm Greaves"})
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {ammo="Amar Cluster",
		head="Sulevia's Mask +1",neck="Twilight Torque",ear1="Thureous Earring",ear2="Cessance Earring",
		body="Sulevia's Plate. +1",hands="Sulev. Gauntlets +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Rudianos's Mantle",waist="Nierenschutz",legs="Sulevi. Cuisses +1",feet="Sulev. Leggings +1"})
    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)

    sets.engaged.DW.PDT = set_combine(sets.engaged.DW, {ammo="Amar Cluster",
		head="Sulevia's Mask +1",neck="Twilight Torque",ear1="Thureous Earring",ear2="Cessance Earring",
		body="Sulevia's Plate. +1",hands="Sulev. Gauntlets +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Rudianos's Mantle",waist="Nierenschutz",legs="Sulevi. Cuisses +1",feet="Amm Greaves"})
    sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.DW.Acc, {ammo="Amar Cluster",
		head="Sulevia's Mask +1",neck="Twilight Torque",ear1="Thureous Earring",ear2="Cessance Earring",
		body="Sulevia's Plate. +1",hands="Sulev. Gauntlets +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Rudianos's Mantle",waist="Nierenschutz",legs="Sulevi. Cuisses +1",feet="Sulev. Leggings +1"})
    sets.engaged.DW.Reraise = set_combine(sets.engaged.DW, sets.Reraise)
    sets.engaged.DW.Acc.Reraise = set_combine(sets.engaged.DW.Acc, sets.Reraise)


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Doom = {ring2="Saida Ring"}
    sets.buff.Cover = {head="Reverence Coronet +1",body="Caballarius Surcoat"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    if state.EquipShield.value == true then
        classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    end

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    
    return meleeSet
end

function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
    
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
    
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end
    
    return defenseSet
end


function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.ExtraDefenseMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
    end
    
    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()
    if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
        classes.CustomDefenseGroups:append('Kheshig Blade')
    end
    
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 5)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 5)
	elseif player.sub_job == 'NIN' then
        set_macro_page(1, 5)
	elseif player.sub_job == 'RUN' then
        set_macro_page(1, 5)
    elseif player.sub_job == 'RDM' then
        set_macro_page(1, 5)
    else
        set_macro_page(1, 5)
    end
end