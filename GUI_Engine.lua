-- GUI_Engine 
GE_theme = "bliss"
font = love.graphics.newFont("GE_asset/bliss/Ubuntu-Titling/UbuntuTitling-Bold.ttf", 64) 


-- General draw funxtion --------------------------------------------------------------------------------------------------------------------------------------------------
function GE_draw()
    GE_draw_Dbuttons()
    GE_draw_buttons1()
    GE_draw_PB()
end
-- 1 | Drawn button -------------------------------------------------------------------------------------------------------------------------------------------
Dbutton_list = {}

function GE_newDbutton(text, posx, posy, sizex, sizey, fn, colorR, colorG, colorB, colorA, textR, textG, textB, textA) 
    return {
        text = text or "Button",
        posx = posx or 10,
        posy = posy or 10,
        sizex = sizex or 60,
        sizey = sizey or 30,
        fn = fn or nilFN,
        colorR = colorR or 1,
        colorG = colorG or 1,
        colorB = colorB or 1,
        colorA = colorA or 0.7,
        textR = textR or 0,
        textG = textG or 0,
        textB = textB or 0,
        textA = textA or 1,
        isPressed = false
    }
end

function nilFN()
    print("button pressed")
end

function GE_CreateDbutton(text, posx, posy, sizex, sizey, fn, colorR, colorG, colorB, colorA, textR, textG, textB, textA) 
    table.insert(Dbutton_list, GE_newDbutton(text, posx, posy, sizex, sizey, fn, colorR, colorG, colorB, colorA, textR, textG, textB, textA))
end

function GE_draw_Dbuttons()
    for i, button in ipairs(Dbutton_list) do
        love.graphics.setColor(button.colorR, button.colorG, button.colorB, button.colorA)
        love.graphics.rectangle("fill", button.posx, button.posy, button.sizex, button.sizey)
        love.graphics.setColor(button.textR, button.textG, button.textB, button.textA)
        textW = font:getWidth(button.text)
        textH = font:getHeight(button.text)
        love.graphics.print(button.text, font, button.posx + (button.sizex / 2) - (textW / 2), button.posy + (button.sizey / 2) - (textH / 2))
        if love.mouse.getX() > button.posx and love.mouse.getX() < button.posx+button.sizex then
            if love.mouse.getY() > button.posy and love.mouse.getY() < button.posy+button.sizey then
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
--------------------------------------------------------------------------------------------------------------------------------------

-- 2 Button1 -------------------------------------------------------------------------------
button1_list = {}

function GE_newbutton1(text, posx, posy, size, fn) 
    return {
        text = text or "Button",
        posx = posx or 10,
        posy = posy or 10,
        size = size,
        fn = fn or nilFN,
        isPressed = false
    }
end

function GE_Createbutton1(text, posx, posy, size, fn) 
    table.insert(button1_list, GE_newbutton1(text, posx, posy, size,fn))
end

image_button1 = love.graphics.newImage("GE_asset/"..GE_theme.."/png/Button/Rect-Medium/Default.png")
function GE_draw_buttons1()
    for i, button in ipairs(button1_list) do
        if love.mouse.getX() > button.posx and love.mouse:getX() < button.posx+(image_button1:getWidth() * button.size) and love.mouse.getY() > button.posy and love.mouse.getY() < button.posy+(image_button1:getHeight()* button.size) then
            image_button1 = love.graphics.newImage("GE_asset/"..GE_theme.."/png/Button/Rect-Medium/Hover.png")
        else
            image_button1 = love.graphics.newImage("GE_asset/"..GE_theme.."/png/Button/Rect-Medium/Default.png")
        end
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(image_button1, button.posx, button.posy, 0, button.size, button.size)
        textW = font:getWidth(button.text)
        textH = font:getHeight(button.text)
        love.graphics.print(button.text, font, button.posx + ((image_button1:getWidth() * button.size) / 2) - ((textW * button.size) / 2), button.posy + ((image_button1:getHeight() * button.size) / 2) - ((textH * button.size) / 2) + (button.size * 4), 0, button.size, button.size)
        if love.mouse.getX() > button.posx and love.mouse:getX() < button.posx+(image_button1:getWidth()*button.size) then
            if love.mouse.getY() > button.posy and love.mouse.getY() < button.posy+(image_button1:getHeight()*button.size) then
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


-- 3 progress Bar ------------------------------------------------------------------------------------------------------------
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

-- this variable clean the list so the PB can be updated without having an accumulation of sprite
function GE_beforeCallingPB()
    for i,v in ipairs(PB_list) do
        table.remove(PB_list, i)
    end
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