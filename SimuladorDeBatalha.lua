--[[

    * Estrutura Do Simulador

    1 .Header/Cabeçario
    
    2. Apresentação do peraonagem
    
    4. Skills/ Habilidades

]]

-- Definições ✅

local Player = require("Player.Player")
local KingSlime = require("KingSlime.KingSlime")
local KingSlimeActions = require("KingSlime.Actions")
local Ultils = require("Ultils")
local PlayerActions = require("Player.Actions")
local boss = KingSlime
local bossActions = KingSlimeActions

-- Habilitar utf-8
Ultils.Utf8()

-- 1. Header/Cabeçario ✅
Ultils.print()

-- 2. Apresentação do Inimigo   

Ultils.StatsCreature(boss)

PlayerActions.build()

bossActions.build(Player, boss)


while true do

    print(string.format([[
        Turno do %s
        ----------------
    ]], Player.name))

    --Turno Player
    print(string.format("O que %s vai fazer agora? ", Player.name))
    local ValidActions = PlayerActions.getValidActions(Player, boss)
    for i, action in pairs(ValidActions) do
        print(string.format("%d. %s", i, action.description))
    end
    -- Aguardar resposta
    local ChosenIndex = Ultils.ask()
    local ChosenAction = ValidActions[ChosenIndex]
    -- Checa se a resposta e valida de acordo com a entrada do usuario
    local IsActionValid = ChosenAction ~= nil

    -- Executa a ação se for diferente de nil
    if IsActionValid then
        ChosenAction.execute(Player, boss)
    else
        print()
        print("====================")
        print(" Você perdeu a vez!")
        print("====================")
        print()
        local Liferate = (boss.health / boss.maxHealth) * 10
        print(string.format("%s: %s", boss.name, Ultils.ProgressBar(Liferate)))
        print()
    end


    if boss.health <= 0 then
        break
    end

    print([[
        Turno do Inimigo
        ----------------
    ]])

    --Turno Criatura
    print()
    local ValidbossActions = bossActions.getValidActions(Player, boss)
    local bossAction = ValidbossActions[math.random(#ValidbossActions)]
    bossAction.execute(Player, boss)

    if Player.health <= 0 then
            break
    end
end

if Player.health <= 0 then
    print()
    print("===========================================================")
    print(string.format("%s não foi capaz de derrotar %s", Player.name, boss.name))
    print("Quem sabe na proxima vez... 😭")
    print("===========================================================")
    print()
end

if boss.health <= 0 then
    print()
    print("==========================================================")
    print(string.format("%s foi capaz de derrotar e expurgar %s", Player.name, boss.name))
    print("Isso foi lendario!!! 😄")
    print("==========================================================")
    print()
end