if JessAspects_BoonsAsAspects.Config.Enabled then
    -- Stygian Blade ★ Poseidon's Flourish --
    if JessAspects_BoonsAsAspects.Config.SwordEnabled then
        JessAspects_BoonsAsAspects.Data.SwordPoseidon = {
            Costs = { 3, 3, 3, 3, 3 },
            MaxUpgradeLevel = 5,
            TraitName = "Jess_SwordPoseidonBoonTrait"
        }
        table.insert(
                WeaponUpgradeData.SwordWeapon,
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
    )]]--

    -- Shield of Chaos ★ Chaos' Favor --
    if JessAspects_BoonsAsAspects.Config.ShieldEnabled then
        JessAspects_BoonsAsAspects.Data.ShieldChaos = {
            Costs = { 3, 3, 3, 3, 3 },
            MaxUpgradeLevel = 5,
            TraitName = "Jess_ShieldChaosBoonTrait"
        }
        table.insert(
                WeaponUpgradeData.ShieldWeapon,
                JessAspects_BoonsAsAspects.Data.ShieldChaos
        )
    end

    --[[
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
            TraitName = "Jess_FistDemeterBoonTrait"
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
            TraitName = "Jess_GunHermesBoonTrait"
        }

        table.insert(
                WeaponUpgradeData.GunWeapon,
                JessAspects_BoonsAsAspects.Data.GunHermes
        )
    end
end