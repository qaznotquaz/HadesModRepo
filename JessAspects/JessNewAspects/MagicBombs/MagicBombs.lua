ModUtil.WrapBaseFunction("ShieldFireClear", function(baseFunc, triggerArgs, args)
    DebugPrint({ Text = triggerArgs.name})
    return baseFunc(triggerArgs, args)
end)

ModUtil.MapSetTable(KeywordList, {
    "Unimplemented"
})

ResetKeywords()