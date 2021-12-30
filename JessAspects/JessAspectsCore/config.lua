ModUtil.RegisterMod("JessAspectsCore")

JessAspectsCore.config = {
    Enabled = true
}

-- check requirements, pt. 1
-- pt.2 is in JessAspectsCore.lua
if MimicUtil == nil then
    JessAspectsCore.config.Enabled = false
end