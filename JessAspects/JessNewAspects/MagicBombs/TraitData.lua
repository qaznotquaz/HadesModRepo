if JessAspects_MagicBombs.Config.Enabled then
    TraitData.Jess_GunMagicBombsTrait = {
        InheritFrom = { "WeaponEnchantmentTrait" },
        AmmoDropData = {
            AmmoDropForceMin = 160,
            AmmoDropForceMax = 190,
            AmmoDropUpwardForceMin = 1000,
            AmmoDropUpwardForceMax = 1030,
        },
        RequiredWeapons = { "GunWeapon", "RangedWeapon" },
        PreEquipWeapons = { "Jess_GunLoadAmmoApplicator" },
        OverrideWeaponFireNames = {
            RangedWeapon = "nil",
            Jess_GunLoadAmmoApplicator = "RangedWeapon",
        },
        OnProjectileDeathFunction = {
            Name = "Jess_BombFireClear",
            Args = {
                Interval = 0.17,
            },
        },
        SetupFunction = {
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

    -- disallow traditional casts and modify beowulf casts. dionysus and poseidon need to be handled separately
    local basicGods = {
        "Aphrodite", "Ares", "Artemis", "Athena", "Demeter", --[[ "Dionysus", "Poseidon", ]] "Zeus"
    }

    local traitName
    for _, godName in pairs(basicGods) do
        traitName = "ShieldLoadAmmo_"..godName.."RangedTrait"
        MimicUtil.RequireFalse(godName.."RangedTrait", "Jess_GunMagicBombsTrait")
        TraitData[traitName].RequiredTrait = nil
        TraitData[traitName].RequiredOneOfTraits = {"ShieldLoadAmmoTrait", "Jess_GunMagicBombsTrait"}
    end

    ModUtil.MapSetTable(TraitData.DionysusRangedTrait.TraitDependencyTextOverrides, {
        Jess_GunMagicBombsTrait = {
            Name = "Jess_GunLoadAmmo_DionysusRangedTrait",
            CustomTrayText = "Jess_GunLoadAmmo_DionysusRangedTrait_Tray",
        },
    })

    ModUtil.MapSetTable(TraitData.PoseidonRangedTrait.TraitDependencyTextOverrides, {
        Jess_GunMagicBombsTrait = {
            Name = "Jess_GunLoadAmmo_PoseidonRangedTrait",
            CustomTrayText = "Jess_GunLoadAmmo_PoseidonRangedTrait_Tray",
        },
    })

    MimicUtil.MimicForeignPropertyModifiers("ShieldLoadAmmoTrait", "Jess_GunMagicBombsTrait")
end