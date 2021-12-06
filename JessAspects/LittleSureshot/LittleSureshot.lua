--[[
     ___                       _           ___    ___            _
    | . | ___ ___  ___  ___  _| |_    ___ | |    | . | _ _  _ _ [_] ___
    |   |[_-[| . \/ ._]/ | '  | |    / . \| |-   |   || ' || ' || |/ ._]
    |_|_|/__/|  _/\___.\_|_.  |_|    \___/|_|    |_|_||_|_||_|_||_|\___.
             |_|
]]

if JessAspects.Config.LittleSureshot then
	ModUtil.RegisterMod("LittleSureshot")

	-- REPLACING: Aspect of Hestia, aka GunManualReloadTrait

	-- base shot changes --
	local gunWeaponData = {
		-- no scatter
		Scatter = 0,
		ScatterCap = 0,

		-- much higher cooldown
		Cooldown = 0.5,

		-- six-shooter
		MaxAmmo = 6,
		FullyAutomatic = false,
		ChargeTimeFrames = 8
	}

	local gunWeaponDashData = {
		-- give this a cooldown
		Cooldown = 0.2
	}

	local gunProjectileData = {
		-- longer range
		Range = 1100.0,
		Speed = 9000.0,

		-- higher damage
		DamageLow = 30,
		DamageHigh = 30,

		-- can crit!
		CriticalHitChance = 0.17
	}

	for propertyName, propertyValue in pairs(gunWeaponData) do
		table.insert(TraitData.GunManualReloadTrait.PropertyChanges,
				{
					WeaponNames = { "GunWeapon" },
					WeaponProperty = propertyName,
					ChangeValue = propertyValue,
					ChangeType = "Absolute",
					ExcludeLinked = true,
				})
	end

	for propertyName, propertyValue in pairs(gunWeaponDashData) do
		table.insert(TraitData.GunManualReloadTrait.PropertyChanges,
				{
					WeaponNames = { "GunWeaponDash" },
					WeaponProperty = propertyName,
					ChangeValue = propertyValue,
					ChangeType = "Absolute",
					ExcludeLinked = true,
				})
	end

	for propertyName, propertyValue in pairs(gunProjectileData) do
		table.insert(TraitData.GunManualReloadTrait.PropertyChanges,
				{
					WeaponNames = { "GunWeapon" },
					ProjectileProperty = propertyName,
					ChangeValue = propertyValue,
					ChangeType = "Absolute",
					ExcludeLinked = true,
				})
	end

	-- special changes --
	local bombProjectileData = {
		SpawnOnDetonate = "DionysusField", "RubbleFallLarge"
	}

	for propertyName, propertyValue in pairs(bombProjectileData) do
		table.insert(TraitData.GunManualReloadTrait.PropertyChanges,
				{
					WeaponNames = { "GunGrenadeToss" },
					ProjectileProperty = propertyName,
					ChangeValue = propertyValue,
					ChangeType = "Absolute",
					ExcludeLinked = true,
				})
	end
end