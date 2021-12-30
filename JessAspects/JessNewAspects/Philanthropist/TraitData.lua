if JessAspects_Philanthropist.Config.Enabled then
    TraitData.Jess_PhilanthropistTrait = {
        InheritFrom = { "WeaponEnchantmentTrait" },
        PropertyChanges = { }
    }

    MimicUtil.TotalMimicWeaponAppearance(
            MimicUtil.BaseWeapons.BowZagreus,
            JessAspects_Philanthropist.Data.BowRobin,
            TraitData.Jess_PhilanthropistTrait
    )
end