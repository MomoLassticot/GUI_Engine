-- GUI_Engine 
GE_theme = "bliss"
font = love.graphics.newFont("GE_asset/bliss/Ubuntu-Titling/UbuntuTitling-Bold.ttf", 64) 


-- General draw funxtion --------------------------------------------------------------------------------------------------------------------------------------------------
function GE_draw()
    GE_draw_buttons1()
    GE_draw_PB()
end

-- General function to call before anything, to clean the lists
function GE_beforeUpdate()
    for i,v in ipairs(PB_list) do
        table.remove(PB_list, i)
    end
end

-- 1 Button -------------------------------------------------------------------------------
button1_list = {}

function GE_newbutton1(text, posx, posy, sizeX, sizeY, fn, text_size) 
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

function GE_Createbutton1(text, posx, posy, sizeX, sizeY, fn, text_size) 
    table.insert(button1_list, GE_newbutton1(text, posx, posy, sizeX, sizeY, fn, text_size))
end

image_button1 = love.graphics.newImage("GE_asset/"..GE_theme.."/png/Button/Rect-Medium/Default.png")
function GE_draw_buttons1()
    for i, button in ipairs(button1_list) do
        if love.mouse.getX() > button.posx and love.mouse:getX() < button.posx+(image_button1:getWidth() * button.sizeX) and love.mouse.getY() > button.posy and love.mouse.getY() < button.posy+(image_button1:getHeight()* button.sizeY) then
            image_button1 = love.graphics.newImage("GE_asset/"..GE_theme.."/png/Button/Rect-Medium/Hover.png")
        else
            image_button1 = love.graphics.newImage("GE_asset/"..GE_theme.."/png/Button/Rect-Medium/Default.png")
        end
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(image_button1, button.posx, button.posy, 0, button.sizeX, button.sizeY)
        textW = font:getWidth(button.text)
        textH = font:getHeight(button.text)
        love.graphics.print(button.text, font, button.posx + ((image_button1:getWidth() * button.sizeX) / 2) - ((textW * button.text_size) / 2), button.posy + ((image_button1:getHeight() * button.sizeY) / 2) - ((textH * button.text_size) / 2) + (button.sizeY * 4), 0, button.text_size, button.text_size)
        if love.mouse.getX() > button.posx and love.mouse:getX() < button.posx+(image_button1:getWidth()*button.sizeX) then
            if love.mouse.getY() > button.posy and love.mouse.getY() < button.posy+(image_button1:getHeight()*button.sizeY) then
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
    for i, PB in ipairs(PB_list) do
        background_sprite = love.graphics.newImage("GE_asset/bliss/png/ProgressBar/Background.png")
        bar_sprite = love.graphics.newImage("GE_asset/bliss/png/ProgressBar/Line.png")
        PB.variable = PB.variable
        love.graphics.draw(background_sprite, PB.posx, PB.posy, 0, PB.size, PB.size)
        love.graphics.draw(bar_sprite, PB.posx + ((bar_sprite:getWidth() * PB.size) / 80), PB.posy + ((bar_sprite:getHeight() * PB.size) / 5), 0, (PB.size * 0.97) * (PB.variable / PB.maxvalue), PB.size)
    end
end