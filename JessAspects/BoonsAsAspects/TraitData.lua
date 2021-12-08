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

        -- for that boss damage boon --
        TraitData.BossDamageTrait.AddOutgoingDamageModifiers.ValidEnchantments.TraitDependentWeapons.SwordPoseidonSecondaryTrait = { "SwordParry" }

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
    end
end