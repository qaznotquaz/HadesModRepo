if JessAspects_BoonsAsAspects.Config.Enabled then
    -- Stygian Blade ★ Poseidon's Flourish --
    JessAspects_BoonsAsAspects.Data.SwordPoseidon = {
        Costs = { 3, 3, 3, 3, 3 },
        MaxUpgradeLevel = 5,
        TraitName = "SwordPoseidonSecondaryTrait",
    }
    table.insert(WeaponUpgradeData.SwordWeapon, JessAspects_BoonsAsAspects.Data.SwordPoseidon)

    --[[

    -- Eternal Spear ★ Hades' Call --
    table.insert(WeaponUpgradeData.SpearWeapon,
            {
                Costs = { 3, 3, 3, 3, 3 },
                MaxUpgradeLevel = 5,
                TraitName = "HadesShoutTrait",
                UpgradeUnequippedId = "SpearWeapon_Unequipped",
                UnequipFunctionName = "RemoveSpearBase",
                EquippedKitAnimation = "WeaponSpearAlt02FloatingIdleOff",
                UnequippedKitAnimation = "WeaponSpearAlt02FloatingIdle",
                BonusUnequippedKitAnimation = "WeaponSpearAlt02FloatingIdleBonus",
                BonusEquippedKitAnimation = "WeaponSpearAlt02FloatingIdleOffBonus",
                Image = "Codex_Portrait_SpearAlt02"
            }
    )

    -- Shield of Chaos ★ Chaos' Favor --
    table.insert(WeaponUpgradeData.ShieldWeapon,
            {
                Costs = { 3, 3, 3, 3, 3 },
                MaxUpgradeLevel = 5,
                TraitName = "ChaosBlessingBoonRarityTrait",
                EquippedKitAnimation = "WeaponShieldAlt01FloatingIdleOff",
                UnequippedKitAnimation = "WeaponShieldAlt01FloatingIdle",
                BonusUnequippedKitAnimation = "WeaponShieldAlt01FloatingIdleBonus",
                BonusEquippedKitAnimation = "WeaponShieldAlt01FloatingIdleOffBonus",
                Image = "Codex_Portrait_ShieldAlt01"
            }
    )
    -- Heart-Seeking Bow ★ Artemis' Cast --
    table.insert(WeaponUpgradeData.BowWeapon,
            {
                Costs = { 3, 3, 3, 3, 3 },
                MaxUpgradeLevel = 5,
                TraitName = "ArtemisRangedTrait",
                EquippedKitAnimation = "WeaponBowAlt01FloatingIdleOff",
                UnequippedKitAnimation = "WeaponBowAlt01FloatingIdle",
                BonusUnequippedKitAnimation = "WeaponBowAlt01FloatingIdleBonus",
                BonusEquippedKitAnimation = "WeaponBowAlt01FloatingIdleOffBonus",
                Image = "Codex_Portrait_BowAlt01"
            }
    )

    -- Twin Fists ★ Demeter's Strike --
    table.insert(WeaponUpgradeData.FistWeapon,
            {
                Costs = { 3, 3, 3, 3, 3 },
                MaxUpgradeLevel = 5,
                TraitName = "DemeterWeaponTrait",
                EquippedKitAnimation = "WeaponFistsAlt01FloatingIdleOff",
                UnequippedKitAnimation = "WeaponFistsAlt01FloatingIdle",
                BonusUnequippedKitAnimation = "WeaponFistsAlt01FloatingIdleBonus",
                BonusEquippedKitAnimation = "WeaponFistsAlt01FloatingIdleOffBonus",
                Image = "Codex_Portrait_FistAlt02"
            }
    )

    -- Adamant Rail ★ Hermes' Evasion --
    table.insert(WeaponUpgradeData.GunWeapon,
            {
                Costs = { 3, 3, 3, 3, 3 },
                MaxUpgradeLevel = 5,
                TraitName = "DodgeChanceTrait",
                EquippedKitAnimation = "WeaponGunAlt01FloatingIdleOff",
                UnequippedKitAnimation = "WeaponGunAlt01FloatingIdle",
                BonusUnequippedKitAnimation = "WeaponGunAlt01FloatingIdleBonus",
                BonusEquippedKitAnimation = "WeaponGunAlt01FloatingIdleOffBonus",
                Image = "Codex_Portrait_GunAlt01"
            }
    )
    ]]--
end