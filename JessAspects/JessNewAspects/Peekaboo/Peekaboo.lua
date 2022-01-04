-- ensure JessAspectsCore requirement
if JessAspectsCore == nil then
    DebugPrint({ Text = "Peekaboo missing requirement: JessAspectsCore" })
    ModUtil.WrapBaseFunction("ShowWeaponUpgradeScreen", function(baseFunc, args)
        ModUtil.Hades.PrintStack("Peekaboo missing requirement: JessAspectsCore", 5, { 0.78, 0.06, 0.06, 1 })
        return baseFunc(args)
    end)
end

if JessAspects_Peekaboo.Config.Enabled then
    ModUtil.MapSetTable(JessAspectsCore.WeaponScreenToggle,
            {
                Text = {
                    Open = {
                        MikeFlavor = "{$Keywords.Unimplemented}, {#ItalicFormatDark}Flavor text unwritten.",
                    },
                    Close = {
                        MikeFlavor = ""
                    }
                }
            }
    )
end