--[[
     ___                       _           ___    ___            _
    | . | ___ ___  ___  ___  _| |_    ___ | |    | . | _ _  _ _ [_] ___
    |   |[_-[| . \/ ._]/ | '  | |    / . \| |-   |   || ' || ' || |/ ._]
    |_|_|/__/|  _/\___.\_|_.  |_|    \___/|_|    |_|_||_|_||_|_||_|\___.
             |_|
]]

if JessAspects_LittleSureshot.Config.Enabled then
    TraitData.Jess_GunLittleSureshotTrait = {
        InheritFrom = { "WeaponEnchantmentTrait" },
        RarityLevels = {
            Common = {
                Multiplier = 1.0
            },
            Rare = {
                Multiplier = 2.0
            },
            Epic = {
                Multiplier = 3.0
            },
            Heroic = {
                Multiplier = 4.0
            },
            Legendary = {
                Multiplier = 5.0
            }
        },

        WeaponDataOverride = {
            GunWeapon = {
                ActiveReloadTime = 0.60
            }
        },

        -- Levelling Bonus Crit Chance on Targeted Enemies / part 1 --
        AddOnFireWeapons = { "GunCritTargetWeapon" },
        LegalOnFireWeapons = { "GunGrenadeToss" },
        AddOnFireWeaponArgs = { UseTargetLocation = true },

        -- Crits dislodge cast --
        CritDislodgeAmmoProperties = {
            ValidWeapons = { "GunWeapon", "GunGrenadeWeapon" },
            ForceMin = 300,
            ForceMax = 420
        },

        OnEnemyCrittedFunction = {
            Name = "CritDislodges",
            Args = nil
        },

        DroppedAmmoForceMultiplier = 5,

        PropertyChanges = {
            -- GunWeapon Weapon 0 Scatter --
            {
                WeaponNames = { "GunWeapon" },
                WeaponProperty = "Scatter",
                ChangeValue = 0,
                ChangeType = "Absolute"
            },
            {
                WeaponNames = { "GunWeapon" },
                WeaponProperty = "ScatterCap",
                ChangeValue = 0,
                ChangeType = "Absolute"
            },

            -- GunWeapon Weapon single-shot
            {
                WeaponNames = { "GunWeapon" },
                WeaponProperty = "MaxAmmo",
                ChangeValue = 1,
                ChangeType = "Absolute",
            },
            {
                WeaponNames = { "GunWeapon" },
                WeaponProperty = "FullyAutomatic",
                ChangeValue = false,
                ChangeType = "Absolute"
            },

            -- GunWeapon Projectile Faster/Farther
            {
                WeaponNames = { "GunWeapon" },
                ProjectileProperty = "Range",
                ChangeValue = 1100.0,
                ChangeType = "Absolute"
            },
            {
                WeaponNames = { "GunWeapon" },
                ProjectileProperty = "Speed",
                ChangeValue = 9000.0,
                ChangeType = "Absolute"
            },

            -- GunWeapon Projectile 25 Damage --
            {
                WeaponNames = { "GunWeapon" },
                ProjectileProperty = "DamageHigh",
                ChangeValue = 25,
                ChangeType = "Absolute",
                ExcludeLinked = true
            },
            {
                WeaponNames = { "GunWeapon" },
                ProjectileProperty = "DamageLow",
                ChangeValue = 25,
                ChangeType = "Absolute",
                ExcludeLinked = true
            },

            -- GunWeaponDash Projectile 35 Damage --
            {
                WeaponNames = { "GunWeaponDash" },
                ProjectileProperty = "DamageHigh",
                ChangeValue = 35,
                ChangeType = "Absolute",
                ExcludeLinked = true
            },
            {
                WeaponNames = { "GunWeaponDash" },
                ProjectileProperty = "DamageLow",
                ChangeValue = 35,
                ChangeType = "Absolute",
                ExcludeLinked = true
            },

            -- GunGrenadeToss Projectile 10 Damage --
            {
                WeaponNames = { "GunGrenadeToss" },
                ProjectileProperty = "DamageLow",
                ChangeValue = 10,
                ChangeType = "Absolute",
                ExcludeLinked = true
            },
            {
                WeaponNames = { "GunGrenadeToss" },
                ProjectileProperty = "DamageHigh",
                ChangeValue = 10,
                ChangeType = "Absolute",
                ExcludeLinked = true
            },

            -- GunGrenadeToss Projectile Slower --
            {
                WeaponNames = { "GunGrenadeToss" },
                ProjectileProperty = "Speed",
                ChangeValue = 400,
                ChangeType = "Absolute"
            },
            {
                WeaponNames = { "GunGrenadeToss" },
                ProjectileProperty = "Gravity",
                ChangeValue = 300,
                ChangeType = "Absolute"
            },

            -- Hestia Graphics --
            {
                WeaponNames = { "GunWeapon" },
                WeaponProperty = "FireGraphic",
                ChangeValue = "ZagreusGunAlt01Fire",
                ChangeType = "Absolute"
            },
            {
                WeaponNames = { "GunWeapon" },
                WeaponProperty = "FailedToFireCooldownAnimation",
                ChangeValue = "ZagreusGunAlt01FireEmpty",
                ChangeType = "Absolute"
            },
            {
                WeaponNames = { "GunGrenadeToss" },
                WeaponProperty = "ChargeStartAnimation",
                ChangeValue = "ZagreusGunAlt01GrenadeTossCharge",
                ChangeType = "Absolute",
                ExcludeLinked = true,
            },
            {
                WeaponNames = { "GunGrenadeToss" },
                WeaponProperty = "FireGraphic",
                ChangeValue = "ZagreusGunAlt01GrenadeTossFire",
                ChangeType = "Absolute",
                ExcludeLinked = true,
            },

            -- Yellow Crit Fx --
            {
                WeaponName = "GunWeapon",
                ProjectileProperty = "CriticalFx",
                ChangeValue = "CriticalHit_Annie"
            },

            -- Levelling Crit Chance from GunWeapon --
            {
                WeaponNames = { "GunWeapon" },
                ProjectileProperty = "CriticalHitChance",
                BaseValue = 0.03,
                ChangeType = "Add",
                ExtractValue = {
                    ExtractAs = "AspectExtract1",
                    Format = "Percent",
                }
            },

            -- Levelling Bonus Crit Chance on Targeted Enemies / part 2 --
            {
                WeaponName = "GunCritTargetWeapon",
                EffectName = "CritVulnerability",
                EffectProperty = "CritMultiplierVulnerabilityAddition",
                BaseValue = 0.08,
                ChangeType = "Add",
                ExtractValue = {
                    ExtractAs = "AspectExtract2",
                    Format = "Percent",
                },
                CustomRarityMultiplier = {
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
                    },
                },
            }
        }
    }

    MimicUtil.TotalMimicWeaponAppearance(
            MimicUtil.BaseWeapons.GunHestia,
            JessAspects_LittleSureshot.Data.GunAnnie,
            TraitData.Jess_GunLittleSureshotTrait
    )

    -- disallow Spread Fire and Flurry Fire
    MimicUtil.RequireFalse("GunShotgunTrait", "Jess_GunLittleSureshotTrait")
    MimicUtil.RequireFalse("GunMinigunTrait", "Jess_GunLittleSureshotTrait")

    -- modify Delta Chamber
    --MimicUtil.RequireFalse("GunInfiniteAmmoTrait", "Jess_GunLittleSureshotTrait")
    ModUtil.MapSetTable(TraitData.GunInfiniteAmmoTrait,
            {
                RequiredFalseTraits = {
                    "Jess_GunLittleSureshot_ShotgunTrait",
                    "Jess_GunLittleSureshot_MinigunTrait"
                },
                PropertyChanges = {
                    {
                        WeaponName = "Jess_GunLittleSureshotTrait",
                        WeaponProperty = "MaxAmmo",
                        ChangeValue = -1,
                        ChangeType = "Absolute"
                    }
                },
            })

    -- replace Spread Fire and Flurry Fire
    -- Spread Fire -> Slug Fire
    MimicUtil.CloneTrait(
            "GunShotgunTrait",
            "Jess_GunLittleSureshot_ShotgunTrait",
            {
                RequiredTrait = "Jess_GunLittleSureshotTrait",
                RequiredFalseTraits = { "Jess_GunLittleSureshot_MinigunTrait" },
                PropertyChanges = {
                    {
                        WeaponNames = { "GunWeapon", "GunWeaponDash" },
                        ProjectileProperty = "DamageLow",
                        ChangeValue = 55,
                        ChangeType = "Absolute",
                        ExcludeLinked = true,
                        ExtractValue = {
                            ExtractAs = "TooltipDamage",
                        },
                    },
                    {
                        WeaponNames = { "GunWeapon" },
                        WeaponProperty = "ChargeTimeFrames",
                        BaseValue = 10,
                        ChangeType = "Multiply",
                        ExcludeLinked = true,
                    },
                    {
                        WeaponNames = { "GunWeapon", "GunWeaponDash" },
                        ProjectileProperty = "DamageHigh",
                        DeriveValueFrom = "DamageLow",
                    },
                    {
                        WeaponNames = { "GunWeapon", "GunWeaponDash" },
                        EffectName = "OnHitStun",
                        EffectProperty = "Active",
                        ChangeValue = true,
                    },
                    {
                        WeaponNames = { "GunWeapon" },
                        ProjectileProperty = "Speed",
                        ChangeValue = 7000.0,
                        ChangeType = "Absolute"
                    },
                    {
                        WeaponNames = { "GunWeapon", "GunWeaponDash" },
                        ProjectileProperty = "ImpactVelocity",
                        ChangeType = "Add",
                        BaseMin = 300,
                        BaseMax = 300,
                        ExcludeLinked = true,
                        IgnoreRarity = true,
                    },

                    GunWeapon = {
                        Sounds = {
                            FireSounds = {
                                { Name = "/VO/ZagreusEmotes/EmoteCharging_Bow" },
                                { Name = "/SFX/Player Sounds/ZagreusGunFire" },
                                { Name = "/Leftovers/SFX/AuraPerfectThrow" },
                            },
                            ImpactSounds = {
                                Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
                                Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
                                Bone = "/SFX/ArrowMetalBoneSmash",
                                Brick = "/SFX/ArrowMetalStoneClang",
                                Stone = "/SFX/ArrowMetalStoneClang",
                                Organic = "/SFX/GunBulletOrganicImpact",
                                StoneObstacle = "/SFX/ArrowWallHitClankSmall",
                                BrickObstacle = "/SFX/ArrowWallHitClankSmall",
                                MetalObstacle = "/SFX/ArrowWallHitClankSmall",
                            },
                        }
                    },
                },
            },
            {
                RequiredWeapon = true,
                PropertyChanges = true
            }
    )

    -- todo: crit-flavored minigun
    -- Flurry Fire -> ConsecutiveCritBonus
end