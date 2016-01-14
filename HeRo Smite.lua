---Auto Smite Developed by HeRoBaNd---
---Changelog---
---1.0 - Reliased For Bol---
---1.1 - Added AutoUpdater (Credit - Simple & HiranN & BF Team)---
---1.2 - 6.1 Updated---
local RangeSmite = 560
local serveradress = "raw.githubusercontent.com"
local scriptadress = "/HeRoBaNd/Scripts/master"
local LocalVersion = "1.2"
local autoupdate = true

	if myHero:GetSpellData(SUMMONER_1).name:find("summonersmite") then Smite = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("summonersmite") then Smite = SUMMONER_2 end

PrintChat("<font color='#FF0000'><b>[HeRo Smite] </b></font>".."<font color='#FF0000'><b>Loaded.</b></font>") 

if Smite ~= nil then 
PrintChat("<font color='#FF0000'><b>[HeRo Smite] </b></font>".."<font color='#FF0000'><b>Smite found.</b></font>") 
else 
PrintChat("<font color='#FF0000'><b>[HeRo Smite] </b></font>".."<font color='#FF0000'><b>Smite not found.</b></font>") 
return 
end

function OnLoad()
  FindUpdates()
	jungleMinions = minionManager(MINION_JUNGLE, RangeSmite, myHero, MINION_SORT_MAXHEALTH_DEC)
	HSMenuInit()
end

function HSMenuInit()
	HSMenu = scriptConfig("HeRo Smite", "HSSmite")
	
	HSMenu:addParam("SmiteActive", "Smite Active", SCRIPT_PARAM_ONKEYTOGGLE, true, 76)
  HSMenu:addParam("rangeSmite", "Draw Range Smite", SCRIPT_PARAM_ONOFF, true)
	HSMenu:addSubMenu("Smite Monsters:", "smitethat")
    HSMenu.smitethat:addParam("SRUDragon", "Use Smite on: Dragon", SCRIPT_PARAM_ONOFF, true)
    HSMenu.smitethat:addParam("SRUBaron", "Use Smite on: Baron", SCRIPT_PARAM_ONOFF, true)
    HSMenu.smitethat:addParam("SRURazorbeak", "Use Smite on: Wraith", SCRIPT_PARAM_ONOFF, false)
    HSMenu.smitethat:addParam("SRUMurkwolf", "Use Smite on: Wolf", SCRIPT_PARAM_ONOFF, false)
    HSMenu.smitethat:addParam("SRUKrug", "Use Smite on: Krug", SCRIPT_PARAM_ONOFF, false)
    HSMenu.smitethat:addParam("SRUGromp", "Use Smite on: Gromp", SCRIPT_PARAM_ONOFF, false)
    HSMenu.smitethat:addParam("SRURed", "Use Smite on: Red", SCRIPT_PARAM_ONOFF, true)
    HSMenu.smitethat:addParam("SRUBlue", "Use Smite on: Blue", SCRIPT_PARAM_ONOFF, true)
    
   DelayAction(function() HSMenu:permaShow("SmiteActive") end, 5.0)
end

function GetSmiteDamage()
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

function OnTick()
	if myHero.dead then return end
	jungleMinions:update()
	CheckJungle()
end

function CheckJungle()
	if HSMenu.SmiteActive then
	for i, jungle in pairs(jungleMinions.objects) do
	if jungle ~= nil then
	if HSMenu.smitethat[jungle.charName:gsub("_", "")] then
	SmiteMonster(jungle)
end
end
end
end   

function SmiteMonster(obj)
    local DistanceMonster = GetDistance(obj)
    if myHero:CanUseSpell(Smite) == READY and DistanceMonster <= RangeSmite and obj.health <= GetSmiteDamage() then
    CastSpell(Smite, obj)
    end
end
end

function OnDraw()
	if myHero.dead then return end

	if HSMenu.rangeSmite and myHero:CanUseSpell(Smite) == READY and HSMenu.SmiteActive then
	DrawCircle(myHero.x, myHero.y, myHero.z, RangeSmite,ARGB(255, 128, 128, 128))
	end

end

function FindUpdates()
	if not autoupdate then return end
	local ServerVersionDATA = GetWebResult(serveradress , scriptadress.."/HeRo Smite.version")
	if ServerVersionDATA then
		local ServerVersion = tonumber(ServerVersionDATA)
		if ServerVersion then
			if ServerVersion > tonumber(LocalVersion) then
			PrintChat("<font color='#FF0000'><b>[HeRo Smite] </b></font>".."<font color='#FAEBD7'><b>Updating, don't press F9.</b></font>")
			Update()
			else
			PrintChat("<font color='#FF0000'><b>[HeRo Smite] </b></font>".."<font color='#FAEBD7'><b>You have the latest version.</b></font>")
			end
		else
		PrintChat("<font color='#FF0000'><b>[HeRo Smite] </b></font>".."<font color='#FAEBD7'><b>An error occured, while updating, please reload.</b></font>")
		end
	else
	PrintChat("<font color='#FF0000'><b>[HR Smite] </b></font>".."<font color='#FAEBD7'><b>Could not connect to update Server.</b></font>")
	end
end

function Update()
	DownloadFile("http://"..serveradress..scriptadress.."/HeRo Smite.lua",SCRIPT_PATH.."HeRo Smite.lua", function ()
	PrintChat("<font color='#FF0000'><b>[HeRo Smite] </b></font>".."<font color='#FAEBD7'><b>Updated, press 2xF9.</b></font>")
	end)
end
