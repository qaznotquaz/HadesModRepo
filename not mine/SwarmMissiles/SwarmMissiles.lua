--[[
    SwarmMissiles
    Author:
        raisins (Discord: raisins77#5716)

   Adds a new special for the gun. Modifies the Zagreus Aspect.
]]
ModUtil.RegisterMod("SwarmMissiles")

local config = {
	Enabled = true,             --true to activate mod
	MaxMissiles = 16,           --max charged barrage with fully upgraded weapon (Lv 1 is half)
	ExtraMissilesPerShot = 1,   --gunshots add this many missiles
	FastExtraMissiles = 4,      --until this many missiles added, gunshots add double per shot
	--fractions ok, i think
}

SwarmMissiles.config = config


if SwarmMissiles.config.Enabled then

-- weapon and projectile changes
local weaponData = {
	--actual changes
	ProjectileAngleOffset = math.rad(247.5),
	ProjectileOffsetStart = "LEFT",
	ProjectileInterval = 0.03,
	NumProjectiles = 1,
	--NumProjectiles = 16,
	ReloadTime = 1.0,
	--defaults from gun/bow
	RootOwnerWhileFiring = false,
	BlockMoveInput = false,
	CancelMovement = false,
	ChargeCancelMovement = false,
	AcceptTriggerLockRequests = true,
	AuraAimLine = true,
	AllowExternalForceRelease = false,
	AutoLockArcDistance = 90,
	AutoLockRange = 900,
	AutoLockWithMouse = false,
	BarrelLength = 50,
	BelowMinChargeCooldown = 0.2,
	ChargeStartAnimation = "ZagreusGunGrenadeTossCharge",
	ClearFireRequestOnSwap = true,
	DisableOwnerForDuration = 0,
	Enabled = true,
	FireOnRelease = false,
	FullyAutomatic = false,
	LockTriggerForCharge = true,
	ManualAiming = false,
	--not sure about this??
	MinChargeToFire = 1,
	PerfectChargeWindowDuration = 0,
	ProjectileSpacing = 0,
	SelfVelocity = 0,
	--ShowFreeAimLine = false,
	TargetReticleAnimation = "null",
	Type = "GUN",
	--MaxAmmo = 21,
	--SpecialMaxMissiles = 8,
	--ProjectileAngleResetCount = 5,
}

local projectileData = {
	ManuallySetTarget = false,
	Speed = 500.0,
	MaxSpeed = 6000.0,
	Range = 3000.0,
	Acceleration = 2000,
	MaxAdjustRate = math.rad(6000),
	AdjustRateAcceleration = math.rad(650),
	Fuse = 2.5,
	DamageLow = 4,		
	DamageHigh = 4,
	ImpactVelocity = 0,
	DamageRadius = 230,
	DetonateGraphic = "RadialNova",
	DamageRadiusScaleY = 0.5,
	Graphic = "GunGrenadeRocket",
	AttachedAnim = "GrenadierShadow",
	--defaults from gun/bow
	DetonateSound = "/SFX/Enemy Sounds/CrusherAttackImpact",
	--DetonateSound = "/SFX/PlayerHammerExplosions"
	--/Leftovers/SFX/MeteorStrikeQuiet
	--"null"
	Type = "HOMING",
	CheckUnitImpact = true,
	CheckObstacleImpact = true,
	ObstacleCollisionCheck = "PolygonContainsPoint",
	NumPenetrations = 0,
	CriticalFx = "CriticalHit",
	HitVulnerabilityFx = "Backstab",
	UseArmor = true,
	UseVulnerability = true,
	UnpauseFx = "BowSplitShotFlare",
	UnpauseResetLocation = true,
	ProjectileDefenseRadius = 40,
	UseDetonationForProjectileDefense = false,
	DeflectProjectiles = false,
	SpawnOnDetonate = "null",
	--SpawnOnDetonate = "LavaPuddleLarge",
	--SpawnOnDetonate = "MissileLavaPuddle",
	--SpawnOnDeath = "GunWeapon", --fatal exception
	SpawnType = "PROJECTILE",
	--SpawnCount = 1,
}

for propertyName, propertyValue in pairs(weaponData) do
	table.insert(TraitData.GunBaseUpgradeTrait.PropertyChanges,
	{
		WeaponNames = { "GunGrenadeToss" },
		WeaponProperty = propertyName,
		ChangeValue = propertyValue,
		ChangeType = "Absolute",
		ExcludeLinked = true,
	})
end

for propertyName, propertyValue in pairs(projectileData) do
	table.insert(TraitData.GunBaseUpgradeTrait.PropertyChanges,
	{
		WeaponNames = { "GunGrenadeToss" },
		ProjectileProperty = propertyName,
		ChangeValue = propertyValue,
		ChangeType = "Absolute",
		ExcludeLinked = true,
	})
end

--scaling missile limit
ModUtil.MapSetTable( TraitData, {
	GunBaseUpgradeTrait = {
		RarityLevels = {
			Common =
			{
				MinMultiplier = 1.0,
				MaxMultiplier = 1.0,
			},
			Rare =
			{
				MinMultiplier = 1.25,
				MaxMultiplier = 1.25,
			},
			Epic =
			{
				MinMultiplier = 1.5,
				MaxMultiplier = 1.5,
			},
			Heroic =
			{
				MinMultiplier = 1.75,
				MaxMultiplier = 1.75,
			},
			Legendary =
			{
				MinMultiplier = 2.0,
				MaxMultiplier = 2.0,
			}
		},
		SpecialMaxMissiles = {
			BaseValue = SwarmMissiles.config.MaxMissiles / 2,
		},
		ExtractValues = {
			{
			Key = "SpecialMaxMissiles",
			ExtractAs = "TooltipMaxMissile"
			}
		}
	}
})

--gunshot hits add extra missiles

ModUtil.MapSetTable( WeaponData, { 
	GunWeapon = {
		ComboPoints = 1
	},
	GunWeaponDash = {
		ComboPoints = 1
	},
	GunGrenadeToss = {
		OnFiredFunctionName = "CheckMissileComboReset",
		MaxMissilesInfo = 0,
	}
})

table.insert(WeaponData.GunGrenadeToss.CompleteObjectivesOnFire, "GunGrenadeMissile")
	
ModUtil.MapSetTable( ObjectiveData, {
	GunWeaponGunWeave = { Description = "Objective_GunWeaponGunWeave"},
	GunGrenadeMissile = { Description = "Objective_GunGrenadeMissile"}
})

ModUtil.MapSetTable( ObjectiveSetData.GunTutorial, {
	Objectives = { {"GunWeapon", "GunWeaponManualReload", "GunGrenadeMissile", "GunWeaponDash", "GunWeaponGunWeave" } }
})

function CheckMissileCombo( victim, attacker, triggerArgs, sourceWeaponData )
	if sourceWeaponData == nil or sourceWeaponData.ComboPoints == nil or sourceWeaponData.ComboPoints <= 0 then
		return
	end

	if triggerArgs.EffectName ~= nil then
		-- Effects never generate combo points for now
		return
	end

	if victim.NoComboPoints then
		return
	end

	if not HeroHasTrait( "GunBaseUpgradeTrait" ) then
		return
	end

	attacker.MissileComboCount = (attacker.MissileComboCount or 0) + sourceWeaponData.ComboPoints
	
	if attacker.MissileComboCount >= 1 and not attacker.MissileComboFull then
		attacker.MissileComboReady = true
		local maxMissiles = math.floor(GetTotalHeroTraitValue("SpecialMaxMissiles") * GetTotalHeroTraitValue("MissileMaxIncrease", { IsMultiplier = true }) + 0.5)
		local extraMissiles = attacker.MissileComboCount * 2 * SwarmMissiles.config.ExtraMissilesPerShot * GetTotalHeroTraitValue("MissileChargeRate", { IsMultiplier = true })
		if (extraMissiles > SwarmMissiles.config.FastExtraMissiles) then
			extraMissiles = SwarmMissiles.config.FastExtraMissiles + ( 0.5 * ( extraMissiles - SwarmMissiles.config.FastExtraMissiles ))
		end
		if HeroHasTrait( "GunExplodingSecondaryTrait" )then 		--Rocket Bomb hammer
			maxMissiles = math.floor( maxMissiles / 4 + 1 )
			extraMissiles = extraMissiles / 4
		end
		local missileCount = 1 + extraMissiles
		--DebugPrint{ Text = "missileCount is "..missileCount.."/"..maxMissiles }
		missileCount = math.floor( math.min( missileCount , maxMissiles ) )
		SetWeaponProperty({ WeaponName = "GunGrenadeToss", DestinationId = CurrentRun.Hero.ObjectId, Property = "NumProjectiles", Value = missileCount })
		if missileCount >= maxMissiles then
			attacker.MissileComboFull = true
			MissileComboReadyPresentation( attacker, triggerArgs )
		end
	end
end

function CheckMissileComboReset( attacker, weaponData, args )
	if weaponData ~= nil and attacker.MissileComboReady then
		if not args or not args.Undelivered then
			if attacker.MissileComboFull then
				thread(MarkObjectiveComplete, "GunWeaponGunWeave")
				MissileComboFullDeliveredPresentation( attacker, triggerArgs )
			else
				MissileComboDeliveredPresentation( attacker, triggerArgs )
			end
		end
		
		if HeroHasTrait( "GunGrenadeFastTrait" ) and (attacker.MissileComboFastTraitClip > 1) and (not args or not args.Undelivered) then
			--Triple Bomb hammer
			attacker.MissileComboFastTraitClip = attacker.MissileComboFastTraitClip - 1
		else
			attacker.MissileComboFastTraitClip = 3
			attacker.MissileComboReady = false
			attacker.MissileComboFull = false
			attacker.MissileComboCount = 0
			SetWeaponProperty({ WeaponName = "GunGrenadeToss", DestinationId = CurrentRun.Hero.ObjectId, Property = "NumProjectiles", Value = 1 })
		end
	end
end

function MissileComboReadyPresentation( attacker, triggerArgs )
	CreateAnimation({ Name = "FistComboReadyFx", DestinationId = attacker.ObjectId })
	CreateAnimation({ Name = "PowerUpComboReady", DestinationId = attacker.ObjectId })
	CreateAnimation({ Name = "FistComboReadyGlow", DestinationId = attacker.ObjectId })
	if CheckCooldown( "ComboReadyHint", 1.5 ) then
		thread( InCombatText, attacker.ObjectId, "MissileCombo_Ready", 0.8 )
		PlaySound({ Name = "/SFX/Player Sounds/ZagreusFistComboProc", Id = CurrentRun.Hero.ObjectId })
	end
end

function MissileComboFullDeliveredPresentation( attacker, triggerArgs )
	--PlaySound({ Name = "/VO/ZagreusEmotes/EmoteAttacking_FistKick", Id = attacker.ObjectId })
	--PlaySound({ Name = "/VO/ZagreusEmotes/EmotePowerAttacking_Sword", Id = attacker.ObjectId })
	PlaySound({ Name = "/VO/ZagreusEmotes/EmoteSuperSpecial_Fist", Id = attacker.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/AuraPerfectThrow", Id = attacker.ObjectId })
	wait(0.5)
	StopAnimation({ Name = "FistComboReadyFx", DestinationId = attacker.ObjectId })
	StopAnimation({ Name = "FistComboReadyGlow", DestinationId = attacker.ObjectId })
end

function MissileComboDeliveredPresentation( attacker, triggerArgs )
	PlaySound({ Name = "/VO/ZagreusEmotes/EmotePowerAttacking_Sword", Id = attacker.ObjectId })
	PlaySound({ Name = "/Leftovers/SFX/AuraPerfectThrow", Id = attacker.ObjectId })
end

function RemoveGunWeaveBuff()
	StopAnimation({ Name = "FistComboReadyFx", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "PowerUpComboReady", DestinationId = CurrentRun.Hero.ObjectId })
	StopAnimation({ Name = "FistComboReadyGlow", DestinationId = CurrentRun.Hero.ObjectId })
	CheckMissileComboReset( CurrentRun.Hero, WeaponData.GunWeapon, { Undelivered = true } )
end

for weapon, aspect in pairs(WeaponUpgradeData.GunWeapon) do
	if aspect.RequiredInvestmentTraitName == "GunBaseUpgradeTrait" then
		aspect.UnequipFunctionName = "RemoveGunWeaveBuff"
	end
end

ModUtil.WrapBaseFunction("DamageEnemy", function ( baseFunc, victim, triggerArgs)
	local sourceWeaponData = triggerArgs.AttackerWeaponData
	local attacker = triggerArgs.AttackerTable
	thread( CheckMissileCombo, victim, attacker, triggerArgs, sourceWeaponData )
	--ModUtil.Hades.PrintStack( "MissileComboCount: "..attackerDM.MissileComboCount, 1 )
	return baseFunc(victim, triggerArgs)
end, SwarmMissiles)

ModUtil.WrapBaseFunction("SetupHeroObject", function ( baseFunc, currentRun, applyLuaUpgrades )
	local heroObj = baseFunc( currentRun, applyLuaUpgrades )
	currentRun.Hero.MissileComboCount = 0
	currentRun.Hero.MissileComboReady = false
	currentRun.Hero.MissileComboFull = false
	currentRun.Hero.MissileComboFastTraitClip = 3 --Triple Bomb hammer
	currentRun.Hero.MissileMax = math.floor(GetTotalHeroTraitValue("SpecialMaxMissiles") * GetTotalHeroTraitValue("MissileMaxIncrease", { IsMultiplier = true }) + 0.5)
	return heroObj
end, SwarmMissiles)

--mass trait change
--tone down explosion graphics size
local gods = { "Aphrodite", "Ares", "Artemis", "Athena", "Demeter", "Dionysus", "Poseidon", "Zeus",}	
for k, trait in pairs(TraitData) do
	if (trait.Slot == "Secondary") then
		if Contains(gods, trait.God) then
			table.insert(trait.PropertyChanges,
			{
			TraitName = "GunBaseUpgradeTrait",
			WeaponNames = { "GunGrenadeToss" },
			ProjectileProperty = "DetonateGraphic",
			ChangeValue = "RadialNovaSwordParry-"..trait.God,
			ChangeType = "Absolute",
			ExcludeLinked = true,
			})
		end
	end
end

--athena needs to relax
table.insert(TraitData.AthenaSecondaryTrait.PropertyChanges,
{
	TraitName = "GunBaseUpgradeTrait",
	WeaponNames = { "GunGrenadeToss" },
	ProjectileProperty = "ProjectileDefenseRadius",
	ChangeValue = 40,
	ChangeType = "Absolute",
	ExcludeLinked = true,
})

--zeus needs to relax (interaction with Burn Swarm)
ModUtil.WrapBaseFunction("AddOnDamageWeapons", function ( baseFunc, hero, weaponName, upgradeData )
	if upgradeData.AddOnDamageWeapons == nil then
		return
	end
	if weaponName == "GunGrenadeToss" then
		for k, onDamageWeapon in pairs( upgradeData.AddOnDamageWeapons ) do
			if onDamageWeapon == "LightningStrikeSecondary" then
				upgradeData.OnDamageWeaponProperties = { FirstHitOnly = true, FireFromVictimLocation = true}
			end
		end
	end	
	return baseFunc( hero, weaponName, upgradeData )
end, SwarmMissiles)

--Hammers
--disable hammers: Hazard Bomb, Targeting System, Cluster Bomb
local conflictingHammers = { "GunGrenadeDropTrait", "GunSlowGrenade", "GunGrenadeClusterTrait" }
for k, hammer in pairs(conflictingHammers) do
	if TraitData[hammer].RequiredFalseTraits ~= nil then
		table.insert(TraitData[hammer].RequiredFalseTraits, "GunBaseUpgradeTrait")
	else
		TraitData[hammer].RequiredFalseTraits = { "GunBaseUpgradeTrait" }
	end
end

--Rocket Bomb
table.insert(TraitData.GunExplodingSecondaryTrait.RequiredFalseTraits, "GunGrenadeGhostTrait")
table.insert(TraitData.GunExplodingSecondaryTrait.PropertyChanges,
{
	TraitName = "GunBaseUpgradeTrait",
	WeaponName = "GunGrenadeToss",
	WeaponProperty = "ProjectileInterval",
	ChangeValue = 0, --0.01
	ChangeType = "Absolute",
})
table.insert(TraitData.GunExplodingSecondaryTrait.PropertyChanges,
{
	TraitName = "GunBaseUpgradeTrait",
	WeaponName = "GunGrenadeToss",
	WeaponProperty = "ProjectileAngleOffset",
	ChangeValue = math.rad(3), --  math.rad(269.5),
	ChangeType = "Absolute",
})
-- table.insert(TraitData.GunExplodingSecondaryTrait.PropertyChanges,
-- {
	-- TraitName = "GunBaseUpgradeTrait",
	-- ExcludeProjectileName = "GunGrenadeSelfDamage",
	-- WeaponName = "GunGrenadeToss",
	-- ProjectileProperty = "DamageLow",
	-- ChangeValue = 20,
	-- ChangeType = "Absolute",
-- })
-- table.insert(TraitData.GunExplodingSecondaryTrait.PropertyChanges,
-- {
	-- TraitName = "GunBaseUpgradeTrait",
	-- ExcludeProjectileName = "GunGrenadeSelfDamage",
	-- WeaponName = "GunGrenadeToss",
	-- ProjectileProperty = "DamageHigh",
	-- ChangeValue = 20,
	-- ChangeType = "Absolute",
-- })

--Ghost Swarm
ModUtil.MapSetTable( TraitData, {
	GunGrenadeGhostTrait =
	{
		Name = "GunGrenadeGhostTrait",
		Frame = "Hammer",
		InheritFrom = { "WeaponTrait" },
		Icon = "Weapon_Gun_15",
		RequiredWeapon = "GunWeapon",
		RequiredTrait = "GunBaseUpgradeTrait",
		RequiredFalseTraits = { "GunExplodingSecondaryTrait" },
		PropertyChanges =
		{
			{
				TraitName = "GunBaseUpgradeTrait",
				WeaponNames = { "GunGrenadeToss" },
				ProjectileProperty = "CheckObstacleImpact",
				ChangeValue = false,
				ChangeType = "Absolute",
				ExcludeLinked = true,
			},			
		},
	}
})

--Itano Circus
ModUtil.MapSetTable( TraitData, {
	GunGrenadeCircusTrait =
	{
		Name = "GunGrenadeCircusTrait",
		Frame = "Hammer",
		InheritFrom = { "WeaponTrait" },
		Icon = "Weapon_Gun_10",
		RequiredWeapon = "GunWeapon",
		RequiredTrait = "GunBaseUpgradeTrait",
		MissileMaxIncrease = {
			BaseValue = 1.5,
			SourceIsMultiplier = true,
		},
		MissileChargeRate = {
			BaseValue = 2.0,
			SourceIsMultiplier = true,
		},
		ExtractValues =
		{
			{
				Key = "MissileMaxIncrease",
				ExtractAs = "TooltipMissileMaxIncrease",
				Format = "PercentDelta",
			},
			{
				Key = "MissileChargeRate",
				ExtractAs = "TooltipMissileChargeRate",
				Format = "PercentDelta",
			},
		}
	}
})

--Incendiary Swarm
ModUtil.MapSetTable( TraitData, {
	GunGrenadeBurnTrait =
	{
		Name = "GunGrenadeBurnTrait",
		Frame = "Hammer",
		InheritFrom = { "WeaponTrait" },
		Icon = "Weapon_Gun_06",
		RequiredWeapon = "GunWeapon",
		RequiredTrait = "GunBaseUpgradeTrait",
		PropertyChanges =
		{
			{
				--TraitName = "GunBaseUpgradeTrait",
				WeaponNames = { "GunGrenadeToss" },
				EffectName = "BurnDot",
				EffectProperty = "Active",
				ChangeValue = true,
				ExcludeLinked = true,
			},
			{
				WeaponName = "GunGrenadeToss",
				EffectName = "DamageOverTime",
				EffectProperty = "Amount",
				BaseMin = 1,
				BaseMax = 1,
				ChangeType = "Absolute",
				IdenticalMultiplier =
				{
					Value = DuplicateMultiplier,
				},
				ExtractValue =
				{
					ExtractAs = "TooltipBurnDamage",
				}
			}
		},
		ExtractValues =
		{
			{
				ExtractAs = "TooltipBurnDuration",
				SkipAutoExtract = true,
				External = true,
				BaseType = "Effect",
				WeaponName = "GunGrenadeToss",
				BaseName = "BurnDot",
				BaseProperty = "Duration",
			},
			{
				ExtractAs = "TooltipBurnStacks",
				SkipAutoExtract = true,
				External = true,
				BaseType = "Effect",
				WeaponName = "GunGrenadeToss",
				BaseName = "BurnDot",
				BaseProperty = "MaxStacks",
			},
			{
				ExtractAs = "TooltipBurnRate",
				SkipAutoExtract = true,
				External = true,
				BaseType = "Effect",
				WeaponName = "GunGrenadeToss",
				BaseName = "BurnDot",
				BaseProperty = "Cooldown",
				DecimalPlaces = 2,
			},
		}
	}
})

function SwarmMissilesDataInsist()
	-- DebugCodexMenuTest( "GunGrenadeFastTrait" )
	-- DebugCodexMenuTest( "GunGrenadeCircusTrait" )
	if not Contains(LootData.WeaponUpgrade.Traits, "GunGrenadeGhostTrait") then
		table.insert(LootData.WeaponUpgrade.Traits, "GunGrenadeGhostTrait")
		table.insert(LootData.WeaponUpgrade.Traits, "GunGrenadeCircusTrait")
		table.insert(LootData.WeaponUpgrade.Traits, "GunGrenadeBurnTrait")
	end
	if not ContainsAnyKey(LootData.WeaponUpgrade.TraitIndex, { "GunGrenadeGhostTrait" }) then
		ModUtil.MapSetTable( LootData, {
			WeaponUpgrade = {
				TraitIndex = {
					GunGrenadeGhostTrait = true,
					GunGrenadeCircusTrait = true,
					GunGrenadeBurnTrait = true,
				}
			}
		})
	end
	if CodexMenuData ~= nil and not Contains(CodexMenuData.GunWeapon, "GunGrenadeGhostTrait") then
		table.insert(CodexMenuData.GunWeapon, "GunGrenadeGhostTrait")
		table.insert(CodexMenuData.GunWeapon, "GunGrenadeCircusTrait")
		table.insert(CodexMenuData.GunWeapon, "GunGrenadeBurnTrait")
		for _,value in ipairs(CodexMenuData.GodNames) do
			CodexMenuData[value.."Inverted"]=CustomInvertTable(CodexMenuData[value])
		end
	end
end

OnPreThingCreation { SwarmMissilesDataInsist }

--tootip popup
table.insert(KeywordList, "MissileBarrage_Unequipped")
table.insert(KeywordList, "MissileBarrage")
table.insert(KeywordList, "MissileBarrage2")
table.insert(KeywordList, "Burn")
ResetKeywords()

-- function DebugCodexMenuTest( traitString )
		-- --local Jtest1 = "IsHammerBoon("..traitString..") == false, "
		-- local Jtest2 = "IsHermesChaosHammerCharonBoon("..traitString..") == false, "
		-- local Jtest3 = "ContainsAnyKey(LootData.WeaponUpgrade.TraitIndex, { "..traitString.." }) == false, "
		-- -- if IsHammerBoon(traitString) then
			-- -- Jtest1 = "IsHammerBoon("..traitString..") == true, "
		-- -- end
		-- if IsHermesChaosHammerCharonBoon(traitString) then
			-- Jtest2 = "IsHermesChaosHammerCharonBoon("..traitString..") == true, "
		-- end
		-- if ContainsAnyKey(LootData.WeaponUpgrade.TraitIndex, { traitString }) then
			-- Jtest3 = "ContainsAnyKey(LootData.WeaponUpgrade.TraitIndex, { "..traitString.." }) == true, "
		-- end
		-- DebugPrint{ Text = "Codex test. "..Jtest2..Jtest3 }
-- end


end