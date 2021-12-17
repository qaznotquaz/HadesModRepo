MimicUtil.BaseWeapons = {
    SwordZagreus = {
        WeaponUpgradeData = WeaponUpgradeData.SwordWeapon[1],
        TraitData = TraitData.SwordBaseUpgradeTrait
    },
    SwordNemesis = {
        WeaponUpgradeData = WeaponUpgradeData.SwordWeapon[2],
        TraitData = TraitData.SwordCriticalParryTrait
    },
    SwordPoseidon = {
        WeaponUpgradeData = WeaponUpgradeData.SwordWeapon[3],
        TraitData = TraitData.DislodgeAmmoTrait
    },
    SwordArthur = {
        WeaponUpgradeData = WeaponUpgradeData.SwordWeapon[4],
        TraitData = TraitData.SwordConsecrationTrait
    },

    SpearZagreus = {
        WeaponUpgradeData = WeaponUpgradeData.SpearWeapon[1],
        TraitData = TraitData.SpearBaseUpgradeTrait
    },
    SpearAchilles = {
        WeaponUpgradeData = WeaponUpgradeData.SpearWeapon[2],
        TraitData = TraitData.SpearTeleportTrait
    },
    SpearHades = {
        WeaponUpgradeData = WeaponUpgradeData.SpearWeapon[3],
        TraitData = TraitData.SpearWeaveTrait
    },
    SpearGuanYu = {
        WeaponUpgradeData = WeaponUpgradeData.SpearWeapon[4],
        TraitData = TraitData.SpearSpinTravel
    },

    ShieldZagreus = {
        WeaponUpgradeData = WeaponUpgradeData.ShieldWeapon[1],
        TraitData = TraitData.ShieldBaseUpgradeTrait
    },
    ShieldChaos = {
        WeaponUpgradeData = WeaponUpgradeData.ShieldWeapon[2],
        TraitData = TraitData.ShieldRushBonusProjectileTrait
    },
    ShieldZeus = {
        WeaponUpgradeData = WeaponUpgradeData.ShieldWeapon[3],
        TraitData = TraitData.ShieldTwoShieldTrait
    },
    ShieldBeowulf = {
        WeaponUpgradeData = WeaponUpgradeData.ShieldWeapon[4],
        TraitData = TraitData.ShieldLoadAmmoTrait
    },

    BowZagreus = {
        WeaponUpgradeData = WeaponUpgradeData.BowWeapon[1],
        TraitData = TraitData.BowBaseUpgradeTrait
    },
    BowChiron = {
        WeaponUpgradeData = WeaponUpgradeData.BowWeapon[2],
        TraitData = TraitData.BowMarkHomingTrait
    },
    BowHera = {
        WeaponUpgradeData = WeaponUpgradeData.BowWeapon[3],
        TraitData = TraitData.BowLoadAmmoTrait
    },
    BowRama = {
        WeaponUpgradeData = WeaponUpgradeData.BowWeapon[4],
        TraitData = TraitData.BowBondTrait
    },

    FistZagreus = {
        WeaponUpgradeData = WeaponUpgradeData.FistWeapon[1],
        TraitData = TraitData.FistBaseUpgradeTrait
    },
    FistTalos = {
        WeaponUpgradeData = WeaponUpgradeData.FistWeapon[2],
        TraitData = TraitData.FistVacuumTrait
    },
    FistDemeter = {
        WeaponUpgradeData = WeaponUpgradeData.FistWeapon[3],
        TraitData = TraitData.FistWeaveTrait
    },
    FistGilgamesh = {
        WeaponUpgradeData = WeaponUpgradeData.FistWeapon[4],
        TraitData = TraitData.FistDetonateTrait
    },

    GunZagreus = {
        WeaponUpgradeData = WeaponUpgradeData.GunWeapon[1],
        TraitData = TraitData.GunBaseUpgradeTrait
    },
    GunEris = {
        WeaponUpgradeData = WeaponUpgradeData.GunWeapon[2],
        TraitData = TraitData.GunGrenadeSelfEmpowerTrait
    },
    GunHestia = {
        WeaponUpgradeData = WeaponUpgradeData.GunWeapon[3],
        TraitData = TraitData.GunManualReloadTrait
    },
    GunLucifer = {
        WeaponUpgradeData = WeaponUpgradeData.GunWeapon[4],
        TraitData = TraitData.GunLoadedGrenadeTrait
    },
}

-- MimicForeignPropertyModifiers is a near-exact copy of code from PonyWarrior's AspectFusion/Data/traitdata.lua
function MimicUtil.MimicForeignPropertyModifiers(sourceTraitName, copyTraitName)
    for _, traitData in pairs(TraitData) do
        if traitData.PropertyChanges ~= nil then
            for _, property in pairs(traitData.PropertyChanges) do
                if property.TraitName ~= nil and property.TraitName == sourceTraitName then
                    local propertyCopy = DeepCopyTable(property)
                    propertyCopy.TraitName = copyTraitName
                    table.insert(traitData.PropertyChanges, propertyCopy)
                end
            end
        end
    end
end

function MimicUtil.RequireFalse(targetTraitName, disallowedTraitName)
    local traitData = TraitData[targetTraitName]

    if traitData.RequiredFalseTraits ~= nil then
        table.insert(traitData.RequiredFalseTraits, disallowedTraitName)
    elseif traitData.RequiredFalseTrait == nil then
        traitData.RequiredFalseTrait = disallowedTraitName
    else
        local singularFalse = traitData.RequiredFalseTrait
        traitData.RequiredFalseTrait = nil
        traitData.RequiredFalseTraits = {
            singularFalse,
            disallowedTraitName
        }
    end
end

function MimicUtil.RequireTrue(targetTraitName, disallowedTraitName)
    local traitData = TraitData[targetTraitName]

    if traitData.RequiredTraits ~= nil then
        table.insert(traitData.RequiredTraits, disallowedTraitName)
    elseif traitData.RequiredFalseTrait == nil then
        traitData.RequiredTrait = disallowedTraitName
    else
        local singularFalse = traitData.RequiredTrait
        traitData.RequiredTrait = nil
        traitData.RequiredTraits = {
            singularFalse,
            disallowedTraitName
        }
    end
end

function MimicUtil.TotalMimicWeaponAppearance(baseWeapon, copyWeaponUpgradeData, copyTraitData)
    local weaponFields = {
        "Image",
        "EquippedKitAnimation", "UnequippedKitAnimation",
        "BonusEquippedKitAnimation", "BonusUnequippedKitAnimation",
    }

    for _, field in pairs(weaponFields) do
        copyWeaponUpgradeData[field] = baseWeapon.WeaponUpgradeData[field]
    end

    local traitFields = {
        "PostWeaponUpgradeScreenAnimation", "PostWeaponUpgradeScreenAngle",
        "WeaponBinks", "WeaponDataOverride",
        "Icon"
    }

    for _, field in pairs(traitFields) do
        copyTraitData[field] = DeepCopyTable(baseWeapon.TraitData[field])
    end

    for _, property in pairs(baseWeapon.TraitData.PropertyChanges) do
        if (property.WeaponProperty ~= nil and MimicUtil.isCosmeticProperty(property.WeaponProperty)) or (property.ProjectileProperty ~= nil and MimicUtil.isCosmeticProperty(property.ProjectileProperty)) then
            table.insert(copyTraitData.PropertyChanges, DeepCopyTable(property))
        end
    end
end