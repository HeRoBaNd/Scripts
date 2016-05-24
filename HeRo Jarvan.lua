 --[[
    __  __     ____               __                           
   / / / /__  / __ \____         / /___ _______   ______ _____ 
  / /_/ / _ \/ /_/ / __ \   __  / / __ `/ ___/ | / / __ `/ __ \
 / __  /  __/ _, _/ /_/ /  / /_/ / /_/ / /   | |/ / /_/ / / / /
/_/ /_/\___/_/ |_|\____/   \____/\__,_/_/    |___/\__,_/_/ /_/                                                               
]]--

if myHero.charName ~= "JarvanIV" then return end
local version = "2.01"
local SCRIPT_NAME = "HeRo Jarvan VI"
local SCRIPT_PATCH = '6.10'
local SCRIPT_AUTHOR = "HeRoBaNd"
local FONTAN = false
local xBase = {["x"] = 406, ["z"] = 424}
local zBase = {["x"] = 14322, ["z"] = 14394}
local VP, DP, SP = nil
local FHPred = false
local ts
local Menu
local MYFOCUS = nil
local Qready, Wready, Eready, Rready = false, false, false, false
local REGENTIME = false
local SMITE, ATTACKSMITE, ATTACKSMITE3 = false, false, false
local SMITELIST = {"summonersmite", "s5_summonersmiteplayerganker", "s5_summonersmiteduel"}
local POT = {"ItemCrystalFlask", "RegenerationPotion", "ItemMiniRegenPotion", "ItemCrystalFlaskJungle", "ItemDarkCrystalFlask"}
local ATTACKITEMS = {"ItemTiamatCleave", "ItemTitanicHydraCleave", "BilgewaterCutlass", "YoumusBlade", "HextechGunblade", "ItemSwordOfFeastAndFamine"}
local ANTICCITEMS = {"QuicksilverSash", "ItemDervishBlade"}
local TIAMAT, TITANIC, CUTLASS, YOUMU, GUNBLADE, BOTRK, QSS, DERVISH = false
local TIAMATSLOT, TITANICSLOT, CUTLASSSLOT, YOUMUSLOT, GUNBLADESLOT, BOTRKSLOT, QSSSLOT, DERVISHSLOT, SMITESLOT
local UNDERCC = false
local DANGERSPELL = {"MordekaiserChildrenOfTheGrave", "SkarnerImpale", "LuxLightBindingMis", "Wither", "SonaCrescendo", "DarkBindingMissile", "CurseoftheSadMummy", "EnchantedCrystalArrow", "BlindingDart", "LuluWTwo", "AhriSeduce", "CassiopeiaPetrifyingGaze", "Terrify", "HowlingGale", "JaxCounterStrike", "KennenShurikenStorm", "LeblancSoulShackle", "LeonaSolarFlare", "LissandraR", "AlZaharNetherGrasp", "MonkeyKingDecoy", "NamiQ", "OrianaDetonateCommand", "Pantheon_LeapBash", "PuncturingTaunt", "SejuaniGlacialPrisonStart", "SwainShadowGrasp", "Imbue", "ThreshQ", "UrgotSwap2", "VarusR", "VeigarEventHorizon", "ViR", "InfiniteDuress", "ZyraGraspingRoots", "paranoiamisschance", "puncturingtauntarmordebuff", "surpression", "zedulttargetmark", "enchantedcrystalarrow", "nasusw"}
local SMITEFOCUS = {"SRU_Blue1.1.1", "SRU_Blue7.1.1", "SRU_Murkwolf2.1.1", "SRU_Murkwolf8.1.1", "SRU_Gromp13.1.1", "SRU_Gromp14.1.1", "Sru_Crab16.1.1", "Sru_Crab15.1.1", "SRU_Red10.1.1", "SRU_Red4.1.1", "SRU_Krug11.1.2", "SRU_Krug5.1.2", "SRU_Razorbeak9.1.1", "SRU_Razorbeak3.1.1", "SRU_Dragon6.1.1", "SRU_Baron12.1.1", "TT_NWraith1.1.1", "TT_NGolem2.1.1", "TT_NWolf3.1.1", "TT_NWraith4.1.1", "TT_NGolem5.1.1", "TT_NWolf6.1.1", "TT_Spiderboss8.1.1"}
local VARS = {
  AA = {RANGE = 270},
  Q = {RANGE = 770, WIDTH = 70, DELAY = 0.1, SPEED = math.huge},
  W = {RANGE = 525, WIDTH = 525, DELAY = 0.1, SPEED = nil},
  E = {RANGE = 830, WIDTH = 75, DELAY = 0.1, SPEED = math.huge},
  R = {RANGE = 650, WIDTH = 325, DELAY = 0.1, SPEED = nil}
}
local ultActive = false

-- BoL Tools Tracker --
assert(load(Base64Decode("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"), nil, "bt", _ENV))()
TrackerLoad("fMqjdNreSdWuDCgq")
-- BoL Tools Tracker --

Sequences = {
	[0]		=	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
	[1]		=	{1, 2, 3, 1, 1, 4, 1, 2, 1, 2, 4, 2, 2, 3, 3, 4, 3, 3}, 
	[2]		=	{1, 3, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2}, 
	[3]		=	{2, 1, 3, 2, 2, 4, 2, 1, 2, 1, 4, 1, 1, 3, 3, 4, 3, 3}, 
	[4]		=	{2, 3, 1, 2, 2, 4, 2, 3, 2, 3, 4, 3, 3, 1, 1, 4, 1, 1}, 
	[5]		=	{3, 1, 2, 3, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2, 4, 2, 2}, 
	[6]		=	{3, 2, 1, 3, 3, 4, 3, 2, 3, 2, 4, 2, 2, 1, 1, 4, 1, 1},
	["JarvanIV"]	=	{3, 1, 2, 1, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2}
}

Skills = {"Q", "W", "E", "R"}

LastLevel = 0;

function OnLoad()
--Credits SxTeam
 	local ToUpdate = {}
    ToUpdate.Version = 2.01
    ToUpdate.UseHttps = true
    ToUpdate.Host = "raw.githubusercontent.com"
    ToUpdate.VersionPath = "/HeRoBaNd/Scripts/master/HeRo%20Jarvan.version"
    ToUpdate.ScriptPath =  "/HeRoBaNd/Scripts/master/HeRo%20Jarvan.lua"
    ToUpdate.SavePath = SCRIPT_PATH.."/HeRo Jarvan_Test.lua"
    ToUpdate.CallbackUpdate = function(NewVersion,OldVersion) print("<font color='#FF0000'><b>[HeRo Info]: </b> </font><font color='#00BFFF'><b>Updated to "..NewVersion..". </b></font>") end
    ToUpdate.CallbackNoUpdate = function(OldVersion) print("<font color='#FF0000'><b>[HeRo Info]: </b></font> <font color='#00BFFF'><b>No Updates Found</b></font>") end
    ToUpdate.CallbackNewVersion = function(NewVersion) print("<font color='#FF0000'><b>[HeRo Info]: </b></font> <font color='#00BFFF'><b>New Version found ("..NewVersion.."). Please wait until its downloaded</b></font>") end
    ToUpdate.CallbackError = function(NewVersion) print("<font color='#FF0000'><b>[HeRo Info]: </b></font> <font color='#00BFFF'><b>Error while Downloading. Please try again.</b></font>") end
    ScriptUpdate(ToUpdate.Version,ToUpdate.UseHttps, ToUpdate.Host, ToUpdate.VersionPath, ToUpdate.ScriptPath, ToUpdate.SavePath, ToUpdate.CallbackUpdate,ToUpdate.CallbackNoUpdate, ToUpdate.CallbackNewVersion,ToUpdate.CallbackError)
