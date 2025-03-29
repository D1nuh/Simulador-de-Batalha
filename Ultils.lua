local Ultils = {}

function Ultils.Utf8()
    os.execute("chcp 65001")
end

function Ultils.print()
    print([[
    
        ========================================================

                      ⚔️ Simulador de batalha ⚔️

        ========================================================

        Você sente um temor no solo que vem de uma enorme massa
                azul pulante, se prepare para lutar

        ========================================================
    ]])
end


function Ultils.ProgressBar(Atributo)
    local Full = "⬜"
    local Empty = "⬛"
    local result = ""

    for i = 1,10,1 do
        result = result .. (i <= Atributo and Full or Empty)
    end
    return result
end

function Ultils.StatsCreature(Creature)

    local Liferate = (Creature.health / Creature.maxHealth) * 10

    print("|    " .. Creature.name)
    print("|")
    print("|    Atributos:")
    print("|        Vida:" .. Ultils.ProgressBar(Liferate))
    print("|        Ataque:" .. Ultils.ProgressBar(Creature.attack))
    print("|        Defesa:" .. Ultils.ProgressBar(Creature.defense))
    print("|        Velocidade:" .. Ultils.ProgressBar(Creature.speed))
    print()
end

function Ultils.ask()
    -- Perguntar sem pular uma linha
    io.write("> ")
    -- Esperar resposta em numero
    local Aswer = io.read("*n")
    return Aswer
end

return Ultils