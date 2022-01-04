if JessAspects_Peekaboo.Config.Enabled then
    JessAspects_Peekaboo.Data.FistMikeTyson = {
                Costs = { 1, 2, 3, 4, 5 },
                MaxUpgradeLevel = -1,
                TraitName = "Jess_PeekabooTrait",
            }
    table.insert(
            WeaponUpgradeData.FistWeapon,
            JessAspects_Peekaboo.Data.FistMikeTyson
    )
end