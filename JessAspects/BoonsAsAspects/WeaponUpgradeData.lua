if JessAspects_BoonsAsAspects.Config.Enabled then
    -- Stygian Blade ★ Poseidon's Flourish --
    if JessAspects_BoonsAsAspects.Config.SwordEnabled then
        JessAspects_BoonsAsAspects.Data.SwordPoseidon = {
            Costs = { 1, 2, 3, 4, 5 },
            MaxUpgradeLevel = 5,
            TraitName = "Jess_SwordPoseidonBoonTrait"
        }
        table.insert(
                WeaponUpgradeData.SwordWeapon,
                JessAspects_BoonsAsAspects.Data.SwordPoseidon
        )
    end

    -- Eternal Spear ★ Hades' Call --
    if JessAspects_BoonsAsAspects.Config.SpearEnabled then
        JessAspects_BoonsAsAspects.Data.SpearHades = {
            Costs = { 3, 3, 3, 4, 5 },
            MaxUpgradeLevel = 5,
            TraitName = "Jess_SpearHadesBoonTrait",
        }
        table.insert(
                WeaponUpgradeData.SpearWeapon,
                JessAspects_BoonsAsAspects.Data.SpearHades
        )
    end

    -- Shield of Chaos ★ Chaos' Favor --
    if JessAspects_BoonsAsAspects.Config.ShieldEnabled then
        JessAspects_BoonsAsAspects.Data.ShieldChaos = {
            Costs = { 1, 2, 3, 4, 5 },
            MaxUpgradeLevel = 5,
            TraitName = "Jess_ShieldChaosBoonTrait"
        }
        table.insert(
                WeaponUpgradeData.ShieldWeapon,
                JessAspects_BoonsAsAspects.Data.ShieldChaos
        )
    end

    -- Heart-Seeking Bow ★ Artemis' Cast --
    if JessAspects_BoonsAsAspects.Config.BowEnabled then
        JessAspects_BoonsAsAspects.Data.BowArtemis = {
            Costs = { 1, 2, 3, 4, 5 },
            MaxUpgradeLevel = 5,
            TraitName = "Jess_BowArtemisBoonTrait",
        }
        table.insert(
                WeaponUpgradeData.BowWeapon,
                JessAspects_BoonsAsAspects.Data.BowArtemis
        )
    end

    -- Twin Fists ★ Demeter's Strike --
    if JessAspects_BoonsAsAspects.Config.FistEnabled then
        JessAspects_BoonsAsAspects.Data.FistDemeter = {
            Costs = { 1, 2, 3, 4, 5 },
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
            Costs = { 1, 2, 3, 4, 5 },
            MaxUpgradeLevel = 5,
            TraitName = "Jess_GunHermesBoonTrait"
        }
        table.insert(
                WeaponUpgradeData.GunWeapon,
                JessAspects_BoonsAsAspects.Data.GunHermes
        )
    end
end