function MimicUtil.MimicLootUpgradeRequirements(sourceTraitName, copyTraitName)
    for _, upgradeSet in pairs(LootData) do
        if upgradeSet.LinkedUpgrades ~= nil then
            for _, requirements in pairs(upgradeSet.LinkedUpgrades) do
                if requirements.OneOf ~= nil and Contains(requirements.OneOf, sourceTraitName) then
                    table.insert(requirements.OneOf, copyTraitName)
                elseif requirements.OneFromEachSet ~= nil then
                    for _, set in pairs(requirements.OneFromEachSet) do
                        if Contains(set, sourceTraitName) then
                            table.insert(set, copyTraitName)
                        end
                    end
                end
            end
        end
    end
end