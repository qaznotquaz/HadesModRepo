local mostRecentSpearReturnId = nil
local shouldUpdateAmmoUI = true

local mo = ModUtil.RegisterMod("AspectsRework")

local function UndoChange(value, changeType)
    if changeType == "Add" then
        return -value
    elseif changeType == "Multiply" then
        return 1 / value
    else
        return value
    end
end

local function AddLimitedHeroBonus(args)
    if CurrentRun.Hero.LimitedBonuses == nil then
        CurrentRun.Hero.LimitedBonuses = { }
    end

    local bonusName = args.BonusName
    local propertyName = args.PropertyName
    local value = args.Value
    local valueChangeType = args.ValueChangeType or "Add"
    local effectName = args.EffectName or nil
    local duration = args.Duration or nil
    local animation = args.Animation or nil

    if CurrentRun.Hero.LimitedBonuses[bonusName] then
        if effectName == nil and duration ~= nil then
            SetThreadWait("HeroLimitedBonus" .. bonusName, duration)
        end
    else
        if animation ~= nil then
            CreateAnimation({ Name = animation, DestinationId = CurrentRun.Hero.ObjectId })
        end
        SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = propertyName, Value = value, ValueChangeType = valueChangeType })
        CurrentRun.Hero.LimitedBonuses[bonusName] = true
        if effectName ~= nil then
            NotifyOnEffectExpired({ Id = CurrentRun.Hero.ObjectId, Notify = effectName .. "Expired", EffectName = effectName })
            waitUntil(effectName .. "Expired")
        elseif duration ~= nil then
            wait(duration, "HeroLimitedBonus" .. bonusName)
        end
        if animation ~= nil then
            StopAnimation({ Name = animation, DestinationId = CurrentRun.Hero.ObjectId })
        end
        SetUnitProperty({ DestinationId = CurrentRun.Hero.ObjectId, Property = propertyName, Value = UndoChange(value, valueChangeType), ValueChangeType = valueChangeType })
        CurrentRun.Hero.LimitedBonuses[bonusName] = nil
    end
end

local function GetTotalTraitValue(traitName, propertyName, requireTraits)
    local total = 0

    requireTraits = requireTraits or true

    if HeroHasTrait(traitName) then
        if not CurrentRun.Hero.TraitDictionary then
            UpdateHeroTraitDictionary()
        end

        for i = 1, #CurrentRun.Hero.TraitDictionary[traitName] do
            for requiredTraitName, propertyChange in pairs(CurrentRun.Hero.TraitDictionary[traitName][i][propertyName]) do
                if not requireTraits or HeroHasTrait(requiredTraitName) then
                    total = total + propertyChange
                end
            end
        end
    end

    return total
end

local function GetHighestRarity(traitName)
    local rarities =
    {
        Common = 1,
        Rare = 2,
        Epic = 3,
        Heroic = 4,
        Legendary = 5
    }

    if HeroHasTrait(traitName) then
        UpdateHeroTraitDictionary()

        local bestRarity = 0
        local index = 1

        for i = 1, #CurrentRun.Hero.TraitDictionary[traitName] do
            if CurrentRun.Hero.TraitDictionary[traitName][i].Rarity and rarities[CurrentRun.Hero.TraitDictionary[traitName][i].Rarity] and rarities[CurrentRun.Hero.TraitDictionary[traitName][i].Rarity] > bestRarity then
                bestRarity = rarities[CurrentRun.Hero.TraitDictionary[traitName][i].Rarity]
                index = i
            end
        end
        return CurrentRun.Hero.TraitDictionary[traitName][index]
    else
        return nil
    end
end

-- for some reason, traits don't work properly unless reloaded on room load. Order seems to matter.
local reload = { "SpearWeaveTrait", "AphroditeRangedTrait", "AresRangedTrait", "AthenaRangedTrait", "ArtemisRangedTrait", "DionysusRangedTrait", "DemeterRangedTrait", "PoseidonRangedTrait", "ZeusRangedTrait", "ZeusBoltAoETrait", "AphroditeRangedBonusTrait" }
local function UpdateHeroTrait(traitName)
    if HeroHasTrait(traitName) then
        local rarity = GetHighestRarity(traitName).Rarity
        local stacks = #CurrentRun.Hero.TraitDictionary[traitName]
        while HeroHasTrait(traitName) do
            RemoveTrait(CurrentRun.Hero, traitName)
        end
        AddTraitToHero({ TraitName = traitName, Rarity = rarity, NoUpdateTrait = traitName, SkipNewTraitHighlight = true })
        for i = 1, stacks - 1 do
            AddTraitToHero({ TraitName = traitName, NoUpdateTrait = traitName, SkipNewTraitHighlight = true })
        end
    end
end

