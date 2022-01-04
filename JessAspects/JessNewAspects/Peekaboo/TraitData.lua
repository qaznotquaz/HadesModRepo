if JessAspects_Peekaboo.Config.Enabled then
    TraitData.Jess_PeekabooTrait = {
        InheritFrom = { "WeaponEnchantmentTrait" },
        PropertyChanges = { }
    }

    MimicUtil.TotalMimicWeaponAppearance(
            MimicUtil.BaseWeapons.FistTalos,
            JessAspects_Peekaboo.Data.FistMikeTyson,
            TraitData.Jess_PeekabooTrait
    )
end