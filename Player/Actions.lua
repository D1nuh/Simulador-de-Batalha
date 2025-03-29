local Ultils = require "Ultils"
local Actions = {}

Actions.List = {}
function Actions.build(PlayerData, CreatureData)

    Actions.List = {}

    local AttackSword = {
        description = "Atacar com a espada.", 
        requirement = nil,
        execute = function (PlayerData, CreatureData)
            -- Calculando a chance do ataque
            local SucessChance = CreatureData.speed == 0 and 1 or PlayerData.speed / CreatureData.speed
            local Sucess = math.random() <= SucessChance
            -- Calculando o Dano do ataque
            local RawDamage = PlayerData.attack - math.random() * CreatureData.defense
            local Damage = math.max(1, math.ceil(RawDamage))
            -- Apresentar ataque e aplicando
            if Sucess then
                CreatureData.health =  CreatureData.health - Damage
                print()
                print("================================================================")
                print(string.format("  %s atacou a criatura com a espada e deu %d de Dano!", PlayerData.name, Damage))
                print("================================================================")
                local Liferate = (CreatureData.health / CreatureData.maxHealth) * 10
                print()
                print(string.format("%s: %s", CreatureData.name, Ultils.ProgressBar(Liferate)))
                print()
            else
            print(string.format("%s erra o ataque vergonhosamente! ", PlayerData.name))
            end
            
        end
    }

    local RegPotion = {
        description = "Usar uma poção e regenera sua vida",
        -- Retorna True ou False se tiver pelo menos 1 poção no inventario
        requirement = function (PlayerData, CreatureData)
            return PlayerData.potion >= 1
        end,
        execute = function (PlayerData, CreatureData)
            -- Tira poção do Player
            PlayerData.potion = PlayerData.potion - 1
            -- Regenera pontos de vida e não deixa esceder vida maxima
           local RegenPoints = 5
           PlayerData.health = math.min(PlayerData.maxHealth, PlayerData.health + RegenPoints)
           print()
           print("=======================================================")
           print(string.format("%s usou uma poção e recuperou 5 pontos de vida! ", PlayerData.name))
           print("=======================================================")
        end
    }
    -- Lista Popular
    Actions.List[#Actions.List + 1] = AttackSword
    Actions.List[#Actions.List + 1] = RegPotion
end



function Actions.getValidActions(PlayerData, CreatureData)
    local ValidActions = {}
    for _, Action in pairs(Actions.List) do
        local requirement = Action.requirement
        local isValid = requirement == nil or requirement(PlayerData, CreatureData)
        if isValid then
            ValidActions[#ValidActions+1] = Action
        end
    end
    return  ValidActions
end
return Actions