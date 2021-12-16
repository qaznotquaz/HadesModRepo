if JessAspects_temp_Cleopatra.Config.Enabled then
    TraitData.Jess_temp_CleopatraTrait = {
        InheritFrom = { "WeaponEnchantmentTrait" },
        PropertyChanges = { }
    }

    MimicUtil.TotalMimicWeaponAppearance(
            MimicUtil.BaseWeapons.BowRama,
            JessAspects_temp_Cleopatra.Data.BowCleopatra,
            TraitData.Jess_temp_CleopatraTrait
    )
end