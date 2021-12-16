if JessAspects_temp_MikeTyson.Config.Enabled then
    JessAspects_temp_MikeTyson.Data.FistMikeTyson = {
                Costs = { 1, 2, 3, 4, 5 },
                MaxUpgradeLevel = -1,
                TraitName = "Jess_temp_MikeTysonTrait",
            }
    table.insert(
            WeaponUpgradeData.FistWeapon,
            JessAspects_temp_MikeTyson.Data.FistMikeTyson
    )
end