if JessAspects_BoonsAsAspects.Config.Enabled then
    -- Stygian Blade ★ Poseidon's Flourish --
    if JessAspects_BoonsAsAspects.Config.SwordEnabled then
        TraitData.SwordPoseidonSecondaryTrait = {
            RarityLevels = {
                Common = {
                    MinMultiplier = 1.0,
                    MaxMultiplier = 1.0,
                },
                Rare = {
                    MinMultiplier = 1.5,
                    MaxMultiplier = 1.5,
                },
                Epic = {
                    MinMultiplier = 2.0,
                    MaxMultiplier = 2.0,
                },
                Heroic = {
                    MinMultiplier = 2.5,
                    MaxMultiplier = 2.5,
                },
                Legendary = {
                    MinMultiplier = 3.0,
                    MaxMultiplier = 3.0,
                }
            },

            God = "Poseidon",
            Slot = "Secondary",
            AddOutgoingDamageModifiers = {
                ValidWeaponMultiplier = {
                    BaseValue = 1.7,
                    SourceIsMultiplier = true,
                    IdenticalMultiplier = {
                        --      DuplicateMultiplier is local to TraitData but,
                        -- for some reason if I try to call it by name, it's nil.
                        Value = -0.60,
                    },
                },
                ValidWeapons = { "SwordParry" },
                ExtractValues = {
                    {
                        Key = "ValidWeaponMultiplier",
                        ExtractAs = "TooltipDamage",
                        Format = "PercentDelta",
                    },
                }
            },
            PropertyChanges = {
                -- Flourish Properties --
                {
                    WeaponNames = { "SwordParry" },
                    ProjectileProperty = "ImpactVelocity",
                    ChangeType = "Add",
                    BaseMin = 1200,
                    BaseMax = 1200,
                    IdenticalMultiplier = {
                        Value = -1,
                        MinMultiplier = 0,
                    },
                    ExcludeLinked = true,
                    IgnoreRarity = true,
                },
                {
                    WeaponNames = { "SwordParry" },
                    ProjectileProperty = "ImpactVelocityCap",
                    ChangeType = "Add",
                    BaseMin = 1200,
                    BaseMax = 1200,
                    IdenticalMultiplier = {
                        Value = -1,
                        MinMultiplier = 0,
                    },
                    ExcludeLinked = true,
                    IgnoreRarity = true,
                },
                {
                    WeaponName = "SwordParry",
                    ProjectileProperty = "StartFx",
                    ChangeValue = "null",
                    ChangeType = "Absolute",
                    ExcludeLinked = true,
                },
                {
                    WeaponName = "SwordParry",
                    WeaponProperty = "FireFx",
                    ChangeValue = "null",
                    ChangeType = "Absolute",
                    ExcludeLinked = true,
                },
                {
                    WeaponName = "SwordParry",
                    ProjectileProperty = "DetonateGraphic",
                    ChangeValue = "RadialNovaSwordParry-Poseidon",
                    ChangeType = "Absolute",
                    ExcludeLinked = true,
                },
            },
        }

        MimicUtil.TotalMimicWeaponAppearance(
                MimicUtil.BaseWeapons.SwordPoseidon,
                JessAspects_BoonsAsAspects.Data.SwordPoseidon,
                TraitData.SwordPoseidonSecondaryTrait
        )
        TraitData.SwordPoseidonSecondaryTrait.Icon = "Boon_Poseidon_00"
        TraitData.SwordPoseidonSecondaryTrait.WeaponDataOverride.RangedWeapon = nil

        MimicUtil.MimicTraitPropertyChanges(
                "PoseidonSecondaryTrait",
                "SwordPoseidonSecondaryTrait"
        )

        TraitData.BossDamageTrait.AddOutgoingDamageModifiers.ValidEnchantments.TraitDependentWeapons.SwordPoseidonSecondaryTrait = { "SwordParry" }

        MimicUtil.RequireFalse(
                "PoseidonSecondaryTrait",
                "SwordPoseidonSecondaryTrait"
        )
    end

    -- Twin Fists ★ Demeter's Strike --
    if JessAspects_BoonsAsAspects.Config.FistEnabled then
        TraitData.FistDemeterWeaponTrait = {
            RarityLevels = {
                Common = {
                    MinMultiplier = 1.0,
                    MaxMultiplier = 1.0,
                },
                Rare = {
                    MinMultiplier = 1.5,
                    MaxMultiplier = 1.5,
                },
                Epic = {
                    MinMultiplier = 2.0,
                    MaxMultiplier = 2.0,
                },
                Heroic = {
                    MinMultiplier = 2.5,
                    MaxMultiplier = 2.5,
                },
                Legendary = {
                    MinMultiplier = 3.0,
                    MaxMultiplier = 3.0,
                }
            },

            God = "Demeter",
            Slot = "Melee",
            AddOutgoingDamageModifiers = {
                ValidWeaponMultiplier = {
                    BaseValue = 1.4,
                    SourceIsMultiplier = true,
                    IdenticalMultiplier = {
                        --      DuplicateMultiplier is local to TraitData but,
                        -- for some reason if I try to call it by name, it's nil.
                        Value = -0.60
                    },
                },
                ValidWeapons = { "FistWeapon" },
                ExtractValues = {
                    {
                        Key = "ValidWeaponMultiplier",
                        ExtractAs = "TooltipDamage",
                        Format = "PercentDelta",
                    },
                }
            },
            PropertyChanges = {
                -- Strike Properties --
                {
                    WeaponNames = { "FistWeapon" },
                    EffectName = "DemeterSlow",
                    EffectProperty = "Active",
                    ChangeValue = true,
                },
                {
                    WeaponNames = { "FistWeapon", "FistWeapon2", "FistWeapon3", "FistWeapon4", "FistWeapon5" },
                    ProjectileProperty = "Graphic",
                    ChangeValue = "FistFxDemeter",
                    ChangeType = "Absolute"
                },
                {
                    WeaponName = "FistWeaponDash",
                    ProjectileProperty = "StartFx",
                    ChangeValue = "FistFxSwipeDemeter",
                    ChangeType = "Absolute",
                },
                {
                    WeaponNames = { "FistWeapon", "FistWeapon3", "FistWeapon5" },
                    TraitName = "FistDetonateTrait",
                    WeaponProperty = "FireFx",
                    ChangeValue = "ClawSwipe-Demeter",
                    ChangeType = "Absolute",
                    ExcludeLinked = true,
                },
                {
                    WeaponNames = { "FistWeapon2", "FistWeapon4" },
                    TraitName = "FistDetonateTrait",
                    WeaponProperty = "FireFx",
                    ChangeValue = "ClawSwipeFlipped-Demeter",
                    ChangeType = "Absolute",
                    ExcludeLinked = true,
                },
                {
                    WeaponNames = { "FistWeapon", "FistWeapon2", "FistWeapon3", "FistWeapon4", "FistWeapon5" },
                    TraitName = "FistDetonateTrait",
                    ProjectileProperty = "Graphic",
                    ChangeValue = "null",
                    ChangeType = "Absolute"
                },
                {
                    WeaponNames = { "FistWeaponDash" },
                    ProjectileProperty = "StartFx",
                    ChangeValue = "ClawSwipeFlippedDash-Demeter",
                    ChangeType = "Absolute",
                    ExcludeLinked = true,
                },
            },
        }

        MimicUtil.TotalMimicWeaponAppearance(
                MimicUtil.BaseWeapons.FistDemeter,
                JessAspects_BoonsAsAspects.Data.FistDemeter,
                TraitData.FistDemeterWeaponTrait
        )

        TraitData.FistDemeterWeaponTrait.Icon = "Boon_Demeter_01"
        TraitData.FistDemeterWeaponTrait.WeaponDataOverride.FistWeaponSpecial = nil
        TraitData.FistDemeterWeaponTrait.WeaponDataOverride.FistWeaponSpecialDash = nil

        MimicUtil.MimicTraitPropertyChanges(
                "DemeterWeaponTrait",
                "FistDemeterWeaponTrait"
        )

        MimicUtil.RequireFalse(
                "DemeterWeaponTrait",
                "FistDemeterWeaponTrait"
        )
    end

    -- watch out, hermes has a gun --
    if JessAspects_BoonsAsAspects.Config.GunEnabled then
        TraitData.GunDodgeChanceTrait = {
            RarityLevels = {
                Common = {
                    Multiplier = 1.00,
                },
                Rare = {
                    Multiplier = 1.5,
                },
                Epic = {
                    Multiplier = 2.0,
                },
                Heroic = {
                    Multiplier = 2.5,
                },
                Legendary = {
                    Multiplier = 3.0
                }
            },
            PropertyChanges = {
                -- Dodge Property --
                {
                    LifeProperty = "DodgeChance",
                    BaseValue = 0.10,
                    ChangeType = "Add",
                    DataValue = false,
                    ExtractValue = {
                        ExtractAs = "TooltipChance",
                        Format = "Percent"
                    },
                },
            }
        }

        MimicUtil.TotalMimicWeaponAppearance(
                MimicUtil.BaseWeapons.GunZagreus,
                JessAspects_BoonsAsAspects.Data.GunHermes,
                TraitData.GunDodgeChanceTrait
        )

        TraitData.GunDodgeChanceTrait.Icon = "Boon_Hermes_04"

        MimicUtil.MimicTraitPropertyChanges(
                "DodgeChanceTrait",
                "GunDodgeChanceTrait"
        )

        MimicUtil.RequireFalse(
                "DodgeChanceTrait",
                "GunDodgeChanceTrait"
        )
    end
end