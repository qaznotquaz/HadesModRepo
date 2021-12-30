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

-- disable config options consistently
if JessAspectsCore == nil or JessAspectsCore.config.Enabled == false or JessAspects_BoonsAsAspects.Config.Enabled == false then
    JessAspects_BoonsAsAspects.Config.Enabled = false
    JessAspects_BoonsAsAspects.Config.SwordEnabled = false
    JessAspects_BoonsAsAspects.Config.SpearEnabled = false
    JessAspects_BoonsAsAspects.Config.ShieldEnabled = false
    JessAspects_BoonsAsAspects.Config.BowEnabled = false
    JessAspects_BoonsAsAspects.Config.FistEnabled = false
    JessAspects_BoonsAsAspects.Config.GunEnabled = false
end