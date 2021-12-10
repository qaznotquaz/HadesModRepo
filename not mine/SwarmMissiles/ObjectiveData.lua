if SwarmMissiles.config.Enabled then
    table.insert(WeaponData.GunGrenadeToss.CompleteObjectivesOnFire, "GunGrenadeMissile")

    ObjectiveData.GunWeaponGunWeave = { Description = "Objective_GunWeaponGunWeave" }
    ObjectiveData.GunGrenadeMissile = { Description = "Objective_GunGrenadeMissile" }

    ObjectiveSetData.GunTutorial_SwarmMissiles = {
        AllowRepeat = true,
        OverrideExistingObjective = false,
        RequiredFalseObjectiveTriggers = { "RoomStart" },
        RequiredMainWeapon = "GunWeapon",
        RequiredTrait = "GunSwarmMissileTrait",
        Objectives = {
            { "GunWeapon", "GunWeaponManualReload", "GunGrenadeMissile", "GunWeaponDash", "GunWeaponGunWeave" }
        }
    }
end