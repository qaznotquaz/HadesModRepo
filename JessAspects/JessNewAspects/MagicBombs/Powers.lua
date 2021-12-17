function Jess_BombFireClear( triggerArgs, args )
    DebugPrint( { "Jess_BombsFireClear Called" } )
    if HeroHasTrait("Jess_GunMagicBombsTrait") and CurrentRun.CurrentRoom.LoadedAmmo and CurrentRun.CurrentRoom.LoadedAmmo > 0 and triggerArgs.name == "GunGrenadeToss" and CurrentRun.Hero.StoredAmmo and CurrentRun.CurrentRoom.LoadedAmmo then
        local numAmmo = CurrentRun.CurrentRoom.LoadedAmmo
        if HeroHasTrait("ShieldLoadAmmo_ZeusRangedTrait" ) then
            local targetId = SpawnObstacle({ Name = "InvisibleTarget", Group = "Scripting", LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY })
            for i = 1, numAmmo do
                thread(FireWeaponWithinRange, { SourceId = targetId, Range = 350, SeekTarget = true, WeaponName = "ZeusShieldLoadAmmoStrike", InitialDelay = 0.1 * i, Delay = 0.25, Count = 1, BonusChance = GetTotalHeroTraitValue("BonusBolts") })
            end
            thread( DestroyOnDelay, { targetId }, 3 )
        end

        thread( UnloadAmmoThread, { Count = numAmmo , Attacker = CurrentRun.Hero, Angle = GetAngle({Id = CurrentRun.Hero.ObjectId}), LocationX = triggerArgs.LocationX, LocationY = triggerArgs.LocationY, Interval = args.Interval })

        while numAmmo  > 0 do
            for i, ammoData in pairs( CurrentRun.Hero.StoredAmmo ) do
                if ammoData.WeaponName == "LoadAmmoApplicator" then
                    local ammoAnchors = ScreenAnchors.SelfStoredAmmo
                    if ammoAnchors ~= nil and ammoAnchors[#ammoAnchors] ~= nil then
                        Destroy({ Id = ammoAnchors[#ammoAnchors] })
                        ammoAnchors[#ammoAnchors] = nil
                    end
                    CurrentRun.Hero.StoredAmmo[i] = nil
                    break
                end
            end
            numAmmo  = numAmmo  - 1
        end
        CurrentRun.Hero.StoredAmmo = CollapseTable( CurrentRun.Hero.StoredAmmo )

        --thread(MarkObjectiveComplete, "BeowulfTackle")
        --ShieldFireClearPresentation( triggerArgs )
    end
end