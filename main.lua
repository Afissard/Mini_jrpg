--[[
    Let's make a small jrpg with the Pico-8 color pallet ...
    Ressources vidéo : Challacade : https://www.youtube.com/playlist?list=PLqPLyUreLV8DrLcLvQQ64Uz_h_JGLgGg2

    NOTE :
        > Pour utiliser le module sti, ne pas oublier d'embarquer la sprite_sheet lors de la création de la carte
            https://github.com/karai17/Simple-Tiled-Implementation/issues/259
        > 
    TODO :
        > Améliorer 'sprite_animation.lua' pour une plus grande facilité d'utilisation
        > Dessiner le jouer au centre de la camera (offset : longueur/2, largeur/2)
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
    Camera = require('Libraries.hump.camera')   -- Module du package hump pour facilité l'utilisation de la camera de Löve
    cam = Camera()
    Zoom = 4.0

    GameMap = sti('Maps/map_1.lua')             -- charge la carte du jeu
end

function love.update(dt) -- 'dt' signifie 'delta time' soit le FPS ?
    --[[
        Fonction "boucle du jeu" se met à jour selon dt
    ]]
    Inputs()
    GameMap:update(dt)
    Animation.update_all_sprite(dt)
    --Camera stuff :
    cam:lookAt(Player.x*Zoom, Player.y*Zoom)                -- la camera suis le joueur
    --Camera_border()
end

function love.draw()
    --[[
        Fonction "affichage" : met à jour l'écran
    ]]
    cam:attach() -- attache à l'objet camera tout ce qui se trouve entre les 2 balise 'cam()'
        love.graphics.scale(Zoom)        -- agrandi les graphisme *4
        -- Dessine la carte du jeu faites avec Tiled
        GameMap:drawLayer(GameMap.layers["Background"]) -- dessine les différentes couches de la map tiled
        GameMap:drawLayer(GameMap.layers["Interaction"])

        Animation.draw_all_sprite()     -- regroupe les commande pour dessiné tout les sprites
    cam:detach()
    love.graphics.print("This is an GUI", 10,10)
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

function Camera_border()
    --[[
        Fonction pour stopper la camera aux bordure de la map.
        (Seras probablement suprimé -> pas utilisable pour de petite map en grand écran)
    ]]
    local win_width = love.graphics.getWidth()              -- récupère largeur de la fenêtre
    local win_height = love.graphics.getHeight()            -- récupère longueur de la fenêtre
    local map_width = GameMap.width * GameMap.tilewidth     -- largeur de la map
    local map_height = GameMap.height * GameMap.tileheight  -- longueur de la map
    if cam.x < win_width/2 then                 -- la camera s'arrette au bord de l'écran à gauche
        cam.x = win_width/2
    elseif cam.x > (map_width - win_width/2) then   -- la camera s'arrette au bord de l'écran à droite
        cam.x = (map_width - win_width/2)
    end
    if cam.y < win_height/2 then                -- la camera s'arrette au bord de l'écran en haut
        cam.y = win_height/2
    elseif cam.y > (map_height - win_height/2) then -- la camera s'arrette au bord de l'écran en bas
    cam.y = (map_height - win_height/2)
    end
end