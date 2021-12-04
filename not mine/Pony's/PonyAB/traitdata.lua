if PAB.Config.Gameplay.Enabled then
    if PAB.Config.Gameplay.ExtraHammers.Enabled then
        if PAB.Config.Gameplay.ExtraHammers.SuperGunManualReloadTrait.Enabled then
            TraitData.SuperGunManualReloadTrait =
            {
                InheritFrom = { "WeaponTrait" },
                Icon = "Weapon_Gun_03",
                RequiredWeapon = "GunWeapon",
                RequiredTrait = "GunManualReloadTrait",
                RequiredFalseTraits = { "GunSniperTrait", "GunInfiniteAmmoTrait", "GunMinigunTrait", "GunConsecutiveFireTrait", "GunChainShotTrait", "GunLoadedGrenadeTrait", "GunHomingBulletTrait" },
                PropertyChanges =
                {
                    {
                        WeaponName = "GunWeapon",
                        WeaponProperty = "MaxAmmo",
                        ChangeValue = 2,
                        ChangeType = "Absolute",
                    },
                    {
                        WeaponName = "GunWeapon",
                        WeaponProperty = "ActiveReloadTime",
                        ChangeValue = 1.5,
                        ChangeType = "Absolute",
                        ExcludeLinked = true,
                    },
                    {
                        WeaponNames = { "SniperGunWeapon", "SniperGunWeaponDash" },
                        ProjectileProperty = "Range",
                        ChangeValue = 1.5,
                        ChangeType = "Multiply",
                        ExcludeLinked = true,
                    },
                    {
                        WeaponNames = { "SniperGunWeapon", "SniperGunWeaponDash" },
                        WeaponProperty = "AutoLockRange",
                        ChangeValue = 1.5,
                        ChangeType = "Multiply",
                        ExcludeLinked = true,
                    },
                    {
                        WeaponNames = WeaponSets.HeroRushWeapons,
                        WeaponProperty = "Enabled",
                        ChangeValue = false,
                        ChangeType = "Absolute",
                    },
    
                    GunWeapon =
                    {
                        Sounds =
                        {
                            FireSounds =
                            {
                                { Name = "/VO/ZagreusEmotes/EmoteCharging_Bow" },
                                { Name = "/SFX/Player Sounds/ZagreusGunFire" },
                                { Name = "/Leftovers/SFX/AuraPerfectThrow" },
                            },
                            ImpactSounds =
                            {
                                Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
                                Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
                                Bone = "/SFX/ArrowMetalBoneSmash",
                                Brick = "/SFX/ArrowMetalStoneClang",
                                Stone = "/SFX/ArrowMetalStoneClang",
                                Organic = "/SFX/GunBulletOrganicImpact",
                                StoneObstacle = "/SFX/ArrowWallHitClankSmall",
                                BrickObstacle = "/SFX/ArrowWallHitClankSmall",
                                MetalObstacle = "/SFX/ArrowWallHitClankSmall",
                            },
                        },
                    },
                },
    
                AddOutgoingDamageModifiers =
                {
                    ValidWeapons = { "SniperGunWeapon", "SniperGunWeaponDash" },
                    ValidWeaponMultiplier =
                    {
                        BaseValue = 3.0,
                        SourceIsMultiplier = true,
                    },
                    ExtractValues =
                    {
                        {
                            Key = "ValidWeaponMultiplier",
                            ExtractAs = "TooltipDamageBonus",
                            Format = "Percent",
                        },
                    }
                },
    
                WeaponDataOverride =
                {
                    GunWeapon =
                    {
                        Sounds =
                        {
                            FireSounds =
                            {
                                { Name = "/SFX/Player Sounds/ZagreusGunFire" },
                                { Name = "/Leftovers/SFX/AuraPerfectThrow" },
                            },
                            ImpactSounds =
                            {
                                Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
                                Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
                                Bone = "/SFX/ArrowMetalBoneSmash",
                                Brick = "/SFX/ArrowMetalStoneClang",
                                Stone = "/SFX/ArrowMetalStoneClang",
                                Organic = "/SFX/GunBulletOrganicImpact",
                                StoneObstacle = "/SFX/ArrowWallHitClankSmall",
                                BrickObstacle = "/SFX/ArrowWallHitClankSmall",
                                MetalObstacle = "/SFX/ArrowWallHitClankSmall",
                            },
                        },
                    },
    
                    GunWeaponDash =
                    {
                        Sounds =
                        {
                            FireSounds =
                            {
                                { Name = "/SFX/Player Sounds/ZagreusGunFire" },
                                { Name = "/Leftovers/SFX/AuraPerfectThrow" },
                            },
                            ImpactSounds =
                            {
                                Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
                                Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
                                Bone = "/SFX/ArrowMetalBoneSmash",
                                Brick = "/SFX/ArrowMetalStoneClang",
                                Stone = "/SFX/ArrowMetalStoneClang",
                                Organic = "/SFX/GunBulletOrganicImpact",
                                StoneObstacle = "/SFX/ArrowWallHitClankSmall",
                                BrickObstacle = "/SFX/ArrowWallHitClankSmall",
                                MetalObstacle = "/SFX/ArrowWallHitClankSmall",
                            },
                        },
                    },
    
                    SniperGunWeapon =
                    {
                        Sounds =
                        {
                            FireSounds =
                            {
                                { Name = "/SFX/Player Sounds/ZagreusGunFire" },
                                { Name = "/Leftovers/SFX/AuraPerfectThrow" },
                            },
                            ImpactSounds =
                            {
                                Invulnerable = "/SFX/Player Sounds/ZagreusShieldRicochet",
                                Armored = "/SFX/Player Sounds/ZagreusShieldRicochet",
                                Bone = "/SFX/ArrowMetalBoneSmash",
                                Brick = "/SFX/ArrowMetalStoneClang",
                                Stone = "/SFX/ArrowMetalStoneClang",
                                Organic = "/SFX/GunBulletOrganicImpact",
                                StoneObstacle = "/SFX/ArrowWallHitClankSmall",
                                BrickObstacle = "/SFX/ArrowWallHitClankSmall",
                                MetalObstacle = "/SFX/ArrowWallHitClankSmall",
                            },
                        },
                    },
                },
            }
        end
        if PAB.Config.Gameplay.ExtraHammers.SuperGunManualReloadTrait.Enabled then
            local config = PAB.Config.Gameplay.ExtraHammers.BowChainPerfectShotTrait
            TraitData.BowChainPerfectShotTrait =
            {
                InheritFrom = { "WeaponTrait" },
                Icon = "Weapon_Bow_06",
                RequiredWeapon = "BowWeapon",
                RequiredFalseTraits = {"BowTapFireTrait"},
                BonusDamagePerShot = config.BonusDamagePerShot,
                BonusCap = config.BonusCap,
                ExtractValues =
                {
                    {
                        Key = "BonusDamagePerShot",
                        ExtractAs = "TooltipDamageBonus",
						Format = "Percent",
				        SkipAutoExtract = true
                    },
                    {
                        Key = "BonusCap",
                        ExtractAs = "TooltipBonusCap",
				        SkipAutoExtract = true
                    }
                }
            }
        end
    end

    if PAB.Config.Gameplay.OldChaosShield.Enabled then

        table.insert(TraitData.ShieldRushBonusProjectileTrait.PropertyChanges,
        {
            WeaponName = "ChaosShieldThrow",
            ProjectileProperty = "Speed",
            ChangeValue = 2600,
            ChangeType = "Absolute",
            ExcludeLinked = true,
        })
        table.insert(TraitData.ShieldRushBonusProjectileTrait.PropertyChanges,
        {
            WeaponName = "ChaosShieldThrow",
            ProjectileProperty = "NumJumps",
            ChangeValue = 2,
            ChangeType = "Absolute",
            ExcludeLinked = true,
        })
        table.insert(TraitData.ShieldRushBonusProjectileTrait.PropertyChanges,
        {
            WeaponName = "ChaosShieldThrow",
            WeaponProperty = "ProjectileAngleOffset",
            ChangeValue = math.rad(72),
            ChangeType = "Absolute",
            ExcludeLinked = true,
        })
    end

    if PAB.Config.Gameplay.BetterBalance.Enabled then
        local config = PAB.Config.Gameplay.BetterBalance
        local temp
        --Frost Strike
        TraitData.DemeterWeaponTrait.AddOutgoingDamageModifiers.ValidWeaponMultiplier.BaseValue = config.FrostStrikeBaseDamage
        --Frost Flourish
        TraitData.DemeterSecondaryTrait.AddOutgoingDamageModifiers.ValidWeaponMultiplier.BaseValue = config.FrostFlourishBaseDamage
        --Mistral Dash
        if config.MistralDashHitCount > 1 then
            TraitData.DemeterRushTrait.ModTextOverride = "DemeterRushTrait_Modded"
            TraitData.DemeterRushTrait.HitCount = config.MistralDashHitCount
            table.insert(TraitData.DemeterRushTrait.ExtractValues, 
        {
                Key = "HitCount",
                ExtractAs = "TooltipTickRate"
            })
        end
        table.insert(TraitData.DemeterRushTrait.PropertyChanges,
        {
            WeaponNames = WeaponSets.HeroRushWeapons,
            ProjectileName = "DemeterIce",
            ProjectileProperty = "TotalFuse",
            ChangeValue = config.MistralDashHitCount * 0.5,
            ChangeType = "Absolute"
        })
        -- Killing Freeze
        if config.KillingFreezePommable then
            TraitData.MaximumChillBonusSlow.RequiredFalseTrait = nil
            for _, propertyChange in pairs(TraitData.MaximumChillBonusSlow.PropertyChanges) do
                -- Decay damage
                if propertyChange.BaseValue ~= nil and propertyChange.BaseValue == 20 then
                    propertyChange.IdenticalMultiplier = { Value = -0.6}
                -- Slow
                elseif propertyChange.BaseValue ~= nil and propertyChange.BaseValue == 0.9 then
                    propertyChange.IdenticalMultiplier = { Value = -1.0}
                end
            end
        end
        -- Arctic Blast
        if config.ArcticBlastPommable then
            TraitData.MaximumChillBlast.RequiredFalseTrait = nil
            for _, propertyChange in pairs(TraitData.MaximumChillBlast.PropertyChanges) do
                if propertyChange.BaseMin ~= nil and propertyChange.BaseMin == 80 then
                    propertyChange.IdenticalMultiplier = { Value = -0.8}
                end
            end
        end
        -- Ravenous Will
        if config.RavenousWillPommable then
            TraitData.ZeroAmmoBonusTrait.RequiredFalseTrait = nil
        end
        --  Demeter's aid
        for _, propertyChange in pairs(TraitData.DemeterShoutTrait.PropertyChanges) do
            if propertyChange.BaseMin ~= nil and propertyChange.BaseMin == 10 then
                propertyChange.BaseMin = config.DemeterAidBaseDamage
                propertyChange.BaseMax = config.DemeterAidBaseDamage
            end
        end
        table.insert(TraitData.DemeterShoutTrait,{
            WeaponNames = { "DemeterSuper", "DemeterMaxSuper", },
            ProjectileProperty = "BlastSpeed",
            ChangeValue = config.DemeterAidExpansionSpeed,
            ChangeType = "Multiply",
            ExcludeLinked = true,
        })
        -- Cold Embrace
        TraitData.SelfLaserTrait.AddOutgoingDamageModifiers.ValidWeaponMultiplier.BaseValue = config.ColdEmbraceBonusDamage
        -- Freezing Vortex
        if config.FreezingVortexSizeChange > 0 then
            TraitData.StationaryRiftTrait.ModTextOverride = "StationaryRiftTrait_Modded"
        end
        for _, propertyChange in pairs(TraitData.StationaryRiftTrait.PropertyChanges) do
            if propertyChange.BaseValue ~= nil and propertyChange.BaseValue == -23 then
                propertyChange.BaseValue = config.FreezingVortexSizeChange
            end
        end
        -- Blizzard Shot
        for _, propertyChange in pairs(TraitData.BlizzardOrbTrait.PropertyChanges) do
            if propertyChange.BaseValue ~= nil and propertyChange.BaseValue == 20 then
                propertyChange.BaseValue = config.BlizzardShotShardDamage
            end
        end
        -- Guan Yu
        for _, propertyChange in pairs(TraitData.SpearSpinTravel.PropertyChanges) do
            -- Dash attack
            if propertyChange.ChangeValue ~= nil and propertyChange.ChangeValue == 30 then
                propertyChange.ChangeValue = config.GuanYuDashAttackDamage
            -- Combo attack 1
            elseif propertyChange.ChangeValue ~= nil and propertyChange.ChangeValue == 40 then
                propertyChange.ChangeValue = config.GuanYuComboAttack1Damage
            -- Special
            elseif propertyChange.ChangeValue ~= nil and propertyChange.ChangeValue == 45 then
                propertyChange.ChangeValue = config.GuanYuSpecialDamage
            -- Combo attack 2
            elseif propertyChange.ChangeValue ~= nil and propertyChange.ChangeValue == 60 then
                propertyChange.ChangeValue = config.GuanYuComboAttack2Damage
            -- Combo attack 3
            elseif propertyChange.ChangeValue ~= nil and propertyChange.ChangeValue == 100 then
                propertyChange.ChangeValue = config.GuanYuComboAttack3Damage
            end
        end
        -- Zagreus Shield
        if config.ZagreusShieldIncreaseSpecialDamage then
            TraitData.ShieldBaseUpgradeTrait.ModTextOverride = "ShieldBaseUpgradeTrait_Modded"
            for _, propertyChange in pairs(TraitData.ShieldBaseUpgradeTrait.PropertyChanges) do
                propertyChange.WeaponNames = { "ShieldWeapon", "ShieldWeaponDash", "ShieldThrow" }
            end
        end
        --Parting Shot
        if config.PartingShotUniversalBackstab then
            temp = nil
            TraitData.CastBackstabTrait.ModTextOverride = "CastBackstabTrait_Modded"
        else
            temp = WeaponSets.HeroNonPhysicalWeapons
        end
        TraitData.CastBackstabTrait.AddOutgoingDamageModifiers =
        {
            ValidWeapons = temp,
			HitVulnerabilityMultiplier = { BaseValue = config.PartingShotBonusDamage, SourceIsMultiplier = true },
			ExtractValues =
			{
				{
					Key = "HitVulnerabilityMultiplier",
					ExtractAs = "TooltipDamageBonus",
					Format = "PercentDelta",
				},
			}
        }
        --Nemesis Sword
        table.insert(TraitData.SwordCriticalParryTrait.PropertyChanges, 
        {
                WeaponNames = { "SwordWeapon", "SwordWeapon2", "SwordWeapon3" },
                WeaponProperty = "ChargeTime",
                ChangeValue = config.SwordComboAttacksChargeTime,
                SourceIsMultiplier = true,
                ChangeType = "Multiply",
                ExcludeLinked = true,
            })
        table.insert(TraitData.SwordCriticalParryTrait.PropertyChanges, 
        {
                WeaponName = "SwordWeapon3",
                ProjectileProperty = "ImpactVelocity",
                ChangeValue = config.SwordThrustKnockBack,
                ChangeType = "Absolute",
                ExcludeLinked = true,
            })
        table.insert(TraitData.SwordCriticalParryTrait.PropertyChanges, 
        {
                WeaponName = "SwordWeapon",
                EffectName = "SwordDisable",
                EffectProperty = "Duration",
                ChangeValue = config.SwordSlashDisabledDuration,
                SourceIsMultiplier = true,
                ChangeType = "Multiply",
                ExcludeLinked = true,
            })

        --Poseidon Sword
        table.insert(TraitData.DislodgeAmmoTrait.PropertyChanges, 
        {
                WeaponNames = { "SwordWeapon", "SwordWeapon2", "SwordWeapon3" },
                WeaponProperty = "ChargeTime",
                ChangeValue = config.SwordComboAttacksChargeTime,
                SourceIsMultiplier = true,
                ChangeType = "Multiply",
                ExcludeLinked = true,
            })
        table.insert(TraitData.DislodgeAmmoTrait.PropertyChanges, 
        {
                WeaponName = "SwordWeapon3",
                ProjectileProperty = "ImpactVelocity",
                ChangeValue = config.SwordThrustKnockBack,
                ChangeType = "Absolute",
                ExcludeLinked = true,
            })
        table.insert(TraitData.DislodgeAmmoTrait.PropertyChanges, 
        {
                WeaponName = "SwordWeapon",
                EffectName = "SwordDisable",
                EffectProperty = "Duration",
                ChangeValue = config.SwordSlashDisabledDuration,
                SourceIsMultiplier = true,
                ChangeType = "Multiply",
                ExcludeLinked = true,
            })
        -- Hades Spear
        if config.HadesSpearGlobalSweepBuff then
            TraitData.SpearWeaveTrait.ModTextOverride = "SpearWeaveTrait_Modded"
        end
        for _, propertyChange in pairs(TraitData.SpearWeaveTrait.PropertyChanges) do
            if propertyChange.BaseValue ~= nil and propertyChange.BaseValue == 0.30 then
                propertyChange.BaseValue = config.HadesSpearBaseSweepBuff
            end
        end
        -- Hoarding slash
        TraitData.SwordGoldDamageTrait.AddOutgoingDamageModifiers.GoldMultiplier = config.HoardingSlashGoldMultiplier
        if config.CursedSlashWorksOnDashStrikes then
            TraitData.SwordCursedLifeStealTrait.AddOutgoingLifestealModifiers.ValidWeapons = { "SwordWeapon", "SwordWeapon2", "SwordWeapon3", "SwordWeaponDash" }
        end
        if config.ShadowSlashWorksOnDashStrikes then
            TraitData.SwordBackstabTrait.AddOutgoingDamageModifiers.ValidWeapons = { "SwordWeapon", "SwordWeapon2", "SwordWeapon3", "SwordWeaponDash" }
        end
        -- Flurry slash
        if config.FlurrySlashDealsRampingDamage then
            table.insert(TraitData.SwordTwoComboTrait.PropertyChanges,
            {
                WeaponNames = { "SwordWeapon", "SwordWeapon2" },
                ProjectileName = "SwordWeapon",
                ProjectileProperty = "ConsecutiveHitWindow",
                ChangeValue = 0.8,
                ChangeType = "Absolute",
            })
            table.insert(TraitData.SwordTwoComboTrait.PropertyChanges,
            {
                WeaponNames = { "SwordWeapon", "SwordWeapon2" },
                ProjectileName = "SwordWeapon",
                ProjectileProperty = "DamagePerConsecutiveHit",
                ChangeValue = 5,
                ChangeType = "Absolute",
                DeriveSource = "DamageSource",
                ExtractValue =
                {
                    ExtractAs = "TooltipDamage",
                },
                ExtractSource = "ExtractSource",
            })
            table.insert(TraitData.SwordTwoComboTrait.PropertyChanges,
            {
                WeaponNames = { "SwordWeapon", "SwordWeapon2" },
                ProjectileName = "SwordWeapon2",
                ProjectileProperty = "DamagePerConsecutiveHit",
                ChangeValue = 5,
                ChangeType = "Absolute",
                DeriveSource = "DamageSource",
                ExtractValue =
                {
                    ExtractAs = "TooltipDamage",
                },
                ExtractSource = "ExtractSource",
            })
        end
        -- Super nova
        TraitData.SwordSecondaryAreaDamageTrait.AddOutgoingDamageModifiers.ValidWeaponMultiplier = config.SuperNovaDamageMultiplier
        TraitData.SwordSecondaryAreaDamageTrait.PropertyChanges[1].ChangeValue = config.SuperNovaRangeMultiplier
        -- Double nova
        TraitData.SwordSecondaryDoubleAttackTrait.PropertyChanges[2].ChangeValue = config.DoubleNovaDamageInterval
        -- Glacial glare
        if config.GlacialGlarePrereqForArcticBlastAndKillingFreeze then
            LootData.DemeterUpgrade.LinkedUpgrades.MaximumChillBlast.OneOf ={ "DemeterWeaponTrait", "DemeterSecondaryTrait", "DemeterRushTrait",
            "DemeterShoutTrait", "ShieldLoadAmmo_DemeterRangedTrait", "CastNovaTrait", "DemeterRangedBonusTrait"}
            LootData.DemeterUpgrade.LinkedUpgrades.MaximumChillBonusSlow.OneOf ={ "DemeterWeaponTrait", "DemeterSecondaryTrait", "DemeterRushTrait",
            "DemeterShoutTrait", "ShieldLoadAmmo_DemeterRangedTrait", "CastNovaTrait", "DemeterRangedBonusTrait"}
        end
        --Beowulf mirage shot
        if config.BeowulfMirageShotBugFix then
            for i, propertyChange in pairs(TraitData.ShieldLoadAmmoTrait.PropertyChanges) do
                if propertyChange.ProjectileProperty ~= nil and propertyChange.ProjectileProperty == "Type" then
                    TraitData.ShieldLoadAmmoTrait.PropertyChanges[i] =
                    {
                        WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                        ProjectileProperty = "Fuse",
                        ChangeValue = 0,
                        ChangeType = "Absolute",
                    }
                end
            end
            for traitName, traitData in pairs(TraitData) do
                if traitData.PropertyChanges ~= nil then
                    for i, propertyChange in pairs(traitData.PropertyChanges) do
                        if propertyChange.TraitName ~= nil and propertyChange.TraitName == "ShieldLoadAmmoTrait" and propertyChange.ProjectileProperty ~= nil and propertyChange.ProjectileProperty == "Type" then
                            traitData.PropertyChanges[i] =
                            {
                                TraitName = "ShieldLoadAmmoTrait",
                                WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                                ProjectileProperty = "Fuse",
                                ChangeValue = 0,
                                ChangeType = "Absolute",
                            }
                        end
                    end
                end
            end
            table.insert(TraitData.ShieldLoadAmmo_AphroditeRangedTrait.PropertyChanges,
            {
                WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                ProjectileProperty = "Type",
                ChangeValue = "HOMING",
                ChangeType = "Absolute",
            })
            table.insert(TraitData.ShieldLoadAmmo_AphroditeRangedTrait.PropertyChanges,
            {
                WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                ProjectileProperty = "Fuse",
                ChangeValue = 0,
                ChangeType = "Absolute",
            })
            table.insert(TraitData.ShieldLoadAmmo_AthenaRangedTrait.PropertyChanges,
            {
                WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                ProjectileProperty = "Type",
                ChangeValue = "HOMING",
                ChangeType = "Absolute",
            })
            table.insert(TraitData.ShieldLoadAmmo_AthenaRangedTrait.PropertyChanges,
            {
                WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                ProjectileProperty = "Fuse",
                ChangeValue = 0,
                ChangeType = "Absolute",
            })
        end
        -- Thunder flare
        if config.ThunderFlareRemake then
            TraitData.ShieldLoadAmmo_ZeusRangedTrait.PreEquipWeapons = nil
            TraitData.ShieldLoadAmmo_ZeusRangedTrait.PropertyChanges =
            {
                {
                    WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                    ProjectileProperty = "Projectile",
                    ChangeValue = "ZeusProjectile",
                    ChangeType = "Absolute",
                },
                {
                    WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                    ProjectileProperty = "DamageLow",
                    BaseMin = 60,
                    BaseMax = 60,
                    DepthMult = 0.0,
                    IdenticalMultiplier =
                    {
                        Value = -0.60,
                    },
                    ExtractValue =
                    {
                        ExtractAs = "TooltipDamage",
                    }
                },
                {
                    WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                    ProjectileProperty = "DamageHigh",
                    DeriveValueFrom = "DamageLow"
                },
                {
                    WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                    WeaponProperty = "FireOnRelease",
                    ChangeValue = false,
                    ChangeType = "Absolute",
                },
                {
                    WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                    ProjectileProperty = "DamageRadius",
                    ChangeValue = 300
                },
                {
                    WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                    ProjectileProperty = "DetonateGraphic",
                    ChangeValue = "RadialNovaSwordParry-Zeus"
                },
                {
                    WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                    EffectName = "OnHitStun",
                    EffectProperty = "Active",
                    ChangeValue = false,
                    ChangeType = "Absolute",
                },
            }
            if config.BeowulfMirageShotBugFix then
                table.insert(TraitData.ShieldLoadAmmo_ZeusRangedTrait.PropertyChanges,
                {
                    WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                    ProjectileProperty = "Fuse",
                    ChangeValue = 0,
                    ChangeType = "Absolute",
                })
            else
                table.insert(TraitData.ShieldLoadAmmo_ZeusRangedTrait.PropertyChanges,
                {
                    WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                    ProjectileProperty = "Type",
                    ChangeValue = "INSTANT",
                    ChangeType = "Absolute",
                })
            end
        end
        -- Clockets
        if config.ClusterBombsRocketBombBugFix then
            table.insert(TraitData.GunExplodingSecondaryTrait.PropertyChanges,
        {
                TraitName = "GunGrenadeClusterTrait",
                WeaponName = "GunGrenadeToss",
                ProjectileProperty = "DamageLow",
                ChangeValue = 0.7,
                ChangeType = "Multiply",
                ExcludeLinked = true,
            })
            table.insert(TraitData.GunExplodingSecondaryTrait.PropertyChanges,
        {
                TraitName = "GunGrenadeClusterTrait",
                WeaponName = "GunGrenadeToss",
                ProjectileProperty = "DamageHigh",
                ChangeValue = 0.7,
                ChangeType = "Multiply",
                ExcludeLinked = true,
            })
        end
        table.insert(TraitData.GunGrenadeFastTrait.PropertyChanges,
    {
            TraitName = "GunExplodingSecondaryTrait",
            WeaponNames = { "GunGrenadeToss" },
            WeaponProperty = "MinChargeToFire",
            ChangeValue = config.TripleBombsRocketBombFireInterval,
            ChangeType = "Absolute",
            ExcludeLinked = true,
        })

    end
end