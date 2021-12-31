-- ensure JessAspectsCore requirement
if JessAspectsCore == nil then
    DebugPrint({ Text = "MikeTyson missing requirement: JessAspectsCore" })
    ModUtil.WrapBaseFunction("ShowWeaponUpgradeScreen", function(baseFunc, args)
        ModUtil.Hades.PrintStack("MikeTyson missing requirement: JessAspectsCore", 5, { 0.78, 0.06, 0.06, 1 })
        return baseFunc(args)
    end)
end

if JessAspects_temp_MikeTyson.Config.Enabled then
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