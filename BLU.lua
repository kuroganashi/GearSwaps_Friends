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
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
    
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false


    blue_magic_maps = {}
    
    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.
    
    -- Physical Spells --
    
    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{
        'Bilgestorm'
    }

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{
        'Heavy Strike',
    }

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{
        'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Sinker Drill','Spinal Cleave',
        'Uppercut','Vertical Cleave'
    }
        
    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{
        'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault',
        'Vanity Dive'
    }
        
    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{
        'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Saurian Slide','Sweeping Gouge','Sub-zero Smash'
    }
        
    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{
        'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'
    }

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{
        'Mandibular Bite','Queasyshroom'
    }

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{
        'Ram Charge','Screwdriver','Tourbillion'
    }

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{
        'Bludgeon'
    }

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{
        'Final Sting'
    }

    -- Magical Spells --

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{
        'Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere','Dark Orb','Death Ray',
        'Diffusion Ray','Droning Whirlwind','Embalming Earth','Firespit','Foul Waters',
        'Ice Break','Leafstorm','Maelstrom','Rail Cannon','Regurgitation','Rending Deluge',
        'Retinal Glare','Spectral Floe','Subduction','Tenebral Crush','Tem. Upheaval','Water Bomb'
    }

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{
        'Acrid Stream','Evryone. Grudge','Nectarous Deluge','Magic Hammer','Mind Blast','Scouring Spate'
    }

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{
        'Eyes On Me','Mysterious Light'
    }

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{
        'Atra. Libations','Entomb','Thermal Pulse'
    }

	--Magical spells with a AGI Stat Mod.
	blue_magic_maps.MagicalAgi = S{
        'Molting Plumage','Palling Salvo','Silent Storm'
    }
	
	--Magical spells with a STR Stat Mod.
	blue_magic_maps.MagicalStr = S{
        'Blinding Fulgor','Searing Tempest'
    }
	
    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{
        'Anvil Lightning','Charged Whisker','Gates of Hades'
    }
            
    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{
        '1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
        'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
        'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
        'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
        'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
        'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
        'Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'
    }
        
    -- Breath-based spells
    blue_magic_maps.Breath = S{
        'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
        'Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
        'Thunder Breath','Vapor Spray','Wind Breath'
    }

    -- Stun spells
    blue_magic_maps.Stun = S{
        'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
        'Thunderbolt','Whirl of Rage'
    }
        
    -- Healing spells
    blue_magic_maps.Healing = S{
        'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','White Wind',
        'Wild Carrot'
    }
    
    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{
        'Barrier Tusk','Diamondhide','Magic Barrier','Mighty Guard','Metallic Body','Plasma Charge',
        'Pyric Bulwark','Reactor Cool',
    }

    -- Other general buffs
    blue_magic_maps.Buff = S{
        'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell',
        'Memento Mori','Mighty Guard','Nat. Meditation','Occultation','Orcish Counterstance','Refueling',
        'Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion',
        'Zephyr Mantle'
    }
    
    
    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{
        'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve','Cruel Joke','Cesspool',
        'Crashing Thunder','Droning Whirlwind','Gates of Hades','Harden Shell','Mighty Guard','Polar Roar',
        'Pyric Bulwark','Tearing Gust','Thunderbolt','Tourbillion','Uproot'
    }
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Refresh', 'Learning', 'Special', 'Triple')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'Refresh', 'PDT', 'Learning')

    -- Additional local binds
    send_command('bind ^` input /ja "Chain Affinity" <me>')
    send_command('bind !` input /ja "Efflux" <me>')
    send_command('bind @` input /ja "Burst Affinity" <me>')

    update_combat_form()
    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
end


