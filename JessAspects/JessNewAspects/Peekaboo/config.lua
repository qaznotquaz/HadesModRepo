ModUtil.RegisterMod("JessAspects_Peekaboo")

JessAspects_Peekaboo.Config = {
    Enabled = true
}

-- check for requirement
if JessAspectsCore == nil or JessAspectsCore.config.Enabled == false then
    JessAspects_Peekaboo.Config.Enabled = false
end