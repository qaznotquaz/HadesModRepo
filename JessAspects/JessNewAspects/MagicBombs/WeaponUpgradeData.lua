if JessAspects_MagicBombs.Config.Enabled then
    JessAspects_MagicBombs.Data.GunJess = {
                Costs = { 1, 2, 3, 4, 5 },
                MaxUpgradeLevel = 5,
                TraitName = "Jess_GunMagicBombsTrait",
                UnequipFunctionName = "RemoveAmmoLoad",
    }
    table.insert(
            WeaponUpgradeData.GunWeapon,
            JessAspects_MagicBombs.Data.GunJess
    )
end