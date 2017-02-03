-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
 
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
     
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end
 
 
-- Setup vars that are user-independent.
function job_setup()
--  state.CombatForm = get_combat_form()
     
    state.Buff = {}
  end
 
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    options.OffenseModes = {'Normal', 'Acc', 'Multi'}
    options.DefenseModes = {'Normal', 'PDT', 'Reraise'}
    options.WeaponskillModes = {'Normal', 'Acc', 'Att', 'Mod'}
    options.CastingModes = {'Normal'}
    options.IdleModes = {'Normal'}
    options.RestingModes = {'Normal'}
    options.PhysicalDefenseModes = {'PDT', 'Reraise'}
    options.MagicalDefenseModes = {'MDT'}
 
 
    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')
 
    select_default_macro_book(1, 9)
end
 
 
-- Called when this job file is unloaded (eg: job change)
function file_unload()
    if binds_on_unload then
        binds_on_unload()
    end
 
    send_command('unbind ^`')
    send_command('unbind !-')
end
 
 
-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
     
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Angon = {ammo="Angon",ear1="Dragoon's Earring",hands="Ptero. Fin. Gaunt."}
    sets.precast.JA.Jump = {
    ammo="Ginsen",
    head="Flam. Zucchetto +1",
    body="Pelt. Plackart +1",
    hands={ name="Valorous Mitts", augments={'Accuracy+19 Attack+19','Crit.hit rate+2','STR+14','Accuracy+14','Attack+14',}},
    legs="Pelt. Cuissots +1",
    feet="Vishap Greaves +1",
    neck="Asperity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}}
    sets.precast.JA['Ancient Circle'] = {legs="Vishap Brais +1"}
    sets.precast.JA['High Jump'] = {
    ammo="Ginsen",
    head="Flam. Zucchetto +1",
    body="Pelt. Plackart +1",
    hands={ name="Valorous Mitts", augments={'Accuracy+19 Attack+19','Crit.hit rate+2','STR+14','Accuracy+14','Attack+14',}},
    legs="Vishap Brais +1",
    feet="Pelt. Schyn. +1",
    neck="Asperity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}}
    sets.precast.JA['Soul Jump'] = {
    ammo="Ginsen",
    head="Flam. Zucchetto +1",
    body="Pelt. Plackart +1",
    hands={ name="Valorous Mitts", augments={'Accuracy+19 Attack+19','Crit.hit rate+2','STR+14','Accuracy+14','Attack+14',}},
    legs="Pelt. Cuissots +1",
    feet="Pelt. Schyn. +1",
    neck="Asperity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}}
    sets.precast.JA['Spirit Jump'] = {
    ammo="Ginsen",
    head="Flam. Zucchetto +1",
    body="Pelt. Plackart +1",
    hands={ name="Valorous Mitts", augments={'Accuracy+19 Attack+19','Crit.hit rate+2','STR+14','Accuracy+14','Attack+14',}},
    legs="Pelt. Cuissots +1",
    feet="Pelt. Schyn. +1",
    neck="Asperity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}}
    sets.precast.JA['Super Jump'] = {ammo="Ginsen",
    head="Flam. Zucchetto +1",
    body="Pelt. Plackart +1",
    hands={ name="Valorous Mitts", augments={'Accuracy+19 Attack+19','Crit.hit rate+2','STR+14','Accuracy+14','Attack+14',}},
    legs="Pelt. Cuissots +1",
    feet="Vishap Greaves +1",
    neck="Asperity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}}
    sets.precast.JA['Spirit Link'] = {hands="Peltast's Vambraces"}
    sets.precast.JA['Call Wyvern'] = {body="Pteroslaver Mail"}
    sets.precast.JA['Deep Breathing'] = {hands="Pteroslaver Finger Gauntlets"}
    sets.precast.JA['Spirit Surge'] = {head="Flam. Zucchetto +1",
    body="Pteroslaver Mail",
    hands={ name="Despair Fin. Gaunt.", augments={'Accuracy+10','Pet: VIT+7','Pet: Damage taken -3%',}},
    legs="Falconer's Hose",
    feet={ name="Ptero. Greaves +1", augments={'Enhances "Empathy" effect',}},
    neck="Chanoix's Gorget",
    waist="Windbuffet Belt +1",
    left_ear="Anastasi Earring",
    right_ear="Lancer's Earring",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back={ name="Updraft Mantle", augments={'STR+2','Pet: Breath+4','Pet: Damage taken -4%',}}} 
     
    -- Healing Breath sets
    sets.HB = {ammo="Staunch Tathlum",
				   head="Ptero. Armet +1",neck="Lancer's Torque",ear1="Anastasi Earring",ear2="Lancer's Earring",
				   body="Emicho Haubert",hands="Despair Fin. Gaunt.",
				   back="Updraft Mantle",waist="Glassblower's Belt",legs="Vishap Brais +1",feet="Ptero. Greaves +1"}
    sets.HB.Pre = {head="Vishap Armet +1"}
    sets.HB.Mid = {ammo="Staunch Tathlum", 
					head="Vishap Armet +1",neck="Twilight Torque",ear1="Etiolation Earring",ear2="Ethereal Earring",
					body="Jumalik Mail",hands="Founder's Gauntlets",ring1="Meridian Ring",ring2="Weather. Ring",
					back="Xucau Mantle",waist="Glassblower's Belt",legs="Founder's Hose",feet="Amm Greaves"}
         
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Yaoyotl Helm",
        body="Mikinaak Breastplate",hands="Buremte Gloves",ring1="Spiral Ring",
        back="Letalis Mantle",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
         
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
 
    sets.midcast.Breath = 
    set_combine(
        sets.midcast.FastRecast, 
        { head="Vishap Armet +1" })
     
    -- Fast cast sets for spells
     
    sets.precast.FC = {ammo="Impatiens", 
		head="Vishap Armet +1",neck="Baetyl Pendant",ear1="Etiolation Earring",ear2="Loquac. Earring",
		body="Jumalik Mail",hands="Leyline Gloves",	ring1="Lebeche Ring",ring2="Weather. Ring",feet="Carmine Greaves +1"}
     
    -- Midcast Sets
    sets.midcast.FastRecast = {ammo="Impatiens", 
		head="Vishap Armet +1",neck="Baetyl Pendant",ear1="Etiolation Earring",ear2="Loquac. Earring",
		body="Jumalik Mail",hands="Leyline Gloves",	ring1="Lebeche Ring",ring2="Weather. Ring",feet="Carmine Greaves +1"}  
         
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Thew Bomblet",
    head={ name="Valorous Mask", augments={'Sklchn.dmg.+4%','STR+8','Accuracy+12',}},
    body="Sulevia's Plate. +1",
    hands={ name="Valorous Mitts", augments={'Accuracy+19 Attack+19','Crit.hit rate+2','STR+14','Accuracy+14','Attack+14',}},
    legs={ name="Valor. Hose", augments={'Attack+21','Sklchn.dmg.+3%','STR+15',}},
    feet="Sulev. Leggings +1",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Ifrit Ring",
    right_ring="Ifrit Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {head="Yaoyotl Helm",back="Letalis Mantle"})
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})
     
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
		sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {})
        sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS.Acc, {})
        sets.precast.WS['Stardiver'].Mod = set_combine(sets.precast.WS['Stardiver'], {})
 
        sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {})
        sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS.Acc, {})
        sets.precast.WS['Drakesbane'].Mod = set_combine(sets.precast.WS['Drakesbane'], {})
 
		sets.precast.WS["Camlann's Torment"] = set_combine(sets.precast.WS, {})
        sets.precast.WS["Camlann's Torment"].Acc = set_combine(sets.precast.WS.Acc, {})
        sets.precast.WS["Camlann's Torment"].Mod = set_combine(sets.precast.WS["Camlann's Torment"], {})
 
        -- Midcast Sets
        sets.midcast.FastRecast = {ammo="Impatiens", 
		head="Vishap Armet +1",neck="Baetyl Pendant",ear1="Etiolation Earring",ear2="Loquac. Earring",
		body="Jumalik Mail",hands="Leyline Gloves",	ring1="Lebeche Ring",ring2="Weather. Ring",feet="Carmine Greaves +1"}
     
    -- Sets to return to when not performing an action.
     
    -- Resting sets
    sets.resting = {head="Yaoyotl Helm",neck="Wiglen Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Ares' cuirass +1",hands="Cizin Mufflers",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Letalis Mantle",waist="Goading Belt",legs="Blood Cuisses",feet="Ejekamal Boots"}
     
 
    -- Idle sets
    sets.idle = {}
 
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = {main={ name="Reienkyo", augments={'Weapon Skill Acc.+14','VIT+5','Accuracy+8','Attack+20','DMG:+23',}},
    sub="Nepenthe Grip",
    ammo="Ginsen",
    head={ name="Valorous Mask", augments={'Accuracy+23 Attack+23','"Dbl.Atk."+2','DEX+4','Accuracy+13','Attack+14',}},
    body="Pteroslaver Mail",
    hands="Sulev. Gauntlets +1",
    legs="Sulevi. Cuisses +1",
    feet="Sulev. Leggings +1",
    neck="Asperity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Petrov Ring",
    right_ring="Warp Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}}
     
    sets.idle.Field = {
        ammo="Ginsen",
    head={ name="Valorous Mask", augments={'Accuracy+23 Attack+23','"Dbl.Atk."+2','DEX+4','Accuracy+13','Attack+14',}},
    body="Pteroslaver Mail",
    hands="Sulev. Gauntlets +1",
    legs="Sulevi. Cuisses +1",
    feet="Sulev. Leggings +1",
    neck="Asperity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Petrov Ring",
    right_ring="Warp Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}}
 
    sets.idle.Weak = {ammo="Ginsen",
    head={ name="Valorous Mask", augments={'Accuracy+23 Attack+23','"Dbl.Atk."+2','DEX+4','Accuracy+13','Attack+14',}},
    body="Pteroslaver Mail",
    hands="Sulev. Gauntlets +1",
    legs="Sulevi. Cuisses +1",
    feet="Sulev. Leggings +1",
    neck="Asperity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Petrov Ring",
    right_ring="Warp Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}}
     
    -- Defense sets
    sets.defense.PDT = {ammo="Hagneia Stone",
        head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Mikinaak Breastplate",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
        back="Letalis Mantle",waist="Goading Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
 
    sets.defense.Reraise = {
        head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Buremte Gloves",ring1="Dark Ring",ring2="Paguroidea Ring",
        back="Letalis Mantle",waist="Goading Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
 
    sets.defense.MDT = {ammo="Demonry Stone",
        head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Mikinaak Breastplate",hands="Cizin Mufflers",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Engulfer Cape",waist="Goading Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
 
    sets.Kiting = {legs="Blood Cuisses"}
 
    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
 
    -- Engaged sets
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
     
    -- Normal melee group
    sets.engaged = {ammo="Ginsen",
    head="Flam. Zucchetto +1",
    body="Pelt. Plackart +1",
    hands={ name="Valorous Mitts", augments={'Accuracy+19 Attack+19','Crit.hit rate+2','STR+14','Accuracy+14','Attack+14',}},
    legs="Sulevi. Cuisses +1",
    feet={ name="Valorous Greaves", augments={'Accuracy+23 Attack+23','Sklchn.dmg.+1%','STR+8','Accuracy+13','Attack+12',}},
    neck="Asperity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}}
    sets.engaged.Acc = {ammo="Hagneia Stone",
        head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Mikinaak Breastplate",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="Mars's Ring",
        back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
    sets.engaged.Multi = {ammo="Hagneia Stone",
        head="Otomi Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Xaddi Mail",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Atheling Mantle",waist="Cetl Belt",legs="Espial hose",feet="Ejekamal Boots"}
    sets.engaged.Multi.PDT = {ammo="Hagneia Stone",
        head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Cizin Mail",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="Mars's Ring",
        back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Cizin Graves"}
    sets.engaged.Multi.Reraise = {ammo="Hagneia Stone",
        head="Twilight Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Breastplate",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="Mars's Ring",
        back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Ejekamal Boots"}
    sets.engaged.PDT = {ammo="Hagneia Stone",
        head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Mikinaak Breastplate",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
        back="Mollusca Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
    sets.engaged.Acc.PDT = {ammo="Hagneia Stone",
        head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Mikinaak Breastplate",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
        back="Mollusca Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
    sets.engaged.Reraise = {ammo="Hagneia Stone",
        head="Twilight Helm",neck="Torero Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
        back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
    sets.engaged.Acc.Reraise = {ammo="Hagneia Stone",
        head="Twilight Helm",neck="Torero Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
        back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
         
    -- Melee sets for in Adoulin, which has an extra 2% Haste from Ionis.
    sets.engaged.Adoulin = {ammo="Ginsen",
    head="Flam. Zucchetto +1",
    body="Pelt. Plackart +1",
    hands={ name="Valorous Mitts", augments={'Accuracy+19 Attack+19','Crit.hit rate+2','STR+14','Accuracy+14','Attack+14',}},
    legs="Sulevi. Cuisses +1",
    feet={ name="Valorous Greaves", augments={'Accuracy+23 Attack+23','Sklchn.dmg.+1%','STR+8','Accuracy+13','Attack+12',}},
    neck="Asperity Necklace",
    waist="Windbuffet Belt +1",
    left_ear="Bladeborn Earring",
    right_ear="Steelflash Earring",
    left_ring="Petrov Ring",
    right_ring="Rajas Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}}
    sets.engaged.Adoulin.Acc = {ammo="Hagneia Stone",
        head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Mikinaak Breastplate",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="Mars's Ring",
        back="Takaha Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
    sets.engaged.Adoulin.Multi = {ammo="Hagneia Stone",
        head="Otomi Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Mikinaak Breastplate",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Letalis Mantle",waist="Goading Belt",legs="Cizin Breeches",feet="Ejekamal Boots"}
    sets.engaged.Adoulin.Multi.PDT = {ammo="Hagneia Stone",
        head="Yaoyotl Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Cizin Mail",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="Mars's Ring",
        back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Cizin Graves"}
    sets.engaged.Adoulin.Multi.Reraise = {ammo="Hagneia Stone",
        head="Twilight Helm",neck="Ganesha's Mala",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Breastplate",hands="Cizin Mufflers",ring1="Rajas Ring",ring2="Mars's Ring",
        back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Ejekamal Boots"}
    sets.engaged.Adoulin.PDT = {ammo="Hagneia Stone",
        head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Mikinaak Breastplate",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
        back="Mollusca Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
    sets.engaged.Adoulin.Acc.PDT = {ammo="Hagneia Stone",
        head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Mikinaak Breastplate",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
        back="Mollusca Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
    sets.engaged.Adoulin.Reraise = {ammo="Hagneia Stone",
        head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
        back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
    sets.engaged.Adoulin.Acc.Reraise = {ammo="Hagneia Stone",
        head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Cizin Mufflers",ring1="Dark Ring",ring2="Dark Ring",
        back="Letalis Mantle",waist="Dynamic Belt",legs="Cizin Breeches",feet="Karieyh Sollerets +1"}
 
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------
 
-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
 
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
    equip(sets.precast.FC)
    end
end
 
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
 
end
 
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
        if spell.action_type == 'Magic' then
        equip(sets.midcast.FastRecast)
        if player.hpp < 51 then
            classes.CustomClass = "Breath" -- This would cause it to look for sets.midcast.Breath 
        end
    end
end
 
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
     
--  if state.DefenseMode == 'Reraise' or
--      (state.Defense.Active and state.Defense.Type == 'Physical' and state.Defense.PhysicalMode == 'Reraise') then
--      equip(sets.Reraise)
--  end
end
 
-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, action, spellMap, eventArgs)
if spell.english:startswith('Healing Breath') or spell.english == 'Restoring Breath' then
        equip(sets.HB.Mid)
    end
end
 
 -- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
        -- Effectively lock these items in place.
        if state.DefenseMode == 'Reraise' or
                (state.Defense.Active and state.Defense.Type == 'Physical' and state.Defense.PhysicalMode == 'Reraise') then
                equip(sets.Reraise)
        end
end
 
-- Run after the default pet midcast() is done.
-- eventArgs is the same one used in job_pet_midcast, in case information needs to be persisted.
function job_pet_post_midcast(spell, action, spellMap, eventArgs)
     
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
--function job_aftercast(spell, action, spellMap, eventArgs)
--if state.DefenseMode == 'Reraise' or
        --(state.Defense.Active and state.Defense.Type == 'Physical' and state.Defense.PhysicalMode == 'Reraise') then
    --end
--end
 
-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)
 
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_aftercast(spell, action, spellMap, eventArgs)
 
end
 
-- Run after the default pet aftercast() is done.
-- eventArgs is the same one used in job_pet_aftercast, in case information needs to be persisted.
function job_pet_post_aftercast(spell, action, spellMap, eventArgs)
 
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------
 
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
 
end
 
-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, spellMap)
 
end
 
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    return idleSet
end
 
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    return meleeSet
end
 
-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
 
end
 
-- Called when the player's pet's status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
 
end
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
 
end
 
function job_update(cmdParams, eventArgs)
    --state.CombatForm = get_combat_form()
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
 
end
 
--function get_combat_form()
--  if areas.Adoulin:contains(world.area) and buffactive.ionis then
--      return 'Adoulin'
--  end
--end
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    classes.CustomMeleeGroups:clear()
    if areas.Adoulin:contains(world.area) and buffactive.ionis then
        classes.CustomMeleeGroups:append('Adoulin')
    end
end
 
-- Job-specific toggles.
function job_toggle(field)
 
end
 
-- Request job-specific mode lists.
-- Return the list, and the current value for the requested field.
function job_get_mode_list(field)
 
end
 
-- Set job-specific mode values.
-- Return true if we recognize and set the requested field.
function job_set_mode(field, val)
 
end
 
-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
 
end
 
-- Handle notifications of user state values being changed.
function job_state_change(stateField, newValue)
 
end
 
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
 
end
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function select_default_macro_book()
    set_macro_page(1, 9)
end