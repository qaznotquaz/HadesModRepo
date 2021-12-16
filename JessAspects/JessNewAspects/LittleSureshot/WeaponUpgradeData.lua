--[[
     ___                       _           ___    ___            _
    | . | ___ ___  ___  ___  _| |_    ___ | |    | . | _ _  _ _ [_] ___
    |   |[_-[| . \/ ._]/ | '  | |    / . \| |-   |   || ' || ' || |/ ._]
    |_|_|/__/|  _/\___.\_|_.  |_|    \___/|_|    |_|_||_|_||_|_||_|\___.
             |_|
]]

if JessAspects_LittleSureshot.Config.Enabled then
    JessAspects_LittleSureshot.Data.GunAnnie = {
                Costs = { 1, 2, 3, 4, 5 },
                MaxUpgradeLevel = 5,
                TraitName = "Jess_GunLittleSureshotTrait",
            }
    table.insert(
            WeaponUpgradeData.GunWeapon,
            JessAspects_LittleSureshot.Data.GunAnnie
    )
end