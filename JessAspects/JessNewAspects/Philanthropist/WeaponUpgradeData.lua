if JessAspects_Philanthropist.Config.Enabled then
    JessAspects_Philanthropist.Data.BowRobin = {
                Costs = { 1, 2, 3, 4, 5 },
                MaxUpgradeLevel = -1,
                TraitName = "Jess_PhilanthropistTrait",
            }
    table.insert(
            WeaponUpgradeData.BowWeapon,
            JessAspects_Philanthropist.Data.BowRobin
    )
end