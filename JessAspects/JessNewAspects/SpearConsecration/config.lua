ModUtil.RegisterMod("JessAspects_SpearConsecration")

JessAspects_SpearConsecration.Config =
{
    Enabled = true
}

-- check for requirement
if JessAspectsCore == nil or JessAspectsCore.config.Enabled == false then
    JessAspects_Philanthropist.Config.Enabled = false
end