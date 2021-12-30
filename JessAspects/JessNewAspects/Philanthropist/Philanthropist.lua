-- ensure JessAspectsCore requirement
if JessAspectsCore == nil then
    DebugPrint({ Text = "Philanthropist missing requirement: JessAspectsCore" })
    ModUtil.WrapBaseFunction("ShowWeaponUpgradeScreen", function(baseFunc, args)
        ModUtil.Hades.PrintStack("Philanthropist missing requirement: JessAspectsCore", 5, { 0.78, 0.06, 0.06, 1 })
        return baseFunc(args)
    end)
end

if JessAspects_Philanthropist.Config.Enabled then
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