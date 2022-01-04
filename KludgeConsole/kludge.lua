ModUtil.RegisterMod("KludgeConsole")

function KludgeConsole.doKludge()
    local loaded_chunk = assert(loadfile("../Content/Mods/KludgeConsole/kludgefile.lua"))
    loaded_chunk()
    KludgeConsole.runKludge()
    DebugPrint({Text = "KludgeConsole successfully ran"})
end

-- Shout + Reload -> doKludge
OnControlPressed{ "Shout",
                  function(triggerArgs)
                      while IsControlDown({ Name = "Shout" }) do
                          if IsControlDown({ Name = "Reload" }) then
                              KludgeConsole.doKludge()
                              return
                          end
                          wait(0.1)
                      end
                  end}