ModUtil.LoadOnce(function()
    -- Aspect of Nemesis
    -- dirty hack to avoid editing Powers.lua

    TraitData.SwordCriticalParryTrait.CustomName = "ModifiedSwordCriticalParryTrait"
    TraitData.SwordCriticalParryTrait.CustomTrayText = "ModifiedSwordCriticalParryTrait_Tray"

    TraitData.SwordCriticalParryTrait.SwordPostParryCriticalGlobalAmount = TraitData.SwordCriticalParryTrait.SwordPostParryCriticalAmount
    TraitData.SwordCriticalParryTrait.SwordPostParryCriticalAmount = nil
    for i, extractValue in ipairs(TraitData.SwordCriticalParryTrait.ExtractValues) do
        if extractValue.Key == "SwordPostParryCriticalAmount" then
            extractValue.Key = "SwordPostParryCriticalGlobalAmount"
        end
    end

    -- Aspect of Poseidon

    TraitData.DislodgeAmmoTrait.CustomName = "ModifiedDislodgeAmmoTrait"
    TraitData.DislodgeAmmoTrait.CustomTrayText = "ModifiedDislodgeAmmoTrait_Tray"

    TraitData.DislodgeAmmoTrait.AddOutgoingDamageModifiers = nil
    TraitData.DislodgeAmmoTrait.DislodgeAmmoBonusDamage = { BaseValue = 1.10, SourceIsMultiplier = true }
    TraitData.DislodgeAmmoTrait.ExtractValues =
    {
        {
            Key = "DislodgeAmmoBonusDamage",
            ExtractAs = "TooltipDamage",
            Format = "PercentDelta"
        }
    }
    ConsumableData.AmmoPack.OnUsedFunctionName = "AddDislodgeAmmoTraitBuff"

    -- Aspect of Achilles

    TraitData.SpearTeleportTrait.CustomName = "ModifiedSpearTeleportTrait"
    TraitData.SpearTeleportTrait.CustomTrayText = "ModifiedSpearTeleportTrait_Tray"

    for i, propertyChange in ipairs(TraitData.SpearTeleportTrait.PropertyChanges) do
        if (propertyChange.WeaponNames and propertyChange.WeaponNames[1] == "SpearWeaponThrow") or propertyChange.WeaponName == "SpearWeaponThrow" then
            if propertyChange.WeaponProperty == "ChargeTime" then
                propertyChange.ChangeValue = propertyChange.ChangeValue * 4
            end

            if propertyChange.WeaponProperty == "MinChargeToFire" then
                propertyChange.ChangeValue = 0.35
            end

            if propertyChange.WeaponProperty == "SwapOnFire" then
                propertyChange.ChangeValue = "SpearWeaponThrow"
            end

            if propertyChange.WeaponProperty == "AddControlOnFire" then
                table.remove(TraitData.SpearTeleportTrait.PropertyChanges, i)
            end
        end
    end

    table.insert(TraitData.SpearTeleportTrait.PropertyChanges,
    {
        WeaponName = "SpearWeaponThrow",
        WeaponProperty = "ReloadTime",
        ChangeValue = 0.2,
        ChangeType = "Absolute",
        ExcludeLinked = true
    })
    
    table.insert(TraitData.SpearTeleportTrait.PropertyChanges,
    {
        WeaponName = "SpearWeaponThrow",
        WeaponProperty = "RemoveControlOnFire",
        ChangeValue = "null",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    })
    
    table.insert(TraitData.SpearTeleportTrait.PropertyChanges,
    {
        WeaponName = "SpearWeaponThrow",
        WeaponProperty = "RemoveControlOnFire2",
        ChangeValue = "null",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    })
    
    table.insert(TraitData.SpearTeleportTrait.PropertyChanges,
    {
        WeaponName = "SpearWeaponThrow",
        WeaponProperty = "RemoveControlOnFire3",
        ChangeValue = "null",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    })
    
    table.insert(TraitData.SpearTeleportTrait.PropertyChanges,
    {
        WeaponName = "SpearWeaponThrow",
        WeaponProperty = "RemoveControlOnFire4",
        ChangeValue = "null",
        ChangeType = "Absolute",
        ExcludeLinked = true,
    })

    TraitData.SpearTeleportTrait.OnWeaponChargeFunctions = 
    {
        ValidWeapons = { "SpearWeaponThrow" },
        FunctionName = "SpearTeleportFlash"
    }

    -- cleanup any duplicate spears - workaround for now
    thread(function()
        while true do
            if HeroHasTrait("SpearTeleportTrait") then
                local ids = GetIdsByType({ Name = "SpearReturnPointAlt01" })
                if TableLength(ids) > 1 then
                    wait(0.1)
                    ids = GetIdsByType({ Name = "SpearReturnPointAlt01" })
                    if TableLength(ids) > 1 then
                        for i = 1, #ids do
                            if ids[i] == mostRecentSpearReturnId then
                                Destroy({ Id = ids[i] })
                            end
                        end
                    end
                end
            end
            wait(0.1)
        end
    end)

    -- Aspect of Hades
    
    for _, propertyChange in ipairs(TraitData.RapidCastTrait.PropertyChanges) do
        if propertyChange.WeaponProperty == "SpeedMultiplier" then
            propertyChange.ChangeType = "Multiply"
        end
    end

    TraitData.SpearWeaveTrait.SetupFunction =
    {
        Name = "SetupSpearAmmoLoad",
        RunOnce = true
    }

    TraitData.SpearWeaveTrait.OverrideWeaponFireNames = TraitData.SpearWeaveTrait.OverrideWeaponFireNames or { }

    TraitData.SpearWeaveTrait.OverrideWeaponFireNames.RangedWeapon = "nil"
    TraitData.SpearWeaveTrait.OverrideWeaponFireNames.SpearLoadAmmoApplicator = "RangedWeapon"

    TraitData.SpearWeaveTrait.PreEquipWeapons = TraitData.SpearWeaveTrait.PreEquipWeapons or { }

    table.insert(TraitData.SpearWeaveTrait.PreEquipWeapons, "SpearLoadAmmoApplicator")

    TraitData.SpearWeaveTrait.SpearCastInterval =
    {
        DemeterRangedTrait = 0.50,
        ArtemisRangedTrait = 1.25,
        AresRangedTrait = 1.25,
        DionysusRangedTrait = 1.666,
        ZeusRangedTrait = 0.714,
        PoseidonRangedTrait = 0.333
    }

    TraitData.SpearWeaveTrait.CustomName = "ModifiedSpearWeaveTrait"
    TraitData.SpearWeaveTrait.CustomTrayText = "ModifiedSpearWeaveTrait_Tray"

    for i = #TraitData.SpearWeaveTrait.PropertyChanges, 1, -1 do
        if TraitData.SpearWeaveTrait.PropertyChanges[i].EffectName == "MarkTargetSpin" then
            table.remove(TraitData.SpearWeaveTrait.PropertyChanges, i)
        elseif TraitData.SpearWeaveTrait.PropertyChanges[i].ProjectileProperty == "DamageRadius" then
            table.remove(TraitData.SpearWeaveTrait.PropertyChanges, i)
        end
    end

    TraitData.SpearWeaveTrait.RarityLevels.Common.MinMultiplier = 1.25
    TraitData.SpearWeaveTrait.RarityLevels.Common.MaxMultiplier = 1.25
    TraitData.SpearWeaveTrait.RarityLevels.Rare.MinMultiplier = 1.2
    TraitData.SpearWeaveTrait.RarityLevels.Rare.MaxMultiplier = 1.2
    TraitData.SpearWeaveTrait.RarityLevels.Epic.MinMultiplier = 1.15
    TraitData.SpearWeaveTrait.RarityLevels.Epic.MaxMultiplier = 1.15
    TraitData.SpearWeaveTrait.RarityLevels.Heroic.MinMultiplier = 1.1
    TraitData.SpearWeaveTrait.RarityLevels.Heroic.MaxMultiplier = 1.1
    TraitData.SpearWeaveTrait.RarityLevels.Heroic.MinMultiplier = 1.05
    TraitData.SpearWeaveTrait.RarityLevels.Heroic.MaxMultiplier = 1.05
    TraitData.SpearWeaveTrait.RarityLevels.Legendary.MinMultiplier = 1
    TraitData.SpearWeaveTrait.RarityLevels.Legendary.MaxMultiplier = 1

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        WeaponProperty = "SpeedMultiplier",
        BaseValue = 1,
        SourceIsNegativeMultiplier = true,
        ChangeType = "Multiply",
        ExtractValue = { ExtractAs = "TooltipSpeedIncrease", Format = "PercentDelta", BaseType = "Weapon", BaseName = "RangedWeapon", BaseProperty = "SpeedMultiplier" }
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        WeaponProperty = "IgnoreOwnerAttackDisabled",
        ChangeValue = true,
        ChangeType = "Absolute"
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        WeaponProperty = "Cooldown",
        ChangeValue = 0,
        ChangeType = "Absolute"
    })
    
    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        WeaponProperty = "ClearFireRequestOnChargeCancel",
        ChangeValue = false,
        ChangeType = "Absolute",
    })
    
    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        WeaponProperty = "SetCompleteAngleOnFire",
        ChangeValue = false,
        ChangeType = "Absolute",
    })
    
    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        WeaponProperty = "SetCompleteAngleOnCharge",
        ChangeValue = false,
        ChangeType = "Absolute",
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        WeaponProperty = "ChargeTime",
        ChangeValue = 0,
        ChangeType = "Absolute"
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        WeaponProperty = "SelfVelocity",
        ChangeValue = 0,
        ChangeType = "Absolute"
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        WeaponProperty = "FireGraphic",
        ChangeValue = "null",
        ChangeType = "Absolute"
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        WeaponProperty = "ChargeStartAnimation",
        ChangeValue = "null",
        ChangeType = "Absolute"
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        WeaponProperty = "FullyAutomatic",
        ChangeValue = true,
        ChangeType = "Absolute"
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        WeaponProperty = "AllowMultiFireRequest",
        ChangeValue = true,
        ChangeType = "Absolute"
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        WeaponProperty = "RootOwnerWhileFiring",
        ChangeValue = false,
        ChangeType = "Absolute"
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        WeaponProperty = "BlockMoveInput",
        ChangeValue = false,
        ChangeType = "Absolute"
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        WeaponProperty = "CancelMovement",
        ChangeValue = false,
        ChangeType = "Absolute"
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        WeaponProperty = "ChargeCancelMovement",
        ChangeValue = false,
        ChangeType = "Absolute"
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        ProjectileProperty = "IgnoreCoverageAngles",
        ChangeValue = false,
        ChangeType = "Absolute"
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        WeaponProperty = "IgnoreForceCooldown",
        ChangeValue = true,
        ChangeType = "Absolute"
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        WeaponProperty = "FireFx",
        ChangeValue = "null",
        ChangeType = "Absolute"
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        WeaponProperty = "ShowFreeAimLine",
        ChangeValue = false,
        ChangeType = "Absolute",
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        WeaponProperty = "FireOnRelease",
        ChangeValue = false,
        ChangeType = "Absolute"
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        WeaponProperty = "UseTargetAngle",
        ChangeValue = false,
        ChangeType = "Absolute"
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "Type",
        ChangeValue = "INSTANT"
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DamageRadius",
        ChangeValue = 200
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileName = "RangedWeapon",
        ProjectileProperty = "DetonateGraphic",
        ChangeValue = "RadialNovaSwordParry"
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileName = "RangedWeapon",
        ProjectileProperty = "StartFx",
        ChangeValue = "null"
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeaon",
        EffectName = "OnHitStun",
        EffectProperty = "Active",
        ChangeValue = false
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileName = "RangedWeapon",
        ProjectileProperty = "DissipateGraphic",
        ChangeValue = "null"
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisable",
        EffectProperty = "Active",
        ChangeValue = false
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisableCancelable",
        EffectProperty = "Active",
        ChangeValue = false
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisableCancelableFast",
        EffectProperty = "Active",
        ChangeValue = false
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "SpearWeaponThrow",
        WeaponProperty = "FireOnRelease",
        ChangeValue = true,
        ChangeType = "Absolute",
        ExcludeLinked = true
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "SpearWeaponThrow",
        WeaponProperty = "ChargeTime",
        ChangeValue = 0.045,
        ChangeType = "Add",
        ExcludeLinked = true
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "SpearWeaponThrow",
        WeaponProperty = "ChargeRangeMultiplier",
        ChangeValue = 3.34,
        ChangeType = "Absolute",
        ExcludeLinked = true
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "SpearWeaponThrow",
        ProjectileProperty = "Range",
        ChangeValue = 0.299,
        ChangeType = "Multiply",
        ExcludeLinked = true
    })

    table.insert(TraitData.SpearWeaveTrait.PropertyChanges,
    {
        WeaponName = "SpearWeaponThrow",
        WeaponProperty = "MinChargeToFire",
        ChangeValue = 0,
        ChangeType = "Absolute",
        ExcludeLinked = true
    })

    -- ranged traits
    
    local rangedTraits = { "AphroditeRangedTrait", "AresRangedTrait", "AthenaRangedTrait", "ArtemisRangedTrait", "DionysusRangedTrait", "DemeterRangedTrait", "PoseidonRangedTrait", "ZeusRangedTrait" }
    for i, rangedTrait in ipairs(rangedTraits) do
        for j, propertyChange in ipairs(TraitData[rangedTrait].PropertyChanges) do
            if propertyChange.ProjectileProperty == "DamageLow" then
                propertyChange.WithoutTraitName = "SpearWeaveTrait"
            end
        end
    end

    TraitData.AphroditeRangedTrait.TraitDependencyTextOverrides = TraitData.AphroditeRangedTrait.TraitDependencyTextOverrides or { }
    TraitData.AphroditeRangedTrait.TraitDependencyTextOverrides.SpearWeaveTrait =
    {
        Name = "SpearLoadAphroditeRangedTrait",
        CustomTrayText = "SpearLoadAphroditeRangedTrait_Tray"
    }

    table.insert(TraitData.AphroditeRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        WeaponProperty = "Projectile",
        ChangeValue = "AphroditeBeowulfProjectile",
        ChangeType = "Absolute"
    })

    table.insert(TraitData.AphroditeRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        WeaponProperty = "FireFx",
        ChangeType = "Absolute",
        ChangeValue = "null"
    })

    table.insert(TraitData.AphroditeRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DamageLow",
        BaseMin = 70,
        BaseMax = 70,
        IdenticalMultiplier = { Value = -0.4 },
        DeriveSource = "AphroditeDamageLow",
        ExtractValue = { ExtractAs = "TooltipSpearLoadDamage" }
    })

    table.insert(TraitData.AphroditeRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DamageHigh",
        DeriveValueFrom = "AphroditeDamageLow"
    })

    table.insert(TraitData.AphroditeRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DamageRadius",
        ChangeValue = 200
    })

    table.insert(TraitData.AphroditeRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisable",
        EffectProperty = "Active",
        ChangeValue = false
    })

    table.insert(TraitData.AphroditeRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisableCancelable",
        EffectProperty = "Active",
        ChangeValue = false
    })

    table.insert(TraitData.AphroditeRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisableCancelableFast",
        EffectProperty = "Active",
        ChangeValue = false
    })

    TraitData.AresRangedTrait.TraitDependencyTextOverrides = TraitData.AresRangedTrait.TraitDependencyTextOverrides or { }
    TraitData.AresRangedTrait.TraitDependencyTextOverrides.SpearWeaveTrait =
    {
        Name = "SpearLoadAresRangedTrait",
        CustomTrayText = "SpearLoadAresRangedTrait_Tray"
    }

    table.insert(TraitData.AresRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        WeaponProperty = "FireFx",
        ChangeType = "Absolute",
        ChangeValue = "null"
    })

    table.insert(TraitData.AresRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "Speed",
        ChangeValue = 0
    })

    table.insert(TraitData.AresRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "TotalFuse",
        ChangeValue = 0.6
    })

    table.insert(TraitData.AresRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DamageRadius",
        ChangeValue = 150
    })

    table.insert(TraitData.AresRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DetonateAtVictimLocation",
        ChangeValue = true
    })

    table.insert(TraitData.AresRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DamageLow",
        BaseMin = 20,
        BaseMax = 20,
        AsInt = true,
        IdenticalMultiplier = { Value = -0.8 },
        DeriveSource = "AresDamageLow",
        ExtractValue = { ExtractAs = "TooltipSpearLoadDamage" }
    })

    table.insert(TraitData.AresRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DamageHigh",
        DeriveValueFrom = "AresDamageLow"
    })

    table.insert(TraitData.AresRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisable",
        EffectProperty = "Active",
        ChangeValue = false
    })

    table.insert(TraitData.AresRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisableCancelable",
        EffectProperty = "Active",
        ChangeValue = false
    })

    table.insert(TraitData.AresRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisableCancelableFast",
        EffectProperty = "Active",
        ChangeValue = false
    })

    TraitData.AthenaRangedTrait.TraitDependencyTextOverrides = TraitData.AthenaRangedTrait.TraitDependencyTextOverrides or { }
    TraitData.AthenaRangedTrait.TraitDependencyTextOverrides.SpearWeaveTrait =
    {
        Name = "SpearLoadAthenaRangedTrait",
        CustomTrayText = "SpearLoadAthenaRangedTrait_Tray"
    }

    table.insert(TraitData.AthenaRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DetonateGraphic",
        ChangeType = "Absolute",
        ChangeValue = "RadialNovaSwordParry-Athena"
    })

    table.insert(TraitData.AthenaRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        WeaponProperty = "FireFx",
        ChangeType = "Absolute",
        ChangeValue = "null"
    })

    table.insert(TraitData.AthenaRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DamageRadius",
        ChangeValue = 350
    })

    table.insert(TraitData.AthenaRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DamageLow",
        BaseMin = 35,
        BaseMax = 35,
        IdenticalMultiplier = { Value = -0.4 },
        DeriveSource = "AthenaDamageLow",
        ExtractValue = { ExtractAs = "TooltipSpearLoadDamage" }
    })

    table.insert(TraitData.AthenaRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DamageHigh",
        DeriveValueFrom = "AthenaDamageLow"
    })

    table.insert(TraitData.AthenaRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisable",
        EffectProperty = "Active",
        ChangeValue = false
    })

    table.insert(TraitData.AthenaRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisableCancelable",
        EffectProperty = "Active",
        ChangeValue = false
    })

    table.insert(TraitData.AthenaRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisableCancelableFast",
        EffectProperty = "Active",
        ChangeValue = false
    })

    TraitData.ArtemisRangedTrait.TraitDependencyTextOverrides = TraitData.ArtemisRangedTrait.TraitDependencyTextOverrides or { }
    TraitData.ArtemisRangedTrait.TraitDependencyTextOverrides.SpearWeaveTrait =
    {
        Name = "SpearLoadArtemisRangedTrait",
        CustomTrayText = "SpearLoadArtemisRangedTrait_Tray"
    }

    table.insert(TraitData.ArtemisRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DetonateGraphic",
        ChangeType = "Absolute",
        ChangeValue = "RadialNovaSwordParry-Artemis"
    })

    table.insert(TraitData.ArtemisRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        WeaponProperty = "FireFx",
        ChangeType = "Absolute",
        ChangeValue = "null"
    })

    table.insert(TraitData.ArtemisRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DamageLow",
        BaseMin = 100,
        BaseMax = 100,
        IdenticalMultiplier = { Value = -0.4 },
        DeriveSource = "ArtemisDamageLow",
        ExtractValue = { ExtractAs = "TooltipSpearLoadDamage" }
    })

    table.insert(TraitData.ArtemisRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DamageHigh",
        DeriveValueFrom = "ArtemisDamageLow"
    })

    table.insert(TraitData.ArtemisRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DamageRadius",
        ChangeValue = 180
    })

    table.insert(TraitData.ArtemisRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisable",
        EffectProperty = "Active",
        ChangeValue = false
    })

    table.insert(TraitData.ArtemisRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisableCancelable",
        EffectProperty = "Active",
        ChangeValue = false
    })

    table.insert(TraitData.ArtemisRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisableCancelableFast",
        EffectProperty = "Active",
        ChangeValue = false
    })

    TraitData.DionysusRangedTrait.TraitDependencyTextOverrides = TraitData.DionysusRangedTrait.TraitDependencyTextOverrides or { }
    TraitData.DionysusRangedTrait.TraitDependencyTextOverrides.SpearWeaveTrait =
    {
        Name = "SpearLoadDionysusRangedTrait",
        CustomTrayText = "SpearLoadDionysusRangedTrait_Tray"
    }

    table.insert(TraitData.DionysusRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "Type",
        ChangeValue = "INSTANT"
    })

    table.insert(TraitData.DionysusRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileName = "DionysusField",
        ProjectileProperty = "TotalFuse",
        ChangeValue = 2
    })

    table.insert(TraitData.DionysusRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DamageRadius",
        ChangeValue = 250
    })

    table.insert(TraitData.DionysusRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileName = "DionysusLobProjectile",
        ProjectileProperty = "DamageLow",
        BaseMin = 165,
        BaseMax = 165,
        IdenticalMultiplier = { Value = -0.4 },
        DeriveSource = "DionysusDamageLow",
        ExtractValue = { ExtractAs = "TooltipSpearLoadDamage" }
    })

    table.insert(TraitData.DionysusRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileName = "DionysusLobProjectile",
        ProjectileProperty = "DamageHigh",
        DeriveValueFrom = "DionysusDamageLow"
    })

    table.insert(TraitData.DionysusRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisable",
        EffectProperty = "Active",
        ChangeValue = false
    })

    table.insert(TraitData.DionysusRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisableCancelable",
        EffectProperty = "Active",
        ChangeValue = false
    })

    table.insert(TraitData.DionysusRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisableCancelableFast",
        EffectProperty = "Active",
        ChangeValue = false
    })

    TraitData.DemeterRangedTrait.TraitDependencyTextOverrides = TraitData.DemeterRangedTrait.TraitDependencyTextOverrides or { }
    TraitData.DemeterRangedTrait.TraitDependencyTextOverrides.SpearWeaveTrait =
    {
        Name = "SpearLoadDemeterRangedTrait",
        CustomTrayText = "SpearLoadDemeterRangedTrait_Tray"
    }

    table.insert(TraitData.DemeterRangedTrait.ExtractValues,
    {
        ExtractAs = "TooltipChillDuration",
        SkipAutoExtract = true,
        External = true,
        BaseType = "Effect",
        WeaponName = "SwordWeapon",
        BaseName = "DemeterSlow",
        BaseProperty = "Duration",
    })

    table.insert(TraitData.DemeterRangedTrait.ExtractValues,
    {
        ExtractAs = "TooltipChillPower",
        SkipAutoExtract = true,
        External = true,
        BaseType = "Effect",
        WeaponName = "SwordWeapon",
        BaseName = "DemeterSlow",
        BaseProperty = "ElapsedTimeMultiplier",
        Format = "NegativePercentDelta"
    })

    table.insert(TraitData.DemeterRangedTrait.ExtractValues,
    {
        ExtractAs = "TooltipChillStacks",
        SkipAutoExtract = true,
        External = true,
        BaseType = "Effect",
        WeaponName = "SwordWeapon",
        BaseName = "DemeterSlow",
        BaseProperty = "MaxStacks",
    })

    table.insert(TraitData.DemeterRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DetonateGraphic",
        ChangeType = "Absolute",
        ChangeValue = "RadialNovaSwordParry-Demeter"
    })

    table.insert(TraitData.DemeterRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        WeaponProperty = "FireFx",
        ChangeType = "Absolute",
        ChangeValue = "null"
    })

    table.insert(TraitData.DemeterRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "Graphic",
        ChangeType = "Absolute",
        ChangeValue = "null"
    })

    table.insert(TraitData.DemeterRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DamageLow",
        BaseMin = 30,
        BaseMax = 30,
        IdenticalMultiplier = { Value = -0.8 },
        DeriveSource = "DemeterDamageLow",
        ExtractValue = { ExtractAs = "TooltipSpearLoadDamage" }
    })

    table.insert(TraitData.DemeterRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DamageHigh",
        DeriveValueFrom = "DemeterDamageLow"
    })

    table.insert(TraitData.DemeterRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "MultiDetonate",
        ChangeValue = false
    })

    table.insert(TraitData.DemeterRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "DemeterSlow",
        EffectProperty = "Active",
        ChangeValue = true
    })

    table.insert(TraitData.DemeterRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisable",
        EffectProperty = "Active",
        ChangeValue = false
    })

    table.insert(TraitData.DemeterRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisableCancelable",
        EffectProperty = "Active",
        ChangeValue = false
    })

    table.insert(TraitData.DemeterRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisableCancelableFast",
        EffectProperty = "Active",
        ChangeValue = false
    })

    TraitData.PoseidonRangedTrait.TraitDependencyTextOverrides = TraitData.PoseidonRangedTrait.TraitDependencyTextOverrides or { }
    TraitData.PoseidonRangedTrait.TraitDependencyTextOverrides.SpearWeaveTrait =
    {
        Name = "SpearLoadPoseidonRangedTrait",
        CustomTrayText = "SpearLoadPoseidonRangedTrait_Tray"
    }

    table.insert(TraitData.PoseidonRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DetonateGraphic",
        ChangeType = "Absolute",
        ChangeValue = "RadialNovaSwordParry-Poseidon"
    })

    table.insert(TraitData.PoseidonRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        WeaponProperty = "FireFx",
        ChangeType = "Absolute",
        ChangeValue = "null"
    })

    table.insert(TraitData.PoseidonRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        ProjectileProperty = "ImpactVelocity",
        ChangeType = "Multiply",
        ChangeValue = 0.6
    })

    table.insert(TraitData.PoseidonRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DamageLow",
        BaseMin = 25,
        BaseMax = 25,
        IdenticalMultiplier = { Value = -0.4 },
        DeriveSource = "PoseidonDamageLow",
        ExtractValue = { ExtractAs = "TooltipSpearLoadDamage" }
    })

    table.insert(TraitData.PoseidonRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DamageHigh",
        DeriveValueFrom = "PoseidonDamageLow",
    })

    table.insert(TraitData.PoseidonRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisable",
        EffectProperty = "Active",
        ChangeValue = false
    })

    table.insert(TraitData.PoseidonRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisableCancelable",
        EffectProperty = "Active",
        ChangeValue = false
    })

    table.insert(TraitData.PoseidonRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisableCancelableFast",
        EffectProperty = "Active",
        ChangeValue = false
    })

    TraitData.ZeusRangedTrait.TraitDependencyTextOverrides = TraitData.ZeusRangedTrait.TraitDependencyTextOverrides or { }
    TraitData.ZeusRangedTrait.TraitDependencyTextOverrides.SpearWeaveTrait =
    {
        Name = "SpearLoadZeusRangedTrait",
        CustomTrayText = "SpearLoadZeusRangedTrait_Tray"
    }

    table.insert(TraitData.ZeusRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "Type",
        ChangeValue = "INSTANT"
    })

    table.insert(TraitData.ZeusRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DamageRadius",
        ChangeValue = 200
    })

    table.insert(TraitData.ZeusRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DetonateGraphic",
        ChangeType = "Absolute",
        ChangeValue = "RadialNovaSwordParry-Zeus"
    })

    table.insert(TraitData.ZeusRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        WeaponProperty = "FireFx",
        ChangeType = "Absolute",
        ChangeValue = "null"
    })

    table.insert(TraitData.ZeusRangedTrait.PropertyChanges, 
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "ImpactFx",
        ChangeType = "Absolute",
        ChangeValue = "null"
    })

    table.insert(TraitData.ZeusRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DamageLow",
        BaseMin = 55,
        BaseMax = 55,
        IdenticalMultiplier = { Value = -0.6 },
        DeriveSource = "ZeusDamageLow",
        ExtractValue = { ExtractAs = "TooltipSpearLoadDamage" }
    })

    table.insert(TraitData.ZeusRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DamageHigh",
        DeriveValueFrom = "ZeusDamageLow"
    })

    table.insert(TraitData.ZeusRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisable",
        EffectProperty = "Active",
        ChangeValue = false
    })

    table.insert(TraitData.ZeusRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisableCancelable",
        EffectProperty = "Active",
        ChangeValue = false
    })

    table.insert(TraitData.ZeusRangedTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponName = "RangedWeapon",
        EffectName = "RangedDisableCancelableFast",
        EffectProperty = "Active",
        ChangeValue = false
    })

    table.insert(TraitData.AphroditeRangedBonusTrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DamageRadius",
        ChangeValue = 1.3,
        ChangeType = "Multiply"
    })

    for god, godLoot in pairs(LootData) do
        if godLoot.LinkedUpgrades then
            for upgrade, linkedData in pairs(godLoot.LinkedUpgrades) do
                local toCheck = { }

                if linkedData.OneOf then
                    table.insert(toCheck, "OneOf")
                end

                if linkedData.OneFromEachSet then
                    table.insert(toCheck, "OneFromEachSet")
                end

                for _, check in ipairs(toCheck) do
                    for i, linkData in ipairs(linkedData[check]) do
                        if type(linkData) == "string" and string.find(linkData, "ShieldLoadAmmo_") == 1 then
                            linkedData[check][i] = { { TraitName = "ShieldLoadAmmoTrait", DisplayIcon = true, IgnoreForSameGod = true }, { TraitName = linkData } }
                        end
                    end
                end
            end
        end
    end

    table.insert(LootData.ZeusUpgrade.LinkedUpgrades.ZeusBoltAoETrait.OneOf,
    {
        { TraitName = "SpearWeaveTrait", DisplayIcon = true, IgnoreForSameGod = true },
        { TraitName = "ZeusRangedTrait", BoonInfoRequirementText = "SpearLoadZeusRangedTrait" }
    })
    
    table.insert(TraitData.ZeusBoltAoETrait.PropertyChanges,
    {
        TraitName = "SpearWeaveTrait",
        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
        ProjectileProperty = "DamageRadius",
        BaseValue = 1.6,
        ChangeType = "Multiply",
        SourceIsMultiplier = true
    })

    -- support multiple trait checks at once
    ModUtil.WrapBaseFunction("HeroHasTrait", function(baseFunc, traitName)
        if type(traitName) == "table" then
            for i, traitTable in ipairs(traitName) do
                if not HeroHasTrait(traitTable.TraitName) then
                    return false
                end
            end
            return true
        else
            return baseFunc(traitName)
        end
    end, mo)

    ModUtil.WrapBaseFunction("CheckSpearTeleportBuffer", function(baseFunc)
        if HeroHasTrait("SpearTeleportTrait") then
            Destroy({ Ids = GetIdsByType({ Name = "SpearReturnPointAlt01" }) })
        end
        baseFunc()
    end, mo)

    ModUtil.WrapBaseFunction("CheckAmmoDrop", function(baseFunc, currentRun, targetId, ammoDropData, numDrops)
        if not HeroHasTrait("SpearWeaveTrait") then
            baseFunc(currentRun, targetId, ammoDropData, numDrops)
        end
    end, mo)

    ModUtil.WrapBaseFunction("ReloadRangedAmmo", function(baseFunc, delay, activateAnyway)
        if not IsMetaUpgradeActive("ReloadAmmoMetaUpgrade") or not HeroHasTrait("SpearWeaveTrait") or activateAnyway then
            baseFunc(delay)
            if IsMetaUpgradeActive("ReloadAmmoMetaUpgrade") and HeroHasTrait("DislodgeAmmoTrait") then 
                AddLimitedHeroBonus({ BonusName = "DislodgeAmmoTraitBuff", PropertyName = "DamageOutputMultiplier", Value = GetTotalHeroTraitValue("DislodgeAmmoBonusDamage", { IsMultiplier = true }) - 1, Duration = 6, Animation = "ErisPowerUpFx" })
            end
        end
    end, mo)

    ModUtil.WrapBaseFunction("StartAmmoReloadPresentation", function(baseFunc, delay, activateAnyway)
        if not IsMetaUpgradeActive("ReloadAmmoMetaUpgrade") or not HeroHasTrait("SpearWeaveTrait") or activateAnyway then
            baseFunc(delay)
        end
    end, mo)

    ModUtil.WrapBaseFunction("GetWeaponData", function(baseFunc, unit, weaponName)
        local ret = baseFunc(unit, weaponName)
        if weaponName == "RangedWeapon" and HeroHasTrait("SpearWeaveTrait") then
            ret = DeepCopyTable(ret)
            ret.StoreAmmoOnHit = nil
        end
        return ret
    end, mo)

    ModUtil.WrapBaseFunction("SetupHeroObject", function(baseFunc, currentRun, applyLuaUpgrades)
        baseFunc(currentRun, applyLuaUpgrades)
        currentRun.Hero.LimitedBonuses = { }
        for _, traitName in ipairs(reload) do
            UpdateHeroTrait(traitName)
        end
    end, mo)

    ModUtil.WrapBaseFunction("AddTraitToHero", function(baseFunc, args)
        baseFunc(args)
        for _, traitName in ipairs(reload) do
            if HeroHasTrait(traitName) and (not args.NoUpdateTrait or not args.NoUpdateTrait == traitName) then
                UpdateHeroTrait(traitName)
            end
        end
    end, mo)

    ModUtil.WrapBaseFunction("UpdateAmmoUI", function(baseFunc, triggerArgs)
        if shouldUpdateAmmoUI then
            baseFunc(triggerArgs)
        end
    end, mo)

    local shouldReplaceTraitName = false
    local function WrapTextBoxFunction(baseFunc, args)
        args = args or { }
        if shouldReplaceTraitName and type(args.LuaValue) == "table" and args.LuaValue.Name and string.find(args.Text, args.LuaValue.Name) then
            local temp = args.LuaValue.Name
            local suffix = ""

            local suffixes = { "_Delta", "_Initial", "_Tray" }
            for _, testSuffix in ipairs(suffixes) do
                if string.find(args.Text, testSuffix) then
                    suffix = testSuffix
                end
            end

            if TraitData[temp] and TraitData[temp].CustomName then
                if HasDisplayName({ Text = TraitData[temp].CustomName .. suffix }) then
                    args.Text = TraitData[temp].CustomName .. suffix
                elseif HasDisplayName({ Text = TraitData[temp].CustomName }) then
                    args.Text = TraitData[temp].CustomName
                end
            end
        end
        baseFunc(args)
    end

    ModUtil.WrapBaseFunction("CreateTextBox", WrapTextBoxFunction, mo)
    ModUtil.WrapBaseFunction("ModifyTextBox", WrapTextBoxFunction, mo)

    ModUtil.WrapBaseFunction("ShowWeaponUpgradeScreen", function(baseFunc, args)
        shouldReplaceTraitName = true
        baseFunc(args)
    end, mo)

    ModUtil.WrapBaseFunction("CloseWeaponUpgradeScreen", function(baseFunc, args)
        baseFunc(args)
        shouldReplaceTraitName = false
    end, mo)

    -- hack to avoid incorrect pom scaling on ranged traits for SpearWeaveAspect
    ModUtil.WrapBaseFunction("GetProcessedValue", function(baseFunc, valueToRamp, args)
        if type(valueToRamp) == "table" and valueToRamp.WithoutTraitName and HeroHasTrait(valueToRamp.WithoutTraitName) then
            valueToRamp.ChangeType = "Add"
            return 0
        else
            return baseFunc(valueToRamp, args)
        end
    end, mo)

    ModUtil.BaseOverride("CreateTraitRequirementList", function(screen, headerTextArgs, traitList, startY, metRequirement)
        local startX = 0
        local originalY = startY
        local requirementsText = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray" })
        local headerText = headerTextArgs.Text
        if TableLength(traitList) == 1 and headerTextArgs.TextSingular then
            headerText = headerTextArgs.TextSingular
        end
        table.insert(screen.TraitRequirements, requirementsText.Id )
        Attach({ Id = requirementsText.Id, DestinationId = screen.Components.ShopBackground.Id, OffsetX = startX , OffsetY = -405 })
        
        local removeIndexes = {}
        for traitName in pairs (screen.HiddenTraits) do
            for i, requirementTraitName in pairs( traitList ) do
    
                if TraitData[requirementTraitName].RequiredTrait == traitName then
                    table.insert(removeIndexes, i)
                end
            end
        end
    
        for _, index in pairs(removeIndexes) do
            traitList[index] = nil
        end
    
        traitList = CollapseTable(traitList)
        
        if metRequirement == nil then
            for i, traitName in pairs( traitList ) do
                if HeroHasTrait( traitName ) then
                    metRequirement = true
                end
            end
        end
    
        local color = Color.White
        if metRequirement then
            color = Color.BoonInfoAcquired
        end
    
        CreateTextBox({
        Id = requirementsText.Id,
        Text = headerText,
        FontSize = 24,
        OffsetX = 205,
        OffsetY =  startY,
        Color = color,
        Font = "AlegreyaSansSCRegular",
        ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
        Justification = "Left"})
        startY = startY + 35
        local sharedGod = nil
        local allSame = true

        for i, traitName in ipairs(traitList) do
            if type(traitName) == "table" then
                local displayedTraitNames = { }
                local displayIcons = { }
                local acquired = true
                
                for i, traitTable in ipairs(traitName) do
                    if traitTable.TraitName then
                        if not traitTable.IgnoreForSameGod then
                            if not sharedGod then
                                sharedGod = GetLootSourceName(traitTable.TraitName)
                            elseif sharedGod ~= GetLootSourceName(traitTable.TraitName) then
                                allSame = false
                            end
                        end

                        if traitTable.BoonInfoRequirementText then
                            table.insert(displayedTraitNames, traitTable.BoonInfoRequirementText)
                        elseif TraitData[traitTable.TraitName].BoonInfoRequirementText then
                            table.insert(displayedTraitNames, TraitData[traitTable.TraitName].BoonInfoRequirementText)
                        else
                            table.insert(displayedTraitNames, traitTable.TraitName)
                        end

                        if traitTable.DisplayIcon and TraitData[traitTable.TraitName].Icon then
                            displayIcons[i] = TraitData[traitTable.TraitName].Icon
                        end

                        if not HeroHasTrait(traitTable.TraitName) then
                            acquired = false
                        end
                    end
                end

                do
                    local traitNamePlate = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray" })
                    table.insert(screen.TraitRequirements, traitNamePlate.Id)
                    Attach({ Id = traitNamePlate.Id, DestinationId = screen.Components.ShopBackground.Id, OffsetX = startX, OffsetY = -405 })

                    CreateTextBox(
                    {
                        Id = traitNamePlate.Id,
                        Text = "BoonInfo_AllOfTheFollowing",
                        FontSize = 20,
                        OffsetX = 220,
                        OffsetY = startY,
                        Color = acquired and Color.BoonInfoAcquired or Color.BoonInfoUnacquired,
                        Font = "AlegreyaSansSCMedium",
                        ShadowBlur = 0, ShadowColor = { 0, 0, 0, 1 }, ShadowOffset = { 0, 2 },
                        Justification = "Left"
                    })

                    startY = startY + BoonInfoScreenData.RequirementsYSpacer
                end

                for i, displayedTraitName in ipairs(displayedTraitNames) do
                    local traitNamePlate = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray" })
                    table.insert(screen.TraitRequirements, traitNamePlate.Id)
                    Attach({ Id = traitNamePlate.Id, DestinationId = screen.Components.ShopBackground.Id, OffsetX = startX, OffsetY = -405 })

                    local color = HeroHasTrait(traitName[i].TraitName) and Color.BoonInfoAcquired or Color.BoonInfoUnacquired

                    local offsetX = 250
                    local textName = "BoonInfo_BulletPoint"

                    if displayIcons[i] then
                        SetAnimation({ DestinationId = traitNamePlate.Id, Name = displayIcons[i] .. "_Large", Group = "Combat_Menu_TraitTray", Scale = 0.15, OffsetX = offsetX + 5, OffsetY = startY })
                        offsetX = offsetX + 15
                        textName = "BoonInfo_NoBulletPoint"
                    end

                    CreateTextBox(
                    {
                        Id = traitNamePlate.Id,
                        Text = textName,
                        FontSize = 20,
                        OffsetX = offsetX,
                        OffsetY = startY,
                        Color = color,
                        Font = "AlegreyaSansSCMedium",
                        ShadowBlur = 0, ShadowColor = { 0, 0, 0, 1 }, ShadowOffset = { 0, 2 },
                        Justification = "Left",
                        LuaKey = "TempTextData",
                        LuaValue = { TraitName = displayedTraitName }
                    })

                    startY = startY + BoonInfoScreenData.RequirementsYSpacer
                end
            else
                if not sharedGod then
                    sharedGod = GetLootSourceName( traitName )
                elseif sharedGod ~= GetLootSourceName(traitName) then
                    allSame = false
                end
                local displayedTraitName = traitName
                if TraitData[traitName].BoonInfoRequirementText then
                    displayedTraitName = TraitData[traitName].BoonInfoRequirementText 
                end
                local traitNamePlate = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray" })
                table.insert(screen.TraitRequirements, traitNamePlate.Id )
                Attach({ Id = traitNamePlate.Id, DestinationId = screen.Components.ShopBackground.Id, OffsetX = startX , OffsetY = -405 })
                
                local color = Color.BoonInfoUnacquired
                if HeroHasTrait(traitName) then
                    color = Color.BoonInfoAcquired
                end
        
                CreateTextBox({
                Id = traitNamePlate.Id,
                Text = "BoonInfo_BulletPoint",
                FontSize = 20,
                OffsetX = 220,
                OffsetY =  startY,
                Color = color,
                Font = "AlegreyaSansSCMedium",
                ShadowBlur = 0, ShadowColor = {0,0,0,1}, ShadowOffset={0, 2},
                Justification = "Left",
                LuaKey = "TempTextData",
                LuaValue = { TraitName = displayedTraitName }})
                startY = startY + BoonInfoScreenData.RequirementsYSpacer
            end
        end
        if allSame and sharedGod and LootData[sharedGod].BoonInfoIcon then
            local godPlate = CreateScreenComponent({ Name = "BlankObstacle", Group = "Combat_Menu_TraitTray" })
            SetAnimation({ Name = LootData[sharedGod].BoonInfoIcon, DestinationId = godPlate.Id })
            SetScale({ Id = godPlate.Id, Fraction = 0.33 })
            table.insert(screen.TraitRequirements, godPlate.Id )
            Attach({ Id = godPlate.Id, DestinationId = screen.Components.ShopBackground.Id, OffsetX = startX + 185, OffsetY = originalY - 405 })
            if (startY - originalY ) < 100 then
                startY = originalY + 100
            end
    
            Move({ Id = requirementsText.Id, OffsetX = 100, Duration = 0 })
    
        end
    
        startY = startY + 35
        return startY
    end, mo)

	for lootName, lootData in pairs(LootData) do
		lootData.Name = lootName
		ProcessDataInheritance(lootData, LootData)
		lootData.UseText = lootData.UseText or "UseRoomLoot"
		lootData.MythmakeUseText = lootData.MythmakeUseText or "UseRoomLoot_MythmakeAvailable"
		if lootData.PropertyChanges ~= nil then
			for k, propertyChange in pairs(lootData.PropertyChanges) do
				AddFormattedPercentageChangeValues(propertyChange)
			end
		end

		local traitDictionary = { }
		BoonInfoScreenData.TraitDictionary[lootName] = { }
		if lootData.WeaponUpgrades ~= nil then
			for i, traitName in pairs(lootData.WeaponUpgrades) do
				traitDictionary[traitName] = true
				BoonInfoScreenData.TraitDictionary[lootName][traitName] = true
			end
		end
		if lootData.Traits ~= nil then
			for i, traitName in pairs(lootData.Traits) do
				traitDictionary[traitName] = true
				BoonInfoScreenData.TraitDictionary[lootName][traitName] = true
			end
		end
		if lootData.PermanentTraits ~= nil then
			for i, traitName in pairs(lootData.PermanentTraits) do
				traitDictionary[traitName] = true
				BoonInfoScreenData.TraitDictionary[lootName][traitName] = true
			end
		end
		if lootData.TemporaryTraits ~= nil then
			for i, traitName in pairs(lootData.TemporaryTraits) do
				traitDictionary[traitName] = true
				BoonInfoScreenData.TraitDictionary[lootName][traitName] = true
			end
		end
		if lootData.LinkedUpgrades ~= nil then
			for traitName, linkedData in pairs(lootData.LinkedUpgrades) do
				traitDictionary[traitName] = true
				BoonInfoScreenData.TraitDictionary[lootName][traitName] = true
				-- Process type of link
				BoonInfoScreenData.TraitRequirementsDictionary[traitName] = DeepCopyTable(linkedData)
				if linkedData.OneOf then
					BoonInfoScreenData.TraitRequirementsDictionary[traitName].Type = "OneOf"
				elseif linkedData.OneFromEachSet then
					BoonInfoScreenData.TraitRequirementsDictionary[traitName].Type = "OneFromEachSet"
					if TableLength(linkedData.OneFromEachSet) == 3 and #(linkedData.OneFromEachSet[1]) == #(linkedData.OneFromEachSet[2]) and #(linkedData.OneFromEachSet[2]) == #(linkedData.OneFromEachSet[3]) then
						BoonInfoScreenData.TraitRequirementsDictionary[traitName].Type = "TwoOf"
					end
				end
			end
		end
		if lootData.Consumables ~= nil then
			for i, consumableName in pairs( lootData.Consumables ) do 
				BoonInfoScreenData.TraitDictionary[lootName][consumableName] = true
			end
		end
		lootData.TraitIndex = traitDictionary
		ProcessTextLines(lootData.DuoPickupTextLineSets)
		ProcessTextLines(lootData.SuperPriorityPickupTextLineSets)
		ProcessTextLines(lootData.PriorityPickupTextLineSets)
		ProcessTextLines(lootData.PickupTextLineSets)
		ProcessTextLines(lootData.RejectionTextLines)
		ProcessTextLines(lootData.MakeUpTextLines)
		ProcessTextLines(lootData.BoughtTextLines)
		ProcessTextLines(lootData.GiftTextLineSets)
	end
