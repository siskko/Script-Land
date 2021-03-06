--[[ WoTD License - 
This software is provided as free and open source by the
team of The WoTD Team. This script was written and is
protected by the GPL v2. Please give credit where credit
is due, if modifying, redistributing and/or using this 
software. Thank you.
Thank: WoTD Team; for the Script
~~End of License... Please Stand By...
-- WoTD Team, Janurary 19, 2010. ]]

--Beryl Treasure Hunter
function BerylTreasureHunter_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("BerylTreasureHunter_Beam", 2000, 0)
end

function BerylTreasureHunter_Beam(Unit,Event)
	Unit:FullCastSpellOnTarget(50658, Unit:GetClosestPlayer())
end

function BerylTreasureHunter_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function BerylTreasureHunter_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(25353, 1, "BerylTreasureHunter_OnEnterCombat")
RegisterUnitEvent(25353, 2, "BerylTreasureHunter_OnLeaveCombat")
RegisterUnitEvent(25353, 4, "BerylTreasureHunter_OnDied")