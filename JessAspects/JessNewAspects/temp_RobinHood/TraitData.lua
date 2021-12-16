if JessAspects_temp_RobinHood.Config.Enabled then
    TraitData.Jess_temp_RobinHoodTrait = {
        InheritFrom = { "WeaponEnchantmentTrait" },
        PropertyChanges = { }
    }

    MimicUtil.TotalMimicWeaponAppearance(
            MimicUtil.BaseWeapons.BowZagreus,
            JessAspects_temp_RobinHood.Data.BowRobin,
            TraitData.Jess_temp_RobinHoodTrait
    )
end