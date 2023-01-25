--[[
    Module pour tout ce qui est lié au joueur
    (création d'un module : https://stackoverflow.com/questions/40928887/how-to-use-multiple-files-in-lua)
]]
local Player = {} -- table pour stocker les fonctions et variables du module

Animation = require("sprite_animation")

-- déplacement du joueur
Player.x = 40
Player.y = 20
Player.speed = 0.5

--Sprite du joueur : 
Player.sprite_sheet = love.graphics.newImage("Sprites/Player_sprite_1.png")

Player.sheet_width = Player.sprite_sheet:getWidth()
Player.sheet_height = Player.sprite_sheet:getHeight()
Player.width = Player.sheet_width /4
Player.height = Player.sheet_height /4
Player.facing = "down"

Player.animation = {}
Player.animation.standing = false
Player.animation.frame = 1
Player.animation.max_frame = 4
Player.animation.timer = 0.1

Player.down = {}
Player.left = {}
Player.right = {}
Player.up = {}
for i = 1, Player.animation.max_frame do
    Player.down[i] = love.graphics.newQuad(Player.width*(i-1),0, Player.width,Player.height, Player.sheet_width,Player.sheet_height)
    Player.left[i] = love.graphics.newQuad(Player.width*(i-1),8, Player.width,Player.height, Player.sheet_width,Player.sheet_height)
    Player.right[i] = love.graphics.newQuad(Player.width*(i-1),16, Player.width,Player.height, Player.sheet_width,Player.sheet_height)
    Player.up[i] = love.graphics.newQuad(Player.width*(i-1),24, Player.width,Player.height, Player.sheet_width,Player.sheet_height)
end


function Player.sprite_animation(dt)
    if not Player.animation.standing then
        Player.animation.frame = Animation.sprite_animation(dt, Player.animation.frame, Player.animation.max_frame)
    else 
        Player.animation.frame = 1 -- standing frame
    end
end

return Player -- returne la table au programe principale