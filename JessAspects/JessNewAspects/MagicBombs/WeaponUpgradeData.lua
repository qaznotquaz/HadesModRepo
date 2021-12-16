if JessAspects_MagicBombs.Config.Enabled then
    JessAspects_MagicBombs.Data.GunJess = {
                Costs = { 1, 2, 3, 4, 5 },
                MaxUpgradeLevel = -1,
                TraitName = "Jess_GunMagicBombsTrait",
            }
    table.insert(
            WeaponUpgradeData.GunWeapon,
            JessAspects_MagicBombs.Data.GunJess
    )
end