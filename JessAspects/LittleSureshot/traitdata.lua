if JessAspect.Config.LittleSureshot then
	--[[
	TraitData.GunLittleSureshotTrait =
	{
		InheritFrom = { "WeaponEnchantmentTrait" },
		CustomTrayText = "GunLittleSureshotTrait_Tray",
		PostWeaponUpgradeScreenAnimation = "ZagreusGunAlt01ReloadEnd",
		RequiredWeapon = "GunWeapon",
		PostWeaponUpgradeScreenAngle = 210,
		RarityLevels =
		{
			Common =
			{
				MinMultiplier = 1.0,
				MaxMultiplier = 1.0,
			},
			Rare =
			{
				MinMultiplier = 2.0,
				MaxMultiplier = 2.0,
			},
			Epic =
			{
				MinMultiplier = 3.0,
				MaxMultiplier = 3.0,
			},
			Heroic =
			{
				MinMultiplier = 4.0,
				MaxMultiplier = 4.0,
			},
			Legendary =
			{
				MinMultiplier = 5.0,
				MaxMultiplier = 5.0,
			},
			Icon = "WeaponEnchantment_Gun03",

		},
		Icon = "WeaponEnchantment_Gun03",

		WeaponBinks =
		{
			"ZagreusGun01_Bink",
			"ZagreusGun01Run_Bink",
			"ZagreusGun01GrenadeToss_Bink",
			"ZagreusGun01Stop_Bink",
			"ZagreusGun01FireEmpty_Bink",
		},

		PropertyChanges = {
			-- Levelling Crit Chance? Right?
			{
				WeaponName = { "GunWeapon" },
				ProjectileProperty = "CriticalHitChance",
				BaseValue = 0.17,
				ChangeType = "Add",
				ExcludeLinked = true,
				ExtractValue =
				{
					ExtractAs = "TooltipCritDamageBonus",
					Format = "Percent",
				}
			}
		}
	}

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

	local gunProjectileData = {
		-- longer range
		Range = 1100.0,
		Speed = 9000.0,

		-- higher damage
		DamageLow = 30,
		DamageHigh = 30,

		-- can crit!
		-- CriticalHitChance depends on level
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
	]]--
    -- Trait specific changes

    -- for traitName, traitData in pairs(TraitData) do
    -- end

    -- Hammers
end