end)

--[[
CritAddition -> Bonus Crit Chance
CritMultiplierAddition -> Bonus Crit Damage
DamageOutputMultiplier -> Bonus Damage
]]--

OnWeaponFired{ "SwordParry",
    function(triggerArgs)
        if HeroHasTrait("SwordCriticalParryTrait") then
            AddLimitedHeroBonus({ BonusName = "SwordPostParryCritical", PropertyName = "CritAddition", Value = GetTotalHeroTraitValue("SwordPostParryCriticalGlobalAmount"), EffectName = "SwordPostParryCritical" })
        end
    end
}

function AddDislodgeAmmoTraitBuff(item)
    if HeroHasTrait("DislodgeAmmoTrait") then
        AddLimitedHeroBonus({ BonusName = "DislodgeAmmoTraitBuff", PropertyName = "DamageOutputMultiplier", Value = GetTotalHeroTraitValue("DislodgeAmmoBonusDamage", { IsMultiplier = true }) - 1, Duration = 6, Animation = "ErisPowerUpFx" })
    end
end

local rush = false
local mostRecentSpearReturnLocation = nil

function SpearTeleportFlash()
    local delay = GetWeaponDataValue({ WeaponName = "SpearWeaponThrow", Id = CurrentRun.Hero.ObjectId, Property = "MinChargeToFire" }) / 2.5 or 0.12

    rush = true

    local notifyName = "SpearTeleportNotifyName"
    NotifyOnWeaponCharge({ Id = CurrentRun.Hero.ObjectId, Notify = notifyName, WeaponName = "SpearWeaponThrow", ChargeFraction = 0, Comparison = "<=", Timeout = delay })
    waitUntil(notifyName)

    Flash({ Id = CurrentRun.Hero.ObjectId, Speed = 4, MinFraction = 0.5, MaxFraction = 0.6, Color = Color.White, Duration = 0.3 })
    rush = false
