if JessAspects_temp_RobinHood.Config.Enabled then
    JessAspects_temp_RobinHood.Data.BowRobin = {
                Costs = { 1, 2, 3, 4, 5 },
                MaxUpgradeLevel = -1,
                TraitName = "Jess_temp_RobinHoodTrait",
            }
    table.insert(
            WeaponUpgradeData.BowWeapon,
            JessAspects_temp_RobinHood.Data.BowRobin
    )
end