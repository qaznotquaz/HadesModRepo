-- ensure JessAspectsCore requirement
if JessAspectsCore == nil then
    DebugPrint({ Text = "Philanthropist missing requirement: JessAspectsCore" })
    ModUtil.WrapBaseFunction("ShowWeaponUpgradeScreen", function(baseFunc, args)
        ModUtil.Hades.PrintStack("Philanthropist missing requirement: JessAspectsCore", 5, { 0.78, 0.06, 0.06, 1 })
        return baseFunc(args)
    end)
end

if JessAspects_Philanthropist.Config.Enabled then
    function JessAspects_Philanthropist.StealMoney()
        thread( InCombatText, CurrentRun.Hero.ObjectId, "InCombat_Steal", 0.8 )
        local money = GetTotalHeroTraitValue("StealFromTheRich")
        GiveRandomConsumables(
                {
                    Delay = 1.5,
                    NotRequiredPickup = true,
                    LootOptions = {
                        {
                            Name = "Money",
                            MinAmount = money,
                            MaxAmount = money,
                        },
                    },
                }
        )
        CreateAnimation({ Name = "MoneyShower", DestinationId = CurrentRun.Hero.ObjectId })
    end

    function JessAspects_Philanthropist.StealArrow()
        thread( InCombatText, CurrentRun.Hero.ObjectId, "InCombat_Steal", 0.8 )
        AddTraitToHero(
                {
                    TraitData = GetProcessedTraitData(
                            {
                                Unit = CurrentRun.Hero,
                                TraitName = "Jess_PhilanthropistBonusArrowsTrait",
                                Rarity = "Common"
                            }
                    )
                }
        )
        CreateAnimation({ Name = "MoneyShower", DestinationId = CurrentRun.Hero.ObjectId })
    end

    ModUtil.MapSetTable(JessAspectsCore.WeaponScreenToggle,
            {
                Text = {
                    Open = {
                        RobinFlavor = "\\n{$Keywords.Unimplemented}, {#ItalicFormatDark}Flavor text unwritten.",
                    },
                    Close = {
                        RobinFlavor = ""
                    }
                }
            }
    )

    ModUtil.MapSetTable(KeywordList, {
        "PhilanthropistSteal",
        "PhilanthropistGive"
    })

    ResetKeywords()
end