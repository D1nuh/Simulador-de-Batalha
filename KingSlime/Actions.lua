local Ultils = require "Ultils"
local Actions = {}

Actions.List = {}
function Actions.build(PlayerData, CreatureData)

    Actions.List = {}

    local SlimeJump = {
        description = "Pulo de Slime.", 
        requirement = nil,
        execute = function (PlayerData, CreatureData)
            -- Calculando a chance do ataque
            local SucessChance = PlayerData.speed == 0 and 1 or CreatureData.speed / PlayerData.speed
            local Sucess = math.random() <= SucessChance
            -- Calculando o Dano do ataque
            local RawDamage = CreatureData.attack - math.random() * PlayerData.defense
            local Damage = math.max(1, math.ceil(RawDamage))
            -- Apresentar ataque e aplicando
            if Sucess then
                PlayerData.health =  PlayerData.health - Damage
                print("===========================================================")
                print(string.format("%s atacou %s com Pulo de Slime e deu %d de Dano!", CreatureData.name, PlayerData.name,  Damage))
                print("===========================================================")
                local Liferate = (PlayerData.health / PlayerData.maxHealth) * 10
                print()
                print(string.format("%s: %s", PlayerData.name, Ultils.ProgressBar(Liferate)))
                print()
            else
            print(string.format("%s tentou atacar mais errou!", CreatureData.name))
            end
            
        end
    }

    local SlimeShoot = {
        description = "Tiro de Geleia Slime",
        requirement = nil,
        execute = function (PlayerData, CreatureData)
            local RawDamage = CreatureData.attack - math.random() * PlayerData.defense
            local Damage = math.max(1, math.ceil(RawDamage * 0.3))
            -- Apresentar ataque e aplicando
            PlayerData.health =  PlayerData.health - Damage
            print("==============================================================")
            print(string.format("%s atacou %s com Tiro de Geleia Slime e deu %d de Dano!", CreatureData.name, PlayerData.name, Damage))
            print("==============================================================")
            local Liferate = (PlayerData.health / PlayerData.maxHealth) * 10
            print()
            print(string.format("%s: %s", PlayerData.name, Ultils.ProgressBar(Liferate)))
            print()  
        end
    }


    local Wait = {
        description = "Aguardar",
        requirement = nil,
        execute = function (PlayerData, CreatureData)
            print("===================================================")
            print(string.format("%s decidiu aguardar, e não fez nada", CreatureData.name))
            print("===================================================")
            local Liferate = (PlayerData.health / PlayerData.maxHealth) * 10
            print()
            print(string.format("%s: %s", PlayerData.name, Ultils.ProgressBar(Liferate)))
            print()  

        end



    }


    -- Lista Popular
    Actions.List[#Actions.List + 1] = SlimeJump
    Actions.List[#Actions.List + 1] = SlimeShoot
    Actions.List[#Actions.List + 1] = Wait
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