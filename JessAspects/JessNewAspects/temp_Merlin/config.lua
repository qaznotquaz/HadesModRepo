ModUtil.RegisterMod("JessAspects_temp_Merlin")

JessAspects_temp_Merlin.Config =
{
    Enabled = true
}

-- check for requirement
if JessAspectsCore == nil or JessAspectsCore.config.Enabled == false then
    JessAspects_Philanthropist.Config.Enabled = false
end