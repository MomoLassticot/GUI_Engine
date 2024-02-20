-- GUI_Engine 
GE_theme = "bliss"
font = love.graphics.newFont("GE_asset/bliss/Ubuntu-Titling/UbuntuTitling-Bold.ttf", 64) 


-- General draw funxtion --------------------------------------------------------------------------------------------------------------------------------------------------
function GE_draw()
    GE_draw_button()
    GE_draw_PB()
    GE_draw_Window()
end

-- General function to call before anything, to clean the lists
function GE_beforeUpdate()
    for i,v in ipairs(PB_list) do
        table.remove(PB_list, i)
    end
    for i,v in ipairs(Window_list) do
        table.remove(Window_list, i)
    end
end

-- 1 Button -------------------------------------------------------------------------------
button_list = {}

function GE_newbutton(text, posx, posy, sizeX, sizeY, fn, text_size) 
    return {
        text = text or "Button",
        posx = posx or 10,
        posy = posy or 10,
        sizeX = sizeX,
        sizeY = sizeY,
        fn = fn or nilFN,
        text_size = text_size or 1,
        isPressed = false
    }
end

function GE_Createbutton(text, posx, posy, sizeX, sizeY, fn, text_size) 
    table.insert(button_list, GE_newbutton(text, posx, posy, sizeX, sizeY, fn, text_size))
end

image_button = love.graphics.newImage("GE_asset/"..GE_theme.."/png/Button/Rect-Medium/Default.png")
function GE_draw_button()
    love.graphics.setColor(1, 1, 1, 1)
    for i, button in ipairs(button_list) do
        if love.mouse.getX() > button.posx and love.mouse:getX() < button.posx+(image_button:getWidth() * button.sizeX) and love.mouse.getY() > button.posy and love.mouse.getY() < button.posy+(image_button:getHeight()* button.sizeY) then
            image_button = love.graphics.newImage("GE_asset/"..GE_theme.."/png/Button/Rect-Medium/Hover.png")
        else
            image_button = love.graphics.newImage("GE_asset/"..GE_theme.."/png/Button/Rect-Medium/Default.png")
        end
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(image_button, button.posx, button.posy, 0, button.sizeX, button.sizeY)
        textW = font:getWidth(button.text)
        textH = font:getHeight(button.text)
        love.graphics.print(button.text, font, button.posx + ((image_button:getWidth() * button.sizeX) / 2) - ((textW * button.text_size) / 2), button.posy + ((image_button:getHeight() * button.sizeY) / 2) - ((textH * button.text_size) / 2) + (button.sizeY * 4), 0, button.text_size, button.text_size)
        if love.mouse.getX() > button.posx and love.mouse:getX() < button.posx+(image_button:getWidth()*button.sizeX) then
            if love.mouse.getY() > button.posy and love.mouse.getY() < button.posy+(image_button:getHeight()*button.sizeY) then
                if love.mouse.isDown(1) then
                    if button.isPressed == false then 
                        button.fn()
                        button.isPressed = true
                    end
                else
                    button.isPressed = false
                end
            end
        end
    end
end


-- 2 progress Bar ------------------------------------------------------------------------------------------------------------
PB_list = {}

function GE_newPB(variable, maxvalue, posx, posy, size, fnp, fnm) 
    return {
        variable = variable,
        maxvalue = maxvalue,
        posx = posx or 10,
        posy = posy or 10,
        size = size or 1
    }
end

function GE_CreatePB(variable, maxvalue, posx, posy, size)
    table.insert(PB_list, GE_newPB(variable, maxvalue, posx, posy, size))
end

function GE_draw_PB()
    love.graphics.setColor(1, 1, 1, 1)
    for i, PB in ipairs(PB_list) do
        background_sprite = love.graphics.newImage("GE_asset/bliss/png/ProgressBar/Background.png")
        bar_sprite = love.graphics.newImage("GE_asset/bliss/png/ProgressBar/Line.png")
        love.graphics.draw(background_sprite, PB.posx, PB.posy, 0, PB.size, PB.size)
        love.graphics.draw(bar_sprite, PB.posx + ((bar_sprite:getWidth() * PB.size) / 80), PB.posy + ((bar_sprite:getHeight() * PB.size) / 5), 0, (PB.size * 0.97) * (PB.variable / PB.maxvalue), PB.size)
    end
end

-- 3 window --------------------------------------------------------------------------------------------------------------
-- THE WAY IT WORK:
    -- if the variable is == true then its show and is reactive, else it dont draw

Window_list = {}

function GE_newWindow(variable, category, posx, posy, sizex, sizey, title, text) 
    return {
        variable = variable,
        category = category or "1",
        posx = posx or 10,
        posy = posy or 10,
        sizex = sizex or 1,
        sizey = sizey or 1,
        title = title or "New Window",
        text = text or "This is a window"
    }
end

function GE_CreateWindow(variable, category, posx, posy, sizex, sizey, title, text)
    table.insert(Window_list, GE_newWindow(variable, category, posx, posy, sizex, sizey, title, text))
end

function GE_draw_Window()
    love.graphics.setColor(1, 1, 1, 1)
    Window_default_sprite = love.graphics.newImage("GE_asset/bliss/png/Panel/Window/1.png")
    for i, Window in ipairs(Window_list) do
        if Window.variable == true then
            Window_sprite = love.graphics.newImage("GE_asset/bliss/png/Panel/Window/"..Window.category..".png")
            love.graphics.draw(Window_sprite, Window.posx, Window.posy, 0, Window.sizex, Window.sizey)
            love.graphics.print(Window.title, font, Window.posx + ((Window_default_sprite:getWidth() * Window.sizex) / 2) - ((font:getWidth(Window.title) * Window.sizex) / 2), Window.posy + ((Window_default_sprite:getHeight() * Window.sizey)/16), 0, Window.sizex, Window.sizey)
        end
    end
end