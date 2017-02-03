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
        state.Buff.Migawari = buffactive.migawari or false
        state.Buff.Doomed = buffactive.doomed or false
        state.Buff.Yonin = buffactive.yonin or false
        state.Buff.Innin = buffactive.innin or false
        state.Buff.Futae = buffactive.futae or false

    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Special', 'Adhemar')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')

    gear.MovementFeet = {name="Danzo Sune-ate"}
    gear.DayFeet = "Danzo Sune-ate"
    gear.NightFeet = "Hachi. Kyahan +1"
    
    
    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    sets.precast.JA['Mijin Gakure'] = {legs="Mochizuki Hakama +1"}
	sets.precast.JA['Migawari'] = {body="Hattori Ningi"}
	sets.precast.JA['Yonin'] = {legs="Hattori Hakama"}
	sets.precast.JA['Innin'] = {head="Hattori Zukin"}
	
	sets.precast.JA['Provoke'] = sets.enmity
	
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Taeon Chapeau",neck="Unmoving Collar",ear1="Soil Pearl",ear2="Soil Pearl",
		body="Hiza. Haramaki +1",hands="Slither Gloves +1",ring1="Titan Ring",ring2="Titan Ring",
		back="Iximulew Cape",waist="Chuq'aba Belt",legs="Samnuha Tights",feet="Amm Greaves"}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Set for acc on steps, since Yonin drops acc a fair bit
	sets.precast.Step = {
		head="Hizamaru Somen +1",neck="Subtlety Spec.",ear1="Digni. Earring",ear2="Cessance Earring",
		body="Hizamaru Harmaki +1",hands="Hizamaru Kote +1",ring1="Begrudging Ring",ring2="Supershear Ring",
		back="Andartia's Mantle",waist="Anguinus Belt",legs="Hiza. Hizayoroi +1",feet="Hiza. Sune-Ate +1"}

	
	-- Fast cast sets for spells

	sets.precast.FC = {ammo="Impatiens",head="Herculean Helm",body="Taeon Tabard",back="Mujin Mantle",ear1="Etiolation Earring",ear2="Loquacious Earring",
	hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",waist="Chuq'aba Belt",
	legs="Rawhide Trousers",neck="Voltsurge Torque",feet="Hattori Kyahan"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Mochi. Chainmail +1",back="Andartia's Mantle",neck="Magoraga Beads",
	legs="Rawhide Trousers",feet="Hattori Kyahan",hands="Mochizuki Tekko +1"})

    sets.enmity = {ear1="Friomisi Earring",neck="Unmoving Collar +1",body="Emet Harness +1",hands="Kurys Gloves",waist="Warwolf Belt",ring1="Petrov Ring",ring2="Begrudging Ring"}
   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Yetshila",
		head="Adhemar Bonnet",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
		body="Hizamaru Haramaki +1",hands="Hizamaru Kote +1",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Andartia's Mantle",waist="Fotia Belt",legs="Samnuha Tights",feet="Loyalist Sabatons"} --Otro. Harness +1/Otronif Boots +1/Letalis Mantle/Steelflash Earring/Bladeborn Earring,Adhemar Jacket,Lilitu Headpiece

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",hands="Floral Gauntlets",waist="Fotia Belt",head="Adhemar Bonnet",body="Vatic Byrnie",
	back="Andartia's Mantle",ring2="Ramuh ring",legs="Samnuha Tights"})--Rancorous Mantle,Fotia Gorget

	sets.precast.WS['Blade: Ten'] = set_combine(sets.precast.WS, {ammo="Ginsen",neck="Fotia Gorget",waist="Fotia Belt",back="Andartia's Mantle",
	ring2="Ifrit ring",ear1="Ishvara Earring",
	head="Hizamaru Somen +1",body="Hiza. Haramaki +1",hands="Hizamaru Kote +1",legs="Hiza. Hizayoroi +1",feet="Hiza. Sune-ate +1"})--Vatic Byrnie
	
	sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {ammo="Yetshila",neck="Fotia Gorget",hands="Floral Gauntlets",waist="Fotia Belt",
	head="Adhemar Bonnet",body="Hizamaru Haramaki +1",ear1="Ishvara Earring",
	legs="Hiza. Hizayoroi +1",feet="Herculean Boots",ring1="Begrudging Ring",ring2="Epona's Ring",back="Andartia's Mantle"})--Adhemar Jacket/Uk'uxkaj Cap
	sets.precast.WS['Blade: Hi'].Mod = set_combine(sets.precast.WS['Blade: Hi'], {neck="Fotia Gorget", waist="Fotia Belt"})
	--Sasuke Tekko +1

	sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt",ring2="Ramuh ring",head="Adhemar Bonnet",body="Hizamaru Haramaki +1",
	back="Andartia's Mantle",legs="Samnuha Tights",feet="Rawhide Boots",ammo="Jukukik Feather",
	hands="Hizamaru Kote +1"})--Ginsen/Naga Samue/Lilitu Headpiece

	sets.precast.WS['Blade: Kamu'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",back="Andartia's Mantle",waist="Fotia Belt",body="Hiza. Haramaki +1",
	legs="Hiza. Hizayoroi +1",hands="Hizamaru Kote +1",head="Hizamaru Somen +1",ring2="Ifrit Ring",ear1="Ishvara Earring",feet="Hiza. Sune-ate +1"})--Vatic Byrnie
	sets.precast.WS['Blade: Kamu'].Mod = set_combine(sets.precast.WS['Blade: Kamu'], {waist="Fotia Belt"})

	sets.precast.WS['Blade: Ku'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",hands="Hizamaru Kote +1",waist="Fotia Belt",head="Adhemar Bonnet",back="Andartia's Mantle",body="Vatic Byrnie",ammo="Ginsen",
	legs="Samnuha Tights",feet="Rawhide Boots"})--Vespid Mantle
	sets.precast.WS['Blade: Ku'].Mod = set_combine(sets.precast.WS['Blade: Ku'], {waist="Fotia Belt"})

	sets.precast.WS['Blade: Metsu'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",waist="Fotia Belt",legs="Hiza. Hizayoroi +1",head="Adhemar Bonnet",
	body="Hizamaru Haramaki +1",hands="Floral Gauntlets",ring2="Ramuh ring",back="Andartia's Mantle",feet="Rawhide Boots"})
	sets.precast.WS['Blade: Metsu'].Mod = set_combine(sets.precast.WS['Blade: Metsu'], {waist="Fotia Belt"})
	
	sets.precast.WS['Aeolian Edge'] = {
		head="Mochi. Hatsuburi +1",neck="Sancitity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Hizamaru Haramaki +1",hands="Leyline Gloves",ring1="Petrov Ring",ring2="Acumen Ring",
		back="Toro Cape",waist="Fotia Belt",legs="Samnuha Tights",feet="Herculean Boots"}

	sets.precast.WS['Sunburst'] = {
		head="Mochi. Hatsuburi +1",neck="Fotia Gorget",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Samnuha Coat",hands="Leyline Gloves",ring1="Petrov Ring",ring2="Acumen Ring",
		back="Toro Cape",waist="Fotia Belt",legs="Samnuha Tights",feet="Herculean Boots"}
		

	-- Midcast Sets
	sets.midcast.FastRecast = {ammo="Impatiens",head="Herculean Helm",body="Taeon Tabard",back="Mujin Mantle",ear1="Etiolation Earring",ear2="Loquacious Earring",waist="Chuq'aba Belt",
	hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
	legs="Rawhide Trousers",neck="Voltsurge Torque",feet="Hattori Kyahan"}

	-- any ninjutsu cast on self
	sets.midcast.SelfNinjutsu = set_combine(sets.midcast.FastRecast, {neck="Voltsurge Torque",legs="Rawhide Trousers"})

	sets.midcast.Utsusemi = set_combine(sets.midcast.SelfNinjutsu, {body="Mochi. Chainmail +1",back="Andartia's Mantle",neck="Magoraga Beads",waist="Chuq'aba Belt",
	legs="Rawhide Trousers",feet="Hattori Kyahan",hands="Mochizuki Tekko +1"})

	-- any ninjutsu cast on enemies
	sets.midcast.Ninjutsu = {ammo="Dosis Tathlum",
		head="Mochi. Hatsuburi +1",neck="Incanter's Torque",
		ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Samnuha Coat",hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Locus Ring",
		back="Toro Cape",waist="Salire Belt",legs="Rawhide Trousers",
		feet="Mochi. Kyahan +1"}--Mochi. Kyahan +1/Hachi. Kyahan +1/Hattori Tekko/Incanter's Torque/Sancitity Necklace/Acumen/Mochi. Hatsuburi +1

	sets.midcast.Ninjutsu.Resistant = set_combine(sets.midcast.Ninjutsu, {ammo="Etiolation Earring",
	head="Mochi. Hatsuburi +1",ear1="Lifestorm Earring",ear2="Psystorm Earring",ring2="Sangoma Ring",neck="Incanter's Torque",
	legs="Rawhide Trousers",
	waist="Salire Belt",feet="Hachi. Kyahan +1",back="Yokaze Mantle"})

	sets.midcast.NinjutsuDebuff = set_combine(sets.midcast.Ninjutsu, {ammo="Etiolation Earring",
	head="Mochi. Hatsuburi +1",ear1="Lifestorm Earring",ear2="Psystorm Earring",ring2="Sangoma Ring",neck="Incanter's Torque",
	legs="Rawhide Trousers",
	waist="Salire Belt",feet="Hachi. Kyahan +1",back="Yokaze Mantle"})--Fenrir Ring

	sets.midcast.Provoke = {ear1="Friomisi Earring",neck="Unmoving Collar +1",body="Emet Harness +1",hands="Kurys Gloves",waist="Warwolf Belt",ring1="Petrov Ring",ring2="Begrudging Ring"}
	
	-- Sets to return to when not performing an action.

	--Adhemar Jacket  
	--Adhemar Wristbands
	--Adhemar Bonnet
	
	--Hizamaru Somen +1
	--Hizamaru Haramaki
	--Hizamaru Kote +1
	--Hiza. Hizayoroi +1
	--Hiza. Sune-ate +1
	
	--main={ name="Ochu", augments={'STR+4','DEX+6','Ninjutsu skill +6','DMG:+9',}}
    --sub={ name="Ochu", augments={'STR+2','DEX+4','Ninjutsu skill +5',}}
	
	-- Resting sets
	sets.resting = {ammo="Togakushi Shuriken",
		head="Adhemar Bonnet",ear1="Infused Earring",ear2="Heartseeker Earring",body="Hiza. Haramaki +1",
		hands="Floral Gauntlets",neck="Lissome Necklace",back="Yokaze Mantle",waist="Windbuffet Belt +1",legs="Hurculean Trousers",
		ring1="Paguroidea Ring",ring2="Sheltered Ring"}--Uk'uxkaj Cap


	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {ammo="Togakushi Shuriken",
		head="Adhemar Bonnet",neck="Lissome Necklace",ear1="Infused Earring",ear2="Heartseeker Earring",
		body="Hiza. Haramaki +1",hands="Floral Gauntlets",ring1="Paguroidea Ring",ring2="Sheltered Ring",
		back="Andartia's Mantle",waist="Windbuffet Belt +1",legs="Hachi. Hakama +1",feet=gear.MovementFeet}--Adhemar Jacket

	sets.idle.Town = {ammo="Togakushi Shuriken",
		main="Kanaria",
		sub="Kanaria",
		head="Adhemar Bonnet",neck="Lissome Necklace",ear1="Infused Earring",ear2="Heartseeker Earring",
		body="Hiza. Haramaki +1",hands="Floral Gauntlets",ring1="Paguroidea Ring",ring2="Sheltered Ring",
		back="Andartia's Mantle",waist="Windbuffet Belt +1",legs="Hachi. Hakama +1",feet=gear.MovementFeet}--Hattori Zukin +1/Adhemar Jacket

	sets.idle.Weak = {ammo="Togakushi Shuriken",
		head="Adhemar Bonnet",neck="Lissome Necklace",ear1="Infused Earring",ear2="Heartseeker Earring",
		body="Hiza. Haramaki +1",hands="Floral Gauntlets",ring1="Dark Ring",ring2="Defending Ring",
		back="Yokaze Mantle",waist="Windbuffet Belt +1",legs="Hachi. Hakama +1",feet=gear.MovementFeet}--Adhemar Jacket

	-- Defense sets
	sets.defense.Evasion = {
		head="Hizamaru Somen +1",neck="Subtlety Spec.",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hiza. Haramaki +1",hands="Hizamaru Kote +1",ring1="Vengeful Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Windbuffet Belt +1",
		legs="Hiza. Hizayoroi +1",
		feet="Hiza. Sune-ate +1"}

	sets.defense.PDT = {
		head="Herculean Helm",neck="Twilight Torque",
		body="Emet Harness",hands="Herculean Gloves",ring1="Dark Ring",ring2="Defending Ring",
		back="Mollusca Mantle",waist="Flume Belt",legs="Herculean Trousers",feet="Amm Greaves"}

	sets.defense.MDT = {
		head="Dampening Tam",neck="Twilight Torque",
		body="Emet Harness",hands="Floral Gauntlets",ring1="Dark Ring",ring2="Defending Ring",
		back="Mollusca Mantle",waist="Flume Belt",legs="Ta'lab Trousers",feet="Amm Greaves"}


	sets.DayMovement = {feet="Danzo sune-ate"}

	sets.NightMovement = {feet="Hachi. Kyahan +1"}

	sets.Kiting = select_movement_feet()


	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged = {ammo="Togakushi Shuriken",
		head="Hattori Zukin",neck="Erudit. Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Mochi. Chainmail +1",hands="Floral Gauntlets",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Andartia's Mantle",waist="Windbuffet Belt +1",legs="Mochizuki Hakama +1",feet="Herculean Boots"} --legs="Hurculean Trousers"/Otronif Gloves +1/Mochi. Chainmail +1/Adhemar Jacket/Nusku's Sash
	sets.engaged.Acc = {ammo="Togakushi Shuriken",
		head="Dampening Tam",neck="Subtlety Spec.",ear1="Digni. Earring",ear2="Cessance Earring",
		body="Hizamaru Haramaki +1",hands="Floral Gauntlets",ring1="Begrudging Ring",ring2="Supershear Ring",
		back="Andartia's Mantle",waist="Anguinus Belt",legs="Hurculean Trousers",feet="Loyalist Sabatons"}
	sets.engaged.Special = {ammo="Togakushi Shuriken",
		head="Skormoth Mask",neck="Clotharius Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hizamaru Haramaki +1",hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Andartia's Mantle",waist="Windbuffet Belt +1",
		legs="Herculean Trousers",
		feet="Herculean Boots"}--feet="Loyalist Sabatons"/Taeon Gloves
	sets.engaged.Adhemar = {ammo="Togakushi Shuriken",
		head="Adhemar Bonnet",neck="Erudit. Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Hizamaru Haramaki +1",hands="Floral Gauntlets",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Andartia's Mantle",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Herculean Boots"}
	sets.engaged.Evasion = {ammo="Togakushi Shuriken",
		head="Hizamaru Somen +1",neck="Subtlety Spec.",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hiza. Haramaki +1",hands="Hizamaru Kote +1",ring1="Varar Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Windbuffet Belt +1",
		legs="Hiza. Hizayoroi +1",
		feet="Hiza. Sune-ate +1"}
	sets.engaged.Acc.Evasion = {ammo="Togakushi Shuriken",
		head="Dampening Tam",neck="Subtlety Spec.",ear1="Digni. Earring",ear2="Cessance Earring",
		body="Hizamaru Haramaki +1",hands="Floral Gauntlets",ring1="Begrudging Ring",ring2="Supershear Ring",
		back="Yokaze Mantle",waist="Anguinus Belt",
		legs={ name="Taeon Tights", augments={'Accuracy+17','"Triple Atk."+2','Crit. hit damage +3%',}},
		feet="Loyalist Sabatons"}
	sets.engaged.PDT = {ammo="Togakushi Shuriken",
		head="Herculean Helm",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Emet Harness",hands="Herculean Gloves",ring1="Dark Ring",ring2="Defending Ring",
		back="Iximulew Cape",waist="Windbuffet Belt +1",legs="Herculean Trousers",feet="Amm Greaves"}
	sets.engaged.Acc.PDT = {ammo="Togakushi Shuriken",
		head="Dampening Tam",neck="Subtlety Spec.",ear1="Digni. Earring",ear2="Cessance Earring",
		body="Mochi. Chainmail +1",hands="Floral Gauntlets",ring1="Begrudging Ring",ring2="Supershear Ring",
		back="Andartia's Mantle",waist="Anguinus Belt",legs="Hurculean Trousers",feet="Amm Sabatons"}

	-- Custom melee group: High Haste (~20% DW)
	sets.engaged.HighHaste = {ammo="Togakushi Shuriken",
		head="Hattori Zukin",neck="Erudit. Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Mochi. Chainmail +1",hands="Floral Gauntlets",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Andartia's Mantle",waist="Windbuffet Belt +1",legs="Mochizuki Hakama +1",feet="Herculean Boots"} --legs="Hurculean Trousers"/Otronif Gloves +1
	sets.engaged.Acc.HighHaste = {ammo="Togakushi Shuriken",
		head="Dampening Tam",neck="Subtlety Spec.",ear1="Digni. Earring",ear2="Cessance Earring",
		body="Hizamaru Haramaki +1",hands="Floral Gauntlets",ring1="Begrudging Ring",ring2="Supershear Ring",
		back="Andartia's Mantle",waist="Anguinus Belt",legs="Hurculean Trousers",feet="Loyalist Sabatons"}
	sets.engaged.Special.HighHaste = {ammo="Togakushi Shuriken",
		head="Skormoth Mask",neck="Clotharius Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hizamaru Haramaki +1",hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Andartia's Mantle",waist="Windbuffet Belt +1",
		legs="Herculean Trousers",
		feet="Herculean Boots"}
	sets.engaged.Adhemar.HighHaste = {ammo="Togakushi Shuriken",
		head="Adhemar Bonnet",neck="Erudit. Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Hizamaru Haramaki +1",hands="Floral Gauntlets",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Andartia's Mantle",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Herculean Boots"}
	sets.engaged.Evasion.HighHaste = {ammo="Togakushi Shuriken",
		head="Hizamaru Somen +1",neck="Subtlety Spec.",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hiza. Haramaki +1",hands="Hizamaru Kote +1",ring1="Varar Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Windbuffet Belt +1",
		legs="Hiza. Hizayoroi +1",
		feet="Hiza. Sune-ate +1"}
	sets.engaged.Acc.Evasion.HighHaste = {ammo="Togakushi Shuriken",
		head="Dampening Tam",neck="Subtlety Spec.",ear1="Digni. Earring",ear2="Cessance Earring",
		body="Hizamaru Haramaki +1",hands="Floral Gauntlets",ring1="Begrudging Ring",ring2="Supershear Ring",
		back="Yokaze Mantle",waist="Anguinus Belt",
		legs={ name="Taeon Tights", augments={'Accuracy+17','"Triple Atk."+2','Crit. hit damage +3%',}},
		feet="Loyalist Sabatons"}
	sets.engaged.PDT.HighHaste = {ammo="Togakushi Shuriken",
		head="Herculean Helm",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Emet Harness",hands="Herculean Gloves",ring1="Dark Ring",ring2="Defending Ring",
		back="Iximulew Cape",waist="Windbuffet Belt +1",legs="Herculean Trousers",feet="Amm Greaves"}
	sets.engaged.Acc.PDT.HighHaste = {ammo="Togakushi Shuriken",
		head="Dampening Tam",neck="Subtlety Spec.",ear1="Digni. Earring",ear2="Cessance Earring",
		body="Mochi. Chainmail +1",hands="Herculean Gloves",ring1="Begrudging Ring",ring2="Supershear Ring",
		back="Andartia's Mantle",waist="Anguinus Belt",legs="Herculean Trousers",feet="Amm Sabatons"}

	-- Custom melee group: Embrava Haste (7% DW)
	sets.engaged.EmbravaHaste = {ammo="Togakushi Shuriken",
		head="Hattori Zukin",neck="Erudit. Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Mochi. Chainmail +1",hands="Floral Gauntlets",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Andartia's Mantle",waist="Windbuffet Belt +1",legs="Mochizuki Hakama +1",feet="Herculean Boots"} --legs="Hurculean Trousers"
	sets.engaged.Acc.EmbravaHaste = {ammo="Togakushi Shuriken",
		head="Dampening Tam",neck="Subtlety Spec.",ear1="Digni. Earring",ear2="Cessance Earring",
		body="Hizamaru Haramaki +1",hands="Floral Gauntlets",ring1="Begrudging Ring",ring2="Supershear Ring",
		back="Andartia's Mantle",waist="Anguinus Belt",legs="Hurculean Trousers",feet="Loyalist Sabatons"}
	sets.engaged.Special.EmbravaHaste = {ammo="Togakushi Shuriken",
		head="Skormoth Mask",neck="Clotharius Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hizamaru Haramaki +1",hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Andartia's Mantle",waist="Windbuffet Belt +1",
		legs="Herculean Trousers",
		feet="Herculean Boots"}
	sets.engaged.Adhemar.EmbravaHaste = {ammo="Togakushi Shuriken",
		head="Adhemar Bonnet",neck="Erudit. Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Hizamaru Haramaki +1",hands="Floral Gauntlets",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Andartia's Mantle",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Herculean Boots"}
	sets.engaged.Evasion.EmbravaHaste = {ammo="Togakushi Shuriken",
		head="Hizamaru Somen +1",neck="Subtlety Spec.",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hiza. Haramaki +1",hands="Hizamaru Kote +1",ring1="Varar Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Windbuffet Belt +1",
		legs="Hiza. Hizayoroi +1",
		feet="Hiza. Sune-ate +1"}
	sets.engaged.Acc.Evasion.EmbravaHaste = {ammo="Togakushi Shuriken",
		head="Dampening Tam",neck="Subtlety Spec.",ear1="Digni. Earring",ear2="Cessance Earring",
		body="Hizamaru Haramaki +1",hands="Herculean Gloves",ring1="Begrudging Ring",ring2="Supershear Ring",
		back="Yokaze Mantle",waist="Anguinus Belt",
		legs={ name="Taeon Tights", augments={'Accuracy+17','"Triple Atk."+2','Crit. hit damage +3%',}},
		feet="Loyalist Sabatons"}
	sets.engaged.PDT.EmbravaHaste = {ammo="Togakushi Shuriken",
		head="Herculean Helm",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Emet Harness",hands="Herculean Gloves",ring1="Dark Ring",ring2="Defending Ring",
		back="Iximulew Cape",waist="Windbuffet Belt +1",legs="Herculean Trousers",feet="Amm Greaves"}
	sets.engaged.Acc.PDT.EmbravaHaste = {ammo="Togakushi Shuriken",
		head="Dampening Tam",neck="Subtlety Spec.",ear1="Digni. Earring",ear2="Cessance Earring",
		body="Mochi. Chainmail +1",hands="Herculean Gloves",ring1="Dark Ring",ring2="Varar Ring",
		back="Andartia's Mantle",waist="Anguinus Belt",legs="Herculean Trousers",feet="Amm Sabatons"}

	-- Custom melee group: Max Haste (0% DW)
	sets.engaged.MaxHaste = {ammo="Togakushi Shuriken",
		head="Hattori Zukin",neck="Erudit. Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Mochi. Chainmail +1",hands="Floral Gauntlets",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Andartia's Mantle",waist="Windbuffet Belt +1",legs="Mochizuki Hakama +1",feet="Herculean Boots"} --legs="Hurculean Trousers"
	sets.engaged.Acc.MaxHaste = {ammo="Togakushi Shuriken",
		head="Dampening Tam",neck="Subtlety Spec.",ear1="Digni. Earring",ear2="Cessance Earring",
		body="Hizamaru Haramaki +1",hands="Floral Gauntlets",ring1="Begrudging Ring",ring2="Supershear Ring",
		back="Andartia's Mantle",waist="Anguinus Belt",legs="Hurculean Trousers",feet="Loyalist Sabatons"}
	sets.engaged.Special.MaxHaste = {ammo="Togakushi Shuriken",
		head="Skormoth Mask",neck="Clotharius Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hizamaru Haramaki +1",hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Andartia's Mantle",waist="Windbuffet Belt +1",
		legs="Herculean Trousers",
		feet="Herculean Boots"}
	sets.engaged.Adhemar.MaxHaste = {ammo="Togakushi Shuriken",
		head="Adhemar Bonnet",neck="Erudit. Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Hizamaru Haramaki +1",hands="Floral Gauntlets",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Andartia's Mantle",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Herculean Boots"}
	sets.engaged.Evasion.MaxHaste = {ammo="Togakushi Shuriken",
		head="Hizamaru Somen +1",neck="Subtlety Spec.",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hiza. Haramaki +1",hands="Hizamaru Kote +1",ring1="Varar Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Windbuffet Belt +1",
		legs="Hiza. Hizayoroi +1",
		feet="Hiza. Sune-ate +1"}
	sets.engaged.Acc.Evasion.MaxHaste = {ammo="Togakushi Shuriken",
		head="Dampening Tam",neck="Subtlety Spec.",ear1="Digni. Earring",ear2="Cessance Earring",
		body="Hizamaru Haramaki +1",hands="Herculean Gloves",ring1="Begrudging Ring",ring2="Supershear Ring",
		back="Yokaze Mantle",waist="Anguinus Belt",
		legs="Herculean Trousers",
		feet="Loyalist Sabatons"}
	sets.engaged.PDT.MaxHaste = {ammo="Togakushi Shuriken",
		head="Herculean Helm",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Emet Harness",hands="Herculean Gloves",ring1="Dark Ring",ring2="Defending Ring",
		back="Iximulew Cape",waist="Windbuffet Belt +1",legs="Herculean Trousers",feet="Amm Greaves"}
	sets.engaged.Acc.PDT.MaxHaste = {ammo="Togakushi Shuriken",
		head="Dampening Tam",neck="Subtlety Spec.",ear1="Digni. Earring",ear2="Cessance Earring",
		body="Mochi. Chainmail +1",hands="Herculean Gloves",ring1="Begrudging Ring",ring2="Supershear Ring",
		back="Andartia's Mantle",waist="Anguinus Belt",legs="Herculean Trousers",feet="Amm Sabatons"}


	sets.buff.Migawari = {body="Hattori Ningi"}
	sets.buff.Yonin = {legs="Hattori Hakama"}
	sets.buff.Innin = {head="Hattori Zukin"}
	sets.buff.Doomed = {ring2="Saida Ring"}
	sets.buff.Futae = {hands="Hattori Tekko"}
	sets.buff.Sange = {ammo="Hachiya Shuriken"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.Buff.Doom then
        equip(sets.buff.Doom)
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
    end
end

-------------------------------------------------------------------------------------------------TEST-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Will Equip Hachirin-no-Obi when Weather or Day Matches the Element of spell

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)

    if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.self_healing)
    end
    --if spell.action_type == 'Magic' then
       -- apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    --end
	if spell.skill == 'Ninjutsu'  then
        if spell.element == world.day_element or spell.element == world.weather_element then
            equip({waist="Hachirin-No-Obi"})
            --add_to_chat(8,'----- Hachirin-no-Obi Equipped. -----')
        end
    end
	--if spell.skill == 'Elemental Magic' then
      --  if state.MagicBurst.value then
        --equip(sets.magic_burst)
        --end
	end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
end

function job_status_change(new_status, old_status)
    if new_status == 'Idle' then
        select_movement_feet()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Get custom spell maps
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == "Ninjutsu" then
        if not default_spell_map then
            if spell.target.type == 'SELF' then
                return 'NinjutsuBuff'
            else
                return 'NinjutsuDebuff'
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Buff.Migawari then
        idleSet = set_combine(idleSet, sets.buff.Migawari)
    end
	        if state.Buff.Futae then
                idleSet = set_combine(idleSet, sets.buff.Futae)
        end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Migawari then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
	        if state.Buff.Yonin then
                meleeSet = set_combine(meleeSet, sets.buff.Yonin)
        end
        if state.Buff.Innin then
                meleeSet = set_combine(meleeSet, sets.buff.Innin)
        end
        if state.Buff.Futae then
                meleeSet = set_combine(meleeSet, sets.buff.Futae)
        end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    return meleeSet
end

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    select_movement_feet()
    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    -- We have three groups of DW in gear: Hachiya body/legs, Iga head + Patentia Sash, and DW earrings
    
    -- Standard gear set reaches near capped delay with just Haste (77%-78%, depending on HQs)

    -- For high haste, we want to be able to drop one of the 10% groups.
    -- Basic gear hits capped delay (roughly) with:
    -- 1 March + Haste
    -- 2 March
    -- Haste + Haste Samba
    -- 1 March + Haste Samba
    -- Embrava
    
    -- High haste buffs:
    -- 2x Marches + Haste Samba == 19% DW in gear
    -- 1x March + Haste + Haste Samba == 22% DW in gear
    -- Embrava + Haste or 1x March == 7% DW in gear
    
    -- For max haste (capped magic haste + 25% gear haste), we can drop all DW gear.
    -- Max haste buffs:
    -- Embrava + Haste+March or 2x March
    -- 2x Marches + Haste
    
    -- So we want four tiers:
    -- Normal DW
    -- 20% DW -- High Haste
    -- 7% DW (earrings) - Embrava Haste (specialized situation with embrava and haste, but no marches)
    -- 0 DW - Max Haste
    
    classes.CustomMeleeGroups:clear()
    
    if buffactive.embrava and (buffactive.march == 2 or (buffactive.march and buffactive.haste)) then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 2 and buffactive.haste then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.embrava and (buffactive.haste or buffactive.march) then
        classes.CustomMeleeGroups:append('EmbravaHaste')
    elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 2 then
        classes.CustomMeleeGroups:append('HighHaste')
    end
end


function select_movement_feet()
    if world.time >= 17*60 or world.time < 7*60 then
        gear.MovementFeet.name = gear.NightFeet
    else
        gear.MovementFeet.name = gear.DayFeet
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
        -- Default macro set/book
        if player.sub_job == 'DNC' then
                set_macro_page(1, 6)
        elseif player.sub_job == 'THF' then
                set_macro_page(2, 6)
        elseif player.sub_job == 'RUN' then
                set_macro_page(9, 6)   
        else
                set_macro_page(10, 6)
        end
end