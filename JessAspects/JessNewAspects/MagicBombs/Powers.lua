if JessAspects_MagicBombs.Config.Enabled then
    -- Most of this function is duplicated from Content/Scripts/Powers.lua @ SelfLoadAmmo()
    function Jess_GunLoadAmmo()
        if not CurrentRun.CurrentRoom.LoadedAmmo or not HeroHasTrait( "Jess_GunMagicBombsTrait" ) then
            return
        end

        PlaySound({ Name = "/Leftovers/SFX/HarpDash", Id = CurrentRun.Hero.ObjectId })
        thread( PlayVoiceLines, HeroVoiceLines.LoadingAmmoVoiceLines, true )

        if ScreenAnchors.AmmoIndicatorUI then
            local offsetX = 380
            local offsetY = -50
            ScreenAnchors.SelfStoredAmmo =  ScreenAnchors.SelfStoredAmmo or {}
            offsetX = offsetX + ( #ScreenAnchors.SelfStoredAmmo * 22 )
            local screenId = CreateScreenObstacle({ Name = "BlankObstacle", Group = "Combat_UI", DestinationId = ScreenAnchors.HealthBack, X = 10 + offsetX, Y = ScreenHeight - 50 + offsetY })
            SetThingProperty({ Property = "SortMode", Value = "Id", DestinationId = screenId })
            table.insert( ScreenAnchors.SelfStoredAmmo, screenId )
            SetAnimation({ Name = "SelfStoredAmmoIcon", DestinationId = screenId })
        end

        CurrentRun.CurrentRoom.LoadedAmmo = CurrentRun.CurrentRoom.LoadedAmmo + 1
        CurrentRun.Hero.StoredAmmo = CurrentRun.Hero.StoredAmmo or {}

        local storedAmmoData =
        {
            Count = 1,
            ForceMin = 300,
            ForceMax = 500,
            AttackerId = CurrentRun.Hero.ObjectId,
            WeaponName = "Jess_GunLoadAmmoApplicator",
            Id = _worldTime
        }
        table.insert( CurrentRun.Hero.StoredAmmo, storedAmmoData )
        thread( UpdateAmmoUI )
    end

    -- Most of this function is duplicated from Content/Scripts/Powers.lua @ SetupAmmoLoad()
    function Jess_SetupGunAmmoLoad(unit, _)
        if CurrentRun and CurrentRun.CurrentRoom then
            CurrentRun.CurrentRoom.LoadedAmmo = 0
            CurrentRun.Hero.StoredAmmo = {}
        end
        Destroy({Ids = ScreenAnchors.SelfStoredAmmo})

        SwapWeapon({ Name = "RangedWeapon", SwapWeaponName = "Jess_GunLoadAmmoApplicator", DestinationId = unit.ObjectId })
    end

    -- Most of this function is duplicated from Content/Scripts/Powers.lua @ ShieldFireClear()
    function Jess_BombFireClear(triggerArgs, args)
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
                    if ammoData.WeaponName == "Jess_GunLoadAmmoApplicator" then
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
        end
    end
end