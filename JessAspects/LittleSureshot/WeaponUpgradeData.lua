--[[
     ___                       _           ___    ___            _
    | . | ___ ___  ___  ___  _| |_    ___ | |    | . | _ _  _ _ [_] ___
    |   |[_-[| . \/ ._]/ | '  | |    / . \| |-   |   || ' || ' || |/ ._]
    |_|_|/__/|  _/\___.\_|_.  |_|    \___/|_|    |_|_||_|_||_|_||_|\___.
             |_|
]]

if JessAspects.Config.LittleSureshot then
    table.insert(WeaponUpgradeData.GunWeapon,
            {
                Costs = { 1, 2, 3, 4, 5 },
                MaxUpgradeLevel = 5,
                TraitName = "GunLittleSureshotTrait",
                EquippedKitAnimation = "WeaponGunAlt01FloatingIdleOff",
                UnequippedKitAnimation = "WeaponGunAlt01FloatingIdle",
                BonusUnequippedKitAnimation = "WeaponGunAlt01FloatingIdleBonus",
                BonusEquippedKitAnimation = "WeaponGunAlt01FloatingIdleOffBonus",
                Image = "Codex_Portrait_GunAlt01"
            }
    )
end