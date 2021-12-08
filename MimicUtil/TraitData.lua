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


-- MimicTraitPropertyChanges i a near-exact copy of code from PonyWarrior's AspectFusion/Data/traitdata.lua
function MimicUtil.MimicTraitPropertyChanges(sourceTraitName, copyTraitName)
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

function MimicUtil.TotalMimicWeaponAppearance(baseWeapon, copyWeaponUpgradeData, copyTraitData)
    copyWeaponUpgradeData.Image = baseWeapon.WeaponUpgradeData.Image
    copyWeaponUpgradeData.EquippedKitAnimation = baseWeapon.WeaponUpgradeData.EquippedKitAnimation
    copyWeaponUpgradeData.UnequippedKitAnimation = baseWeapon.WeaponUpgradeData.UnequippedKitAnimation
    copyWeaponUpgradeData.BonusUnequippedKitAnimation = baseWeapon.WeaponUpgradeData.BonusUnequippedKitAnimation
    copyWeaponUpgradeData.BonusEquippedKitAnimation = baseWeapon.WeaponUpgradeData.BonusEquippedKitAnimation

    copyTraitData.PostWeaponUpgradeScreenAnimation = baseWeapon.TraitData.PostWeaponUpgradeScreenAnimation
    copyTraitData.PostWeaponUpgradeScreenAngle = baseWeapon.TraitData.PostWeaponUpgradeScreenAngle
    copyTraitData.WeaponBinks = DeepCopyTable(baseWeapon.TraitData.WeaponBinks)
    copyTraitData.WeaponDataOverride = DeepCopyTable(baseWeapon.TraitData.WeaponDataOverride)
    copyTraitData.Icon = baseWeapon.TraitData.Icon

    for _, property in pairs(baseWeapon.TraitData.PropertyChanges) do
        if property.WeaponProperty ~= nil and MimicUtil.isCosmeticProperty(property.WeaponProperty) then
            table.insert(copyTraitData.PropertyChanges, DeepCopyTable(property))
        end
    end
end