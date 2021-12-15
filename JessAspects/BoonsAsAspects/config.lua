ModUtil.RegisterMod("JessAspects_BoonsAsAspects")

JessAspects_BoonsAsAspects.Config = {
    Enabled = true,
    SwordEnabled = true,
    SpearEnabled = false,
    ShieldEnabled = false,
    BowEnabled = false,
    FistEnabled = true,
    GunEnabled = true
}

JessAspects_BoonsAsAspects.TraitNames = {
    "Jess_SwordPoseidonBoonTrait",
    "Jess_SpearHadesBoonTrait",
    "Jess_ShieldChaosBoonTrait",
    "Jess_BowArtemisBoonTrait",
    "Jess_FistDemeterBoonTrait",
    "Jess_GunHermesBoonTrait"
}

JessAspects_BoonsAsAspects.CustomText = {
    -- Aspect: {$TooltipData.TooltipDamage:P}
    -- Pom: {$TooltipData.DisplayDelta1}
    AspectOrPom = "{$TooltipData.DisplayDelta1}",
    
    SwordFlavor = "",
    SpearFlavor = "",
    ShieldFlavor = "",
    BowFlavor = "",
    FistFlavor = "",
    GunFlavor = ""
}