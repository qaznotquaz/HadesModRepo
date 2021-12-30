if JessAspects_BoonsAsAspects.Config.Enabled then
    if JessAspects_BoonsAsAspects.Config.SwordEnabled then
        MimicUtil.MimicLootUpgradeRequirements(
                "PoseidonSecondaryTrait",
                "Jess_SwordPoseidonBoonTrait"
        )
    end

    if JessAspects_BoonsAsAspects.Config.SpearEnabled then
        MimicUtil.MimicLootUpgradeRequirements(
                "HadesShoutTrait",
                "Jess_SpearHadesBoonTrait"
        )
    end

    if JessAspects_BoonsAsAspects.Config.ShieldEnabled then
        MimicUtil.MimicLootUpgradeRequirements(
                "ChaosBlessingBoonRarityTrait",
                "Jess_ShieldChaosBoonTrait"
        )
    end

    if JessAspects_BoonsAsAspects.Config.BowEnabled then
        MimicUtil.MimicLootUpgradeRequirements(
                "ArtemisRangedTrait",
                "Jess_BowArtemisBoonTrait"
        )
    end

    if JessAspects_BoonsAsAspects.Config.FistEnabled then
        MimicUtil.MimicLootUpgradeRequirements(
                "DemeterSecondaryTrait",
                "Jess_FistDemeterBoonTrait"
        )
    end

    if JessAspects_BoonsAsAspects.Config.GunEnabled then
        MimicUtil.MimicLootUpgradeRequirements(
                "DodgeChanceTrait",
                "Jess_GunHermesBoonTrait"
        )
    end
end