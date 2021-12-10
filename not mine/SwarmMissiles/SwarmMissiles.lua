--[[
    SwarmMissiles
    Author:
        raisins (Discord: raisins77#5716)
        fallen_angel.js (Discord: qaznotquaz#3300)
        	-- ported it to be a new aspect instead of replacing Zag's

   Adds a new special for the gun.
]]

--[[ qaz: moved config to config.lua ]]--

if SwarmMissiles.config.Enabled then
    --[[ qaz: moved Aspect initialization to WeaponUpgradeData.lua ]]--
    --[[ qaz: moved Trait changes to TraitData.lua ]]--

    --[[ qaz: why does the game complain when I move this? ]]--
    --gunshot hits add extra missiles
    ModUtil.MapSetTable(WeaponData, {
        GunWeapon = {
            ComboPoints = 1
        },
        GunWeaponDash = {
            ComboPoints = 1
        },
        GunGrenadeToss = {
            OnFiredFunctionName = "CheckMissileComboReset",
            MaxMissilesInfo = 0,
        }
    })

    --[[ qaz: moved objective addition to ObjectiveData.lua ]]--

    function CheckMissileCombo(victim, attacker, triggerArgs, sourceWeaponData)
        if sourceWeaponData == nil or sourceWeaponData.ComboPoints == nil or sourceWeaponData.ComboPoints <= 0 then
            return
        end

        if triggerArgs.EffectName ~= nil then
            -- Effects never generate combo points for now
            return
        end

        if victim.NoComboPoints then
            return
        end

        if not HeroHasTrait("GunSwarmMissileTrait") then
            return
        end

        attacker.MissileComboCount = (attacker.MissileComboCount or 0) + sourceWeaponData.ComboPoints

        if attacker.MissileComboCount >= 1 and not attacker.MissileComboFull then
            attacker.MissileComboReady = true
            local maxMissiles = math.floor(GetTotalHeroTraitValue("SpecialMaxMissiles") * GetTotalHeroTraitValue("MissileMaxIncrease", { IsMultiplier = true }) + 0.5)
            local extraMissiles = attacker.MissileComboCount * 2 * SwarmMissiles.config.ExtraMissilesPerShot * GetTotalHeroTraitValue("MissileChargeRate", { IsMultiplier = true })
            if (extraMissiles > SwarmMissiles.config.FastExtraMissiles) then
                extraMissiles = SwarmMissiles.config.FastExtraMissiles + (0.5 * (extraMissiles - SwarmMissiles.config.FastExtraMissiles))
            end
            if HeroHasTrait("GunExplodingSecondaryTrait") then
                --Rocket Bomb hammer
                maxMissiles = math.floor(maxMissiles / 4 + 1)
                extraMissiles = extraMissiles / 4
            end
            local missileCount = 1 + extraMissiles
            --DebugPrint{ Text = "missileCount is "..missileCount.."/"..maxMissiles }
            missileCount = math.floor(math.min(missileCount, maxMissiles))
            SetWeaponProperty({ WeaponName = "GunGrenadeToss", DestinationId = CurrentRun.Hero.ObjectId, Property = "NumProjectiles", Value = missileCount })
            if missileCount >= maxMissiles then
                attacker.MissileComboFull = true
                MissileComboReadyPresentation(attacker, triggerArgs)
            end
        end
    end

    function CheckMissileComboReset(attacker, weaponData, args)
        if weaponData ~= nil and attacker.MissileComboReady then
            if not args or not args.Undelivered then
                if attacker.MissileComboFull then
                    thread(MarkObjectiveComplete, "GunWeaponGunWeave")
                    MissileComboFullDeliveredPresentation(attacker, triggerArgs)
                else
                    MissileComboDeliveredPresentation(attacker, triggerArgs)
                end
            end

            if HeroHasTrait("GunGrenadeFastTrait") and (attacker.MissileComboFastTraitClip > 1) and (not args or not args.Undelivered) then
                --Triple Bomb hammer
                attacker.MissileComboFastTraitClip = attacker.MissileComboFastTraitClip - 1
            else
                attacker.MissileComboFastTraitClip = 3
                attacker.MissileComboReady = false
                attacker.MissileComboFull = false
                attacker.MissileComboCount = 0
                SetWeaponProperty({ WeaponName = "GunGrenadeToss", DestinationId = CurrentRun.Hero.ObjectId, Property = "NumProjectiles", Value = 1 })
            end
        end
    end

    function MissileComboReadyPresentation(attacker, triggerArgs)
        CreateAnimation({ Name = "FistComboReadyFx", DestinationId = attacker.ObjectId })
        CreateAnimation({ Name = "PowerUpComboReady", DestinationId = attacker.ObjectId })
        CreateAnimation({ Name = "FistComboReadyGlow", DestinationId = attacker.ObjectId })
        if CheckCooldown("ComboReadyHint", 1.5) then
            thread(InCombatText, attacker.ObjectId, "MissileCombo_Ready", 0.8)
            PlaySound({ Name = "/SFX/Player Sounds/ZagreusFistComboProc", Id = CurrentRun.Hero.ObjectId })
        end
    end

    function MissileComboFullDeliveredPresentation(attacker, triggerArgs)
        PlaySound({ Name = "/VO/ZagreusEmotes/EmoteSuperSpecial_Fist", Id = attacker.ObjectId })
        PlaySound({ Name = "/Leftovers/SFX/AuraPerfectThrow", Id = attacker.ObjectId })
        wait(0.5)
        StopAnimation({ Name = "FistComboReadyFx", DestinationId = attacker.ObjectId })
        StopAnimation({ Name = "FistComboReadyGlow", DestinationId = attacker.ObjectId })
    end

    function MissileComboDeliveredPresentation(attacker, triggerArgs)
        PlaySound({ Name = "/VO/ZagreusEmotes/EmotePowerAttacking_Sword", Id = attacker.ObjectId })
        PlaySound({ Name = "/Leftovers/SFX/AuraPerfectThrow", Id = attacker.ObjectId })
    end

    function RemoveGunWeaveBuff()
        StopAnimation({ Name = "FistComboReadyFx", DestinationId = CurrentRun.Hero.ObjectId })
        StopAnimation({ Name = "PowerUpComboReady", DestinationId = CurrentRun.Hero.ObjectId })
        StopAnimation({ Name = "FistComboReadyGlow", DestinationId = CurrentRun.Hero.ObjectId })
        CheckMissileComboReset(CurrentRun.Hero, WeaponData.GunWeapon, { Undelivered = true })
    end

    --[[ qaz: moved RemoveGunWeaveBuff addition to WeaponUpgradeData.lua ]]--

    ModUtil.WrapBaseFunction("DamageEnemy", function(baseFunc, victim, triggerArgs)
        local sourceWeaponData = triggerArgs.AttackerWeaponData
        local attacker = triggerArgs.AttackerTable
        thread(CheckMissileCombo, victim, attacker, triggerArgs, sourceWeaponData)
        --ModUtil.Hades.PrintStack( "MissileComboCount: "..attackerDM.MissileComboCount, 1 )
        return baseFunc(victim, triggerArgs)
    end, SwarmMissiles)

    ModUtil.WrapBaseFunction("SetupHeroObject", function(baseFunc, currentRun, applyLuaUpgrades)
        local heroObj = baseFunc(currentRun, applyLuaUpgrades)
        currentRun.Hero.MissileComboCount = 0
        currentRun.Hero.MissileComboReady = false
        currentRun.Hero.MissileComboFull = false
        currentRun.Hero.MissileComboFastTraitClip = 3 --Triple Bomb hammer
        currentRun.Hero.MissileMax = math.floor(
                GetTotalHeroTraitValue("SpecialMaxMissiles")
                        * GetTotalHeroTraitValue("MissileMaxIncrease",
                        { IsMultiplier = true }
                ) + 0.5
        )
        return heroObj
    end, SwarmMissiles)

    --[[ qaz: moved Trait changes to TraitData.lua ]]--

    --[[ qaz: moved Hammer changes moved to TraitData.lua ]]--

    --[[ qaz: what does this do and how does it actually work??
            I tried moving things to more apt files
            but the game didn't want to work until I moved it all back in here. ]]--
    function SwarmMissilesDataInsist()
        if not Contains(LootData.WeaponUpgrade.Traits, "GunGrenadeGhostTrait") then
            table.insert(LootData.WeaponUpgrade.Traits, "GunGrenadeGhostTrait")
            table.insert(LootData.WeaponUpgrade.Traits, "GunGrenadeCircusTrait")
            table.insert(LootData.WeaponUpgrade.Traits, "GunGrenadeBurnTrait")
        end
        if not ContainsAnyKey(LootData.WeaponUpgrade.TraitIndex, { "GunGrenadeGhostTrait" }) then
            ModUtil.MapSetTable(LootData, {
                WeaponUpgrade = {
                    TraitIndex = {
                        GunGrenadeGhostTrait = true,
                        GunGrenadeCircusTrait = true,
                        GunGrenadeBurnTrait = true,
                    }
                }
            })
        end

        if CodexMenuData ~= nil and not Contains(CodexMenuData.GunWeapon, "GunGrenadeGhostTrait") then
            table.insert(CodexMenuData.GunWeapon, "GunGrenadeGhostTrait")
            table.insert(CodexMenuData.GunWeapon, "GunGrenadeCircusTrait")
            table.insert(CodexMenuData.GunWeapon, "GunGrenadeBurnTrait")
            for _, value in ipairs(CodexMenuData.GodNames) do
                CodexMenuData[value .. "Inverted"] = CustomInvertTable(CodexMenuData[value])
            end
        end
    end

    OnPreThingCreation { SwarmMissilesDataInsist }

    --tootip popup
    table.insert(KeywordList, "MissileBarrage_Unequipped")
    table.insert(KeywordList, "MissileBarrage")
    table.insert(KeywordList, "MissileBarrage2")
    table.insert(KeywordList, "Burn")
    ResetKeywords()
end