-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    sets.buff['Burst Affinity'] = {legs="Assim. Shalwar",feet="Hashishin Basmak",back="Cornflower Cape",ring1="Locus Ring",ring2="Mujin Band"}--Assim. Shalwar +1
    sets.buff['Chain Affinity'] = {head="Hashishin Kavuk",feet="Assim. Charuqs",back="Cornflower Cape",ring2="Mujin Band"}--Assim. Charuqs +1
    sets.buff.Convergence = {head="Luhlaza Keffiyeh"} --Luhlaza Keffiyeh +1
    sets.buff.Diffusion = {feet="Luhlaza Charuqs"}--Luhlaza Charuqs +1
    sets.buff.Enchainment = {body="Luhlaza Jubbah"}
    sets.buff.Efflux = {legs="Hashishin Tayt",back="Rosmerta's Cape"} --Hashishin Tayt +1

    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Azure Lore'] = {hands="Luhlaza Bazubands"}

	sets.precast.JA['Provoke'] = sets.enmity

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Taeon Chapeau",neck="Unmoving Collar",ear1="Soil Pearl",ear2="Soil Pearl",
        body="Samnuha Coat",hands="Rawhide Gloves",ring1="Titan Ring",ring2="Titan Ring",
        back="Iximulew Cape",waist="Chuq'aba Belt",legs="Samnuha Tights",feet="Rawhide Boots"}--Telchine Gloves
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
	
	-- Set for acc on steps, since Yonin drops acc a fair bit
	sets.precast.Step = {
		head="Carmine Mask",neck="Subtlety Spec.",ear1="Digni. Earring",ear2="Cessance Earring",
		body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Herculean Gloves",ring1="Begrudging Ring",ring2="Supershear Ring",
		back="Rosmerta's Cape",waist="Anguinus Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Impatiens",
        head="Carmine Mask",neck="Voltsurge Torque",ear1="Etiolation Earring",ear2="Loquacious Earring",
        body="Taeon Tabard",hands="Leyline Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
        back="Ogapepo Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Chelona Boots +1"}
        
    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, 
	{body="Hashishin Mintan"})

    sets.enmity = {ear1="Friomisi Earring",neck="Unmoving Collar +1",body="Emet Harness +1",hands="Kurys Gloves",waist="Warwolf Belt",ring1="Petrov Ring",ring2="Begrudging Ring"}

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Honed Tathlum",
        head="Adhemar Bonnet",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Jhakri Cuffs +1",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Rosmerta's Cape",waist="Fotia Belt",legs="Samnuha Tights",feet="Herculean Boots"}
    
    sets.precast.WS.acc = set_combine(sets.precast.WS, 
		{back="Atheling Mantle",hands="Leyline Gloves",ammo="Honed Tathlum",head="Dampening Tam"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	
	--Sword Weaponskill
	
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, 
		{ammo="Ginsen",ring1="Levia. Ring",ring2="Rufescent Ring",
		feet="Thereoid Greaves",body="Jhakri Robe +1",head="Jhakri Coronal +1",feet="Jhakri Pigaches +1",
		legs="Jhakri Slops +1",hands="Jhakri Cuffs +1",back="Vespid Mantle"})--Luhlaza Charuqs +1/Medium's Sabots

	sets.precast.WS['Expiacion'] = {ammo="Ginsen",
         head="Jhakri Coronal +1",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
         body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Petrov Ring",ring2="Ramuh Ring",
         back="Laic Mantle",waist="Fotia Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}--Thereoid Greaves, Vespid Mantle,  Rawhide Gloves / Jhakri Cuffs +1/"Jhakri Robe +1"
	
	sets.precast.WS['Savage Blade'] = {ammo="Honed Tathlum",
         head="Adhemar Bonnet",neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",
         body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Petrov Ring",ring2="Rufescent Ring",
         back="Vespid Mantle",waist="Fotia Belt",legs="Samnuha Tights",feet="Thereoid Greaves"}
	
	sets.precast.WS['Chant du Cygne'] = {ammo="Jukukik Feather",
         head="Adhemar Bonnet",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
         hands="Jhakri Cuffs +1",ring1="Begrudging Ring",ring2="Ramuh Ring",
         back="Rosmerta's Cape",waist="Fotia Belt",legs="Samnuha Tights",feet="Thereoid Greaves"}--Uk'uxkaj cap/Lilitu Headpiece
	
	sets.precast.WS['Vorpal Blade'] = {ammo="Honed Tathlum",
         head="Adhemar Bonnet",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
         body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Ifrit ring",ring2="Rufescent Ring",
         back="Vespid Mantle",waist="Fotia Belt",legs="Samnuha Tights",feet="Thereoid Greaves"}
	
    sets.precast.WS['Sanguine Blade'] = {ammo="Dosis Tathlum",
        head="Jhakri Coronal +1",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Fenrir Ring",ring2="Fenrir Ring",waist="Salire Belt",
        back="Cornflower Cape",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
    
	--Club Weaponskill
	
	sets.precast.WS['Realmrazer'] = {ammo="Ginsen",
		ring1="Levia. Ring",ring2="Rufescent Ring",ear1="Brutal Earring",ear2="Moonshade Earring",neck="Fotia Gorget",waist="Fotia Belt",
		feet="Jhakri Pigaches +1",body="Jhakri Robe +1",head="Jhakri Coronal +1",
		legs="Jhakri Slops +1",hands="Jhakri Cuffs +1",back="Vespid Mantle"}
    
	sets.precast.WS['Black Halo'] = {ammo="Ginsen",
		ring1="Ifrit Ring",ring2="Rufescent Ring",ear1="Brutal Earring",ear2="Moonshade Earring",neck="Fotia Gorget",waist="Fotia Belt",
		feet="Thereoid Greaves",head="Adhemar Bonnet",
		legs="Samnuha Tights",body="Jhakri Robe +1",hands="Herculean Gloves",back="Vespid Mantle"}
	
	sets.precast.WS['Flash Nova'] = {ammo="Dosis Tathlum",
        head="Jhakri Coronal +1",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Fenrir Ring",ring2="Fenrir Ring",waist="Salire Belt",
        back="Cornflower Cape",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
	
	sets.precast.WS['True Strike'] = {ammo="Honed Tathlum",
		ring1="Petrov Ring",ring2="Rufescent Ring",ear1="Ishvara Earring",ear2="Moonshade Earring",neck="Fotia Gorget",waist="Fotia Belt",
		feet="Thereoid Greaves",head="Adhemar Bonnet",
		legs="Samnuha Tights",body="Jhakri Robe +1",hands="Jhakri Cuffs +1",back="Rancorous Mantle"}
	
    -- Midcast Sets
    sets.midcast.FastRecast = {ammo="Impatiens",
		head="Carmine Mask",neck="Voltsurge Torque",ear1="Etiolation Earring",ear2="Loquac. Earring",
        body="Hashishin Mintan",hands="Hashishin Bazubands",ring1="Weatherspoon Ring",ring2="Prolix ring",
        back="Swith Cape",waist="Witful belt",legs="Psycloth Lappas",feet="Chelona Boots +1"}
        
    sets.midcast['Blue Magic'] = {}
    
    -- Physical Spells --
    
	--body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}}
	
    sets.midcast['Blue Magic'].Physical = {ammo="Mavi Tathlum",
        head="Jhakri Coronal +1",neck="Incanter's Torque",ear1="Digni. Earring",ear2="Cessance Earring",
        body="Jhakri Robe +1",hands="Rawhide Gloves",ring1="Petrov Ring",ring2="Supershear Ring",
        back="Cornflower Cape",waist="Anguinus Belt",legs="Samnuha Tights",feet="Rawhide Boots"}--Rawhide Gloves / Leyline Gloves / Assim. Keffiyeh +1 / Jhakri Robe +1

    sets.midcast['Blue Magic'].PhysicalAcc = {ammo="Honed Tathlum",
        head="Carmine Mask",neck="Subtlety Spec.",ear1="Digni. Earring",ear2="Cessance Earring",
        body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Begrudging Ring",ring2="Supershear Ring",
        back="Lupine Cape",waist="Anguinus Belt",legs="Jhakri Slops +1",feet="Herculean Boots"}

    sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical,
        {head="Jhakri Coronal +1",body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Rawhide Gloves",ring1="Ifrit Ring",ring2="Ifrit Ring",waist="Chuq'aba Belt",back="Lupine Cape"})

    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical,
        {ammo="Jukukik Feather",head="Lilitu Headpiece",body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Rawhide Gloves",
         waist="Warwolf Belt",back="Rosmerta's Cape",legs="Samnuha Tights",ring1="Petrov Ring",ring2="Ramuh Ring",feet="Thereoid Greaves"})

    sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical,
        {head="Taeon Chapeau",body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Rawhide Gloves",back="Iximulew Cape",ear1="Soil Pearl",ear2="Soil Pearl",ring1="Titan Ring",ring2="Titan Ring",neck="Unmoving Collar",waist="Chuq'aba Belt",feet="Rawhide Boots"})

    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical,
        {head="Uk'uxkaj Cap",body="Adhemar Jacket",hands="Rawhide Gloves",ring1="Garuda Ring",ring2="Garuda Ring",back="Lupine Cape",
         waist="Chaac Belt",feet="Herculean Boots"})

    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical,
        {ear1="Psystorm Earring",head="Jhakri Coronal +1",body="Jhakri Robe +1",hands="Jhakri Cuffs +1",legs="Jhakri Slops +1",
         ring1="Acumen Ring",back="Cornflower Cape",feet="Jhakri Pigaches +1"})

    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical,
        {ear1="Lifestorm Earring",head="Jhakri Coronal +1",body="Jhakri Robe +1",hands="Rawhide Gloves",legs="Jhakri Slops +1",
         ring1="Levia. Ring",ring2="Rufescent Ring",waist="Salire Belt",back="Cornflower Cape",feet="Jhakri Pigaches +1"})

    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical,
        {head="Jhakri Coronal +1",body="Jhakri Robe +1",hands="Rawhide Gloves",back="Cornflower Cape",legs="Jhakri Slops +1",neck="Unmoving Collar",
         waist="Chaac Belt",feet="Jhakri Pigaches +1"})

    sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical, 
		{head="Assim. Keffiyeh",body="Assim. Jubbah +1",hands="Rawhide Gloves",legs="Assim. Shalwar",feet="Assim. Charuqs",ring1="Begrudging Ring",ring2="Supershear Ring",neck="Subtlety Spectacles"})--Assim. Charuqs +1 / Assim. Shalwar +1 / Assim. Keffiyeh +1


    -- Magical Spells --
    
    sets.midcast['Blue Magic'].Magical = {ammo="Dosis Tathlum",
        head="Jhakri Coronal +1",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Jhakri Robe +1",hands="Amalric Gages",ring1="Fenrir Ring",ring2="Fenrir Ring",
        back="Cornflower Cape",waist="Salire Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}--Hashishin Bazubands/Dampening Tam/Psycloth Lappas

    sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,
        {head="Carmine Mask",neck="Incanter's Torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Sangoma Ring",ring2="Fenrir Ring",back="Cornflower Cape",waist="Salire Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"})
    
	sets.midcast['Blue Magic'].MagicalInt = set_combine(sets.midcast['Blue Magic'].Magical,
        {ear1="Psystorm Earring",head="Jhakri Coronal +1",body="Jhakri Robe +1",hands="Amalric Gages",legs="Jhakri Slops +1",
         ring1="Acumen Ring",back="Cornflower Cape",waist="Salire Belt",feet="Jhakri Pigaches +1"})
	
    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical,
        {ring1="Levia. Ring",ring2="Rufescent Ring",head="Jhakri Coronal +1",ear2="Lifestorm Earring",body="Jhakri Robe +1",hands="Jhakri Cuffs +1",legs="Jhakri Slops +1",waist="Salire Belt",feet="Jhakri Pigaches +1"})

    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {feet="Jhakri Pigaches +1",head="Jhakri Coronal +1",hands="Jhakri Cuffs +1",legs="Jhakri Slops +1",body="Jhakri Robe +1",neck="Unmoving Collar"})

    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical,
        {head="Dampening Tam",body="Samnuha Coat",hands="Rawhide Gloves",ring1="Titan Ring",ring2="Titan Ring",ear1="Soil Pearl",ear2="Soil Pearl",neck="Unmoving Collar",back="Iximulew Cape",waist="Chuq'aba Belt"})

	sets.midcast['Blue Magic'].MagicalAgi = set_combine(sets.midcast['Blue Magic'].Magical,
        {head="Dampening Tam",body="Samnuha Coat",hands="Leyline Gloves",ring1="Garuda Ring",ring2="Garuda Ring"})
	
	sets.midcast['Blue Magic'].MagicalStr = set_combine(sets.midcast['Blue Magic'].Magical,
        {head="Jhakri Coronal +1",body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Ifrit Ring",ring2="Ifrit Ring"})
	
    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {head="Dampening Tam",ring1="Petrov Ring",ring2="Ramuh Ring",hands="Jhakri Cuffs +1",body="Samnuha Coat",back="Rosmerta's Cape"})

    sets.midcast['Blue Magic'].MagicAccuracy = {ammo="Mavi Tathlum",
        head="Jhakri Coronal +1",neck="Eddy Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring2="Sangoma Ring",ring1="Weatherspoon Ring",
        back="Cornflower Cape",waist="Salire Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}--Luhlaza Keffiyeh +1/Hashishin Basmak

    -- Breath Spells --
    
    sets.midcast['Blue Magic'].Breath = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh",neck="Incanter's Torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Fenrir Ring",ring2="Fenrir Ring",
        back="Cornflower Cape",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"} --Luhlaza Keffiyeh +1

    -- Other Types --
    
    sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy,
        {waist="Salire Belt",hands="Jhakri Cuffs +1",ring1="Weatherspoon Ring",ring2="Sangoma Ring",back="Cornflower Cape",body="Jhakri Robe +1",legs="Jhakri Slops +1",neck="Incanter's Torque",feet="Jhakri Pigaches +1",head="Jhakri Coronal +1"})--Strendu Ring
        
    sets.midcast['Blue Magic']['White Wind'] = {ammo="Impatiens",
        head="Carmine Mask",neck="Incanter's Torque",ear1="Mendi. Earring",ear2="Loquacious Earring",
        body="Vrikodara Jupon",hands="Telchine Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
        back="Ogapepo Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Medium's Sabots"}--Telchine Gloves/Taeon Tabard/Pahtli Cape

    sets.midcast['Blue Magic'].Healing = {ammo="Impatiens",
        head="Carmine Mask",neck="Incanter's Torque",ear1="Mendi. Earring",ear2="Loquacious Earring",
        body="Vrikodara Jupon",hands="Telchine Gloves",ring1="Weatherspoon Ring",ring2="Prolix Ring",
        back="Oretan. Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Medium's Sabots"}--Taeon Tabard/Pahtli Cape

    sets.midcast['Blue Magic'].SkillBasedBuff = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh",neck="Incanter's Torque",
        body="Assimilator's Jubbah +1",hands="Rawhide Gloves",
        back="Cornflower Cape",legs="Hashishin Tayt",feet="Luhlaza Charuqs"}--Luhlaza Charuqs +1 / Hashishin Tayt +1 / Luhlaza Keffiyeh +1 

    sets.midcast['Blue Magic'].Buff = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh",neck="Incanter's Torque",
        body="Assimilator's Jubbah +1",hands="Rawhide Gloves",
        back="Cornflower Cape",legs="Hashishin Tayt",feet="Luhlaza Charuqs"}--Luhlaza Charuqs +1 / Hashishin Tayt +1 / Luhlaza Keffiyeh +1
    
    sets.midcast.Protect = set_combine(sets.precast.FC, {ring1="Sheltered Ring"})
    sets.midcast.Protectra = set_combine(sets.precast.FC, {ring1="Sheltered Ring"})
    sets.midcast.Shell = set_combine(sets.precast.FC, {ring1="Sheltered Ring"})
    sets.midcast.Shellra = set_combine(sets.precast.FC, {ring1="Sheltered Ring"})
       
    -- Sets to return to when not performing an action.

    -- Gear for learning spells: +skill and AF hands.
    sets.Learning = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh",neck="Incanter's Torque",
        body="Assimilator's Jubbah +1",hands="Assimilator's Bazubands",
        back="Cornflower Cape",legs="Hashishin Tayt",feet="Luhlaza Charuqs"}--Luhlaza Charuqs +1 / Hashishin Tayt +1 / Assimilator's Bazubands +1 / Luhlaza Keffiyeh +1

    sets.latent_refresh = {waist="Fucho-no-obi"}

		--Cornflower Cape aug MP+18 DEX+2 ACC+2 Blue Magic Skill +9	
		--Total of Skill+81 on Learning , Rawhide Gloves makes +91 total.
	
    -- Resting sets
    sets.resting = {ammo="Mavi Tathlum",
        head="Rawhide Mask",neck="Lissome Necklace",ear1="Infused Earring",ear2="Cessance Earring",
        body="Jhakri Robe +1",hands="Serpentes Cuffs",ring1="Paguroidea Ring",ring2="Sheltered Ring",
        back="Umbra Cape",waist="Fucho-no-obi",legs="Rawhide Trousers",feet="Serpentes Sabots"}--Twilight Torque
    
    -- Idle sets
    sets.idle = {ammo="Mavi Tathlum",
        head="Rawhide Mask",neck="Lissome Necklace",ear1="Infused Earring",ear2="Cessance Earring",
        body="Jhakri Robe +1",hands="Serpentes Cuffs",ring1="Paguroidea Ring",ring2="Sheltered Ring",
        back="Umbra Cape",waist="Fucho-no-obi",legs="Crimson Cuisses",feet="Serpentes Sabots"}

	sets.idle.Refresh = {ammo="Mavi Tathlum",
        head="Rawhide Mask",neck="Lissome Necklace",ear1="Infused Earring",ear2="Cessance Earring",
        body="Jhakri Robe +1",hands="Serpentes Cuffs",ring1="Paguroidea Ring",ring2="Sheltered Ring",
        back="Umbra Cape",waist="Fucho-no-obi",legs="Rawhide Trousers",feet="Serpentes Sabots"}
		
    sets.idle.PDT = {ammo="Impatiens",
        head="Dampening Tam",neck="Twilight Torque",ear1="Infused Earring",ear2="Cessance Earring",
        body="Emet Harness",hands="Rawhide Gloves",ring1="Dark Ring",ring2="Defending Ring",
        back="Umbra Cape",waist="Flume Belt",legs="Crimson Cuisses",feet="Battlecast Gaiters"}--Emet Harness +1

    sets.idle.Town = {
		main="Colada",
		sub="Colada",
		ammo="Mavi Tathlum",
        head="Rawhide Mask",neck="Lissome Necklace",ear1="Infused Earring",ear2="Cessance Earring",
        body="Jhakri Robe +1",hands="Serpentes Cuffs",ring1="Paguroidea Ring",ring2="Sheltered Ring",
        back="Umbra Cape",waist="Fucho-no-obi",legs="Crimson Cuisses",feet="Serpentes Sabots"}

    sets.idle.Learning = set_combine(sets.idle, sets.Learning)

    
    -- Defense sets
    sets.defense.PDT = {ammo="Impatiens",
        head="Herculean Helm",neck="Twilight Torque",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Emet Harness",hands="Herculean Gloves",ring1="Dark Ring",ring2="Defending Ring",
        back="Umbra Cape",waist="Flume Belt",legs="Herculean Trousers",feet="Herculean Boots"}--Emet Harness +1

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Dampening Tam",neck="Twilight Torque",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Samnuha Coat",hands="Herculean Gloves",ring1="Dark Ring",ring2="Defending Ring",
        back="Mollusca Mantle",waist="Flume Belt",legs="Ta'lab Trousers",feet="Herculean Boots"}

    sets.Kiting = {legs="Crimson Cuisses"}

    -- Engaged sets

	--body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}}
	
	--ear1="Brutal Earring",ear2="Cessance Earring"
	
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Ginsen",
        head="Adhemar Bonnet",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Herculean Trousers",feet="Herculean Boots"}--Bleating Mantle/Lupine Cape/Asperity Necklace/Clotharius Torque

    sets.engaged.Acc = {ammo="Honed Tathlum",
        head="Carmine Mask",neck="Subtlety Spec.",ear1="Digni. Earring",ear2="Cessance Earring",
        body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Herculean Gloves",ring1="Begrudging Ring",ring2="Supershear Ring",
        back="Atheling Mantle",waist="Anguinus Belt","Hurculean Trousers",feet="Herculean Boots"}--

    sets.engaged.Refresh = {ammo="Ginsen",
        head="Rawhide Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Jhakri Robe +1",hands="Serpentes Cuffs",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Lupine Cape",waist="Fucho-no-obi",legs="Rawhide Trousers",feet="Serpentes Sabots"}--Bleating Mantle

	sets.engaged.Special = {ammo="Ginsen",
        head="Dampening Tam",neck="Clotharius Torque",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Adhemar Jacket",hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Herculean Trousers",feet="Herculean Boots"}--Cetl Belt/Bleating Mantle
	
	sets.engaged.Triple = {ammo="Ginsen",
        head="Herculean Helm",neck="Clotharius Torque",ear1="Brutal Earring",ear2="Cessance Earring",
        body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Herculean Trousers",feet="Herculean Boots"}
	
    sets.engaged.DW = {ammo="Ginsen",
        head="Adhemar Bonnet",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Herculean Trousers",feet="Herculean Boots"}--Bleating Mantle/Lupine Cape

    sets.engaged.DW.Acc = {ammo="Honed Tathlum",
        head="Carmine Mask",neck="Subtlety Spec.",ear1="Digni. Earring",ear2="Cessance Earring",
        body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Herculean Gloves",ring1="Begrudging Ring",ring2="Supershear Ring",
        back="Atheling Mantle",waist="Anguinus Belt","Hurculean Trousers",feet="Herculean Boots"}

    sets.engaged.DW.Refresh = {ammo="Ginsen",
        head="Rawhide Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Jhakri Robe +1",hands="Serpentes Cuffs",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Lupine Cape",waist="Fucho-no-obi",legs="Rawhide Trousers",feet="Serpentes Sabots"}--Bleating Mantle

	sets.engaged.DW.Special = {ammo="Ginsen",
        head="Dampening Tam",neck="Clotharius Torque",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Adhemar Jacket",hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Herculean Trousers",feet="Herculean Boots"}--Cetl Belt/Bleating Mantle
		
	sets.engaged.DW.Triple = {ammo="Ginsen",
        head="Herculean Helm",neck="Clotharius Torque",ear1="Brutal Earring",ear2="Cessance Earring",
        body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Herculean Trousers",feet="Herculean Boots"}
		
    sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)
    sets.engaged.DW.Learning = set_combine(sets.engaged.DW, sets.Learning)


    sets.self_healing = set_combine(sets.midcast['Blue Magic'].Healing, {body="Vrikodara Jupon",waist="Chuq'aba Belt",hands="Telchine Gloves",ear1="Mendi. Earring",ring1="Weatherspoon Ring",ring2="Prolix Ring",feet="Medium's Sabots",back="Oretan. Cape +1"})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
            equip(sets.self_healing)
        end
    end

    -- If in learning mode, keep on gear intended to help with that, regardless of action.
    if state.OffenseMode.value == 'Learning' then
        equip(sets.Learning)
    end
end


------------------------------------------------------------------------------------------------------------------
-- Testing out Hachirin-no-Obi 
------------------------------------------------------------------------------------------------------------------
-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)

    if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.self_healing)
    end
    --if spell.action_type == 'Magic' then
       -- apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    --end
	if spell.skill == 'Blue Magic'  then
        if spell.element == world.day_element or spell.element == world.weather_element then
            equip({waist="Hachirin-No-Obi"})
            --add_to_chat(8,'----- Hachirin-no-Obi Equipped. -----')
        end
    end
	--if spell.skill == 'Blue Magic' then
      --  if state.MagicBurst.value then
        --equip(sets.magic_burst)
        --end
	--end
	if spell.type == "WeaponSkill" then
      if spell.element == world.weather_element or spell.element == world.day_element then
        --equip({waist="Hachirin-no-Obi"})
        --add_to_chat(8,'----- Hachirin-no-Obi Equipped. -----')
      end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    -- Check for H2H or single-wielding
    if player.equipment.sub == "Genbu's Shield" or player.equipment.sub == 'empty' then
        state.CombatForm:reset()
    else
        state.CombatForm:set('DW')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 4)
	elseif player.sub_job == 'WAR' then
        set_macro_page(1, 4)
	elseif player.sub_job == 'RUN' then
        set_macro_page(1, 4)
	elseif player.sub_job == 'SAM' then
        set_macro_page(1, 4)
	elseif player.sub_job == 'NIN' then
        set_macro_page(1, 4)
	elseif player.sub_job == 'RDM' then
        set_macro_page(10, 4)
    elseif player.sub_job == 'BLM' then
        set_macro_page(10, 4)
	elseif player.sub_job == 'WHM' then
        set_macro_page(10, 4)
	elseif player.sub_job == 'SCH' then
        set_macro_page(10, 4)
	else
        set_macro_page(1, 4)
    end
end