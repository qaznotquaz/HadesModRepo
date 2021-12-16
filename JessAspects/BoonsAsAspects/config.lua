ModUtil.RegisterMod("JessAspects_BoonsAsAspects")

JessAspects_BoonsAsAspects.Config = {
    Enabled = true,
    SwordEnabled = true,
    SpearEnabled = true,
    ShieldEnabled = true,
    BowEnabled = true,
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
    AspectOrPom = "{$TooltipData.DisplayDelta1}",
    
    SwordFlavor = "",
    SpearFlavor = "",
    ShieldFlavor = "",
    BowFlavor = "",
    FistFlavor = "",
    GunFlavor = ""
}

if JessAspects_BoonsAsAspects.Config.Enabled == false then
    JessAspects_BoonsAsAspects.Config.SwordEnabled = false
    JessAspects_BoonsAsAspects.Config.SpearEnabled = false
    JessAspects_BoonsAsAspects.Config.ShieldEnabled = false
    JessAspects_BoonsAsAspects.Config.BowEnabled = false
    JessAspects_BoonsAsAspects.Config.FistEnabled = false
    JessAspects_BoonsAsAspects.Config.GunEnabled = false
end