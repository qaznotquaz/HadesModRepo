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
        CustomTrayText = "Jess_GunLittleSureshotTrait_Tray",
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
                ExcludeLinked = true
            },
            {
                WeaponNames = { "GunWeapon" },
                WeaponProperty = "FullyAutomatic",
                ChangeValue = false,
                ChangeType = "Absolute"
            },
            {
                WeaponNames = { "GunWeapon" },
                WeaponProperty = "ReloadTime",
                BaseValue = 0.0,
                ChangeType = "Absolute"
            },
            --{
            --    WeaponNames = { "GunWeapon" },
            --    WeaponProperty = "Cooldown",
            --    ChangeValue = 0.25,
            --    ChangeType = "Absolute"
            --},
            --{
            --    WeaponNames = { "GunWeapon" },
            --    WeaponProperty = "ChargeTimeFrames",
            --    ChangeValue = 4,
            --    ChangeType = "Absolute",
            --    ExcludeLinked = true
            --},

            -- GunReloadSelf faster reload --
            --{
            --    WeaponNames = { "GunReloadSelf" },
            --    EffectName = "ZagreusSelfReload",
            --    ChangeValue = "Absolute",
            --    EffectProperty = "Duration",
            --    ChangeValue = 0.0
            --},

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

            -- GunWeapon Projectile Levelling Crit Chance --
            {
                WeaponNames = { "GunWeapon" },
                ProjectileProperty = "CriticalHitChance",
                BaseValue = 0.03,
                ChangeType = "Add",
                ExtractValue = {
                    ExtractAs = "TooltipCritChance",
                    Format = "Percent",
                }
            },

            -- GunGrenadeToss Projectile 20 Damage --
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

            -- Levelling Bonus Crit Chance on Targeted Enemies / part 2 --
            {
                WeaponName = "GunCritTargetWeapon",
                EffectName = "CritVulnerability",
                EffectProperty = "CritVulnerabilityAddition",
                BaseValue = 0.10,
                ExtractValue = {
                    ExtractAs = "CritTargetVulnerability",
                    Format = "Percent",
                },
                CustomRarityMultiplier = {
                    Common = {
                        Multiplier = 1.0
                    },
                    Rare = {
                        Multiplier = 1.2
                    },
                    Epic = {
                        Multiplier = 1.4
                    },
                    Heroic = {
                        Multiplier = 1.6
                    },
                    Legendary = {
                        Multiplier = 1.8
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
end