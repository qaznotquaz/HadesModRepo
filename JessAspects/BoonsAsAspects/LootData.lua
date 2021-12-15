if JessAspects_BoonsAsAspects.Config.Enabled then
    if JessAspects_BoonsAsAspects.Config.SwordEnabled then
        MimicUtil.MimicLootUpgradeRequirements(
                "PoseidonSecondaryTrait",
                "Jess_SwordPoseidonBoonTrait"
        )
    end

    --[[ These aren't really necessary,
            they aren't quite naturally-granted boons --

    if JessAspects_BoonsAsAspects.Config.SpearEnabled then
    end

    if JessAspects_BoonsAsAspects.Config.ShieldEnabled then
    end
    ]]--

    if JessAspects_BoonsAsAspects.Config.BowEnabled then
        MimicUtil.MimicLootUpgradeRequirements(
                "ArtemisRangedTrait",
                "BowArtemisRangedTrait"
        )
    end

    if JessAspects_BoonsAsAspects.Config.FistEnabled then
        MimicUtil.MimicLootUpgradeRequirements(
                "DemeterSecondaryTrait",
                "FistDemeterSecondaryTrait"
        )
    end

    if JessAspects_BoonsAsAspects.Config.GunEnabled then
        MimicUtil.MimicLootUpgradeRequirements(
                "DodgeChanceTrait",
                "Jess_GunHermesBoonTrait"
        )
    end
end