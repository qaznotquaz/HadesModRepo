ModUtil.RegisterMod("JessAspects_temp_MikeTyson")

JessAspects_temp_MikeTyson.Config = {
    Enabled = true
}

-- check for requirement
if JessAspectsCore == nil or JessAspectsCore.config.Enabled == false then
    JessAspects_temp_MikeTyson.Config.Enabled = false
end