end

OnSpawn{ "SpearReturnPointAlt01 SpearReturnPointAlt02",
    function(triggerArgs)
        if HeroHasTrait("SpearTeleportTrait") then
            SetInteractProperty({ DestinationId = triggerArgs.triggeredById, Property = "AutoActivate", Value = false })
            mostRecentSpearReturnId = triggerArgs.triggeredById
        end

        if HeroHasTrait("SpearWeaveTrait") then
            mostRecentSpearReturnLocation = GetLocation({ Id = triggerArgs.triggeredById })
        end
    end
}

OnWeaponFired{ "SpearRushWeapon",
    function(triggerArgs)
        if HeroHasTrait("SpearTeleportTrait") then
            local rushLocation = GetLocation({ Id = CurrentRun.Hero.ObjectId })
            SpawnObstacle({ Name = "SpearReturnPointAlt01", LocationX = rushLocation.X, LocationY = rushLocation.Y })
        end
    end
}

OnWeaponChargeCanceled{ "SpearWeaponThrow",
    function(triggerArgs)
        if rush and HeroHasTrait("SpearTeleportTrait") and not ProjectileExists({ Names = { "SpearWeaponThrow" }}) then
            local ids = GetIdsByType({ Name = "SpearReturnPointAlt01" })
            if TableLength(ids) > 0 then
                local tempFireToObstacle = GetWeaponProperty({ WeaponName = "SpearRushWeapon", Id = CurrentRun.Hero.ObjectId, Property = "FireToObstacle" }) or "SpearReturnPointAlt01"
                local tempSetCompleteAngleOnFire = GetWeaponProperty({ WeaponName = "SpearRushWeapon", Id = CurrentRun.Hero.ObjectId, Property = "SetCompleteAngleOnFire" }) or true
                AngleTowardTarget({ Id = CurrentRun.Hero.ObjectId, DestinationId = ids[1], CompleteAngle = true })
                SetWeaponProperty({ WeaponName = "SpearRushWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "FireToObstacle", Value = "null" })
                SetWeaponProperty({ WeaponName = "SpearRushWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "SetCompleteAngleOnFire", Value = false })
                FireWeaponFromUnit({ Weapon = "SpearRushWeapon", Id = CurrentRun.Hero.ObjectId, DestinationId = ids[1] })
                SetWeaponProperty({ WeaponName = "SpearRushWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "FireToObstacle", Value = tempFireToObstacle })
                SetWeaponProperty({ WeaponName = "SpearRushWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "SetCompleteAngleOnFire", Value = tempSetCompleteAngleOnFire })
                Destroy{ Id = ids[1] }
            else
                FireWeaponFromUnit({ Weapon = "SpearRushWeapon", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
            end
        end
    end
}

local function SpearShrinkOverTime(id, initialDelay, waitTime, ticks)
    local initial = 1
    local scale = initial
    SetScale({ Id = id, Fraction = scale })
    wait(initialDelay)
    while scale > 0 do
        SetScale({ Id = id, Fraction = scale })
        scale = scale - initial / ticks
        wait(waitTime)
    end

    Destroy({ Id = id })
    wait(0.01)

    if not IsMetaUpgradeActive("ReloadAmmoMetaUpgrade") then
        local maxAmmo = GetWeaponDataValue({ WeaponName = "RangedWeapon", Id = CurrentRun.Hero.ObjectId, Property = "MaxAmmo" }) or 1
        local unfiltered = GetIdsByType({ Name = "InvisibleTarget" })
        local filtered = { }

        for i, tid in ipairs(unfiltered) do
            if GetThingDataValue({ Id = tid, Property = "Graphic" }) == "SpearReturnPointAlt02" then
                table.insert(filtered, tid)
            end
        end

        local ammoCount = maxAmmo - TableLength(filtered)

        if ScreenAnchors.SelfStoredAmmo then
            ammoCount = ammoCount - CurrentRun.Hero.LoadedAmmo
        end
        
        RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "RangedWeapon", Method = "EmptyAmmo" })
        RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "RangedWeapon", Method = "AddAmmo", Parameters = { ammoCount } })
    end
    
    thread(UpdateAmmoUI)
end

local function SpearDamageOverTime(id, waitTime, ticksBetween, timesToFire)
    local tick = 0
    local timesFired = 0
    while IdExists({ Id = id }) and (timesToFire == nil or timesFired < timesToFire) do
        local maxAmmo = GetWeaponDataValue({ WeaponName = "RangedWeapon", Id = CurrentRun.Hero.ObjectId, Property = "MaxAmmo" }) or 1
        local waited = 0

        while maxAmmo < 0 do
            maxAmmo = GetWeaponDataValue({ WeaponName = "RangedWeapon", Id = CurrentRun.Hero.ObjectId, Property = "MaxAmmo" }) or 1
            wait(0.01)
            waited = waited + 0.01
        end

        if tick == ticksBetween then
            local ammoBefore = RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "RangedWeapon", Method = "GetAmmo" })

            SetWeaponProperty({ WeaponName = "RangedWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "MaxAmmo", Value = -1 })
            SetWeaponProperty({ WeaponName = "SpearLoadAmmoApplicator", DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })

            shouldUpdateAmmoUI = false
            FireWeaponFromUnit({ Id = CurrentRun.Hero.ObjectId, DestinationId = id, Weapon = "RangedWeapon" })
            wait(0.01)
            shouldUpdateAmmoUI = true

            SetWeaponProperty({ WeaponName = "RangedWeapon", DestinationId = CurrentRun.Hero.ObjectId, Property = "MaxAmmo", Value = maxAmmo })
            SetWeaponProperty({ WeaponName = "SpearLoadAmmoApplicator", DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })

            if IsMetaUpgradeActive("ReloadAmmoMetaUpgrade") then
                RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "RangedWeapon", Method = "EmptyAmmo" })
                RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "RangedWeapon", Method = "AddAmmo", Parameters = { ammoBefore } })
            end

            tick = 0
            waited = waited + 0.01
            timesFired = timesFired + 1
        end

        if not IsMetaUpgradeActive("ReloadAmmoMetaUpgrade") then
            local unfiltered = GetIdsByType({ Name = "InvisibleTarget" })
            local filtered = { }

            for i, tid in ipairs(unfiltered) do
                if GetThingDataValue({ Id = tid, Property = "Graphic" }) == "SpearReturnPointAlt02" then
                    table.insert(filtered, tid)
                end
            end

            local ammoCount = maxAmmo - TableLength(filtered)
    
            if ScreenAnchors.SelfStoredAmmo then
                ammoCount = ammoCount - CurrentRun.Hero.LoadedAmmo
            end
            
            RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "RangedWeapon", Method = "EmptyAmmo" })
            RunWeaponMethod({ Id = CurrentRun.Hero.ObjectId, Weapon = "RangedWeapon", Method = "AddAmmo", Parameters = { ammoCount } })
        end

        thread(UpdateAmmoUI)
        
        wait(waitTime - waited)
        tick = tick + 1
    end

    thread(UpdateAmmoUI)
