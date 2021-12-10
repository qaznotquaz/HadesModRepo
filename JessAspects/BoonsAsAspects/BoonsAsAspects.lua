ModUtil.WrapBaseFunction("IsGodTrait", function(baseFunc, traitName)
    normalReturn = baseFunc(traitName)

    return normalReturn or traitName == "SwordPoseidonSecondaryTrait"
end, BoonsAsAspects)

ModUtil.WrapBaseFunction("ShowWeaponUpgradeScreen", function(baseFunc, args)
    if TraitData.SwordPoseidonSecondaryTrait.AddOutgoingDamageModifiers.ValidWeaponMultiplier.IdenticalMultiplier ~= nil then
        TraitData.SwordPoseidonSecondaryTrait.AddOutgoingDamageModifiers.ValidWeaponMultiplier.IdenticalMultiplier = nil
    end

    return baseFunc(args)
end, BoonsAsAspects)

ModUtil.WrapBaseFunction("CloseWeaponUpgradeScreen", function(baseFunc, screen)
    if TraitData.SwordPoseidonSecondaryTrait.AddOutgoingDamageModifiers.ValidWeaponMultiplier.IdenticalMultiplier == nil then
        TraitData.SwordPoseidonSecondaryTrait.AddOutgoingDamageModifiers.ValidWeaponMultiplier.IdenticalMultiplier = {
            -- this should be DuplicateValue, but that's local to TraitData --
            Value = -0.60
        }
    end

    return baseFunc(screen)
end, BoonsAsAspects)