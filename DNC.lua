-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    
    gs c step
        Uses the currently configured step on the target, with either <t> or <stnpc> depending on setting.

    gs c step t
        Uses the currently configured step on the target, but forces use of <t>.
    
    
    Configuration commands:
    
    gs c cycle mainstep
        Cycles through the available steps to use as the primary step when using one of the above commands.
        
    gs c cycle altstep
        Cycles through the available steps to use for alternating with the configured main step.
        
    gs c toggle usealtstep
        Toggles whether or not to use an alternate step.
        
    gs c toggle selectsteptarget
        Toggles whether or not to use <stnpc> (as opposed to <t>) when using a step.
--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Climactic Flourish'] = buffactive['climactic flourish'] or false

    state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
    state.AltStep = M{['description']='Alt Step', 'Quickstep', 'Feather Step', 'Stutter Step', 'Box Step'}
    state.UseAltStep = M(false, 'Use Alt Step')
    state.SelectStepTarget = M(false, 'Select Step Target')
    state.IgnoreTargetting = M(false, 'Ignore Targetting')

    state.CurrentStep = M{['description']='Current Step', 'Main', 'Alt'}
    state.SkillchainPending = M(false, 'Skillchain Pending')

    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Fodder')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Fodder')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')


    gear.default.weaponskill_neck = "Asperity Necklace"
    gear.default.weaponskill_waist = "Caudata Belt"
    gear.AugQuiahuiz = {name="Quiahuiz Trousers", augments={'Haste+2','"Snapshot"+2','STR+8'}}

    -- Additional local binds
    send_command('bind ^= gs c cycle mainstep')
    send_command('bind != gs c cycle altstep')
    send_command('bind ^- gs c toggle selectsteptarget')
    send_command('bind !- gs c toggle usealtstep')
    send_command('bind ^` input /ja "Chocobo Jig" <me>')
    send_command('bind !` input /ja "Chocobo Jig II" <me>')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^=')
    send_command('unbind !=')
    send_command('unbind ^-')
    send_command('unbind !-')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs

    sets.precast.JA['No Foot Rise'] = {body="Horos Casaque +1"}

    sets.precast.JA['Trance'] = {head="Horos Tiara"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
		head="Horos Tiara",neck="Unmoving Collar",ear2="Roundel Earring",ear1="Soil Pearl",ring1="Titan Ring",ring2="Titan Ring",
		body="Maxixi Casaque +1",hands="Slither Gloves +1",
		back="Toetapper Mantle",waist="Warwolf Belt",legs="Samnuha Tights",feet="Maxixi Toe Shoes +1"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Samba = {head="Maxixi Tiara +1"}

    sets.precast.Jig = {legs="Horos Tights",feet="Maxixi Toe Shoes +1"}

   sets.precast.Step = {ammo="Honed Tathlum",
	head="Maxixi Tiara +1",hands="Maxixi Bangles +1",feet="Horos Shoes +1",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",waist="Windbuffet Belt +1",back="Archon Cape"}
	
	sets.precast.Step['Feather Step'] = set_combine(sets.precast.Step,  {hands="Maxixi Bangles +1",feet="Maculele Toeshoes"})

	--Flourish
	sets.precast.Flourish1 = {ammo="Honed Tathlum",
	waist="Windbuffet Belt +1",back="Archon Mantle",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1"}
	
	sets.precast.Flourish1['Violent Flourish'] =  set_combine(sets.precast.Flourish1,   {ammo="Honed Tathlum",
	ear1="Digni. Earring",ear2="Gwati Earring",
		head="Mummu Bonnet +1",body="Horos Casaque +1",hands="Mummu Wrists +1",ring2="Ramuh Ring +1",
		back="Archon Mantle",legs="Mummu Kecks +1",feet="Mummu Gamashes +1"}) -- magic accuracy
	sets.precast.Flourish1['Desperate Flourish'] =  set_combine(sets.precast.Flourish1,  {ammo="Charis Feather",
		head="Mummu Bonnet +1",
		body="Samnuha Coat",hands="Mummu Wrists +1",ring1="Varar Ring",
		back="Senuna's Mantle",waist="Windbuffet Belt +1",legs="Mummu Kecks +1",feet="Mummu Gamashes +1"}) -- acc gear

	sets.precast.Flourish1['Animated Flourish'] = sets.enmity

	--Flourish2
	sets.precast.Flourish2 = {}
	
	sets.precast.Flourish2['Reverse Flourish'] = {hands="Maculele Bangles"}

	--Flourish3
	sets.precast.Flourish3 = {ammo="Honed Tathlum",
	waist="Windbuffet Belt +1",back="Archon Mantle",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1"}
	
	sets.precast.Flourish3['Striking Flourish'] =  set_combine(sets.precast.Flourish3,   {body="Maculele Casaque"})
	sets.precast.Flourish3['Climactic Flourish'] =  set_combine(sets.precast.Flourish3,   {head="Maculele Tiara"})

	-- Fast cast sets for spells

	sets.precast.FC = {ammo="Impatiens",
	head="Anwig Salade",neck="Voltsurge Torque",ear1="Mendi. Earring",ear2="Loquacious Earring",hands="Leyline Gloves",feet="Mummu Gamashes +1",
	legs="Rawhide Trousers",
	ring1="Weatherspoon Ring",ring2="Prolix Ring",body="Taeon Tabard"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {back="Mujin Mantle",neck="Magoraga Beads"})

    sets.enmity = {ear1="Friomisi Earring",neck="Unmoving Collar",body="Emet Harness +1",hands="Kurys Gloves",waist="Warwolf Belt",ring1="Rajas Ring",ring2="Begrudging Ring"}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Charis Feather",
		head="Mummu Bonnet +1",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Moonshade Earring",
		body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Mummu Wrists +1",ring1="Ramuh Ring +1",ring2="Epona's Ring",
		back="Senuna's Mantle",waist="Windbuffet Belt +1",legs="Mummu Kecks +1",feet="Mummu Gamashes +1"}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Honed Tathlum", back="Senuna's Mantle"})

	gear.default.weaponskill_neck = "Asperity Necklace"
	gear.default.weaponskill_waist = "Windbuffet Belt +1"

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {hands="Mummu Wrists +1",head="Mummu Bonnet +1",
		ring1="Garuda Ring",ring2="Garuda Ring",legs="Samnuha Tights"})
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {ammo="Honed Tathlum", back="Senuna's Mantle"})
	sets.precast.WS['Exenterator'].Mod = set_combine(sets.precast.WS['Exenterator'], {body="Rawhide Vest",waist="Fotia Belt"})

	sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {hands="Mummu Wrists +1"})
	sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS.Acc, {hands="Mummu Wrists +1"})

	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ammo="Charis Feather",head="Mummu Bonnet +1",waist="Wanion Belt",
	back="Rancorous Mantle",legs="Samnuha Tights",hands="Buremte Gloves"})
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {ammo="Honed Tathlum", back="Senuna's Mantle"})
	sets.precast.WS['Evisceration'].Mod = set_combine(sets.precast.WS['Evisceration'], {body="Maxixi Casaque",waist="Fotia Belt"})

	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {ammo="Charis Feather",head="Mummu Bonnet +1",neck="Fotia Gorget",ear1="Ishvara Earring",
	hands="Buremte Gloves",ring2="Ramuh Ring +1",back="Rancorous Mantle",legs="Samnuha Tights",waist="Fotia Belt"})
	sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Honed Tathlum", back="Senuna's Mantle"})

	sets.precast.WS['Aeolian Edge'] = {ammo="Charis Feather",
		head="Thaumas Hat",neck="Sancitity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Samnuha Coat",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Fenrir Ring +1",
		back="Toro Cape",waist="Fotia Belt",legs="Rawhide Trousers",feet="Mummu Gamashes +1"}

	sets.precast.Skillchain = {hands="Maculele Bangles",legs="Maxixi Tights +1"}


    -- Midcast Sets
   sets.midcast.FastRecast = {ammo="Impatiens",
		head="Anwig Salade",neck="Voltsurge Torque",ear1="Mendi. Earring",ear2="Loquacious Earring",
		body="Taeon Tabard",hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Mujin Mantle",
		legs="Rawhide Trousers",
		feet="Mummu Gamashes +1"}

	-- Specific spells
	sets.midcast.Utsusemi = {ammo="Impatiens",
		head="Anwig Salade",neck="Magoraga Beads",ear1="Mendi. Earring",ear2="Loquacious Earring",
		body="Taeon Tabard",hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
		back="Mujin Mantle",
		legs="Rawhide Trousers",
		feet="Mummu Gamashes +1"}


	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {head="Ocelomeh Headpiece +1",neck="Sanctity Necklace",
		ring1="Dark Ring",ring2="Defending Ring"}
	sets.ExtraRegen = {head="Ocelomeh Headpiece +1"}


	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle.Town = {main="Skinflayer",sub="Polyhymnia",ammo="Ginsen",
		head="Mummu Bonnet +1",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Mummu Wrists +1",ring1="Ramuh Ring +1",ring2="Defending Ring",
		back="Senuna's Mantle",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Tandava Crackows"}--Atoyac/Uk'uxkaj Cap

	sets.idle.Field = {ammo="Ginsen",
		head="Mummu Bonnet +1",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Mummu Wrists +1",ring1="Ramuh Ring +1",ring2="Defending Ring",
		back="Senuna's Mantle",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Tandava Crackows"}

	sets.idle.Weak = {ammo="Ginsen",
		head="Mummu Bonnet +1",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Mummu Wrists +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Senuna's Mantle",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Tandava Crackows"}

	-- Defense sets

	sets.defense.Evasion = {
		head="Mummu Bonnet +1",neck="Torero Torque",
		body="Emet Harness +1",hands="Mummu Wrists +1",ring1="Varar Ring",ring2="Dark Ring",
		back="Fravashi Mantle",waist="Flume Belt",legs="Samnuha Tights",feet="Mummu Gamashes +1"}

	sets.defense.PDT = {ammo="Iron Gobbet",
		head="Mummu Bonnet +1",neck="Twilight Torque",
		body="Emet Harness +1",hands="Mummu Wrists +1",ring1="Dark Ring",ring2="Defending Ring",
		back="Mollusca Mantle",waist="Flume Belt",legs="Samnuha Tights",feet="Mummu Gamashes +1"}

	sets.defense.MDT = {ammo="Demonry Stone",
		head="Dampening Tam",neck="Twilight Torque",
		body="Emet Harness +1",hands="Wayfarer Cuffs",ring1="Dark Ring",ring2="Defending Ring",
		back="Mollusca Mantle",waist="Flume Belt",legs="Ta'lab Trousers",feet="Wayfarer Clogs"}

	sets.Kiting = {feet="Tandava Crackows"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged = {ammo="Ginsen",
		head="Mummu Bonnet +1",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Mummu Wrists +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Horos Shoes +1"}--Horos Shoes +1
	sets.engaged.iLvl = {ammo="Ginsen",
		head="Mummu Bonnet +1",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Mummu Wrists +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",waist="Windbuffet Belt +1",legs="Mummu Kecks +1",feet="Horos Shoes +1"}
	sets.engaged.Acc = {ammo="Honed Tathlum",
		head="Dampening Tam",neck="Ej Necklace",ear1="Digni. Earring",ear2="Zennaroi Earring",
		body="Samnuha Coat",hands="Leyline Gloves",ring1="Varar Ring",ring2="Varar Ring",
		back="Senuna's Mantle",waist="Kentarch Belt",legs="Samnuha Tights",feet="Mummu Gamashes +1"}
	sets.engaged.Evasion = {ammo="Ginsen",
		head="Mummu Bonnet +1",neck="Ej Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Emet Harness +1",hands="Mummu Wrists +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Horos Shoes +1"}
	sets.engaged.Acc.Evasion = {ammo="Honed Tathlum",
		head="Dampening Tam",neck="Ej Necklace",ear1="Digni. Earring",ear2="Zennaroi Earring",
		body="Emet Harness +1",hands="Leyline Gloves",ring1="Varar Ring",ring2="Varar Ring",
		back="Senuna's Mantle",waist="Kentarch Belt",legs="Samnuha Tights",feet="Mummu Gamashes +1"}
	sets.engaged.PDT = {ammo="Charis Feather",
		head="Mummu Bonnet +1",neck="Twilight Torque",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Emet Harness +1",hands="Mummu Wrists +1",ring1="Dark Ring",ring2="Epona's Ring",
		back="Shadow Mantle",waist="Patentia Sash",legs="Samnuha Tights",feet="Mummu Gamashes +1"}
	sets.engaged.Acc.PDT = {ammo="Honed Tathlum",
		head="Dampening Tam",neck="Twilight Torque",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Emet Harness +1",hands="Mummu Wrists +1",ring1="Dark Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",waist="Hurch'lan Sash",legs="Samnuha Tights",feet="Mummu Gamashes +1"}

	-- Custom melee group: High Haste
	sets.engaged.HighHaste = {ammo="Ginsen",
		head="Mummu Bonnet +1",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Mummu Wrists +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Horos Shoes +1"}
	sets.engaged.Acc.HighHaste = {ammo="Honed Tathlum",
		head="Dampening Tam",neck="Ej Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Samnuha Coat",hands="Mummu Wrists +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",waist="Kentarch Belt",legs="Samnuha Tights",feet="Mummu Gamashes +1"}
	sets.engaged.Evasion.HighHaste = {ammo="Charis Feather",
		head="Mummu Bonnet +1",neck="Torero Torque",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Emet Harness +1",hands="Mummu Wrists +1",ring1="Varar Ring",ring2="Epona's Ring",
		back="Ik Cape",waist="Patentia Sash",legs="Samnuha Tights",feet="Horos Shoes +1"}
	sets.engaged.Acc.Evasion.HighHaste = {ammo="Ginsen",
		head="Dampening Tam",neck="Torero Torque",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Emet Harness +1",hands="Mummu Wrists +1",ring1="Varar Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",waist="Kentarch Belt",legs="Samnuha Tights",feet="Mummu Gamashes +1"}
	sets.engaged.PDT.HighHaste = {ammo="Charis Feather",
		head="Mummu Bonnet +1",neck="Twilight Torque",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Emet Harness +1",hands="Mummu Wrists +1",ring1="Patricius Ring",ring2="Epona's Ring",
		back="Shadow Mantle",waist="Patentia Sash",legs="Mummu Kecks +1",feet="Mummu Gamashes +1"}
	sets.engaged.Acc.PDT.HighHaste = {ammo="Honed Tathlum",
		head="Dampening Tam",neck="Twilight Torque",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Emet Harness +1",hands="Mummu Wrists +1",ring1="Patricius Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",waist="Hurch'lan Sash",legs="Mummu Kecks +1",feet="Mummu Gamashes +1"}

	-- Custom melee group: Max Haste
	sets.engaged.MaxHaste = {ammo="Ginsen",
		head="Mummu Bonnet +1",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Mummu Wrists +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Horos Shoes +1"}
	sets.engaged.Acc.MaxHaste = {ammo="Honed Tathlum",
		head="Dampening Tam",neck="Ej Necklace",ear2="Bladeborn Earring",ear1="Digni. Earring",
		body="Samnuha Coat",hands="Mummu Wrists +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",waist="Kentarch Belt",legs="Samnuha Tights",feet="Mummu Gamashes +1"}
	sets.engaged.Evasion.MaxHaste = {ammo="Charis Feather",
		head="Mummu Bonnet +1",neck="Torero Torque",ear2="Bladeborn Earring",ear1="Digni. Earring",
		body="Emet Harness +1",hands="Mummu Wrists +1",ring1="Varar Ring",ring2="Epona's Ring",
		back="Ik Cape",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet="Horos Shoes +1"}
	sets.engaged.Acc.Evasion.MaxHaste = {ammo="Honed Tathlum",
		head="Dampening Tam",neck="Torero Torque",ear2="Bladeborn Earring",ear1="Digni. Earring",
		body="Emet Harness +1",hands="Mummu Wrists +1",ring1="Varar Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",waist="Kentarch Belt",legs="Samnuha Tights",feet="Mummu Gamashes +1"}
	sets.engaged.PDT.MaxHaste = {ammo="Charis Feather",
		head="Mummu Bonnet +1",neck="Twilight Torque",ear2="Bladeborn Earring",ear1="Digni. Earring",
		body="Emet Harness +1",hands="Mummu Wrists +1",ring1="Patricius Ring",ring2="Epona's Ring",
		back="Shadow Mantle",waist="Windbuffet Belt +1",legs="Mummu Kecks +1",feet="Mummu Gamashes +1"}
	sets.engaged.Acc.PDT.MaxHaste = {ammo="Honed Tathlum",
		head="Dampening Tam",neck="Twilight Torque",ear2="Bladeborn Earring",ear1="Digni. Earring",
		body="Emet Harness +1",hands="Mummu Wrists +1",ring1="Patricius Ring",ring2="Epona's Ring",
		back="Senuna's Mantle",waist="Hurch'lan Sash",legs="Mummu Kecks +1",feet="Mummu Gamashes +1"}



	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Saber Dance'] = {legs="Horos Tights"}
	sets.buff['Fan Dance'] = {hands="Horos Bangles",legs="Maculele Tights"}
	sets.buff['Climactic Flourish'] = {head="Maculele Tiara"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    --auto_presto(spell)
end


function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == "WeaponSkill" then
        if state.Buff['Climactic Flourish'] then
            equip(sets.buff['Climactic Flourish'])
        end
        if state.SkillchainPending.value == true then
            equip(sets.precast.Skillchain)
        end
    end
end


-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Wild Flourish" then
            state.SkillchainPending:set()
            send_command('wait 5;gs c unset SkillchainPending')
        elseif spell.type:lower() == "weaponskill" then
            state.SkillchainPending:toggle()
            send_command('wait 6;gs c unset SkillchainPending')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
        handle_equipping_gear(player.status)
    elseif buff == 'Saber Dance' or buff == 'Climactic Flourish' then
        handle_equipping_gear(player.status)
    end
end


function job_status_change(new_status, old_status)
    if new_status == 'Engaged' then
        determine_haste_group()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    determine_haste_group()
end


function customize_idle_set(idleSet)
    if player.hpp < 80 and not areas.Cities:contains(world.area) then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end
    
    return idleSet
end

function customize_melee_set(meleeSet)
    if state.DefenseMode.value ~= 'None' then
        if buffactive['saber dance'] then
            meleeSet = set_combine(meleeSet, sets.buff['Saber Dance'])
        end
        if state.Buff['Climactic Flourish'] then
            meleeSet = set_combine(meleeSet, sets.buff['Climactic Flourish'])
        end
    end
    
    return meleeSet
end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
    if spell.type == 'Step' then
        if state.IgnoreTargetting.value == true then
            state.IgnoreTargetting:reset()
            eventArgs.handled = true
        end
        
        eventArgs.SelectNPCTargets = state.SelectStepTarget.value
    end
end


-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
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
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end

    msg = msg .. ', ['..state.MainStep.current

    if state.UseAltStep.value == true then
        msg = msg .. '/'..state.AltStep.current
    end
    
    msg = msg .. ']'

    if state.SelectStepTarget.value == true then
        steps = steps..' (Targetted)'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'step' then
        if cmdParams[2] == 't' then
            state.IgnoreTargetting:set()
        end

        local doStep = ''
        if state.UseAltStep.value == true then
            doStep = state[state.CurrentStep.current..'Step'].current
            state.CurrentStep:cycle()
        else
            doStep = state.MainStep.current
        end        
        
        send_command('@input /ja "'..doStep..'" <t>')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    -- We have three groups of DW in gear: Charis body, Charis neck + DW earrings, and Patentia Sash.

    -- For high haste, we want to be able to drop one of the 10% groups (body, preferably).
    -- High haste buffs:
    -- 2x Marches + Haste
    -- 2x Marches + Haste Samba
    -- 1x March + Haste + Haste Samba
    -- Embrava + any other haste buff
    
    -- For max haste, we probably need to consider dropping all DW gear.
    -- Max haste buffs:
    -- Embrava + Haste/March + Haste Samba
    -- 2x March + Haste + Haste Samba

    classes.CustomMeleeGroups:clear()
    
    if buffactive.embrava and (buffactive.haste or buffactive.march) and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 2 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.embrava and (buffactive.haste or buffactive.march or buffactive['haste samba']) then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 2 and (buffactive.haste or buffactive['haste samba']) then
        classes.CustomMeleeGroups:append('HighHaste')
    end
end


-- Automatically use Presto for steps when it's available and we have less than 3 finishing moves
function auto_presto(spell)
    if spell.type == 'Step' then
        local allRecasts = windower.ffxi.get_ability_recasts()
        local prestoCooldown = allRecasts[236]
        local under3FMs = not buffactive['Finishing Move 3'] and not buffactive['Finishing Move 4'] and not buffactive['Finishing Move 5']
        
        if player.main_job_level >= 77 and prestoCooldown < 1 and under3FMs then
            cast_delay(1.1)
            send_command('@input /ja "Presto" <me>')
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 4)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 4)
    elseif player.sub_job == 'SAM' then
        set_macro_page(1, 4)
    else
        set_macro_page(1, 4)
    end
end