end

OnWeaponFired{ "SpearWeaponThrowReturn SpearWeaponThrowInvisibleReturn",
    function(triggerArgs)
        if mostRecentSpearReturnLocation and HeroHasTrait("SpearWeaveTrait") and CurrentRun.Hero.LoadedAmmo > 0 then
            SetWeaponProperty({ WeaponName = "SpearLoadAmmoApplicator", DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = false })
            local timeBetweenSpears = 0.1
            for i = 1, CurrentRun.Hero.LoadedAmmo do
                local createdID = SpawnObstacle({ Name = "InvisibleTarget", LocationX = mostRecentSpearReturnLocation.X, LocationY = mostRecentSpearReturnLocation.Y, Group = "Standing" })
                if i == 1 then
                    SetThingProperty({ DestinationId = createdID, Property = "Invisible", Value = false })
                end
                SetThingProperty({ DestinationId = createdID, Property = "Graphic", Value = "SpearReturnPointAlt02" })

                local duration = 5
                local shrinkWaitTime = 0.01
                local shrinkTicks = 40

                thread(SpearShrinkOverTime, createdID, duration + shrinkWaitTime * shrinkTicks + timeBetweenSpears * CurrentRun.Hero.LoadedAmmo, shrinkWaitTime, shrinkTicks)

                local waitTime = 0.1
                local interval = GetTotalTraitValue("SpearWeaveTrait", "SpearCastInterval")

                if interval == 0 then
                    interval = duration / 5
                end

                local speedMultiplier = GetWeaponDataValue({ WeaponName = "RangedWeapon", Id = CurrentRun.Hero.ObjectId, Property = "SpeedMultiplier" })

                if speedMultiplier > 0 then
                    interval = interval / speedMultiplier
                end

                thread(SpearDamageOverTime, createdID, waitTime, math.floor(interval / waitTime), math.floor(duration / interval))
                wait(timeBetweenSpears)

                if IsMetaUpgradeActive("ReloadAmmoMetaUpgrade") then
                    local delay = GetBaseAmmoReloadTime()
                    local ammoDivisor = GetTotalHeroTraitValue("AmmoReloadTimeDivisor")
                    if ammoDivisor == 0 then
                        ammoDivisor = 1
                    end
                    delay = delay / ammoDivisor
                    thread(ReloadRangedAmmo, delay, true)
                    StartAmmoReloadPresentation(delay, true)
                end
            end
            local ammoAnchors = ScreenAnchors.SelfStoredAmmo
            while ammoAnchors ~= nil and ammoAnchors[#ammoAnchors] ~= nil do
                Destroy({ Id = ammoAnchors[#ammoAnchors] })
                ammoAnchors[#ammoAnchors] = nil
            end
            SetWeaponProperty({ WeaponName = "SpearLoadAmmoApplicator", DestinationId = CurrentRun.Hero.ObjectId, Property = "Enabled", Value = true })
            CurrentRun.Hero.LoadedAmmo = 0
        end
    end
}

function SetupSpearAmmoLoad(unit, args)
    Destroy({ Ids = ScreenAnchors.SelfStoredAmmo })
    SwapWeapon({ Name = "RangedWeapon", SwapWeaponName = "SpearLoadAmmoApplicator", DestinationId = unit.ObjectId })
    if CurrentRun and CurrentRun.Hero then
        CurrentRun.Hero.LoadedAmmo = 0
    end
end

OnWeaponFired{ "SpearLoadAmmoApplicator",
    function(triggerArgs)
        if not HeroHasTrait("SpearWeaveTrait") or not CurrentRun.Hero or not CurrentRun.Hero.LoadedAmmo then
            return
        end

        PlaySound({ Name = "/Leftovers/SFX/HarpDash", Id = CurrentRun.Hero.ObjectId })
        thread(PlayVoiceLines, HeroVoiceLines.LoadingAmmoVoiceLines, true)

        local maxAmmo = GetWeaponDataValue({ WeaponName = "RangedWeapon", Id = CurrentRun.Hero.ObjectId, Property = "MaxAmmo" }) or 1
        while maxAmmo < 0 do
            maxAmmo = GetWeaponDataValue({ WeaponName = "RangedWeapon", Id = CurrentRun.Hero.ObjectId, Property = "MaxAmmo" }) or 1
            wait(0.01)
        end
        
        if ScreenAnchors.AmmoIndicatorUI and (not ScreenAnchors.SelfStoredAmmo or #ScreenAnchors.SelfStoredAmmo <= maxAmmo) then
            local offsetX = 380
            local offsetY = -50
            ScreenAnchors.SelfStoredAmmo = ScreenAnchors.SelfStoredAmmo or { }
            offsetX = offsetX + (#ScreenAnchors.SelfStoredAmmo * 22)
            local screenId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI", DestinationId = ScreenAnchors.HealthBack, X = 10 + offsetX, Y = ScreenHeight - 50 + offsetY })
            SetThingProperty({ DestinationId = screenId, Property = "SortMode", Value = "Id" })
            table.insert(ScreenAnchors.SelfStoredAmmo, screenId)
            SetAnimation({ DestinationId = screenId, Name = "SelfStoredAmmoIcon" })
        end

        CurrentRun.Hero.LoadedAmmo = CurrentRun.Hero.LoadedAmmo + 1

        thread(UpdateAmmoUI)
    end
}