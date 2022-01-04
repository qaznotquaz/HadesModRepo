if JessAspects_Philanthropist.Config.Enabled then
    TraitData.Jess_PhilanthropistTrait = {
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
        InheritFrom = { "WeaponEnchantmentTrait" },
        StealFromTheRich = {
            BaseValue = 6,
            ExtractValue = {
                ExtractAs = "StealFromTheRich",
            }
        },
        GiveToThePoor = {
            BaseValue = 50,
            ExtractValue = {
                ExtractAs = "GiveToThePoor",
            },
            CustomRarityMultiplier = {
                Common = {
                    Multiplier = 1.0
                },
                Rare = {
                    Multiplier = 0.9
                },
                Epic = {
                    Multiplier = 0.8
                },
                Heroic = {
                    Multiplier = 0.7
                },
                Legendary = {
                    Multiplier = 0.6
                }
            },
        },
        PropertyChanges = { }
    }

    MimicUtil.TotalMimicWeaponAppearance(
            MimicUtil.BaseWeapons.BowZagreus,
            JessAspects_Philanthropist.Data.BowRobin,
            TraitData.Jess_PhilanthropistTrait
    )

    -- when the game gives you bonus arrows for your special,
    --      this is the trait it's increasing.
    TraitData.Jess_PhilanthropistBonusArrowsTrait = {
        RarityLevels = {
            Common = {
                Multiplier = 1.0
            }
        },
        Hidden = true,
        RequiredWeapon = "BowSplitShot",
        PropertyChanges = {
            {
                WeaponName = "BowSplitShot",
                WeaponProperty = "NumProjectiles",
                ChangeValue = 1,
                ChangeType = "Add"
            }
        }
    }
end