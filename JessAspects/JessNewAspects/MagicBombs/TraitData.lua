if JessAspects_MagicBombs.Config.Enabled then
    TraitData.Jess_GunMagicBombsTrait = {
        InheritFrom = { "WeaponEnchantmentTrait" },
        PropertyChanges = { }
    }

    MimicUtil.TotalMimicWeaponAppearance(
            MimicUtil.BaseWeapons.GunLucifer,
            JessAspects_MagicBombs.Data.GunJess,
            TraitData.Jess_GunMagicBombsTrait
    )
end