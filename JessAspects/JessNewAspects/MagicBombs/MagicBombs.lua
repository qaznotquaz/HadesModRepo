-- ensure JessAspectsCore requirement
if JessAspectsCore == nil then
    DebugPrint({ Text = "MagicBombs missing requirement: JessAspectsCore" })
    ModUtil.WrapBaseFunction("ShowWeaponUpgradeScreen", function(baseFunc, args)
        ModUtil.Hades.PrintStack("MagicBombs missing requirement: JessAspectsCore", 5, { 0.78, 0.06, 0.06, 1 })
        return baseFunc(args)
    end)
end

if JessAspects_MagicBombs.Config.Enabled then
    ModUtil.MapSetTable(JessAspectsCore.WeaponScreenToggle,
            {
                Text = {
                    Open = {
                        MagicBombsFlavor = "\\n\\n{$Keywords.Prototype}\\n{#ItalicFormatDark}Usually nonviolent, this mod creator does have a flair for the dramatic."
                    },
                    Close = {
                        MagicBombsFlavor = ""
                    }
                }
            }
    )
end