if SwarmMissiles.config.Enabled then
    SwarmMissiles.Data.GunSwarmMissiles = {
        Costs = { 1, 1, 1, 1, 1 },
        MaxUpgradeLevel = 5,
        TraitName = "GunSwarmMissileTrait",
        UnequipFunctionName = "RemoveGunWeaveBuff",
        Image = "Codex_Portrait_Gun"
    }

    table.insert(
            WeaponUpgradeData.GunWeapon,
            SwarmMissiles.Data.GunSwarmMissiles
    )
end