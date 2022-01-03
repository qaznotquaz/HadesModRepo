-- These functions are copied from DebugScripts.lua
function KludgeConsole.MaxAllGifts()
    CurrentRun.DebugUnlockGifts = true
    for npcName, npcData in pairs(GiftData) do
        if true then
            IncrementGiftMeter( npcName, GetMaxGiftLevel(npcName))

            if GameState.Gift[npcName].NewTraits == nil then
                GameState.Gift[npcName].NewTraits = {}
            end
            for i, data in pairs(npcData) do
                if type(data) == "table" and data.Gift ~= nil then
                    local traitName = data.Gift
                    table.insert( GameState.Gift[npcName].NewTraits, traitName )
                end
            end
        end
    end
end

function KludgeConsole.AddRerolls()
    if CurrentRun ~= nil then
        AddRerolls( 99, "Debug", { IgnoreMetaUpgrades = true } )
    end
end

function KludgeConsole.AddResources()
    AddResource( "MetaPoints", 99999, "Debug" )
    AddResource( "Gems", 9999, "Debug" )
    AddResource( "LockKeys", 999, "Debug" )
    AddResource( "GiftPoints", 9999, "Debug" )
    AddResource( "SuperLockKeys", 99, "Debug" )
    AddResource( "SuperGems", 99, "Debug" )
    AddResource( "SuperGiftPoints", 99, "Debug" )
    PlaySound({ Name = "/Leftovers/Menu Sounds/EmoteExcitement" })
    thread( PlayVoiceLines, GlobalVoiceLines.FabulousWealthVoiceLines, true )
end

function KludgeConsole.AddTraits(traits)
    for _, data in pairs(traits) do
        local name = data.name
        local level = data.level or 1
        local rarity = data.rarity or "Common"

        for i = 1, level, 1 do
            AddTraitToHero({
                TraitData = GetProcessedTraitData({
                    Unit = CurrentRun.Hero,
                    TraitName = name,
                    Rarity = rarity}) })
        end
    end
end

function KludgeConsole.runKludge()
    -- just a sample
    traits = {
        {
            name = "ArtemisRangedTrait",
            rarity = "Heroic"
        },
        {
            name = "AresWeaponTrait",
            level = 4
        },
        {
            name = "ZeusRushTrait",
            level = 6,
            rarity = "Epic"
        }
    }
    KludgeConsole.AddTraits(traits)
end