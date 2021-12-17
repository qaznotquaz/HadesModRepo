if JessAspects_MagicBombs.Config.Enabled then
    MimicUtil.MimicLootUpgradeRequirements(
            "ShieldLoadAmmo_AphroditeRangedTrait",
            "GunMagicBomb_AphroditeRangedTrait"
    )

    ModUtil.MapSetTable(LootData.AphroditeUpgrade, {
        PriorityUpgrades = { "GunMagicBomb_AphroditeRangedTrait" },
        WeaponUpgrades ={ "GunMagicBomb_AphroditeRangedTrait" }
    })
end