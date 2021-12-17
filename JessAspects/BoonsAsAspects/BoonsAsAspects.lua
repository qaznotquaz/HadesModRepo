ModUtil.WrapBaseFunction("IsGodTrait", function(baseFunc, traitName)
    normalReturn = baseFunc(traitName)

    return normalReturn or Contains(JessAspects_BoonsAsAspects.TraitNames, traitName)
end, BoonsAsAspects)

ModUtil.WrapBaseFunction("ShowWeaponUpgradeScreen", function(baseFunc, args)
    TraitData.Jess_SwordPoseidonBoonTrait.AddOutgoingDamageModifiers.ValidWeaponMultiplier.IdenticalMultiplier = nil
    TraitData.Jess_SpearHadesBoonTrait.AddShout.BonusDamageExtract.IdenticalMultiplier = nil
    TraitData.Jess_ShieldChaosBoonTrait.RarityBonus.RareBonus.IdenticalMultiplier = nil
    TraitData.Jess_BowArtemisBoonTrait.PropertyChanges[3].IdenticalMultiplier = nil
    TraitData.Jess_FistDemeterBoonTrait.AddOutgoingDamageModifiers.ValidWeaponMultiplier.IdenticalMultiplier = nil
    TraitData.Jess_GunHermesBoonTrait.PropertyChanges[1].IdenticalMultiplier = nil

    ModUtil.MapSetTable(JessAspects_BoonsAsAspects.CustomText,
            {
                AspectOrPom = "{$TooltipData.AspectExtract}",
                SwordFlavor = " \\n{$Keywords.Untested}\\n {#ItalicFormatDark}Poseidon's favor rests strongly on this weapon.",
                SpearFlavor = " \\n{$Keywords.Known_Bugs}",
                ShieldFlavor = " \\n\\n{$Keywords.Untested}\\n {#ItalicFormatDark}Chaos' favor rests strongly on this weapon.",
                BowFlavor = " \\n{$Keywords.Known_Bugs}\\n {#ItalicFormatDark}Artemis' favor rests strongly on this weapon.",
                FistFlavor = " \\n{$Keywords.Untested}\\n {#ItalicFormatDark}Demeter's favor rests strongly on this weapon.",
                GunFlavor = " \\n{$Keywords.Untested}\\n {#ItalicFormatDark}Hermes' favor rests strongly on this weapon."
            })

    return baseFunc(args)
end, BoonsAsAspects)

ModUtil.WrapBaseFunction("CloseWeaponUpgradeScreen", function(baseFunc, screen)
    TraitData.Jess_SwordPoseidonBoonTrait.AddOutgoingDamageModifiers.ValidWeaponMultiplier.IdenticalMultiplier = {
        -- this should be DuplicateValue, but that's local to TraitData --
        Value = -0.60
    }
    TraitData.Jess_SpearHadesBoonTrait.AddShout.BonusDamageExtract.IdenticalMultiplier = {
        Value = -0.80
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

ModUtil.MapSetTable(KeywordList, {
    "Unimplemented",
    "Under_Construction",
    "Untested",
    "Known_Bugs",
})

ResetKeywords()