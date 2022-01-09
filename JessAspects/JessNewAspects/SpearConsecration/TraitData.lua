if JessAspects_SpearConsecration.Config.Enabled then
    TraitData.Jess_SpearConsecrationTrait = {
        InheritFrom = { "WeaponEnchantmentTrait" },
        PropertyChanges = { }
    }

    MimicUtil.TotalMimicWeaponAppearance(
            MimicUtil.BaseWeapons.SpearAchilles,
            JessAspects_SpearConsecration.Data.SpearMerlin,
            TraitData.Jess_SpearConsecrationTrait
    )
end