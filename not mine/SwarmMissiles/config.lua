ModUtil.RegisterMod("SwarmMissiles")

local config = {
    Enabled = true,             --true to activate mod
    MaxMissiles = 16,           --max charged barrage with fully upgraded weapon (Lv 1 is half)
    ExtraMissilesPerShot = 1,   --gunshots add this many missiles
    FastExtraMissiles = 4,      --until this many missiles added, gunshots add double per shot
    --fractions ok, i think
}

SwarmMissiles.config = config