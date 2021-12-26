ModUtil.MapSetTable(KeywordList, {
    "Prototype",
    "Annie_SharpAim"
})

ResetKeywords()

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