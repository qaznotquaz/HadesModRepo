-- ensure JessAspectsCore requirement
if JessAspectsCore == nil then
    DebugPrint({ Text = "LittleSureshot missing requirement: JessAspectsCore" })
    ModUtil.WrapBaseFunction("ShowWeaponUpgradeScreen", function(baseFunc, args)
        ModUtil.Hades.PrintStack("LittleSureshot missing requirement: JessAspectsCore", 5, { 0.78, 0.06, 0.06, 1 })
        return baseFunc(args)
    end)
end

if JessAspects_LittleSureshot.Config.Enabled then
    function CritDislodges(victim, _)
        --[[ local args = ModUtil.Locals(3).args
                    the following nonsense for getting args is because the above line of code is broken ]]--
        local test = ModUtil.Locals(3)
        local args
        for k, v in pairs(test) do
            if k == "args" then
                args = v
            end
        end

        if args ~= nil and victim ~= nil then
            local weaponName = args.SourceWeapon
            local angle = args.ImpactAngle

            for _, traitPropertyData in pairs(GetHeroTraitValues("CritDislodgeAmmoProperties")) do
                if ( Contains( traitPropertyData.ValidWeapons, weaponName ) or WeaponData[weaponName] and Contains( traitPropertyData.ValidWeapons, WeaponData[weaponName].LinkedUpgrades )) then
                    if not IsEmpty( victim.StoredAmmo ) then
                        CreateAnimation({ Name = "ExitWoundsFx_Annie", DestinationId = victim.ObjectId })
                    end
                    while not IsEmpty( victim.StoredAmmo ) do
                        local dropData = MergeTables(WeaponData[victim.StoredAmmo[1].WeaponName], { DropAmmoForceMin = traitPropertyData.ForceMin, DropAmmoForceMax = traitPropertyData.ForceMax, Angle = angle, AmmoDropDelay = 0 })
                        DropStoredAmmo( victim, dropData )
                    end
                end
            end
        end
    end

    function LittleSureshotDataInsist()
        if not Contains(LootData.WeaponUpgrade.Traits, "Jess_GunLittleSureshot_ShotgunTrait") then
            table.insert(LootData.WeaponUpgrade.Traits, "Jess_GunLittleSureshot_ShotgunTrait")
            --table.insert(LootData.WeaponUpgrade.Traits, "Jess_GunLittleSureshot_MinigunTrait")
        end
        if not ContainsAnyKey(LootData.WeaponUpgrade.TraitIndex, { "Jess_GunLittleSureshot_ShotgunTrait" }) then
            ModUtil.MapSetTable(LootData, {
                WeaponUpgrade = {
                    TraitIndex = {
                        Jess_GunLittleSureshot_ShotgunTrait = true,
                        --Jess_GunLittleSureshot_MinigunTrait = true,
                    }
                }
            })
        end

        if CodexMenuData ~= nil and not Contains(CodexMenuData.GunWeapon, "Jess_GunLittleSureshot_ShotgunTrait") then
            table.insert(CodexMenuData.GunWeapon, "Jess_GunLittleSureshot_ShotgunTrait")
            --table.insert(CodexMenuData.GunWeapon, "Jess_GunLittleSureshot_MinigunTrait")
            for _, value in ipairs(CodexMenuData.GodNames) do
                CodexMenuData[value .. "Inverted"] = CustomInvertTable(CodexMenuData[value])
            end
        end
    end

    OnPreThingCreation { LittleSureshotDataInsist }

    ModUtil.MapSetTable(JessAspectsCore.WeaponScreenToggle,
            {
                Text = {
                    Open = {
                        LittleSureshotFlavor = "\\n{$Keywords.Prototype}, {#ItalicFormatDark}Flavor text unwritten.",
                    },
                    Close = {
                        LittleSureshotFlavor = ""
                    }
                }
            }
    )

    ModUtil.MapSetTable(KeywordList, {
        "Annie_SharpAim"
    })

    ResetKeywords()
end
