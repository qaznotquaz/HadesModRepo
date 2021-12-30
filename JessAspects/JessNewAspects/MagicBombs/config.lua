ModUtil.RegisterMod("JessAspects_MagicBombs")

JessAspects_MagicBombs.Config = {
    Enabled = true
}

-- check for requirement
if JessAspectsCore == nil or JessAspectsCore.config.Enabled == false then
    JessAspects_MagicBombs.Config.Enabled = false
end