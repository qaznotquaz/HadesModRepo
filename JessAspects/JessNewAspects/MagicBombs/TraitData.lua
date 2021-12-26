if JessAspects_MagicBombs.Config.Enabled then
    TraitData.Jess_GunMagicBombsTrait = {
        InheritFrom = { "WeaponEnchantmentTrait" },
        AmmoDropData =
        {
            AmmoDropForceMin = 160,
            AmmoDropForceMax = 190,
            AmmoDropUpwardForceMin = 1000,
            AmmoDropUpwardForceMax = 1030,
        },
        RequiredWeapons = { "GunWeapon", "RangedWeapon" },
        PreEquipWeapons = { "Jess_GunLoadAmmoApplicator" },
        OverrideWeaponFireNames =
        {
            RangedWeapon = "nil",
            Jess_GunLoadAmmoApplicator = "RangedWeapon",
        },
        OnProjectileDeathFunction =
        {
            Name = "Jess_BombFireClear",
            Args = {
                Interval = 0.17,
            },
        },
        SetupFunction =
        {
            Name = "Jess_SetupGunAmmoLoad",
            RunOnce = true,
        },
        PropertyChanges = {
            {
                WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                WeaponProperty = "FullyAutomatic",
                ChangeValue = true,
                ChangeType = "Absolute",
            },
            {
                WeaponName = "RangedWeapon",
                WeaponProperty = "ShowFreeAimLine",
                ChangeValue = false,
                ChangeType = "Absolute",
            },
            {
                WeaponName = "RangedWeapon",
                WeaponProperty = "IgnoreOwnerAttackDisabled",
                ChangeValue = true,
                ChangeType = "Absolute",
            },
            {
                WeaponName = "RangedWeapon",
                WeaponProperty = "ClearFireRequestOnChargeCancel",
                ChangeValue = false,
                ChangeType = "Absolute",
            },
            {
                WeaponName = "RangedWeapon",
                WeaponProperty = "Cooldown",
                ChangeValue = 0,
                ChangeType = "Absolute",
            },
            {
                WeaponName = "RangedWeapon",
                WeaponProperty = "ChargeTime",
                ChangeValue = 0,
                ChangeType = "Absolute",
            },
            {
                WeaponName = "RangedWeapon",
                WeaponProperty = "SelfVelocity",
                ChangeValue = 0,
                ChangeType = "Absolute",
            },
            {
                WeaponName = "RangedWeapon",
                WeaponProperty = "FireGraphic",
                ChangeValue = "null",
                ChangeType = "Absolute",
            },
            {
                WeaponName = "RangedWeapon",
                WeaponProperty = "AllowMultiFireRequest",
                ChangeValue = true,
                ChangeType = "Absolute",
            },
            {
                WeaponName = "RangedWeapon",
                WeaponProperty = "AllowExternalForceRelease",
                ChangeValue = false,
                ChangeType = "Absolute",
            },
            {
                WeaponName = "RangedWeapon",
                WeaponProperty = "RootOwnerWhileFiring",
                ChangeValue = false,
                ChangeType = "Absolute",
            },
            {
                WeaponName = "RangedWeapon",
                WeaponProperty = "ChargeStartAnimation",
                ChangeValue = "null",
                ChangeType = "Absolute",
            },
            {
                WeaponName = "RangedWeapon",
                WeaponProperty = "SetCompleteAngleOnFire",
                ChangeValue = false,
                ChangeType = "Absolute",
            },
            {
                WeaponName = "RangedWeapon",
                WeaponProperty = "IgnoreForceCooldown",
                ChangeValue = true,
                ChangeType = "Absolute"
            },
            {
                WeaponName = "RangedWeapon",
                EffectName = "RangedDisable",
                EffectProperty = "Active",
                ChangeValue = false,
            },
            {
                WeaponName = "RangedWeapon",
                EffectName = "RangedDisableCancelable",
                EffectProperty = "Active",
                ChangeValue = false,
            },
            {
                WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                WeaponProperty = "FireOnRelease",
                ChangeValue = false,
                ChangeType = "Absolute",
            },
            {
                WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                ProjectileProperty = "Type",
                ChangeValue = "INSTANT",
            },
            {
                WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                ProjectileProperty = "DamageRadius",
                ChangeValue = 300
            },
            {
                WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                ProjectileName = "RangedWeapon",
                ProjectileProperty = "DetonateGraphic",
                ChangeValue = "RadialNovaSwordParry"
            },
        }
    }

    MimicUtil.TotalMimicWeaponAppearance(
            MimicUtil.BaseWeapons.GunZagreus,
            JessAspects_MagicBombs.Data.GunJess,
            TraitData.Jess_GunMagicBombsTrait
    )

    TraitData.GunMagicBomb_AphroditeRangedTrait = {
        InheritFrom = { "ShopTier1Trait" },
        CustomTrayText = "ShieldLoadAmmo_AphroditeRangedTrait_Tray",
        RequiredTrait = "Jess_GunMagicBombsTrait",
        Icon = "Boon_Aphrodite_02",
        God = "Aphrodite",
        Slot = "Ranged",
        RarityLevels =
        {
            Common =
            {
                Multiplier = 1.0,
            },
            Rare =
            {
                Multiplier = 1.2,
            },
            Epic =
            {
                Multiplier = 1.4,
            },
            Heroic =
            {
                Multiplier = 1.6,
            }
        },
        PropertyChanges =
        {
            {
                WeaponNames = { WeaponSets.HeroNonPhysicalWeapons },
                WeaponProperty = "Projectile",
                ChangeValue = "AphroditeBeowulfProjectile",
                ChangeType = "Absolute",
            },
            {
                WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                WeaponProperty = "FireFx",
                ChangeValue = "ProjectileFireRing-Aphrodite",
                ChangeType = "Absolute",
            },
            {
                WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                ProjectileProperty = "DamageLow",
                BaseMin = 80,
                BaseMax = 80,
                DepthMult = DepthDamageMultiplier,
                IdenticalMultiplier =
                {
                    Value = DuplicateStrongMultiplier,
                },
                ExtractValue =
                {
                    ExtractAs = "TooltipDamage",
                }
            },
            {
                WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                ProjectileProperty = "DamageHigh",
                DeriveValueFrom = "DamageLow"
            },
            {
                WeaponName = "RangedWeapon",
                EffectName = "OnHitStun",
                EffectProperty = "Active",
                ChangeValue = false,
            },
        },
        ExtractValues =
        {
            {
                ExtractAs = "BaseRangedDamage",
                External = true,
                BaseType = "Projectile",
                BaseName = "RangedWeapon",
                BaseProperty = "DamageLow",
            },
            {
                ExtractAs = "TooltipWeakDuration",
                SkipAutoExtract = true,
                External = true,
                BaseType = "Effect",
                WeaponName = "SwordWeapon",
                BaseName = "ReduceDamageOutput",
                BaseProperty = "Duration",
            },
            {
                ExtractAs = "TooltipWeakPower",
                SkipAutoExtract = true,
                External = true,
                BaseType = "Effect",
                WeaponName = "SwordWeapon",
                BaseName = "ReduceDamageOutput",
                BaseProperty = "Modifier",
                Format = "NegativePercentDelta"
            }
        }
    }
end