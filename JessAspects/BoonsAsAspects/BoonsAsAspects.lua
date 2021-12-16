ModUtil.WrapBaseFunction("IsGodTrait", function(baseFunc, traitName)
    normalReturn = baseFunc(traitName)

    return normalReturn or Contains(JessAspects_BoonsAsAspects.TraitNames, traitName)
end, BoonsAsAspects)

ModUtil.WrapBaseFunction("ShowWeaponUpgradeScreen", function(baseFunc, args)
    TraitData.Jess_SwordPoseidonBoonTrait.AddOutgoingDamageModifiers.ValidWeaponMultiplier.IdenticalMultiplier = nil
    TraitData.Jess_BowArtemisBoonTrait.PropertyChanges[3].IdenticalMultiplier = nil
    TraitData.Jess_ShieldChaosBoonTrait.RarityBonus.RareBonus.IdenticalMultiplier = nil
    TraitData.Jess_FistDemeterBoonTrait.AddOutgoingDamageModifiers.ValidWeaponMultiplier.IdenticalMultiplier = nil
    TraitData.Jess_GunHermesBoonTrait.PropertyChanges[1].IdenticalMultiplier = nil

    ModUtil.MapSetTable(JessAspects_BoonsAsAspects.CustomText,
            {
                AspectOrPom = "{$TooltipData.AspectExtract}",
                SwordFlavor = " \\n\\n {#ItalicFormatDark}Poseidon's favor rests strongly on this weapon.",
                SpearFlavor = " \\n\\n {#ItalicFormatDark}Hades' favor rests strongly on this weapon.",
                ShieldFlavor = " \\n\\n {#ItalicFormatDark}Chaos' favor rests strongly on this weapon.",
                BowFlavor = " \\n\\n {#ItalicFormatDark}Artemis' favor rests strongly on this weapon.",
                FistFlavor = " \\n\\n {#ItalicFormatDark}Demeter's favor rests strongly on this weapon.",
                GunFlavor = " \\n\\n {#ItalicFormatDark}Hermes' favor rests strongly on this weapon."
            })

    return baseFunc(args)
end, BoonsAsAspects)

ModUtil.WrapBaseFunction("CloseWeaponUpgradeScreen", function(baseFunc, screen)
    TraitData.Jess_SwordPoseidonBoonTrait.AddOutgoingDamageModifiers.ValidWeaponMultiplier.IdenticalMultiplier = {
        -- this should be DuplicateValue, but that's local to TraitData --
        Value = -0.60
    }
    TraitData.Jess_ShieldChaosBoonTrait.RarityBonus.RareBonus.IdenticalMultiplier = {
        Value = -0.80
    }
    TraitData.Jess_BowArtemisBoonTrait.PropertyChanges[3].IdenticalMultiplier = {
        -- DuplicateStrongMultiplier
        Value = -0.40,
    }
    TraitData.Jess_FistDemeterBoonTrait.AddOutgoingDamageModifiers.ValidWeaponMultiplier.IdenticalMultiplier = {
        -- this should be DuplicateValue, but that's local to TraitData --
        Value = -0.60
    }
    TraitData.Jess_GunHermesBoonTrait.PropertyChanges[1].IdenticalMultiplier = {
        Value = -0.80
    }

    ModUtil.MapSetTable(JessAspects_BoonsAsAspects.CustomText,
            {
                AspectOrPom = "{$TooltipData.DisplayDelta1}",
                SwordFlavor = "",
                SpearFlavor = "",
                ShieldFlavor = "",
                BowFlavor = "",
                FistFlavor = "",
                GunFlavor = ""
            })

    return baseFunc(screen)
end, BoonsAsAspects)