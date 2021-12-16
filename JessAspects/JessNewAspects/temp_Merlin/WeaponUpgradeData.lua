if JessAspects_temp_Merlin.Config.Enabled then
    JessAspects_temp_Merlin.Data.SpearMerlin = {
                Costs = { 1, 2, 3, 4, 5 },
                MaxUpgradeLevel = -1,
                TraitName = "Jess_temp_MerlinTrait",
            }
    table.insert(
            WeaponUpgradeData.SpearWeapon,
            JessAspects_temp_Merlin.Data.SpearMerlin
    )
end