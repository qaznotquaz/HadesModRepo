if JessAspects_temp_Cleopatra.Config.Enabled then
    JessAspects_temp_Cleopatra.Data.BowCleopatra = {
                Costs = { 1, 2, 3, 4, 5 },
                MaxUpgradeLevel = -1,
                TraitName = "Jess_temp_CleopatraTrait",
            }
    table.insert(
            WeaponUpgradeData.BowWeapon,
            JessAspects_temp_Cleopatra.Data.BowCleopatra
    )
end