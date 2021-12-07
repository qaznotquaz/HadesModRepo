--[[
     ___                       _           ___    ___            _
    | . | ___ ___  ___  ___  _| |_    ___ | |    | . | _ _  _ _ [_] ___
    |   |[_-[| . \/ ._]/ | '  | |    / . \| |-   |   || ' || ' || |/ ._]
    |_|_|/__/|  _/\___.\_|_.  |_|    \___/|_|    |_|_||_|_||_|_||_|\___.
             |_|
]]

if JessAspects.Config.LittleSureshot then
    --[[
    table.insert(WeaponUpgradeData.SwordWeapon, {
        Costs = { 0, 0, 0, 0, 0 }
        MaxUpgradeLevel = 0,
        StartsUnlocked = true,
        TraitName = "ArtemisWeaponTrait"
    }
    )]]--
    table.insert(WeaponUpgradeData.GunWeapon,
    {
    Costs = { 1, 1, 1, 1, 1 },
    MaxUpgradeLevel = 5,
    StartsUnlocked = true,
    TraitName = "GunLittleSureshotTrait",
    EquippedKitAnimation = "WeaponGunAlt03FloatingIdleOff",
    UnequippedKitAnimation = "WeaponGunAlt03FloatingIdle",
    BonusUnequippedKitAnimation = "WeaponGunAlt03FloatingIdleBonus",
    BonusEquippedKitAnimation = "WeaponGunAlt03FloatingIdleOffBonus",
    Image = "Codex_Portrait_GunAlt03"
    }
    )
end