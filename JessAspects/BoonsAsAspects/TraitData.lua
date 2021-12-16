if JessAspects_BoonsAsAspects.Config.Enabled then
    -- Stygian Blade ★ Poseidon's Flourish --
    if JessAspects_BoonsAsAspects.Config.SwordEnabled then
        TraitData.Jess_SwordPoseidonBoonTrait = {
            InheritFrom = { "WeaponEnchantmentTrait" },
            RarityLevels = {
                Common = {
                    Multiplier = 1.0
                },
                Rare = {
                    Multiplier = 1.5
                },
                Epic = {
                    Multiplier = 2.0
                },
                Heroic = {
                    Multiplier = 2.5
                },
                Legendary = {
                    Multiplier = 3.0
                }
            },

            God = "Poseidon",
            Slot = "Secondary",

            AddOutgoingDamageModifiers = {
                ValidWeaponMultiplier = {
                    BaseValue = 1.7,
                    IdenticalMultiplier = {
                        -- this should be DuplicateValue, but that's local to TraitData --
                        Value = -0.60
                    }
                },
                ValidWeapons = { "SwordParry" },
                ExtractValues = {
                    {
                        Key = "ValidWeaponMultiplier",
                        ExtractAs = "AspectExtract",
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
                TraitData.Jess_SwordPoseidonBoonTrait
        )
        TraitData.Jess_SwordPoseidonBoonTrait.Icon = "Boon_Poseidon_00"
        TraitData.Jess_SwordPoseidonBoonTrait.WeaponDataOverride.RangedWeapon = nil

        MimicUtil.MimicForeignPropertyModifiers(
                "PoseidonSecondaryTrait",
                "Jess_SwordPoseidonBoonTrait"
        )

        TraitData.BossDamageTrait.AddOutgoingDamageModifiers.ValidEnchantments.TraitDependentWeapons.Jess_SwordPoseidonBoonTrait = { "SwordParry" }

        MimicUtil.RequireFalse(
                "PoseidonSecondaryTrait",
                "Jess_SwordPoseidonBoonTrait"
        )
    end

    -- Twin Fists ★ Demeter's Strike --
    if JessAspects_BoonsAsAspects.Config.FistEnabled then
        TraitData.Jess_FistDemeterBoonTrait = {
            InheritFrom = { "WeaponEnchantmentTrait" },
            RarityLevels = {
                Common = {
                    Multiplier = 1.0
                },
                Rare = {
                    Multiplier = 1.5
                },
                Epic = {
                    Multiplier = 2.0
                },
                Heroic = {
                    Multiplier = 2.5
                },
                Legendary = {
                    Multiplier = 3.0
                }
            },

            God = "Demeter",
            Slot = "Melee",
            AddOutgoingDamageModifiers = {
                ValidWeaponMultiplier = {
                    BaseValue = 1.4,
                    IdenticalMultiplier = {
                        -- this should be DuplicateValue, but that's local to TraitData --
                        Value = -0.60
                    }
                },
                ValidWeapons = { "FistWeapon" },
                ExtractValues = {
                    {
                        Key = "ValidWeaponMultiplier",
                        ExtractAs = "AspectExtract",
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
            ExtractValues = {
                {
                    ExtractAs = "TooltipChillDuration",
                    SkipAutoExtract = true,
                    External = true,
                    BaseType = "Effect",
                    WeaponName = "SwordWeapon",
                    BaseName = "DemeterSlow",
                    BaseProperty = "Duration",
                },
                {
                    ExtractAs = "TooltipChillPower",
                    SkipAutoExtract = true,
                    External = true,
                    BaseType = "Effect",
                    WeaponName = "SwordWeapon",
                    BaseName = "DemeterSlow",
                    BaseProperty = "ElapsedTimeMultiplier",
                    Format = "NegativePercentDelta"
                },
                {
                    ExtractAs = "TooltipChillStacks",
                    SkipAutoExtract = true,
                    External = true,
                    BaseType = "Effect",
                    WeaponName = "SwordWeapon",
                    BaseName = "DemeterSlow",
                    BaseProperty = "MaxStacks",
                },
            }
        }

        MimicUtil.TotalMimicWeaponAppearance(
                MimicUtil.BaseWeapons.FistDemeter,
                JessAspects_BoonsAsAspects.Data.FistDemeter,
                TraitData.Jess_FistDemeterBoonTrait
        )

        TraitData.Jess_FistDemeterBoonTrait.Icon = "Boon_Demeter_01"
        TraitData.Jess_FistDemeterBoonTrait.WeaponDataOverride.FistWeaponSpecial = nil
        TraitData.Jess_FistDemeterBoonTrait.WeaponDataOverride.FistWeaponSpecialDash = nil

        MimicUtil.MimicForeignPropertyModifiers(
                "DemeterWeaponTrait",
                "Jess_FistDemeterBoonTrait"
        )

        MimicUtil.RequireFalse(
                "DemeterWeaponTrait",
                "Jess_FistDemeterBoonTrait"
        )
    end

    -- Eternal Spear ★ Hades' Aid --
    -- im scared to do this one

    -- Shield of Chaos ★ Chaos' Favor --
    if JessAspects_BoonsAsAspects.Config.ShieldEnabled then
        TraitData.Jess_ShieldChaosBoonTrait = {
            InheritFrom = { "WeaponEnchantmentTrait" },

            RarityBonus = {
                RareBonus = {
                    BaseValue = 0.1,
                    IdenticalMultiplier = {
                        Value = -0.80
                    }
                },
                EpicBonus = 0.1,
                LegendaryBonus = 0.1,
                ExtractValues = {
                    {
                        Key = "RareBonus",
                        ExtractAs = "AspectExtract",
                        Format = "Percent",
                    }
                }
            },

            PropertyChanges = {}
        }

        MimicUtil.TotalMimicWeaponAppearance(
                MimicUtil.BaseWeapons.ShieldChaos,
                JessAspects_BoonsAsAspects.Data.ShieldChaos,
                TraitData.Jess_ShieldChaosBoonTrait
        )

        TraitData.Jess_ShieldChaosBoonTrait.Icon = "Boon_Chaos_Blessing_10"

        MimicUtil.RequireFalse(
                "ChaosBlessingBoonRarityTrait",
                "Jess_ShieldChaosBoonTrait"
        )
    end

    -- Heart-Seeking Bow ★ Artemis' Cast --
    if JessAspects_BoonsAsAspects.Config.BowEnabled then
        TraitData.Jess_BowArtemisBoonTrait = {
            InheritFrom = { "WeaponEnchantmentTrait" },
            RarityLevels = {
                Common = {
                    Multiplier = 1.000
                },
                Rare = {
                    Multiplier = 1.145
                },
                Epic = {
                    Multiplier = 1.290
                },
                Heroic = {
                    Multiplier = 1.435
                },
                Legendary = {
                    Multiplier = 1.570
                }
            },

            God = "Artemis",
            Slot = "Ranged",

            PropertyChanges = {
                {
                    WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                    WeaponProperty = "Projectile",
                    ChangeValue = "ArtemisProjectile",
                    ChangeType = "Absolute",
                },
                {
                    WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                    WeaponProperty = "FireFx",
                    ChangeValue = "ProjectileFireRing-Artemis",
                    ChangeType = "Absolute",
                },
                {
                    WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                    ProjectileProperty = "DamageLow",
                    BaseMin = 70,
                    BaseMax = 70,
                    -- DepthDamageMultiplier
                    DepthMult = 0.0,
                    IdenticalMultiplier =
                    {
                        -- DuplicateStrongMultiplier
                        Value = -0.40,
                    },
                    ExtractValue =
                    {
                        ExtractAs = "AspectExtract",
                    }
                },
                {
                    WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                    ProjectileProperty = "DamageHigh",
                    DeriveValueFrom = "DamageLow"
                },
                {
                    WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                    ProjectileProperty = "CriticalHitChance",
                    ChangeValue = 0.10,
                    ChangeType = "Absolute",
                    ExtractValue =
                    {
                        ExtractAs = "TooltipCritChance",
                        Format = "Percent",
                        SkipAutoExtract = true
                    }
                },
            },
            ExtractValues = {
                {
                    ExtractAs = "BaseRangedDamage",
                    External = true,
                    BaseType = "Projectile",
                    BaseName = "RangedWeapon",
                    BaseProperty = "DamageLow",
                }
            }
        }

        MimicUtil.TotalMimicWeaponAppearance(
                MimicUtil.BaseWeapons.BowChiron,
                JessAspects_BoonsAsAspects.Data.BowArtemis,
                TraitData.Jess_BowArtemisBoonTrait
        )

        TraitData.Jess_BowArtemisBoonTrait.Icon = "Boon_Artemis_02"

        MimicUtil.MimicForeignPropertyModifiers(
                "ArtemisRangedTrait",
                "Jess_BowArtemisBoonTrait"
        )

        MimicUtil.RequireFalse(
                "ArtemisRangedTrait",
                "Jess_BowArtemisBoonTrait"
        )
    end

    -- watch out, hermes has a gun --
    if JessAspects_BoonsAsAspects.Config.GunEnabled then
        TraitData.Jess_GunHermesBoonTrait = {
            InheritFrom = { "WeaponEnchantmentTrait" },
            RarityLevels = {
                Common = {
                    Multiplier = 1.0
                },
                Rare = {
                    Multiplier = 1.5
                },
                Epic = {
                    Multiplier = 2.0
                },
                Heroic = {
                    Multiplier = 2.5
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
                        ExtractAs = "AspectExtract",
                        Format = "Percent"
                    },
                    IdenticalMultiplier = {
                        Value = -0.80
                    }
                },
            }
        }

        MimicUtil.TotalMimicWeaponAppearance(
                MimicUtil.BaseWeapons.GunZagreus,
                JessAspects_BoonsAsAspects.Data.GunHermes,
                TraitData.Jess_GunHermesBoonTrait
        )

        TraitData.Jess_GunHermesBoonTrait.Icon = "Boon_Hermes_04"

        MimicUtil.MimicForeignPropertyModifiers(
                "DodgeChanceTrait",
                "Jess_GunHermesBoonTrait"
        )

        MimicUtil.RequireFalse(
                "DodgeChanceTrait",
                "Jess_GunHermesBoonTrait"
        )
    end
end