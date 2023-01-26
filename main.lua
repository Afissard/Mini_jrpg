--[[
    Let's make a small jrpg with the Pico-8 color pallet ...
    Ressources vidéo : Challacade : https://www.youtube.com/playlist?list=PLqPLyUreLV8DrLcLvQQ64Uz_h_JGLgGg2

    NOTE :
        > Pour utiliser le module sti, ne pas oublier d'embarquer la sprite_sheet lors de la création de la carte
            https://github.com/karai17/Simple-Tiled-Implementation/issues/259
        > 
]]

function love.load()
    --[[
        Fonction pour charger toute les variables et modules
    ]]
    _G.love = require("love")
    -- retire le blur des image pixelisé => dessins au pixel près (placer avant load des images) :
    love.graphics.setDefaultFilter("nearest", "nearest")
    Player = require('player')                  -- fichier avec toute les fonction et variables du joueur
    Animation = require('sprite_animation')     -- module pour gérer l'animation/affichage des sprites
    sti = require('Libraries/sti')              -- Simple Tiled Implementation Libraries

    GameMap = sti('Maps/map_1.lua')             -- charge la carte du jeu
end

function love.update(dt) -- 'dt' signifie 'delta time' soit le FPS ?
    --[[
        Fonction "boucle du jeu" se met à jour selon dt
    ]]
    Inputs()
    GameMap:update(dt)
    Animation.update_all_sprite(dt)
end

function love.draw()
    --[[
        Fonction "affichage" : met à jour l'écran
    ]]
    love.graphics.scale(4.0)        -- agrandi les graphisme *4
    GameMap:draw()                  -- Dessine la carte du jeu faites avec Tiled
    Animation.draw_all_sprite()     -- regroupe les commande pour dessiné tout les sprites
end


function Inputs() -- à déplacer quelque part ...
    Player.animation.standing = true

    if love.keyboard.isDown("right") then
        Player.facing = "right"
        Player.animation.standing = false
        Player.x = Player.x + Player.speed
    end
    if love.keyboard.isDown("left") then
        Player.facing = "left"
        Player.animation.standing = false
        Player.x = Player.x - Player.speed
    end
    if love.keyboard.isDown("up") then
        Player.facing = "up"
        Player.animation.standing = false
        Player.y = Player.y - Player.speed
    end
    if love.keyboard.isDown("down") then
        Player.facing = "down"
        Player.animation.standing = false
        Player.y = Player.y + Player.speed
    end
end

