if JessAspects_Peekaboo.Config.Enabled then
    TraitData.Jess_PeekabooTrait = {
        InheritFrom = { "WeaponEnchantmentTrait" },
        RequiredWeapon = "FistWeapon",
        PreEquipWeapons = { "PeekabooEmpowerApplicator" },
        PropertyChanges =
        {
            {
                WeaponName = "PeekabooEmpowerApplicator",
                EffectName = "FistWeaponDamageBonus",
                EffectProperty = "Modifier",
                BaseValue = 0.4,
                ChangeType = "Add",
                ExtractValue =
                {
                    ExtractAs = "AspectExtract1",
                    Format = "Percent"
                }
            },
            {
                WeaponName = "PeekabooEmpowerApplicator",
                EffectName = "FistWeaponDamageBonus",
                EffectProperty = "Duration",
                ChangeValue = 999,
                ChangeType = "Absolute"
            },
        },
    }

    MimicUtil.TotalMimicWeaponAppearance(
            MimicUtil.BaseWeapons.FistTalos,
            JessAspects_Peekaboo.Data.FistMikeTyson,
            TraitData.Jess_PeekabooTrait
    )
end