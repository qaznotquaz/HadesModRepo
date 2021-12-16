if JessAspects_temp_Merlin.Config.Enabled then
    TraitData.Jess_temp_MerlinTrait = {
        InheritFrom = { "WeaponEnchantmentTrait" },
        PropertyChanges = { }
    }

    MimicUtil.TotalMimicWeaponAppearance(
            MimicUtil.BaseWeapons.SpearAchilles,
            JessAspects_temp_Merlin.Data.SpearMerlin,
            TraitData.Jess_temp_MerlinTrait
    )
end