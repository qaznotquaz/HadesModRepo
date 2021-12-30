-- ensure JessAspectsCore requirement
if JessAspectsCore == nil then
    DebugPrint({ Text = "BoonsAsAspects missing requirement: JessAspectsCore" })
    ModUtil.WrapBaseFunction("ShowWeaponUpgradeScreen", function(baseFunc, args)
        ModUtil.Hades.PrintStack("BoonsAsAspects missing requirement: JessAspectsCore", 5, { 0.78, 0.06, 0.06, 1 })
        return baseFunc(args)
    end)
end

if JessAspects_BoonsAsAspects.Config.Enabled then
    JessAspects_BoonsAsAspects.TraitNames = {
        "Jess_SwordPoseidonBoonTrait",
        "Jess_SpearHadesBoonTrait",
        "Jess_ShieldChaosBoonTrait",
        "Jess_BowArtemisBoonTrait",
        "Jess_FistDemeterBoonTrait",
        "Jess_GunHermesBoonTrait"
    }

    ModUtil.WrapBaseFunction("IsGodTrait", function(baseFunc, traitName)
        normalReturn = baseFunc(traitName)

        return normalReturn or Contains(JessAspects_BoonsAsAspects.TraitNames, traitName)
    end, BoonsAsAspects)

    ModUtil.MapSetTable(JessAspectsCore.WeaponScreenToggle,
            {
                Text = {
                    Open = {
                        PoseidonSwordFlavor = "\\n{$Keywords.Untested}\\n {#ItalicFormatDark}Poseidon's favor rests strongly on this weapon.",
                        HadesSpearFlavor = " \\n{$Keywords.Known_Bugs}",
                        ChaosShieldFlavor = " \\n\\n{$Keywords.Untested}\\n {#ItalicFormatDark}Chaos' favor rests strongly on this weapon.",
                        ArtemisBowFlavor = " \\n{$Keywords.Known_Bugs}\\n {#ItalicFormatDark}Artemis' favor rests strongly on this weapon.",
                        DemeterFistFlavor = " \\n{$Keywords.Untested}\\n {#ItalicFormatDark}Demeter's favor rests strongly on this weapon.",
                        HermesGunFlavor = " \\n{$Keywords.Untested}\\n {#ItalicFormatDark}Hermes' favor rests strongly on this weapon."
                    },
                    Close = {
                        PoseidonSwordFlavor = "",
                        HadesSpearFlavor = "\\n{$Keywords.Known_Bugs}",
                        ChaosShieldFlavor = "",
                        ArtemisBowFlavor = "\\n{$Keywords.Known_Bugs}",
                        DemeterFistFlavor = "",
                        HermesGunFlavor = ""
                    }
                },
                Actions = {
                    Open = {
                        BoonsAsAspects = function()
                            TraitData.Jess_SwordPoseidonBoonTrait.AddOutgoingDamageModifiers.ValidWeaponMultiplier.IdenticalMultiplier = nil
                            TraitData.Jess_SpearHadesBoonTrait.AddShout.BonusDamageExtract.IdenticalMultiplier = nil
                            TraitData.Jess_ShieldChaosBoonTrait.RarityBonus.RareBonus.IdenticalMultiplier = nil
                            TraitData.Jess_BowArtemisBoonTrait.PropertyChanges[3].IdenticalMultiplier = nil
                            TraitData.Jess_FistDemeterBoonTrait.AddOutgoingDamageModifiers.ValidWeaponMultiplier.IdenticalMultiplier = nil
                            TraitData.Jess_GunHermesBoonTrait.PropertyChanges[1].IdenticalMultiplier = nil
                        end
                    },
                    Close = {
                        BoonsAsAspects = function()
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
                        end
                    }
                }
            }
    )
end