--[[
    Module pour animé mes sprites
]]
local animation = {}

--animation.frame = 1
--animation.max_frame = 4
animation.timer = 0.1


function animation.sprite_animation(dt, frame, max_frame)
    --[[
        fonction pour animé le sprite donné en paramètre ...
    ]]
    animation.timer = animation.timer + dt
    if animation.timer > 0.25 then
        animation.timer = 0.1
        frame = frame +1
        if frame > max_frame then -- empèche d'aller au delà du nombre max de frames
            frame = 1
        end
    end
    return frame
end

function animation.update_all_sprite(dt)
    --[[
        fonction pour regroupé toute les commande pour mettre à jour les sprites
    ]]
    Player.sprite_animation(dt)
end

function animation.draw_all_sprite()
    --[[
        fonction pour regroupé toute les commande pour afficher les sprites
    ]]
    if Player.facing == "down" then
        love.graphics.draw(Player.sprite_sheet, Player.down[Player.animation.frame], Player.x, Player.y)
    elseif Player.facing == "right" then
        love.graphics.draw(Player.sprite_sheet, Player.right[Player.animation.frame], Player.x, Player.y)
    elseif Player.facing == "left" then
        love.graphics.draw(Player.sprite_sheet, Player.left[Player.animation.frame], Player.x, Player.y)
    elseif Player.facing == "up" then
        love.graphics.draw(Player.sprite_sheet, Player.up[Player.animation.frame], Player.x, Player.y)
    end
end

return animation