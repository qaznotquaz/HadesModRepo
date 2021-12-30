ModUtil.RegisterMod("JessAspects_Philanthropist")

JessAspects_Philanthropist.Config = {
    Enabled = true
}

-- check for requirement
if JessAspectsCore == nil or JessAspectsCore.config.Enabled == false then
    JessAspects_Philanthropist.Config.Enabled = false
end