{\rtf1\ansi\ansicpg1252\deff0\deflang1033{\fonttbl{\f0\fswiss\fcharset0 Arial;}}
{\*\generator Msftedit 5.41.15.1515;}\viewkind4\uc1\pard\f0\fs20 function necro_onspawn(pUnit, event)\par
 setvars(pUnit, \{skelalive=1, amplifyhap=0, archastehap=0, buffhap=0\});\par
 local rand = math.random(1, 2)\par
 local gx = pUnit:GetX()\par
 local gy = pUnit:GetY()\par
 local gz = pUnit:GetZ()\par
pUnit:CastSpell(53708)\par
pUnit:SpawnCreature(20007, gx+rand, gy+rand, gz, 20, 30000)\par
pUnit:RegisterEvent("necro_skeltrig", 1000, 0)\par
pUnit:RegisterEvent("necro_markskeldesp", 30000, 1)\par
end\par
\par
function necro_skeltrig(pUnit, event)\par
 local args = getvars(pUnit);\par
 if (args.skelalive == 0) then\par
 pUnit:RegisterEvent("necro_summskel", 30000, 1)\par
 pUnit:RegisterEvent("necro_markskelsum", 500, 1)\par
else\par
end\par
end\par
\par
function summskel(pUnit, event)\par
 local rand = math.random(1, 2)\par
 local gx = pUnit:GetX()\par
 local gy = pUnit:GetY()\par
 local gz = pUnit:GetZ()\par
pUnit:CastSpell(53708)\par
pUnit:SpawnCreature(20007, gx+rand, gy+rand, gz, 20, 30000)\par
pUnit:RegisterEvent("necro_markskeldesp", 30000, 1)\par
end\par
\par
function necro_markskeldesp(pUnit, event)\par
 local args = getvars(pUnit);\par
 if (args.skelalive == 1) then\par
 args.skelalive=0;\par
 setvars(pUnit, args);\par
else\par
end\par
end\par
\par
function necro_markskelsum(pUnit, event)\par
\tab local args = getvars(pUnit);\par
\tab args.skelalive=1;\par
\tab setvars(pUnit, args);\par
end\par
\par
function necro_oncombat(pUnit, event)\par
 pUnit:RegisterEvent("necro_shadowbolt", math.random(5000, 6000), 0)\par
 pUnit:RegisterEvent("necro_ampweak", 1000, 0)\par
 pUnit:RegisterEvent("necro_arcself", 1000, 0)\par
 pUnit:RegisterEvent("necro_bonebuff", 1000, 0)\par
end\par
\par
function necro_bonebuff(pUnit, event)\par
local args = getvars(pUnit);\par
local buffplr = pUnit:GetMainTank()\par
 if (args.skelalive == 0) and (args.buffhap ==0) and (buffplr ~= nil) then\par
 buffplr:CastSpell(11445)\par
 pUnit:RegisterEvent("necro_buffhap", 500, 1)\par
else\par
end\par
end\par
\par
function necro_buffhap(pUnit, event)\par
local args = getvars(pUnit);\par
args.buffhap=1;\par
setvars(pUnit, args);\par
end\par
\par
function necro_arcself(pUnit, event)\par
local args = getvars(pUnit);\par
 if (args.archastehap == 0) and pUnit:GetHealthPct() <= 20 then\par
 pUnit:CastSpell(32693)\par
 pUnit:RegisterEvent("necro_markarc", 500, 1)\par
end\par
end\par
\par
function necro_markarc(pUnit, event)\par
local args = getvars(pUnit);\par
args.archastehap=1;\par
setvars(pUnit, args);\par
end\par
\par
function necro_ampweak(pUnit, event)\par
local args = getvars(pUnit);\par
local amplr = pUnit:GetMainTank()\par
 if (amplr ~= nil) and (args.amplifyhap == 0) and amplr:GetHealthPct() <= 20 then\par
pUnit:FullCastSpellOnTarget(12248, amplr)\par
pUnit:RegisterEvent("necro_markamphap", 500, 1)\par
end\par
end\par
\par
function necro_markamphap(pUnit, event)\par
\tab local args = getvars(pUnit);\par
\tab args.amplifyhap=1;\par
\tab setvars(pUnit, args);\par
end\par
\par
function necro_shadowbolt(pUnit, event)\par
local shadhit = pUnit:GetMainTank()\par
 if (shadhit ~= nil) then\par
pUnit:StopMovement(3100)\par
pUnit:FullCastSpellOnTarget(9613, shadhit)\par
        else\par
    end\par
end\par
\par
function necro_leavecombat(pUnit, event)\par
\tab pUnit:RemoveEvents()\par
end\par
\par
function necro_died(pUnit, event)\par
\tab pUnit:RemoveEvents()\par
end\par
\par
RegisterUnitEvent(20006, 1, "necro_oncombat")\par
RegisterUnitEvent(20006, 2, "necro_leavecombat")\par
RegisterUnitEvent(20006, 4, "necro_died")\par
RegisterUnitEvent(20006, 18, "necro_onspawn")\par
}
 