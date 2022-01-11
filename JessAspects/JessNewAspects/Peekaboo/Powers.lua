if JessAspects_Peekaboo.Config.Enabled then
    OnWeaponFired { "RushWeapon",
                    function(triggerArgs)
                        DashManeuver()
                        if --[[triggerArgs.NearbyDangerId ~= nil and triggerArgs.NearbyDangerId > 0 and]] HeroHasTrait("Jess_PeekabooTrait") --[[and CheckCooldownNoTrigger("BlockPerfectDash", CurrentRun.Hero.PerfectDashHitDisableDuration)]] then
                            PerfectDashStartPresentation(triggerArgs)
                            FireWeaponFromUnit({ Weapon = "PeekabooEmpowerApplicator", Id = CurrentRun.Hero.ObjectId, DestinationId = CurrentRun.Hero.ObjectId })
                            PerfectDashEndPresentation(triggerArgs)
                        end
                    end
    }

    function PeekabooDamageBonusApply(triggerArgs)
        DebugPrint({Text = "damage bonus supposedly applied"})

        if not triggerArgs.Reapplied then
            local validWeapons = AddLinkedWeapons(WeaponSets.HeroPhysicalWeapons)
            AddLimitedWeaponBonus({ AsMultiplier = true, EffectName = triggerArgs.EffectName, Amount = 5, DamageBonus = triggerArgs.Modifier, WeaponNames = validWeapons })
        end
    end
end