ModUtil.MapSetTable(EncounterData,
        {
            BossEncounter = {
                PostUnthreadedEvents = {
                    {
                        FunctionName = "JessAspects_Philanthropist.StealArrow",
                        GameStateRequirements = {
                            RequiredTrait = "Jess_PhilanthropistTrait",
                            RequiredMetaUpgrade = "StartingMoney"
                        },
                    },
                },
            },

            MinibossEncounter = {
                PostUnthreadedEvents = {
                    {
                        FunctionName = "JessAspects_Philanthropist.StealMoney",
                        GameStateRequirements = {
                            RequiredTrait = "Jess_PhilanthropistTrait",
                            RequiredMetaUpgrade = "StartingMoney"
                        },
                    },
                },
            }
        }
)