if JessAspects_BoonsAsAspects.Config.Enabled then
    -- Stygian Blade ★ Poseidon's Flourish --
    if JessAspects_BoonsAsAspects.Config.SwordEnabled then
        JessAspects_BoonsAsAspects.Data.SwordPoseidon = {
            Costs = { 3, 3, 3, 3, 3 },
            MaxUpgradeLevel = 5,
            TraitName = "SwordPoseidonSecondaryTrait"
        }
        table.insert(
                WeaponUpgradeData.SwordWeapon, 2,
                JessAspects_BoonsAsAspects.Data.SwordPoseidon
        )
        table.insert(
                WeaponUpgradeData.SwordWeapon, 2,
                JessAspects_BoonsAsAspects.Data.SwordPoseidon
        )
    end

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
    )]]--

    -- Twin Fists ★ Demeter's Strike --
    if JessAspects_BoonsAsAspects.Config.FistEnabled then
        JessAspects_BoonsAsAspects.Data.FistDemeter = {
            Costs = { 3, 3, 3, 3, 3 },
            MaxUpgradeLevel = 5,
            TraitName = "FistDemeterWeaponTrait"
        }
        table.insert(
                WeaponUpgradeData.FistWeapon,
                JessAspects_BoonsAsAspects.Data.FistDemeter
        )
    end

    -- Adamant Rail ★ Hermes' Evasion --
    if JessAspects_BoonsAsAspects.Config.GunEnabled then
        JessAspects_BoonsAsAspects.Data.GunHermes = {
            Costs = { 3, 3, 3, 3, 3 },
            MaxUpgradeLevel = 5,
            TraitName = "GunDodgeChanceTrait"
        }

        table.insert(
                WeaponUpgradeData.GunWeapon,
                JessAspects_BoonsAsAspects.Data.GunHermes
        )
    end
end