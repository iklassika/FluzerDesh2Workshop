function init()
    local pornoSound = "https://files.catbox.moe/g6spg1.mp3"

    api.log("сколько жироаппс брал минетов: " .. api.get_coins())
    api.set_jump_sound(pornoSound)
    api.set_damage_sound(pornoSound)
    api.set_death_sound(pornoSound)
    api.set_finish_sound(pornoSound)
    api.set_level_music(pornoSound)
    api.set_music_volume(0.9)
    api.play_sound(pornoSound)
    api.set_gravity(1.8)          -- почти луна
    api.set_jump_force(16)        -- высоко
    api.set_run_speed(9)          -- быстро
    api.set_max_hp(69)            -- символично
    api.heal_player(69)
    api.add_coins(69)
    api.shake_screen(0.4, 0.8)
    api.set_time_scale(0.7)       -- небольшое слоу-мо на старте
    api.vibrate()
    api.show_message("ПОРНО", 5)
    api.copy_to_clipboard("Фчик по заказу попросил сделать мод на порно в Fluzer Desh 2")

    -- ===== КОЛБЭКИ =====
    local sec = 0
    local lastHeal = 0
    local lastShake = 0

    api.on_second(function()
        sec = sec + 1

        -- Спам сообщениями
        if sec % 5 == 0 then
            api.show_message("порно", 1.2)
        end
        if sec % 9 == 0 then
            local msg = "HP: " .. math.floor(api.get_player_hp()) .. "/" .. api.get_player_max_hp()
            api.show_message(msg, 1.5)
        end
        if sec % 12 == 0 then
            api.show_message("X: " .. math.floor(api.get_player_x()) .. "  Y: " .. math.floor(api.get_player_y()), 1.5)
        end
        if sec % 15 == 0 then
            api.show_message("время уровня: " .. math.floor(api.time()) .. " сек", 1.5)
        end
        if sec % 18 == 0 then
                    api.play_sound(pornoSound)
            api.show_message("Фчик сказал — я сделал", 2)
        end
        if sec % 25 == 0 then
            api.show_message("это не баг, это порно", 2)
            api.vibrate()
        end

        -- Реген
        if not api.is_player_dead() and api.get_player_hp() < api.get_player_max_hp() then
            lastHeal = lastHeal + 1
            if lastHeal >= 6 then
                lastHeal = 0
                api.heal_player(7)
            end
        end

        -- Через 8 секунд вернуть нормальную скорость времени
        if sec == 8 then
            api.set_time_scale(1)
            api.show_message("скорость времени восстановлена", 2)
        end
    end)

    api.on_update(function(dt)
        -- Иногда трясём, если стоим на земле и низко
        lastShake = lastShake + dt
        if api.is_player_grounded() and api.get_player_y() < -3 and lastShake > 4 then
            lastShake = 0
            api.shake_screen(0.25, 0.3)
            api.vibrate()
        end
    end)
end
