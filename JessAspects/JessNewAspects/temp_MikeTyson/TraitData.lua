if JessAspects_temp_MikeTyson.Config.Enabled then
    TraitData.Jess_temp_MikeTysonTrait = {
        InheritFrom = { "WeaponEnchantmentTrait" },
        PropertyChanges = { }
    }

    MimicUtil.TotalMimicWeaponAppearance(
            MimicUtil.BaseWeapons.FistTalos,
            JessAspects_temp_MikeTyson.Data.FistMikeTyson,
            TraitData.Jess_temp_MikeTysonTrait
    )
end