if SwarmMissiles.config.Enabled then
    -- The gun itself --
    TraitData.GunSwarmMissileTrait = {
        Icon = "WeaponEnchantment_Gun01",
        InheritFrom = { "WeaponEnchantmentTrait" },
        RarityLevels = {
            Common = {
                Multiplier = 1.0
            },
            Rare = {
                Multiplier = 1.25
            },
            Epic = {
                Multiplier = 1.5
            },
            Heroic = {
                Multiplier = 1.75
            },
            Legendary = {
                Multiplier = 2.0
            }
        },
        CustomTrayText = "GunSwarmMissileTrait_Tray",
        SpecialMaxMissiles = {
            BaseValue = SwarmMissiles.config.MaxMissiles / 2,
        },
        ExtractValues = {
            {
                Key = "SpecialMaxMissiles",
                ExtractAs = "TooltipMaxMissile"
            }
        },

        PropertyChanges =
        {
            {
                WeaponNames = { "GunWeapon" },
                WeaponProperty = "MaxAmmo",
                BaseValue = 4,
                AsInt = true,
                ChangeType = "Add",
                ExtractValue =
                {
                    ExtractAs = "TooltipAmmo"
                }
            },
        },
    }

    --qaz: surely there's a better way to do mass property changes like this
    local weaponData = {
        --actual changes
        ProjectileAngleOffset = math.rad(247.5),
        ProjectileOffsetStart = "LEFT",
        ProjectileInterval = 0.03,
        NumProjectiles = 1,
        ReloadTime = 1.0,
        --defaults from gun/bow
        RootOwnerWhileFiring = false,
        BlockMoveInput = false,
        CancelMovement = false,
        ChargeCancelMovement = false,
        AcceptTriggerLockRequests = true,
        AuraAimLine = true,
        AllowExternalForceRelease = false,
        AutoLockArcDistance = 90,
        AutoLockRange = 900,
        AutoLockWithMouse = false,
        BarrelLength = 50,
        BelowMinChargeCooldown = 0.2,
        ChargeStartAnimation = "ZagreusGunGrenadeTossCharge",
        ClearFireRequestOnSwap = true,
        DisableOwnerForDuration = 0,
        Enabled = true,
        FireOnRelease = false,
        FullyAutomatic = false,
        LockTriggerForCharge = true,
        ManualAiming = false,
        --not sure about this??
        MinChargeToFire = 1,
        PerfectChargeWindowDuration = 0,
        ProjectileSpacing = 0,
        SelfVelocity = 0,
        --ShowFreeAimLine = false,
        TargetReticleAnimation = "null",
        Type = "GUN"
    }
    local projectileData = {
        ManuallySetTarget = false,
        Speed = 500.0,
        MaxSpeed = 6000.0,
        Range = 3000.0,
        Acceleration = 2000,
        MaxAdjustRate = math.rad(6000),
        AdjustRateAcceleration = math.rad(650),
        Fuse = 2.5,
        DamageLow = 4,
        DamageHigh = 4,
        ImpactVelocity = 0,
        DamageRadius = 230,
        DetonateGraphic = "RadialNova",
        DamageRadiusScaleY = 0.5,
        Graphic = "GunGrenadeRocket",
        AttachedAnim = "GrenadierShadow",
        DetonateSound = "/SFX/Enemy Sounds/CrusherAttackImpact",
        Type = "HOMING",
        CheckUnitImpact = true,
        CheckObstacleImpact = true,
        ObstacleCollisionCheck = "PolygonContainsPoint",
        NumPenetrations = 0,
        CriticalFx = "CriticalHit",
        HitVulnerabilityFx = "Backstab",
        UseArmor = true,
        UseVulnerability = true,
        UnpauseFx = "BowSplitShotFlare",
        UnpauseResetLocation = true,
        ProjectileDefenseRadius = 40,
        UseDetonationForProjectileDefense = false,
        DeflectProjectiles = false,
        SpawnOnDetonate = "null",
        SpawnType = "PROJECTILE",
    }

    for propertyName, propertyValue in pairs(weaponData) do
        table.insert(TraitData.GunSwarmMissileTrait.PropertyChanges,
                {
                    WeaponNames = { "GunGrenadeToss" },
                    WeaponProperty = propertyName,
                    ChangeValue = propertyValue,
                    ChangeType = "Absolute",
                    ExcludeLinked = true,
                })
    end
    for propertyName, propertyValue in pairs(projectileData) do
        table.insert(TraitData.GunSwarmMissileTrait.PropertyChanges,
                {
                    WeaponNames = { "GunGrenadeToss" },
                    ProjectileProperty = propertyName,
                    ChangeValue = propertyValue,
                    ChangeType = "Absolute",
                    ExcludeLinked = true,
                })
    end

    -- Tone down explosion graphics size --
    local gods = { "Aphrodite", "Ares", "Artemis", "Athena", "Demeter", "Dionysus", "Poseidon", "Zeus", }
    for _, trait in pairs(TraitData) do
        if (trait.Slot == "Secondary") then
            if Contains(gods, trait.God) then
                table.insert(trait.PropertyChanges,
                        {
                            TraitName = "GunSwarmMissileTrait",
                            WeaponNames = { "GunGrenadeToss" },
                            ProjectileProperty = "DetonateGraphic",
                            ChangeValue = "RadialNovaSwordParry-" .. trait.God,
                            ChangeType = "Absolute",
                            ExcludeLinked = true,
                        })
            end
        end
    end

    --athena needs to relax
    table.insert(TraitData.AthenaSecondaryTrait.PropertyChanges,
            {
                TraitName = "GunSwarmMissileTrait",
                WeaponNames = { "GunGrenadeToss" },
                ProjectileProperty = "ProjectileDefenseRadius",
                ChangeValue = 40,
                ChangeType = "Absolute",
                ExcludeLinked = true,
            })

    --zeus needs to relax (interaction with Burn Swarm)
    ModUtil.WrapBaseFunction("AddOnDamageWeapons", function(baseFunc, hero, weaponName, upgradeData)
        if upgradeData.AddOnDamageWeapons == nil then
            return
        end
        if weaponName == "GunGrenadeToss" then
            for _, onDamageWeapon in pairs(upgradeData.AddOnDamageWeapons) do
                if onDamageWeapon == "LightningStrikeSecondary" then
                    upgradeData.OnDamageWeaponProperties = { FirstHitOnly = true, FireFromVictimLocation = true }
                end
            end
        end
        return baseFunc(hero, weaponName, upgradeData)
    end, SwarmMissiles)

    -- Hammer changes --
    -- disable hammers: Hazard Bomb, Targeting System, Cluster Bomb
    local conflictingHammers = { "GunGrenadeDropTrait", "GunSlowGrenade", "GunGrenadeClusterTrait" }
    for _, hammer in pairs(conflictingHammers) do
        if TraitData[hammer].RequiredFalseTraits ~= nil then
            table.insert(TraitData[hammer].RequiredFalseTraits, "GunSwarmMissileTrait")
        else
            TraitData[hammer].RequiredFalseTraits = { "GunSwarmMissileTrait" }
        end
    end

    --modify Rocket Bomb
    table.insert(TraitData.GunExplodingSecondaryTrait.RequiredFalseTraits, "GunGrenadeGhostTrait")
    table.insert(TraitData.GunExplodingSecondaryTrait.PropertyChanges,
            {
                TraitName = "GunSwarmMissileTrait",
                WeaponName = "GunGrenadeToss",
                WeaponProperty = "ProjectileInterval",
                ChangeValue = 0,
                ChangeType = "Absolute",
            })
    table.insert(TraitData.GunExplodingSecondaryTrait.PropertyChanges,
            {
                TraitName = "GunSwarmMissileTrait",
                WeaponName = "GunGrenadeToss",
                WeaponProperty = "ProjectileAngleOffset",
                ChangeValue = math.rad(3),
                ChangeType = "Absolute",
            })

    --Ghost Swarm
    TraitData.GunGrenadeGhostTrait = {
        Name = "GunGrenadeGhostTrait",
        Frame = "Hammer",
        InheritFrom = { "WeaponTrait" },
        Icon = "Weapon_Gun_15",
        RequiredWeapon = "GunWeapon",
        RequiredTrait = "GunSwarmMissileTrait",
        RequiredFalseTraits = { "GunExplodingSecondaryTrait" },
        PropertyChanges = {
            {
                TraitName = "GunSwarmMissileTrait",
                WeaponNames = { "GunGrenadeToss" },
                ProjectileProperty = "CheckObstacleImpact",
                ChangeValue = false,
                ChangeType = "Absolute",
                ExcludeLinked = true,
            },
        },
    }

    --Circus Swarm
    TraitData.GunGrenadeCircusTrait = {
        Name = "GunGrenadeCircusTrait",
        Frame = "Hammer",
        InheritFrom = { "WeaponTrait" },
        Icon = "Weapon_Gun_10",
        RequiredWeapon = "GunWeapon",
        RequiredTrait = "GunSwarmMissileTrait",
        MissileMaxIncrease = {
            BaseValue = 1.5,
            SourceIsMultiplier = true,
        },
        MissileChargeRate = {
            BaseValue = 2.0,
            SourceIsMultiplier = true,
        },
        ExtractValues = {
            {
                Key = "MissileMaxIncrease",
                ExtractAs = "TooltipMissileMaxIncrease",
                Format = "PercentDelta",
            },
            {
                Key = "MissileChargeRate",
                ExtractAs = "TooltipMissileChargeRate",
                Format = "PercentDelta",
            },
        }
    }

    --Incendiary Swarm
    TraitData.GunGrenadeBurnTrait = {
        Name = "GunGrenadeBurnTrait",
        Frame = "Hammer",
        InheritFrom = { "WeaponTrait" },
        Icon = "Weapon_Gun_06",
        RequiredWeapon = "GunWeapon",
        RequiredTrait = "GunSwarmMissileTrait",
        PropertyChanges = {
            {
                --TraitName = "GunBaseUpgradeTrait",
                WeaponNames = { "GunGrenadeToss" },
                EffectName = "BurnDot",
                EffectProperty = "Active",
                ChangeValue = true,
                ExcludeLinked = true,
            },
            {
                WeaponName = "GunGrenadeToss",
                EffectName = "DamageOverTime",
                EffectProperty = "Amount",
                BaseMin = 1,
                BaseMax = 1,
                ChangeType = "Absolute",
                IdenticalMultiplier = {
                    -- duplicate multiplier
                    Value = -0.60,
                },
                ExtractValue = {
                    ExtractAs = "TooltipBurnDamage",
                }
            }
        },
        ExtractValues = {
            {
                ExtractAs = "TooltipBurnDuration",
                SkipAutoExtract = true,
                External = true,
                BaseType = "Effect",
                WeaponName = "GunGrenadeToss",
                BaseName = "BurnDot",
                BaseProperty = "Duration",
            },
            {
                ExtractAs = "TooltipBurnStacks",
                SkipAutoExtract = true,
                External = true,
                BaseType = "Effect",
                WeaponName = "GunGrenadeToss",
                BaseName = "BurnDot",
                BaseProperty = "MaxStacks",
            },
            {
                ExtractAs = "TooltipBurnRate",
                SkipAutoExtract = true,
                External = true,
                BaseType = "Effect",
                WeaponName = "GunGrenadeToss",
                BaseName = "BurnDot",
                BaseProperty = "Cooldown",
                DecimalPlaces = 2,
            },
        }
    }
end