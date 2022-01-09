if JessAspects_SpearConsecration.Config.Enabled then
    JessAspects_SpearConsecration.Data.SpearMerlin = {
                Costs = { 1, 2, 3, 4, 5 },
                MaxUpgradeLevel = -1,
                TraitName = "Jess_SpearConsecrationTrait",
            }
    table.insert(
            WeaponUpgradeData.SpearWeapon,
            JessAspects_SpearConsecration.Data.SpearMerlin
    )
end