--Credits SxTeam

	ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 900, DAMAGE_PHYSICAL)

	DelayAction(function() PrintChat("<font color='#FF0000'><b>[HeRo Jarvan] </b></font><font color='#00BFFF'><b>Loaded.</b></font>") end, 4.0)

	ultActive = false

	AddApplyBuffCallback(Buff_Add)
  	AddRemoveBuffCallback(Buff_Rem)
  	AddTickCallback(AutoSmite)
	AddDrawCallback(DrawSmiteable)	

	Menu = scriptConfig(SCRIPT_NAME.." ["..SCRIPT_PATCH.."]", "Hero Jarvan")
	
	Menu:addSubMenu("[HeRo Jarvan - Combo]", "Combo")
		Menu.Combo:addParam("ComboMode", "Combo mode", SCRIPT_PARAM_ONKEYDOWN, false, 32)
		Menu.Combo:addParam("ChangeCombo", "Change Combo Mode Key", SCRIPT_PARAM_ONKEYTOGGLE, false, 89)
		Menu.Combo:addParam("Cmode", "Combo Q and E Mode", SCRIPT_PARAM_LIST, 1, {"Smart", "E+Q", "Q or E", "Q Only", "E Only"})
    	--Menu.Combo:addParam("Burst", "All In/Burst Combo (Toggle)", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("S"))
		Menu.Combo:addParam("ComboQ", "Use Q in Combo", SCRIPT_PARAM_ONOFF, true)
		Menu.Combo:addParam("ComboW", "Use W in Combo", SCRIPT_PARAM_ONOFF, true)
		Menu.Combo:addParam("ComboE", "Use E in Combo", SCRIPT_PARAM_ONOFF, true)
		Menu.Combo:addParam("ComboR", "Use R in Combo", SCRIPT_PARAM_ONOFF, false)
		Menu.Combo:addParam("UseFocus", "Use Cistom Target Selector", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addSubMenu("[HeRo Jarvan - Harass]", "Harass")
		Menu.Harass:addParam("HS", "Harass", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
		Menu.Harass:addParam("ChangeHarass", "Change Harass Mode Key", SCRIPT_PARAM_ONKEYTOGGLE, false, 84)
		Menu.Harass:addParam("Hmode", "Harass Q and E Mode", SCRIPT_PARAM_LIST, 1, {"E+Q", "Q or E", "Q Only", "E Only"})		
		Menu.Harass:addParam("HarassQ", "Use Q in Harass", SCRIPT_PARAM_ONOFF, true)
		Menu.Harass:addParam("HarassE", "Use E in Harass", SCRIPT_PARAM_ONOFF, true)
		Menu.Harass:addParam("HarassMana", "% Mana for Harass", SCRIPT_PARAM_SLICE, 50, 0, 100, 0)

	igniteslot = FindSlotByName("SummonerDot")
	Menu:addSubMenu("[HeRo Jarvan - KillSteal]", "KillSteal")
		Menu.KillSteal:addParam("Steal", "Endble KillSteal", SCRIPT_PARAM_ONOFF, true)
		Menu.KillSteal:addParam("QSteal", "Use Q", SCRIPT_PARAM_ONOFF, true)
		Menu.KillSteal:addParam("ESteal", "Use E", SCRIPT_PARAM_ONOFF, true)
		Menu.KillSteal:addParam("RSteal", "Use R", SCRIPT_PARAM_ONOFF, false)
		if igniteslot ~= nil then
			Menu.KillSteal:addParam("UseIgnite", "Use Ignite", SCRIPT_PARAM_ONOFF, true)
		end
	
	Menu:addSubMenu("[HeRo Jarvan - LaneClear]", "Clear")
		Menu.Clear:addParam("LaneClear", "LaneClear", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
		Menu.Clear:addParam("LaneClearQ", "Use Q in LaneClear", SCRIPT_PARAM_ONOFF, true)
		Menu.Clear:addParam("LaneClearE", "Use E in LaneClear", SCRIPT_PARAM_ONOFF, true)
		Menu.Clear:addParam("LaneClearW", "Use W in LaneClear", SCRIPT_PARAM_ONOFF, true)
		Menu.Clear:addParam("ClearMana", "% Mana for LaneClear", SCRIPT_PARAM_SLICE, 50, 0, 100, 0)
	
	Menu:addSubMenu("[HeRo Jarvan - JungleClear]", "JClear")
		Menu.JClear:addParam("JungleClear", "JungleClear", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
		Menu.JClear:addParam("JungleClearQ", "Use Q in JungleClear", SCRIPT_PARAM_ONOFF, true)
		Menu.JClear:addParam("JungleClearE", "Use E in JungleClear", SCRIPT_PARAM_ONOFF, true)
		Menu.JClear:addParam("JungleClearW", "Use W in JungleClear", SCRIPT_PARAM_ONOFF, true)
		Menu.JClear:addParam("JClearMana", "% Mana for JungleClear", SCRIPT_PARAM_SLICE, 75, 0, 100, 0)
	
	Menu:addSubMenu("[HeRo Jarvan - Escape]", "Escape")
		Menu.Escape:addParam("EnableEscape", "Escape", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("S"))
		Menu.Escape:addParam("WEscape", "Use W for slow Enemy", SCRIPT_PARAM_ONOFF, true)
	
	Menu:addSubMenu("[HeRo Jarvan - Ult Blacklist]", "ultb")
		for i, enemy in pairs(GetEnemyHeroes()) do
			Menu.ultb:addParam(enemy.charName, "Use ult on: "..enemy.charName, SCRIPT_PARAM_ONOFF, true)
		end

	Menu:addSubMenu("[HeRo Jarvan - Item Usage]", "Item")
		Menu.Item:addParam("UseItem", "Enable Item Usage", SCRIPT_PARAM_ONOFF, true)
		Menu.Item:addSubMenu("[Offensive Items]", "AttackItem")
		Menu.Item.AttackItem:addParam("UseTiamat", "Use Tiamat/Hydra", SCRIPT_PARAM_ONOFF, true)
		Menu.Item.AttackItem:addParam("UseTitanic", "Use Titanic Hydra", SCRIPT_PARAM_ONOFF, true)
		Menu.Item.AttackItem:addParam("UseCutlass", "Use Bilgewater Cutlass", SCRIPT_PARAM_ONOFF, true)
		Menu.Item.AttackItem:addParam("UseBOTRK", "Use BOTRK", SCRIPT_PARAM_ONOFF, true)
		Menu.Item.AttackItem:addParam("UseYoumu", "Use Youmus Blade", SCRIPT_PARAM_ONOFF, true)
		Menu.Item.AttackItem:addParam("UseGunblade", "Use Hextech Gunblade", SCRIPT_PARAM_ONOFF, true)

	Menu.Item:addSubMenu("[HeRo Jarvan - Anti CC]", "DefItem")
		Menu.Item.DefItem:addParam("EnableACC", "Enable AntiCC", SCRIPT_PARAM_ONOFF, true)
		Menu.Item.DefItem:addParam("UseQSS", "Use Quicksilver Sash", SCRIPT_PARAM_ONOFF, true)
		Menu.Item.DefItem:addParam("UseDervish", "Use Dervish Blade", SCRIPT_PARAM_ONOFF, true)

	Menu:addSubMenu("[HeRo Jarvan - Auto]", "Auto")
		Menu.Auto:addParam("autoPOT", "Auto Potions Usage", SCRIPT_PARAM_ONOFF, true)
 		Menu.Auto:addParam("autoPOTHealth", "% Health for Auto Potions", SCRIPT_PARAM_SLICE, 50, 0, 100, 0)

	Menu:addSubMenu("[HeRo Jarvan - Others]", "Others")
		Menu.Others:addSubMenu("[Change PermaShow]", "Snow")
		Menu.Others.Snow:addParam("ChangeShow", "Change PermaShow Color(Green)", SCRIPT_PARAM_ONOFF, true)
		Menu.Others.Snow:addParam("info", "Reload this(2xF9)", SCRIPT_PARAM_INFO, "")
		
		if VIP_USER and (string.find(GetGameVersion(), 'Releases/6.10') ~= nil) then
			Menu.Others:addSubMenu("[Auto level - Up]", "LVLUP")
				Menu.Others.LVLUP:addParam("Enable", "Enable LVL-UP", SCRIPT_PARAM_ONOFF, false)
				Menu.Others.LVLUP:addParam("Mod", "Mode:", SCRIPT_PARAM_LIST, 1, {"Auto", "Manual"})
    			Menu.Others.LVLUP:addParam("Level13", "Level 1-3:", SCRIPT_PARAM_LIST, 1, {"Q-W-E",  "Q-E-W",  "W-Q-E",  "W-E-Q",  "E-Q-W",  "E-W-Q"})
   				Menu.Others.LVLUP:addParam("Level418", "Level 4-18:", SCRIPT_PARAM_LIST, 1, {"Q-W-E",  "Q-E-W",  "W-Q-E",  "W-E-Q",  "E-Q-W",  "E-W-Q"})
		end

		if VIP_USER then
			Menu.Others:addSubMenu("[SkinChanger]", "skin")
		end

			Menu.Others:addSubMenu("[Smite Usage]", "Smite")
				Menu.Others.Smite:addParam("UseSmite", "Enable Smite Usage", SCRIPT_PARAM_ONKEYTOGGLE, true, string.byte("N"))
				Menu.Others.Smite:addParam("UseSmiteCombo", "Use Smite in Combo", SCRIPT_PARAM_ONKEYTOGGLE, true, string.byte("M"))
				Menu.Others.Smite:addParam("StealSmite", "Use Smite on KillSteal", SCRIPT_PARAM_ONKEYTOGGLE, true, string.byte("K"))
				Menu.Others.Smite:addParam('Info123', '-----------------------------------------------------', SCRIPT_PARAM_INFO, "-------------")
				Menu.Others.Smite:addParam("info1234", "[Smite List]", SCRIPT_PARAM_INFO, "")
				Menu.Others.Smite:addParam('Info12345', '-----------------------------------------------------', SCRIPT_PARAM_INFO, "-------------")

				if GetGame().map.shortName == "twistedTreeline" then
				   Menu.Others.Smite:addParam("Wraith", "Use Smite on: Wraith", SCRIPT_PARAM_ONOFF, true)
				   Menu.Others.Smite:addParam("Golem", "Use Smite on: Golem", SCRIPT_PARAM_ONOFF, true)
				   Menu.Others.Smite:addParam("Wolf", "Use Smite on: Wolf", SCRIPT_PARAM_ONOFF, true)
				   Menu.Others.Smite:addParam("Spiderboss", "Use Smite on: SpiderBoss", SCRIPT_PARAM_ONOFF, true)
				else
				   Menu.Others.Smite:addParam("Dragon", "Use Smite on: Dragon", SCRIPT_PARAM_ONOFF, true)
				   Menu.Others.Smite:addParam("Baron", "Use Smite on: Baron", SCRIPT_PARAM_ONOFF, true)
				   Menu.Others.Smite:addParam("Razorbeak", "Use Smite on: Wraith", SCRIPT_PARAM_ONOFF, false)
				   Menu.Others.Smite:addParam("Murkwolf", "Use Smite on: Wolf", SCRIPT_PARAM_ONOFF, false)
				   Menu.Others.Smite:addParam("Krug", "Use Smite on: Krug", SCRIPT_PARAM_ONOFF, false)
				   Menu.Others.Smite:addParam("Gromp", "Use Smite on: Gromp", SCRIPT_PARAM_ONOFF, false)
				   Menu.Others.Smite:addParam("Red", "Use Smite on: Red Buff", SCRIPT_PARAM_ONOFF, true)
				   Menu.Others.Smite:addParam("Blue", "Use Smite on: Blue Buff", SCRIPT_PARAM_ONOFF, true)
				end
	
	Menu:addSubMenu("[HeRo Jarvan - Draw Settings]", "Drawings")
		Menu.Drawings:addParam("AllDraw", "Enable or Disable all Draws", SCRIPT_PARAM_ONOFF, true)
		Menu.Drawings:addParam("FPS", 'Use FPS Draw Circle(Fix Soon)', SCRIPT_PARAM_ONOFF, false)

		Menu.Drawings:addParam('Info1', '-----------------------------------------------------', SCRIPT_PARAM_INFO, "-------------")
		Menu.Drawings:addParam("Infokek1", "[Spell Draw]", SCRIPT_PARAM_INFO, "")
		Menu.Drawings:addParam('Info1', '-----------------------------------------------------', SCRIPT_PARAM_INFO, "-------------")

		Menu.Drawings:addParam("DrawAA", "Draw AA Range", SCRIPT_PARAM_ONOFF, true)
		Menu.Drawings:addParam("DrawQ", "Draw Q Range", SCRIPT_PARAM_ONOFF, true)	
		Menu.Drawings:addParam("DrawW", "Draw W Range", SCRIPT_PARAM_ONOFF, true)
		Menu.Drawings:addParam("DrawE", "Draw E Range", SCRIPT_PARAM_ONOFF, true)
		Menu.Drawings:addParam("DrawR", "Draw R Range", SCRIPT_PARAM_ONOFF, true)
		
		Menu.Drawings:addParam('Info1', '-----------------------------------------------------', SCRIPT_PARAM_INFO, "-------------")
		Menu.Drawings:addParam("Infokek3", "[Smite Draw]", SCRIPT_PARAM_INFO, "")
		Menu.Drawings:addParam('Info1', '-----------------------------------------------------', SCRIPT_PARAM_INFO, "-------------")

		Menu.Drawings:addParam("DrawSmite", "Draw Smite Range", SCRIPT_PARAM_ONOFF, true)
		Menu.Drawings:addParam("DrawSmiteable", "Draw Smite Process", SCRIPT_PARAM_ONOFF, true)
		Menu.Drawings:addParam("DrawSmiteTargetable", "Draw Smite Target", SCRIPT_PARAM_ONOFF, true)

		Menu.Drawings:addParam('Info1', '-----------------------------------------------------', SCRIPT_PARAM_INFO, "-------------")
		Menu.Drawings:addParam("Infokek2", "[Other Draw]", SCRIPT_PARAM_INFO, "")
		Menu.Drawings:addParam('Info1', '-----------------------------------------------------', SCRIPT_PARAM_INFO, "-------------")

		Menu.Drawings:addParam("drawHP", "Draw HP Bar Damage", SCRIPT_PARAM_ONOFF, true)
		Menu.Drawings:addParam("DrawComboModex", "Draw Current Combo Mode", SCRIPT_PARAM_ONOFF, true)
		Menu.Drawings:addParam("DrawHarassModex", "Draw Current Harass Mode", SCRIPT_PARAM_ONOFF, true)

		Menu:addParam("info1", "", SCRIPT_PARAM_INFO, "")
  		Menu:addParam("info2", ""..SCRIPT_NAME.." [Version - "..version.."]", SCRIPT_PARAM_INFO, "")
  		Menu:addParam("info4", "Package: [Game Version - "..SCRIPT_PATCH.."]", SCRIPT_PARAM_INFO, "")
  		Menu:addParam("info3", "Author - "..SCRIPT_AUTHOR.."", SCRIPT_PARAM_INFO, "")


	Menu:addSubMenu("[HeRo Jarvan - Prediction]", "Prediction")
  		Menu.Prediction:addParam("activePred", "Prediction (require reload)", SCRIPT_PARAM_LIST, 1, {"VPred", "DPred", "FHPred", "SPred"})
  		if Menu.Prediction.activePred == 1 then
    		if FileExist(LIB_PATH .. "VPrediction.lua") then
      			require "VPrediction"
      			VP = VPrediction()
      			Menu.Prediction:addParam("QVPHC", "Q HitChance", SCRIPT_PARAM_SLICE, 2, 1, 5, 0)
      			Menu.Prediction:addParam("EVPHC", "E HitChance", SCRIPT_PARAM_SLICE, 2, 1, 5, 0)
      			DelayAction(function() PrintChat("<font color='#FF0000'><b>[HeRo Jarvan]: </b></font><font color='#F0F8FF'><b>VPrediction Found!</b></font>") end, 4.1)
    		end
  		elseif Menu.Prediction.activePred == 2 then
    		if VIP_USER and FileExist(LIB_PATH.."DivinePred.lua") and FileExist(LIB_PATH.."DivinePred.luac") then
      			require "DivinePred"
      			DP = DivinePred()
      			Menu.Prediction:addParam("QHC", "Q HitChance %", SCRIPT_PARAM_SLICE, 75, 50, 100, 0)
      			Menu.Prediction:addParam("EHC", "E HitChance %", SCRIPT_PARAM_SLICE, 75, 50, 100, 0)
      			DelayAction(function() PrintChat("<font color='#FF0000'><b>[HeRo Jarvan]: </b></font><font color='#F0F8FF'><b>Divine Prediction Found!</b></font>") end, 4.1)
    		end
  		elseif Menu.Prediction.activePred == 3 then
    		if FHPrediction.GetVersion() ~= nil then
      			if FHPrediction.GetVersion() >= 0.24 then
        			FHPred = true
        			DelayAction(function() PrintChat("<font color='#FF0000'><b>[HeRo Jarvan]: </b></font><font color='#F0F8FF'><b>FHPrediction Found!</b></font>") end, 4.1)
        			Menu.Prediction:addParam("infoFH", "FHPrediction found!", SCRIPT_PARAM_INFO, "")
      			end
    		else
      			DelayAction(function()PrintChat("<font color='#FF0000'><b>[HeRo Jarvan]: </b></font><font color='#F0F8FF'><b>FHPrediction don't Loaded!</b></font>") end, 4.1)
    		end
  		elseif Menu.Prediction.activePred == 4 then
    		if FileExist(LIB_PATH.."SPrediction.lua") then
      			require "SPrediction"
      			SP = SPrediction()
      			Menu.Prediction:addParam("QSPHC", "Q HitChance", SCRIPT_PARAM_SLICE, 1.5, 0, 3, 0)
      			Menu.Prediction:addParam("ESPHC", "E HitChance", SCRIPT_PARAM_SLICE, 1.5, 0, 3, 0)
      			DelayAction(function() PrintChat("<font color='#FF0000'><b>[HeRo Jarvan]: </b></font><font color='#F0F8FF'><b>SPrediction Found!</b></font>") end, 4.1)	
    		end
  		end


	if Menu.Others.Snow.ChangeShow then
		IDPerma = Menu.Combo:permaShow("ComboMode")
		Menu.permaShowEdit(IDPerma, "lText", "[Combo]")
		Menu.permaShowEdit(IDPerma, "lTextColor", 0xFF00FF00)

		IDPerma = Menu.Combo:permaShow("Cmode")
		Menu.permaShowEdit(IDPerma, "lText", "[Combo Mode]")
		Menu.permaShowEdit(IDPerma, "lTextColor", 0xFF00FF00)

	  	--IDPerma = Menu.Combo:permaShow("Burst")
	  	--Menu.permaShowEdit(IDPerma, "lText", "[Burst Mode]")
	  	--Menu.permaShowEdit(IDPerma, "lTextColor", 0xFF00FF00)

		IDPerma = Menu.Harass:permaShow("HS")
		Menu.permaShowEdit(IDPerma, "lText", "[Harass]")
		Menu.permaShowEdit(IDPerma, "lTextColor", 0xFF00FF00)

		IDPerma = Menu.Harass:permaShow("Hmode")
		Menu.permaShowEdit(IDPerma, "lText", "[Harass Mode]")
		Menu.permaShowEdit(IDPerma, "lTextColor", 0xFF00FF00)
		
		IDPerma = Menu.Clear:permaShow("LaneClear")
		Menu.permaShowEdit(IDPerma, "lText", "[Lane Clear]")
		Menu.permaShowEdit(IDPerma, "lTextColor", 0xFF00FF00)
		
		IDPerma = Menu.JClear:permaShow("JungleClear")
		Menu.permaShowEdit(IDPerma, "lText", "[Jungle Clear]")
		Menu.permaShowEdit(IDPerma, "lTextColor", 0xFF00FF00)

		IDPerma = Menu.Escape:permaShow("EnableEscape")
		Menu.permaShowEdit(IDPerma, "lText", "[Escape]")
		Menu.permaShowEdit(IDPerma, "lTextColor", 0xFF00FF00)
		
		IDPerma = Menu.Prediction:permaShow("activePred")
		Menu.permaShowEdit(IDPerma, "lTextColor", 0xFF00FF00)	
	else
		Menu.Combo:permaShow("ComboMode")

		Menu.Combo:permaShow("Cmode")
		
		--Menu.Combo:permaShow("Burst")
		
		Menu.Harass:permaShow("HS")

		Menu.Harass:permaShow("Hmode")
		
		Menu.Clear:permaShow("LaneClear")
		
		Menu.JClear:permaShow("JungleClear")
		
		Menu.Escape:permaShow("EnableEscape")
		
		Menu.Prediction:permaShow("activePred")
	end
	if VIP_USER then 
		SkinLoad() 
	end
end

function OnTick()
	ts:update()
	if myHero.dead then return end
	spell_check()
	GetSmiteSlot()

	if MYFOCUS ~= nil then
    	if MYFOCUS.dead or not MYFOCUS.visible then
      		MYFOCUS = nil
    	end
  	end

	if Menu.Combo.ChangeCombo then
		Menu.Combo.ChangeCombo = false
		Menu.Combo.Cmode = Menu.Combo.Cmode >= 5 and 1 or (Menu.Combo.Cmode + 1)
		print("<font color='#FF0000'><b>[HeRo Jarvan]: </b></font><font color='#F0F8FF'><b>New Combo mode: </b></font> "..PrintComboMode(msgg))
	end

	if Menu.Harass.ChangeHarass then
		Menu.Harass.ChangeHarass = false
		Menu.Harass.Hmode = Menu.Harass.Hmode >= 4 and 1 or (Menu.Harass.Hmode + 1)
		print("<font color='#FF0000'><b>[HeRo Jarvan]: </b></font><font color='#F0F8FF'><b>New Harass mode: </b></font> "..PrintHarassMode(msgg))
	end

	if VIP_USER and (string.find(GetGameVersion(), 'Releases/6.10') ~= nil) and Menu.Others.LVLUP.Enable then
		print("<font color='#FF0000'><b>[HeRo - Info]: </b></font><font color='#F0F8FF'><b>I'm fix Lvl-Up function soon, sry.</b></font>")
		Menu.Others.LVLUP.Enable = false
		--if (LastLevel < myHero.level) then
			--LevelUp()
		--end
	end

    if SMITE then
	    if Menu.Others.Smite.UseSmite then
	      	AutoSmite()
	    end
	end
	
	if Menu.Combo.ComboMode then
		JarvanCombo()
		CastItemsF()
	end
	
	if Menu.KillSteal.Steal then
		KSteal()
	end

	if Menu.Harass.HS then
		if ((myHero.mana*100)/myHero.maxMana) <= Menu.Harass.HarassMana then return end
		Harass()
		CastItemsF()
	end

	if Menu.Clear.LaneClear then
		if ((myHero.mana*100)/myHero.maxMana) <= Menu.Clear.ClearMana then return end
		LCLR()
		CastItemsC()
	end

	if Menu.JClear.JungleClear then
		if ((myHero.mana*100)/myHero.maxMana) <= Menu.JClear.JClearMana then return end
		JCLR()
		CastItemsCJ()
	end
	
	if UltActive then
		if CountEnemyHeroInRange(650) == 0 then
			CastSpell(_R)
		end
	end
	
	if Menu.Escape.EnableEscape then
		EQEscape()
	end

  	if Menu.Auto.AutoPOT then
    	CheckFountain()
  	end

  	if (Menu.Auto.AutoPOT and not REGENTIME) and not FONTAN then
    	AutoPotion()
  	end

  	if Menu.Item.UseItem then
    	FindItems()
  	end

  	if UNDERCC and Menu.Item.UseItem and Menu.Item.DefItem.EnableACC then
    	if Menu.Item.DefItem.UseQSS and QSS then
      		CastQSS()
    	end
   		if Menu.Item.DefItem.UseDervish and DERVISH then
     		CastDervish()
    	end
  	end
end

function CastItemsC()
	for _, minions in pairs(minionManager(MINION_ENEMY, 1000, myHero, MINION_SORT_HEALTH_ASC).objects) do
		if minions ~= nil and minions.visible then
			if TITANIC and Menu.Item.AttackItem.UseTitanic then CastTITANIC() end
    		if TIAMAT and Menu.Item.AttackItem.UseTiamat and GetDistance(minions) <= 400 then CastTiamat() end
		end
	end
end

function CastItemsCJ()
	for _, jminions in pairs(minionManager(MINION_JUNGLE, 1000, myHero, MINION_SORT_HEALTH_ASC).objects) do
		if jminions ~= nil and jminions.visible then
			if TITANIC and Menu.Item.AttackItem.UseTitanic then CastTITANIC() end
    		if TIAMAT and Menu.Item.AttackItem.UseTiamat and GetDistance(jminions) <= 400 then CastTiamat() end
		end
	end
end

function CastItemsF()
	if ts.target ~= nil and ts.target.visible then
		if TITANIC and Menu.Item.AttackItem.UseTitanic then CastTITANIC() end
    	if TIAMAT and Menu.Item.AttackItem.UseTiamat and GetDistance(ts.target) <= 400 then CastTiamat() end
    	if YOUMU and Menu.Item.AttackItem.UseYoumu and GetDistance(ts.target) < 800 then CastYoumu() end
    	if BOTRK and Menu.Item.AttackItem.UseBOTRK and GetDistance(ts.target) <= 550 then CastBOTRK(ts.target) end
	end
end

function JarvanCombo()
	local target = GetMyTarget(1000)
    if target ~= nil then
    	if Menu.Combo.Cmode == 1 then
			if Qready and Eready then
				CastE(target)
				DelayAction(function() CastQ(target) end, 0.3)
			elseif Qready and not Eready then
				CastQ(target)
			elseif Eready and not Qready then
				CastE(target)
			end
		elseif Menu.Combo.Cmode == 2 and (Qready and Eready and Menu.Combo.ComboQ and Menu.Combo.ComboE) then
			CastE(target)
			DelayAction(function() CastQ(target) end, 0.3)
		elseif Menu.Combo.Cmode == 3 then
			if Eready and Menu.Combo.ComboE then CastE(target) end
			if Qready and Menu.Combo.ComboQ then CastQ(target) end
		elseif Menu.Combo.Cmode == 4 and (Qready and Menu.Combo.ComboQ) then
			CastQ(target)
		elseif Menu.Combo.Cmode == 5 and (not Qready and Menu.Combo.ComboE) then
			CastE(target)
		end
		if Menu.Combo.ComboR then
			DelayAction(function() UseR() end, 0.7)
		end
		if Menu.Combo.ComboW then
			UseW()
		end
		if SMITE and ATTACKSMITE3 and Menu.Others.Smite.UseSmiteCombo and GetDlina(myHero, target) <= 560 then
	    	CastSmite(target)
		end
end
end

function KSteal()
	if Menu.KillSteal.QSteal then
		QSteal()
	end

	if Menu.KillSteal.ESteal then
		ESteal()
	end

	if Menu.KillSteal.RSteal then
		RSteal()
	end
	
	for i,enemy in pairs(GetEnemyHeroes()) do
    	if not enemy.dead and enemy.visible then
      		if ValidTarget(enemy, 1000) then
				if igniteslot ~= nil and Menu.KillSteal.UseIgnite and GetDlina(myHero, enemy) <= 600 then
					local igniteDmg = 50 + 20*myHero.level
					if igniteDmg >= enemy.health and SpellReady(igniteslot) and not enemy.dead then
						CastSpell(igniteslot, enemy)
					end
				end
			end
		end
		if GetDlina(myHero, enemy) <= 560 then
      		if SMITE and ATTACKSMITE and Menu.Others.Smite.StealSmite then
	        	local SmiteDmg = GetAttackSmiteDamage()
	        	if SmiteDmg >= enemy.health and SpellReady(SMITESLOT) and not enemy.dead then
          			CastSmite(enemy)
        		end
      		end
    	end
	end
end

function QSteal()
 	for i,enemy in pairs(GetEnemyHeroes()) do
  		if not enemy.dead and enemy.visible then
			if not Qready then return end
			if ValidTarget(enemy, 770) then
				if enemy.health < GetQDamage(enemy) then
					CastQ(enemy)
				end
			end
		end
	end
end

function ESteal()
  	for i,enemy in pairs(GetEnemyHeroes()) do
  		if not enemy.dead and enemy.visible then
			if not Eready then return end
			if ValidTarget(enemy, 830) then
				if enemy.health < GetEDamage(enemy) then
					CastE(enemy)
				end
			end
		end
	end
end

function RSteal() 
	for i,enemy in pairs(GetEnemyHeroes()) do
    	if not enemy.dead and enemy.visible then
		if not Rready then return end
			if ValidTarget(enemy, 650) then
				if enemy.health < GetRDamage(enemy) then
					CastSpell(_R, enemy)
				end
			end
		end
	end
end

function Harass()
	local target = GetMyTarget(1000)
    if target ~= nil then
		if Menu.Harass.Hmode == 1 and Qready and Eready then
			if ValidTarget(target, 1000) then
				CastE(target)
				DelayAction(function() CastQ(target) end, 0.3)
			end
		elseif Menu.Harass.Hmode == 2 and Menu.Harass.HarassE then
			if ValidTarget(target, 1000) then
				CastE(target)
				if Menu.Harass.HarassQ then
					if ValidTarget(target, 1000) then
						CastQ(target)
					end
				end
			end
		elseif Menu.Harass.Hmode == 3 and Qready and Menu.Harass.HarassQ then
			if ValidTarget(target, 1000) then
				CastQ(target)
			end
		elseif Menu.Harass.Hmode == 4 and Eready and Menu.Harass.HarassE then
			if ValidTarget(target, 1000) then
				CastE(target)
			end
		end
	end
end


function LCLR()
	for _, minions in pairs(minionManager(MINION_ENEMY, 1000, myHero, MINION_SORT_HEALTH_ASC).objects) do
		if Qready and Menu.Clear.LaneClearQ then
			if ValidTarget(minions, 770) then
				CastQ(minions)
			end
		end
		if Eready and Menu.Clear.LaneClearE then
				CastE(minions)
    		end
			if Wready and Menu.Clear.LaneClearW then
				if GetDistance(minions) <= 525 then
					CastSpell(_W)
    			end
  			end
		end
end

function JCLR()
	for _, jminion in pairs(minionManager(MINION_JUNGLE, 1000, myHero, MINION_SORT_HEALTH_ASC).objects) do
    	if ValidTarget(jminion, VARS.Q.RANGE) then
			if Qready and Menu.JClear.JungleClearQ then
				CastQ(jminion)
			end
			if Eready and Menu.JClear.JungleClearE then
				CastE(jminion)
    		end
			if Wready and Menu.JClear.JungleClearW then
				if GetDistance(jminion) <= 525 then
					CastSpell(_W)
    			end
  			end
		end
	end
end

function OnDraw()
	if myHero.dead then return end
	if Menu.Drawings.AllDraw then
		
			if Menu.Drawings.drawHP then
	      		DrawHPbar()
	    	end

			if Menu.Drawings.DrawQ and Qready then
				DrawCircle(myHero.x, myHero.y, myHero.z, VARS.Q.RANGE, ARGB(255, 0, 0, 80))
			end	

			if Menu.Drawings.DrawW and Wready then
				DrawCircle(myHero.x, myHero.y, myHero.z, VARS.W.RANGE, ARGB(255, 0, 0, 80))
			end

			if Menu.Drawings.DrawE and Eready then
				DrawCircle(myHero.x, myHero.y, myHero.z, VARS.E.RANGE, ARGB(255, 0, 0, 80))
			end

			if Menu.Drawings.DrawAA then
				DrawCircle(myHero.x, myHero.y, myHero.z, VARS.AA.RANGE, ARGB(255, 0, 0, 80))
			end
		
			if Menu.Drawings.DrawR and Rready then
				DrawCircle(myHero.x, myHero.y, myHero.z, VARS.R.RANGE, ARGB(255, 0, 0, 80))
			end
			if SMITE or ATTACKSMITE or ATTACKSMITE3 then
		      	if Menu.Drawings.DrawSmite then
		        	DrawCircle(myHero.x, myHero.y, myHero.z, 560, ARGB(255, 100, 100, 80))
		      	end
	      	end

	      	if Menu.Drawings.DrawComboModex then
	        	DrawComboMode()
			end

			if Menu.Drawings.DrawHarassModex then
	        	DrawHarassMode()
			end

			if Menu.Combo.UseFocus then
				if not Menu.Combo.UseFocus then return end
	  			local target = MYFOCUS
	  			if target == nil then return end
	  			if (target ~= nil and target.type == myHero.type and target.team ~= myHero.team) then
	    			DrawCircle(target.x, target.y, target.z, 120, ARGB(255, 100, 100, 80))
	    			local posMinion = WorldToScreen(D3DXVECTOR3(target.x, target.y, target.z))
	    			DrawText("Target", 20, posMinion.x, posMinion.y, ARGB(255, 100, 100, 255))
	  			end
			end

		      	if Menu.Drawings.DrawSmiteable then
		        	DrawSmiteable()
		        end

		        if Menu.Drawings.DrawSmiteTargetable then
		        	DrawSmiteTarget()
		        end
	end
end

function spell_check()
	Qready = (myHero:CanUseSpell(_Q) == READY)
	Wready = (myHero:CanUseSpell(_W) == READY)
	Eready = (myHero:CanUseSpell(_E) == READY)
	Rready = (myHero:CanUseSpell(_R) == READY)
end


function blCheck(target)
	if ts.target ~= nil and Menu.ultb[target.charName] then
		return true
	else
		return false
	end
end

function OnCreateObj(obj)
	if obj == nil then return end
	if obj.name:find("jarvancataclysm_sound") then
		ultActive = true
		DelayAction(function() ultActive = false end, 3.5)
	end
end

function OnDeleteteObj(obj)
	if obj == nil then return end
	if obj.name:find("jarvancataclysm_sound") then
		ultActive = false
	end
end

function EQEscape()
  	myHero:MoveTo(mousePos.x, mousePos.z)
	if Eready and Qready then
		MousePos = Vector(mousePos.x, mousePos.y, mousePos.z)
		CastSpell(_E, mousePos.x, mousePos.z)
		DelayAction(function() CastSpell(_Q, mousePos.x, mousePos.z) end, 0.35)
		myHero:MoveTo(mousePos.x, mousePos.z)
	end
end

function CastQ(unit)
  	if unit == nil and Qready then return end
  	if VP ~= nil then
    	local CastPosition, HitChance = VP:GetLineCastPosition(unit, 0.5, VARS.Q.WIDTH, VARS.Q.RANGE, VARS.Q.SPEED, myHero, false)
    	if HitChance >= Menu.Prediction.QVPHC then
      		CastSpell(_Q, CastPosition.x, CastPosition.z)
    	end
  	end
  	if DP ~= nil then
    	local state,hitPos,perc = DP:predict(nil,unit,myHero,SkillShot.TYPE.LINE,VARS.Q.SPEED,VARS.Q.RANGE,VARS.Q.WIDTH,0.5*1000,0,{Minions = false,Champions = false})
    	if perc >= Menu.Prediction.QHC then
      		CastSpell(_Q, hitPos.x, hitPos.z)
    	end
  	end
  	if FHPred and Menu.Prediction.activePred == 3 then
    	local CastPosition, hc, info = FHPrediction.GetPrediction("Q", unit)
    	if hc > 0 and CastPosition ~= nil then
      		CastSpell(_Q, CastPosition.x, CastPosition.z)
    	end
  	end
  	if SP ~= nil then
    	local CastPosition, Chance, PredPos = SP:Predict(unit, VARS.Q.RANGE, VARS.Q.SPEED, VARS.Q.DELAY, VARS.Q.WIDTH, false, myHero)
    	if Chance >= Menu.Prediction.QSPHC then
      		CastSpell(_Q, CastPosition.x, CastPosition.z)
    	end
  	end
end

function CastE(unit)
  	if unit == nil and Eready then return end
  	if VP ~= nil then
    	local CastPosition, HitChance = VP:GetLineCastPosition(unit, 0.5, VARS.E.WIDTH, 830, VARS.E.SPEED, myHero, false)
    	if HitChance >= Menu.Prediction.EVPHC then
      		CastSpell(_E, CastPosition.x, CastPosition.z)
    	end
  	end
  	if DP ~= nil then
    	local state,hitPos,perc = DP:predict(nil,unit,myHero,SkillShot.TYPE.CIRCLE,VARS.E.SPEED,VARS.E.RANGE,VARS.E.WIDTH,0.5*1000,0,{Minions = false,Champions = false})
    	if perc >= Menu.Prediction.EHC then
      		CastSpell(_E, hitPos.x, hitPos.z)
    	end
  	end
  	if FHPred and Menu.Prediction.activePred == 3 then
    	local CastPosition, hc, info = FHPrediction.GetPrediction("E", unit)
    	if hc > 0 and CastPosition ~= nil then
      		CastSpell(_E, CastPosition.x, CastPosition.z)
    	end
  	end
  	if SP ~= nil then
    	local CastPosition, Chance, PredPos = SP:Predict(unit, VARS.Q.RANGE, VARS.Q.SPEED, VARS.Q.DELAY, VARS.Q.WIDTH, false, myHero)
    	if Chance >= Menu.Prediction.ESPHC then
      		CastSpell(_E, CastPosition.x, CastPosition.z)
    	end
  	end
end

function CastW(unit)
	if unit == nil and Wready then return end
 	if ValidTarget(ts.target, 525) or GetDlina(myHero, ts.target) <= 525 then
    	CastSpell(_W)
  	end
end

function CastR(unit)
  	if unit == nil then return end
    if ValidTarget(unit, 650) then
      	CastSpell(_R, unit)
    end
end

--------------------------------------Need This too-

function UseW()
	if Wready and Menu.Combo.ComboW then
		local target = GetMyTarget(700) 
		if target ~= nil then
			if ValidTarget(target, 525) or CountEnemyHeroInRange(525) >= 1 then
				CastSpell(_W)
			end
		end
	end
end
	
function UseR()
	if Rready and Menu.Combo.ComboR and blCheck(ts.target) then
		local target = GetMyTarget(700) 
		if target ~= nil then
			CastR(target)
		end
	end
end

--------------------------------------Need This too-

function GetDlina(a, b)
  	local Dlina = math.sqrt((b.x-a.x)*(b.x-a.x) + (b.z-a.z)*(b.z-a.z))
  	return Dlina
end

function SpellReady(spell)
  	return myHero:CanUseSpell(spell) == READY
end

function FindItems()
  	if (Menu.Item.AttackItem.UseTiamat) then
    	GetTiamat()
  	end

  	if (Menu.Item.AttackItem.UseTitanic) then
    	GetTitanic()
  	end

  	if (Menu.Item.AttackItem.UseBOTRK) then
    	GetBOTRK()
  	end

  	if (Menu.Item.AttackItem.UseCutlass) then
    	GetCutlass()
  	end

  	if (Menu.Item.AttackItem.UseYoumu) then
    	GetYoumu()
  	end

  	if (Menu.Item.AttackItem.UseGunblade) then
    	GetGunblade()
  	end

  	if (Menu.Item.DefItem.UseQSS) then
    	GetQSS()
  	end

  	if (Menu.Item.DefItem.UseDervish) then
    	GetDervish()
 	end
end

function GetTiamat()
  	local slot = GetItem(ATTACKITEMS[1])
  	if (slot ~= nil) then
    	TIAMAT = true
    	TIAMATSLOT = slot
  	else
    	TIAMAT = false
  	end
end

function GetTitanic()
  	local slot = GetItem(ATTACKITEMS[2])
  	if (slot ~= nil) then
    	TITANIC = true
    	TITANICSLOT = slot
  	else
    	TITANIC = false
  	end
end

function GetCutlass()
  	local slot = GetItem(ATTACKITEMS[3])
  	if (slot ~= nil) then
    	CUTLASS = true
    	CUTLASSSLOT = slot
  	else
    	CUTLASS = false
  	end
end

function GetYoumu()
  	local slot = GetItem(ATTACKITEMS[4])
  	if (slot ~= nil) then
    	YOUMU = true
    	YOUMUSLOT = slot
  	else
    	YOUMU = false
  	end
end

function GetGunblade()
  	local slot = GetItem(ATTACKITEMS[5])
  	if (slot ~= nil) then
    	GUNBLADE = true
    	GUNBLADESLOT = slot
  	else
    	GUNBLADE = false
  	end
end

function GetBOTRK()
  	local slot = GetItem(ATTACKITEMS[6])
  	if (slot ~= nil) then
    	BOTRK = true
    	BOTRKSLOT = slot
  	else
    	BOTRK = false
  	end
end

function GetQSS()
  	local slot = GetItem(ANTICCITEMS[1])
  	if (slot ~= nil) then
    	QSS = true
    	QSSSLOT = slot
  	else
    	QSS = false
  	end
end

function GetDervish()
  	local slot = GetItem(ANTICCITEMS[2])
  	if (slot ~= nil) then
   		DERVISH = true
    	DERVISHSLOT = slot
 	else
    	DERVISH = false
  	end
end

function CastTiamat()
  	if TIAMAT then
    	if (SpellReady(TIAMATSLOT)) then
     		CastSpell(TIAMATSLOT)
    	end
  	end
end

function CastSmite(target)
  	if SpellReady(SMITESLOT) then
    	CastSpell(SMITESLOT, target)
  	end
end

function CastYoumu()
  	if YOUMU then
    	if (SpellReady(YOUMUSLOT)) then
      		CastSpell(YOUMUSLOT)
    	end
  	end
end

function CastBOTRK(target)
  	if BOTRK then
    	if (SpellReady(BOTRKSLOT)) then
      		CastSpell(BOTRKSLOT, target)
    	end
  	end
end

function CastTITANIC()
  	if TITANIC then
    	if (SpellReady(TITANICSLOT)) then
      		CastSpell(TITANICSLOT)
    	end
  	end
end

function CastCutlass(target)
  	if CUTLASS then
    	if (SpellReady(CUTLASSSLOT)) then
      		CastSpell(CUTLASSSLOT, target)
    	end
  	end
end

function CastGunblade(target)
  	if GUNBLADE then
    	if (SpellReady(GUNBLADESLOT)) then
      		CastSpell(GUNBLADESLOT, target)
    	end
  	end
end

function CastQSS()
  	if QSS then
    	if SpellReady(QSSSLOT) then
      		CastSpell(QSSSLOT)
    	end
  	end
end

function CastDervish()
  	if DERVISH then
    	if SpellReady(DERVISHSLOT) then
      	CastSpell(DERVISHSLOT)
    	end
  	end
end

function Buff_Add(unit, target, buff)
  	for j = 1, #DANGERSPELL do
    	if target then
      		if target.isMe and buff.name == DANGERSPELL[j] then
        		UNDERCC = true
      		end
    	end
  	end
  	for i=1, 5 do
    	if (buff.name == POT[i] and unit.isMe) then
      		REGENTIME = true
    	end
  	end
end

function Buff_Rem(unit, buff)
  	for j = 1, #DANGERSPELL do
    	if unit.isMe and buff.name == DANGERSPELL[j] then
      		UNDERCC = false
    	end
  	end
  	for i=1, 5 do
    	if (buff.name == POT[i] and unit.isMe) then
      		REGENTIME = false
    	end
  	end
end

function AutoPotion()
  	for i=1, 5 do
    	local Hilka = GetItem(POT[i])
    	if (Hilka ~= nil) then
      		if (((myHero.health*100)/myHero.maxHealth) <= Menu.Auto.autoPOTHealth and not REGENTIME) then
        		CastSpell(Hilka)
      		end
    	end
  	end
end

function FindSlotByName(name)
  	if name ~= nil then
    	for i=0, 12 do
      		if string.lower(myHero:GetSpellData(i).name) == string.lower(name) then
        		return i
      		end
    	end
  	end  
  	return nil
end

function GetItem(name)
  	local slot = FindSlotByName(name)
  	return slot 
end

function CheckFountain()
  	if not GetGame().map.index == 15 then return end
  	if myHero.team == 100 then
    	local rastoyanieDown = math.sqrt((myHero.x-xBase.x)*(myHero.x-xBase.x) + (myHero.z-xBase.z)*(myHero.z-xBase.z))
    	if rastoyanieDown < 900 then
      		FONTAN = true
    	else
      		FONTAN = false
    	end
  	elseif myHero.team == 200 then
    	local rastoyanieUp = math.sqrt((myHero.x-zBase.x)*(myHero.x-zBase.x) + (myHero.z-zBase.z)*(myHero.z-zBase.z))
    	if rastoyanieUp < 900 then
      		FONTAN = true
    	else
      		FONTAN = false
    	end
  	end
end

function GetSmiteSlot()
  	for i=1, 3 do
    	if FindSlotByName(SMITELIST[i]) ~= nil then
      		SMITESLOT = FindSlotByName(SMITELIST[i])
      		SMITE = true
      		if i == 2 then
        		ATTACKSMITE = true
      		else
        		ATTACKSMITE = false
      		end
      		if i == 3 then
      			ATTACKSMITE3 = true
      		else
      			ATTACKSMITE3 = false
      		end
    	end
  	end
end

function GetAttackSmiteDamage(unit)
  	if SMITE and ATTACKSMITE then
  		SmiteDmg = 20 + 8*myHero.level
    	return SmiteDmg
  	end
end

function GetSmiteDamage(unit)
  	if SMITE then
    	local SmiteDamage
    	if myHero.level <= 4 then
      		SmiteDamage = 370 + (myHero.level*20)
    	end
    	if myHero.level > 4 and myHero.level <= 9 then
      		SmiteDamage = 330 + (myHero.level*30)
    	end
    	if myHero.level > 9 and myHero.level <= 14 then
      		SmiteDamage = 240 + (myHero.level*40)
    	end
    	if myHero.level > 14 then
      		SmiteDamage = 100 + (myHero.level*50)
    	end
    	return SmiteDamage
  	end
end

function AutoSmite()
   	local SmiteDmg = GetSmiteDamage()
   	for _, jminions in pairs(minionManager(MINION_JUNGLE, 1000, myHero, MINION_SORT_HEALTH_ASC).objects) do
   		if not jminions.dead and jminions.visible and ValidTarget(jminions, 560) then
      		local name = jminions.charName
      		name = name:sub(name:find("_")+1, name:len())
      		name = name:sub(1, (name:find("_") or name:len()+1)-1)
      		if Menu.Others.Smite[name] then
        		if SpellReady(SMITESLOT) and GetDlinaForSmiteDraw(myHero, jminions) <= 560 and SmiteDmg >= jminions.health then
          			CastSpell(SMITESLOT, jminions)
        		end
      		end
     	end
   	end
end

function DrawSmiteable()
	local SmiteDmg = GetSmiteDamage()
	for _, jminion in pairs(minionManager(MINION_JUNGLE, 1000, myHero, MINION_SORT_HEALTH_ASC).objects) do
    	if not jminion.dead and jminion.visible and ValidTarget(jminion, 560) then
      		local name = jminion.charName
      		name = name:sub(name:find("_")+1, name:len())
      		name = name:sub(1, (name:find("_") or name:len()+1)-1)
      		if Menu.Others.Smite[name] then
       			local posMinion = WorldToScreen(D3DXVECTOR3(jminion.x, jminion.y, jminion.z))
       			local SmiteProcess = math.round(100-100*(jminion.health-SmiteDmg)/jminion.maxHealth)
       			if SpellReady(SMITESLOT) and GetDlinaForSmiteDraw(myHero, jminion) <= 560 then
        			DrawText("Smite Process - "..SmiteProcess.."%", 20, posMinion.x - GetTextArea("Smite Process - "..SmiteProcess.."%", 20).x/2, posMinion.y, ARGB(255,255,0,0))
        			DrawCircle(jminion.x, jminion.y, jminion.z, 1.5*SmiteProcess, ARGB(255, 255*(1-SmiteProcess/100), 255*SmiteProcess/100, 255*(1-SmiteProcess/100)))
        			DrawCircle(jminion.x, jminion.y, jminion.z, 150, ARGB(55, 55, 155, 55))
        			DrawCircle(jminion.x, jminion.y, jminion.z, 75, ARGB(255, 128, 128, 128))
       			end
     		end
   		end
 	end
end

function GetDlinaForSmiteDraw(a, b)
  	local dx, dz = a.x - b.x, (a.z or a.y) - (b.z or b.y)
  	return math.sqrt(dx*dx + dz*dz)
end

local invul = {"undyingrage", "sionpassivezombie", "aatroxpassivedeath", "chronoshift", "judicatorintervention"}

function CheckFail(unit)
  	for i,buff in pairs(invul) do
    	if TargetHaveBuff(buff, unit) then
      		return true
    	end
  	end
    return false
end

function OnWndMsg(msg, key)
  	if msg == WM_LBUTTONDOWN and Menu.Combo.UseFocus and not myHero.dead then
    	for i, fokuspokus in ipairs(GetEnemyHeroes()) do
      		if GetDlina(mousePos, fokuspokus) <= 120 and Validation(fokuspokus) and not CheckFail(fokuspokus) then
       		 	if MYFOCUS ~= fokuspokus then
          			MYFOCUS = fokuspokus
          			print("<font color='#FF0000'><b>[Target Selector]: </b></font><font color='#F0F8FF'><b>New Target selected: </b></font>"..fokuspokus.charName)
        		else
          			MYFOCUS = nil
          			print("<font color='#FF0000'><b>[Target Selector]: </b></font><font color='#F0F8FF'><b>New Target unselected: </b></font>"..fokuspokus.charName)
        		end
      		end
    	end
  	end
end

function GetMyTarget(range)
  	local fokusnick = MYFOCUS
  	if fokusnick ~= nil and Menu.Combo.UseFocus then
    	if fokusnick.type == myHero.type and fokusnick.team ~= myHero.team and Validation(fokusnick, range + 100) and not CheckFail(enemy) then
      		return fokusnick
    	end
  	end
  	local MyTarget = nil
  	local lessCast = 0
  	for i = 1, #GetEnemyHeroes() do
    	local enemy = GetEnemyHeroes()[i]
    	if Validation(enemy, range) and not CheckFail(enemy) then
      		local kArmor = (100+enemy.magicArmor)/100
      		local kKillable = kArmor*enemy.health
      		if kKillable <= lessCast or lessCast == 0 then
        		MyTarget = enemy
        		lessCast = kKillable
      		end
    	end
  	end
  	return MyTarget
end

function Validation(object, range)
  	return object ~= nil and object.valid and object.visible and not object.dead and object.bInvulnerable == 0 and object.bTargetable and (range == nil or GetDlina(object, myHero) <= range)
end


function PrintComboMode(msgg)
	if Menu.Combo.Cmode == 2 then msgg = 'E + Q'
		elseif Menu.Combo.Cmode == 3 then msgg = 'Q or E'
		elseif Menu.Combo.Cmode == 4 then msgg = 'Q Only'
		elseif Menu.Combo.Cmode == 5 then msgg = 'E Only'
		elseif Menu.Combo.Cmode == 1 then msgg = 'Smart'	
	end
	return msgg
end

function PrintHarassMode(msgg)
	if Menu.Harass.Hmode == 1 then msgg = 'E + Q'
		elseif Menu.Harass.Hmode == 2 then msgg = 'Q or E'
		elseif Menu.Harass.Hmode == 3 then msgg = 'Q Only'
		elseif Menu.Harass.Hmode == 4 then msgg = 'E Only'
	end
	return msgg
end

function DrawComboMode()
	if Menu.Combo.Cmode == 1 then
		local txt = 'Smart'
		DrawText ("Combo Mode: "..txt, 20, 1125, 885, 0xFFFFF5EE)
	elseif Menu.Combo.Cmode == 2 then
		local txt = 'E + Q'
		DrawText ("Combo Mode: "..txt, 20, 1125, 885, 0xFFFFF5EE)
	elseif Menu.Combo.Cmode == 3 then
		local txt = 'Q or E'
		DrawText ("Combo Mode: "..txt, 20, 1125, 885, 0xFFFFF5EE)
	elseif Menu.Combo.Cmode == 4 then 
		local txt = 'Q Only'
		DrawText ("Combo Mode: "..txt, 20, 1125, 885, 0xFFFFF5EE)
	elseif Menu.Combo.Cmode == 5 then 
		local txt = 'E Only'
		DrawText ("Combo Mode: "..txt, 20, 1125, 885, 0xFFFFF5EE)
	end
end

function DrawHarassMode()
	if Menu.Harass.Hmode == 1 then
		local tst = 'E + Q'
		DrawText ("Harass Mode: "..tst, 20, 1125, 905, 0xFFFFF5EE)
	elseif Menu.Harass.Hmode == 2 then 
		local tst = 'Q or E'
		DrawText ("Harass Mode: "..tst, 20, 1125, 905, 0xFFFFF5EE)
	elseif Menu.Harass.Hmode == 3 then 
		local tst = 'Q Only'
		DrawText ("Harass Mode: "..tst, 20, 1125, 905, 0xFFFFF5EE)
	elseif Menu.Harass.Hmode == 4 then 
		local tst = 'E Only'
		DrawText ("Harass Mode: "..tst, 20, 1125, 905, 0xFFFFF5EE)
	end
end

-- Credits PvPSuite
function SkinLoad()
    Menu.Others.skin:addParam('changeSkin', 'Change Skin', SCRIPT_PARAM_ONOFF, false);
    Menu.Others.skin:setCallback('changeSkin', function(nV)
        if (nV) then
            SetSkin(myHero, Menu.Others.skin.skinID)
        else
            SetSkin(myHero, -1)
        end
    end)
    Menu.Others.skin:addParam('skinID', 'Skin', SCRIPT_PARAM_LIST, 1, {"Commando", "Dragonslayer", "Darkforge", "Victorious", "Warring Kingdoms", "Fnatic", "Classic"})
    Menu.Others.skin:setCallback('skinID', function(nV)
        if (Menu.Others.skin.changeSkin) then
            SetSkin(myHero, nV)
        end
    end)
    
    if (Menu.Others.skin.changeSkin) then
        SetSkin(myHero, Menu.Others.skin.skinID)
    end
end
-- Credits PvPSuite

function DrawLineA(x1, y1, x2, y2, color)
  	DrawLine(x1, y1, x2, y2, 1, color)
end

function LevelUp()
	if Menu.Others.LVLUP.Enable then
		if Menu.Others.LVLUP.Mod == 1 then
			Sequence = Sequences[myHero.charName]
		elseif myHero.level < 4 then
			Sequence = Sequences[Menu.Others.LVLUP.Level13]
		else
			Sequence = Sequences[Menu.Others.LVLUP.Level418]
		end
			
		LevelSpell(Sequence[myHero.level])
		
		if myHero.level < 18 then
			PrintChat("<font color='#00BFFF'>This Level: </font><font color='#7CFC00'>"..Skills[Sequence[myHero.level]].."</font><font color='#00BFFF'><font color='#FF0000'> ===></font> Next level: </font><font color='#7CFC00'>"..Skills[Sequence[myHero.level + 1]].. "</font><font color='#EE82EE'>. </font>")
		end		
		LastLevel = myHero.level
	end
end

if VIP_USER then
	_G.LevelSpell = function(id)
  	if (string.find(GetGameVersion(), 'Releases/6.10') ~= nil) then
		local offsets =
			{ 
				[1] = 0x71,
				[2] = 0xF1,
				[3] = 0x31,
				[4] = 0xB1
			}	
		local p = CLoLPacket(0x13)
		p.vTable = 0xF4DA68
		p:EncodeF(myHero.networkID)
		p:Encode1(0x17)
		p:Encode1(offsets[id])
		p:Encode4(0x6A6A6A6A)
		p:Encode4(0x30303030)
		p:Encode4(0x81818181)
		SendPacket(p)
		end
	end
end

function GetQDamage(unit)
  	local Qlvl = myHero:GetSpellData(_Q).level
  	if Qlvl < 1 then return 0 end
  	local QDmg = {70, 115, 160, 205, 250}
  	local QDmgMod = 1.2
  	local DmgRaw = QDmg[Qlvl] + myHero.totalDamage * QDmgMod
  	local Dmg = myHero:CalcDamage(unit, DmgRaw)
  	return Dmg
end

function GetEDamage(unit)
  	local Elvl = myHero:GetSpellData(_E).level
  	if Elvl < 1 then return 0 end
  	local EDmg = {60, 105, 150, 195, 240}
  	local EDmgMod = 0.8
  	local DmgRaw = EDmg[Elvl] + (myHero.ap * EDmgMod)
  	local Dmg = myHero:CalcDamage(unit, DmgRaw)
  	return Dmg
end

function GetRDamage(unit)
  	local Rlvl = myHero:GetSpellData(_R).level
  	if Rlvl < 1 then return 0 end
  	local RDmg = {200, 325, 450}
  	local RDmgMod = 1.5
  	local DmgRaw = RDmg[Rlvl] + (myHero.totalDamage * RDmgMod)
  	local Dmg = myHero:CalcDamage(unit, DmgRaw)
  	return Dmg
end

function DrawLineHPBar(damage, text, unit, enemyteam)
  	if unit.dead or not unit.visible then return end
  	local p = WorldToScreen(D3DXVECTOR3(unit.x, unit.y, unit.z))
  	if not OnScreen(p.x, p.y) then return end
  	local thedmg = 0
  	local line = 2
  	local linePosA  = {x = 0, y = 0 }
  	local linePosB  = {x = 0, y = 0 }
  	local TextPos   = {x = 0, y = 0 }

  	if damage >= unit.health then
    	thedmg = unit.health - 1
    	text = "Killable!"
  	else
    	thedmg = damage
    	text = "You Damage"
  	end

  	thedmg = math.round(thedmg)

  	local StartPos, EndPos = GetHPBarPos(unit)
  	local Real_X = StartPos.x + 24
  	local Offs_X = (Real_X + ((unit.health - thedmg) / unit.maxHealth) * (EndPos.x - StartPos.x - 2))
  	if Offs_X < Real_X then Offs_X = Real_X end 
  	local number1 = 350 - math.round(255*((unit.health-thedmg)/unit.maxHealth))
  	if number1 >= 255 then number1=254 end
  	local number2 = math.round(400*((unit.health-thedmg)/unit.maxHealth))
  	if number2 >= 255 then number2=254 end

  	if enemyteam then
    	linePosA.x = Offs_X-150
    	linePosA.y = (StartPos.y-(30+(line*15)))    
    	linePosB.x = Offs_X-150
    	linePosB.y = (StartPos.y-10)
    	TextPos.x = Offs_X-148
    	TextPos.y = (StartPos.y-(30+(line*15)))
  	else
    	linePosA.x = Offs_X-125
    	linePosA.y = (StartPos.y-(30+(line*15)))    
    	linePosB.x = Offs_X-125
    	linePosB.y = (StartPos.y-15)
    	TextPos.x = Offs_X-122
    	TextPos.y = (StartPos.y-(30+(line*15)))
  	end

  	DrawLine(linePosA.x, linePosA.y, linePosB.x, linePosB.y , 2, ARGB(number1, 255, number2, 0))
  	DrawText(tostring(thedmg).." "..tostring(text), 15, TextPos.x, TextPos.y , ARGB(number1, 255, number2, 0))
end

function DrawHPbar()
  	for i, HPbarEnemyChamp in pairs(GetEnemyHeroes()) do
    	if not HPbarEnemyChamp.dead and HPbarEnemyChamp.visible then
      		local dmg = myHero:CalcDamage(HPbarEnemyChamp, myHero.totalDamage)
      		if myHero:CanUseSpell(_Q) == READY and not HPbarEnemyChamp.dead then
        		dmg = dmg + GetQDamage(HPbarEnemyChamp)
      		end
	      	if myHero:CanUseSpell(_E) == READY and not HPbarEnemyChamp.dead then
	        	dmg = dmg + GetEDamage(HPbarEnemyChamp)
	      	end
	      	if myHero:CanUseSpell(_R) == READY and not HPbarEnemyChamp.dead then
	      		dmg = dmg + GetRDamage(HPbarEnemyChamp)
	      	end
	      	if igniteslot ~= nil then
	        	if SpellReady(igniteslot) then
	          		dmg = dmg + (50 + 20*myHero.level)
	        	end
	      	end
      		DrawLineHPBar(dmg, "", HPbarEnemyChamp, HPbarEnemyChamp.team)
    	end
  	end
end

function GetHPBarPos(enemy)
	enemy.barData = {PercentageOffset = {x = -0.05, y = 0}}
	local barPos = GetUnitHPBarPos(enemy)
	local barPosOffset = GetUnitHPBarOffset(enemy)
	local barOffset = { x = enemy.barData.PercentageOffset.x, y = enemy.barData.PercentageOffset.y }
	local barPosPercentageOffset = { x = enemy.barData.PercentageOffset.x, y = enemy.barData.PercentageOffset.y }
	local BarPosOffsetX = -50
	local BarPosOffsetY = 46
	local CorrectionY = 39
	local StartHpPos = 31 
	barPos.x = math.floor(barPos.x + (barPosOffset.x - 0.5 + barPosPercentageOffset.x) * BarPosOffsetX + StartHpPos)
	barPos.y = math.floor(barPos.y + (barPosOffset.y - 0.5 + barPosPercentageOffset.y) * BarPosOffsetY + CorrectionY)
	local StartPos = Vector(barPos.x , barPos.y, 0)
	local EndPos = Vector(barPos.x + 108 , barPos.y , 0)    
	return Vector(StartPos.x, StartPos.y, 0), Vector(EndPos.x, EndPos.y, 0)
end

--Credits SxTeam
class "ScriptUpdate"
function ScriptUpdate:__init(LocalVersion,UseHttps, Host, VersionPath, ScriptPath, SavePath, CallbackUpdate, CallbackNoUpdate, CallbackNewVersion,CallbackError)
    self.LocalVersion = LocalVersion
    self.Host = Host
    self.VersionPath = '/BoL/TCPUpdater/GetScript'..(UseHttps and '5' or '6')..'.php?script='..self:Base64Encode(self.Host..VersionPath)..'&rand='..math.random(99999999)
    self.ScriptPath = '/BoL/TCPUpdater/GetScript'..(UseHttps and '5' or '6')..'.php?script='..self:Base64Encode(self.Host..ScriptPath)..'&rand='..math.random(99999999)
    self.SavePath = SavePath
    self.CallbackUpdate = CallbackUpdate
    self.CallbackNoUpdate = CallbackNoUpdate
    self.CallbackNewVersion = CallbackNewVersion
    self.CallbackError = CallbackError
    AddDrawCallback(function() self:OnDraw() end)
    self:CreateSocket(self.VersionPath)
    self.DownloadStatus = 'Connect to Server for VersionInfo'
    AddTickCallback(function() self:GetOnlineVersion() end)
end

function ScriptUpdate:print(str)
    print('<font color="#FFFFFF">'..os.clock()..': '..str)
end

function ScriptUpdate:OnDraw()
    if self.DownloadStatus ~= 'Downloading Script (100%)' and self.DownloadStatus ~= 'Downloading VersionInfo (100%)'then
        DrawText('Download Status: '..(self.DownloadStatus or 'Unknown'),50,10,50,ARGB(0xFF,0xFF,0xFF,0xFF))
    end
end

function ScriptUpdate:CreateSocket(url)
    if not self.LuaSocket then
        self.LuaSocket = require("socket")
    else
        self.Socket:close()
        self.Socket = nil
        self.Size = nil
        self.RecvStarted = false
    end
    self.LuaSocket = require("socket")
    self.Socket = self.LuaSocket.tcp()
    self.Socket:settimeout(0, 'b')
    self.Socket:settimeout(99999999, 't')
    self.Socket:connect('sx-bol.eu', 80)
    self.Url = url
    self.Started = false
    self.LastPrint = ""
    self.File = ""
end

function ScriptUpdate:Base64Encode(data)
    local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x)
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

function ScriptUpdate:GetOnlineVersion()
    if self.GotScriptVersion then return end

    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
    if self.Status == 'timeout' and not self.Started then
        self.Started = true
        self.Socket:send("GET "..self.Url.." HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
    end
    if (self.Receive or (#self.Snipped > 0)) and not self.RecvStarted then
        self.RecvStarted = true
        self.DownloadStatus = 'Downloading VersionInfo (0%)'
    end

    self.File = self.File .. (self.Receive or self.Snipped)
    if self.File:find('</s'..'ize>') then
        if not self.Size then
            self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</si'..'ze>')-1))
        end
        if self.File:find('<scr'..'ipt>') then
            local _,ScriptFind = self.File:find('<scr'..'ipt>')
            local ScriptEnd = self.File:find('</scr'..'ipt>')
            if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
            local DownloadedSize = self.File:sub(ScriptFind+1,ScriptEnd or -1):len()
            self.DownloadStatus = 'Downloading VersionInfo ('..math.round(100/self.Size*DownloadedSize,2)..'%)'
        end
    end
    if self.File:find('</scr'..'ipt>') then
        self.DownloadStatus = 'Downloading VersionInfo (100%)'
        local a,b = self.File:find('\r\n\r\n')
        self.File = self.File:sub(a,-1)
        self.NewFile = ''
        for line,content in ipairs(self.File:split('\n')) do
            if content:len() > 5 then
                self.NewFile = self.NewFile .. content
            end
        end
        local HeaderEnd, ContentStart = self.File:find('<scr'..'ipt>')
        local ContentEnd, _ = self.File:find('</sc'..'ript>')
        if not ContentStart or not ContentEnd then
            if self.CallbackError and type(self.CallbackError) == 'function' then
                self.CallbackError()
            end
        else
            self.OnlineVersion = (Base64Decode(self.File:sub(ContentStart + 1,ContentEnd-1)))
            self.OnlineVersion = tonumber(self.OnlineVersion)
            if self.OnlineVersion > self.LocalVersion then
                if self.CallbackNewVersion and type(self.CallbackNewVersion) == 'function' then
                    self.CallbackNewVersion(self.OnlineVersion,self.LocalVersion)
                end
                self:CreateSocket(self.ScriptPath)
                self.DownloadStatus = 'Connect to Server for ScriptDownload'
                AddTickCallback(function() self:DownloadUpdate() end)
            else
                if self.CallbackNoUpdate and type(self.CallbackNoUpdate) == 'function' then
                    self.CallbackNoUpdate(self.LocalVersion)
                end
            end
        end
        self.GotScriptVersion = true
    end
end

function ScriptUpdate:DownloadUpdate()
    if self.GotScriptUpdate then return end
    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
    if self.Status == 'timeout' and not self.Started then
        self.Started = true
        self.Socket:send("GET "..self.Url.." HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
    end
    if (self.Receive or (#self.Snipped > 0)) and not self.RecvStarted then
        self.RecvStarted = true
        self.DownloadStatus = 'Downloading Script (0%)'
    end

    self.File = self.File .. (self.Receive or self.Snipped)
    if self.File:find('</si'..'ze>') then
        if not self.Size then
            self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</si'..'ze>')-1))
        end
        if self.File:find('<scr'..'ipt>') then
            local _,ScriptFind = self.File:find('<scr'..'ipt>')
            local ScriptEnd = self.File:find('</scr'..'ipt>')
            if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
            local DownloadedSize = self.File:sub(ScriptFind+1,ScriptEnd or -1):len()
            self.DownloadStatus = 'Downloading Script ('..math.round(100/self.Size*DownloadedSize,2)..'%)'
        end
    end
    if self.File:find('</scr'..'ipt>') then
        self.DownloadStatus = 'Downloading Script (100%)'
        local a,b = self.File:find('\r\n\r\n')
        self.File = self.File:sub(a,-1)
        self.NewFile = ''
        for line,content in ipairs(self.File:split('\n')) do
            if content:len() > 5 then
                self.NewFile = self.NewFile .. content
            end
        end
        local HeaderEnd, ContentStart = self.NewFile:find('<sc'..'ript>')
        local ContentEnd, _ = self.NewFile:find('</scr'..'ipt>')
        if not ContentStart or not ContentEnd then
            if self.CallbackError and type(self.CallbackError) == 'function' then
                self.CallbackError()
            end
        else
            local newf = self.NewFile:sub(ContentStart+1,ContentEnd-1)
            local newf = newf:gsub('\r','')
            if newf:len() ~= self.Size then
                if self.CallbackError and type(self.CallbackError) == 'function' then
                    self.CallbackError()
                end
                return
            end
            local newf = Base64Decode(newf)
            if type(load(newf)) ~= 'function' then
                if self.CallbackError and type(self.CallbackError) == 'function' then
                    self.CallbackError()
                end
            else
                local f = io.open(self.SavePath,"w+b")
                f:write(newf)
                f:close()
                if self.CallbackUpdate and type(self.CallbackUpdate) == 'function' then
                    self.CallbackUpdate(self.OnlineVersion,self.LocalVersion)
                end
            end
        end
        self.GotScriptUpdate = true
    end
end
--Credits SxTeam
