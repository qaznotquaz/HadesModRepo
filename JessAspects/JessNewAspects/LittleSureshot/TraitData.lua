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

        -- Higher Crit Chance on Targeted Enemies? / part 1 --
        --[[
        AddOnFireWeapons = { "CritVulnerabilityWeapon" },
        LegalOnFireWeapons = { "GunGrenadeToss" },
        AddOnFireWeaponArgs = { UseTargetLocation = true },
        ]]--

        -- Normal Shot dislodge cast --
        DislodgeAmmoProperties = {
            ValidWeapons = { "GunWeapon" },
            ForceMin = 300,
            ForceMax = 420
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

            -- GunWeapon Weapon acts like a six-shooter
            {
                WeaponNames = { "GunWeapon" },
                WeaponProperty = "MaxAmmo",
                ChangeValue = 6,
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
                WeaponProperty = "Cooldown",
                ChangeValue = 0.5,
                ChangeType = "Absolute",
                ExcludeLinked = true
            },
            {
                WeaponNames = { "GunWeaponDash" },
                WeaponProperty = "Cooldown",
                ChangeValue = 0.2,
                ChangeType = "Absolute",
                ExcludeLinked = true
            },
            {
                WeaponNames = { "GunWeapon" },
                WeaponProperty = "ChargeTimeFrames",
                ChangeValue = 8,
                ChangeType = "Absolute",
                ExcludeLinked = true
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

            -- GunWeapon Projectile 30 Damage --
            {
                WeaponNames = { "GunWeapon" },
                ProjectileProperty = "DamageHigh",
                ChangeValue = 30,
                ChangeType = "Absolute"
            },
            {
                WeaponNames = { "GunWeapon" },
                ProjectileProperty = "DamageLow",
                ChangeValue = 30,
                ChangeType = "Absolute"
            },

            -- GunWeapon Projectile Levelling Crit Chance --
            {
                WeaponNames = { "GunWeapon" },
                ProjectileProperty = "CriticalHitChance",
                BaseValue = 0.17,
                ChangeType = "Add"
            },

            -- GunGrenadeToss Projectile 20 Damage --
            {
                WeaponNames = { "GunGrenadeToss" },
                ProjectileProperty = "DamageLow",
                ChangeValue = 20,
                ChangeType = "Absolute"
            },
            {
                WeaponNames = { "GunGrenadeToss" },
                ProjectileProperty = "DamageHigh",
                ChangeValue = 20,
                ChangeType = "Absolute"
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
                ChangeValue = 400,
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

            -- Bloodstone Graphics? --
            --[[{
                WeaponNames = { "GunWeapon" },
                ProjectileProperty = "Thing",
                ChangeType = "Absolute",
                ChangeValue = {
                    Graphic = "BloodstoneProjectile",
                    OffsetZ = 112,
                    AttachedAnim = "SlingShotShadow",
                    Grip = 999999,
                    RotateGeometry = true,
                    Tallness = 20,
                    Points = {
                        {
                            X = 76,
                            Y = 20
                        },
                        {
                            X = 76,
                            Y = -20
                        },
                        {
                            X = -32,
                            Y = -20
                        },
                        {
                            X = -32,
                            Y = 20
                        }
                    }
                }
            }
            ]]--

            -- Higher Crit Chance on Targeted Enemies? / part 2 --
            --[[
            {
                WeaponNames = { "CritVulnerabilityWeapon" },
                EffectName = "ImpactVulnerability",
                EffectProperty = "Modifier",
                ChangeValue = 0.30,
                ChangeType = "Add"
            },
            {
                WeaponNames = { "CritVulnerabilityWeapon" },
                EffectName = "ImpactVulnerability",
                EffectProperty = "Type",
                ChangeValue = 0.30,
                ChangeType = "Add"
            },
            {
                TraitName = "GunExplodingSecondaryTrait",
                WeaponName = "CritVulnerabilityWeapon",
                ProjectileProperty = "Type",
                ChangeValue = "STRAIGHT",
            },
            {
                TraitName = "GunExplodingSecondaryTrait",
                WeaponName = "CritVulnerabilityWeapon",
                ProjectileProperty = "Speed",
                ChangeValue = 2200,
                ChangeType = "Absolute",
            },
            {
                TraitName = "GunExplodingSecondaryTrait",
                WeaponName = "CritVulnerabilityWeapon",
                ProjectileProperty = "DetonateLineOfSightFromOwner",
                ChangeValue = true,
                ChangeType = "Absolute",
            },
            {
                TraitName = "GunExplodingSecondaryTrait",
                WeaponName = "CritVulnerabilityWeapon",
                ProjectileProperty = "CheckObstacleImpact",
                ChangeValue = true,
                ChangeType = "Absolute",
            },
            {
                TraitName = "GunExplodingSecondaryTrait",
                WeaponName = "CritVulnerabilityWeapon",
                ProjectileProperty = "Range",
                ChangeValue = 800,
                ChangeType = "Absolute",
            },
            {
                TraitName = "GunGrenadeDropTrait",
                WeaponName = "CritVulnerabilityWeapon",
                ProjectileProperty = "UseStartLocation",
                ChangeValue = true,
                ChangeType = "Absolute",
            },
            {
                TraitName = "GunGrenadeDropTrait",
                WeaponName = "CritVulnerabilityWeapon",
                ProjectileProperty = "UseStartLocation",
                ChangeValue = true,
                ChangeType = "Absolute",
            },
            {
                TraitName = "GunGrenadeDropTrait",
                WeaponName = "CritVulnerabilityWeapon",
                ProjectileProperty = "DamageRadius",
                ChangeValue = 1.5,
                ChangeType = "Multiply",
            }
            ]]--
        }
    }

    MimicUtil.TotalMimicWeaponAppearance(
            MimicUtil.BaseWeapons.GunHestia,
            JessAspects_LittleSureshot.Data.GunAnnie,
            TraitData.Jess_GunLittleSureshotTrait
    )
end