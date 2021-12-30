ModUtil.RegisterMod("JessAspects_LittleSureshot")

JessAspects_LittleSureshot.Config =
{
    Enabled = true
}

-- check for requirement
if JessAspectsCore == nil or JessAspectsCore.config.Enabled == false then
    JessAspects_LittleSureshot.Config.Enabled = false
end