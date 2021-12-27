if JessAspects_MagicBombs.Config.Enabled then
    local basicGods = {
        "Aphrodite", "Ares", "Artemis", "Athena", "Demeter", "Dionysus", "Poseidon", "Zeus"
    }

    for _, godName in pairs(basicGods) do
        MimicUtil.MimicLootUpgradeRequirements(
                "ShieldLoadAmmo_"..godName.."RangedTrait",
                "Jess_GunLoadAmmo_"..godName.."RangedTrait"
        )

        ModUtil.MapSetTable(LootData[godName.."Upgrade"], {
            PriorityUpgrades = { "Jess_GunLoadAmmo_"..godName.."RangedTrait" },
            WeaponUpgrades ={ "Jess_GunLoadAmmo_"..godName.."RangedTrait" }
        })
    end
end