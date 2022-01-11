-- check AspectExtender requirement
if AspectExtender == nil then
    -- it doesn't have to fail out if AspectExtender is missing.
    DebugPrint({Text = "JessAspectsCore missing requirement: AspectExtender"})
    ModUtil.WrapBaseFunction("ShowWeaponUpgradeScreen", function(baseFunc, args)
        ModUtil.Hades.PrintStack("JessAspectsCore missing requirement: AspectExtender", 5, {0.78, 0.06, 0.06, 1})
        ModUtil.Hades.PrintStack("alternate aspects may be loaded, but will not be naturally accessible.", 5, {0.78, 0.06, 0.06, 1})
        return baseFunc(args)
    end)
end

-- ensure MimicUtil requirement
if MimicUtil == nil then
    DebugPrint({Text = "JessAspectsCore missing requirement: MimicUtil"})
    ModUtil.WrapBaseFunction("ShowWeaponUpgradeScreen", function(baseFunc, args)
        ModUtil.Hades.PrintStack("JessAspectsCore missing requirement: MimicUtil", 5, {0.78, 0.06, 0.06, 1})
        return baseFunc(args)
    end)
end

if JessAspectsCore.config.Enabled then
    JessAspectsCore.WeaponScreenToggle = {
        Text = {
            Active = { },
            Open = {
                -- SampleWeaponAspectTrait = "sample flavor text"
                AspectOrPom1 = "{$TooltipData.AspectExtract1}",
                AspectOrPom2 = "{$TooltipData.AspectExtract2}"
            },
            Close = {
                -- SampleWeaponAspectTrait = ""
                AspectOrPom1 = "{$TooltipData.DisplayDelta1}",
                AspectOrPom2 = "{$TooltipData.DisplayDelta2}"
            }
        },
        Actions = {
            Open = {
                JessAspectsCore = function()
                    JessAspectsCore.WeaponScreenToggle.Text.Active = DeepCopyTable(
                            JessAspectsCore.WeaponScreenToggle.Text.Open)
                end
            },
            Close = {
                JessAspectsCore = function()
                    JessAspectsCore.WeaponScreenToggle.Text.Active = DeepCopyTable(
                            JessAspectsCore.WeaponScreenToggle.Text.Close)
                end
            }
        }
    }

    ModUtil.WrapBaseFunction("ShowWeaponUpgradeScreen", function(baseFunc, args)
        for _, func in pairs(JessAspectsCore.WeaponScreenToggle.Actions.Open) do
            func()
        end

        return baseFunc(args)
    end, JessAspectsCore)

    ModUtil.WrapBaseFunction("CloseWeaponUpgradeScreen", function(baseFunc, args)
        for _, func in pairs(JessAspectsCore.WeaponScreenToggle.Actions.Close) do
            func()
        end

        return baseFunc(args)
    end, JessAspectsCore)

    ModUtil.MapSetTable(KeywordList, {
        "Unimplemented",
        "Under_Construction",
        "Prototype",
        "Untested",
        "Known_Bugs",
    })

    ResetKeywords()
end