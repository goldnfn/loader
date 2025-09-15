-- Smooth Exploit UI with draggable titlebar, UICorner, sliders, buttons, FOV, transparency, mobile toggles, and more

local UIS = game:GetService('UserInputService')
local RS = game:GetService('RunService')
local Players = game:GetService('Players')
local LP = Players.LocalPlayer

-- Helper: Add UICorner
local function addCorner(obj, rad)
    local c = Instance.new('UICorner')
    c.CornerRadius = UDim.new(0, rad or 8)
    c.Parent = obj
end

-- Helper: Make Draggable (only on dragBar)
local function makeDraggable(frame, dragBar)
    local dragToggle, dragInput, dragStart, startPos
    dragBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragToggle = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)
    dragBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragToggle then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- UI Setup
local gui = Instance.new('ScreenGui', game.CoreGui)
gui.Name = 'SmoothExploitUI'

local frame = Instance.new('Frame', gui)
frame.Size = UDim2.new(0, 370, 0, 500)
frame.Position = UDim2.new(0.5, -185, 0.5, -250)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
addCorner(frame, 12)

-- Titlebar
local titleBar = Instance.new('Frame', frame)
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
addCorner(titleBar, 12)
titleBar.Name = 'DragBar'

local title = Instance.new('TextLabel', titleBar)
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = '🤖 Aimbot'
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextYAlignment = Enum.TextYAlignment.Center

-- Minimize Button
local minBtn = Instance.new('TextButton', titleBar)
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -70, 0, 5)
minBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
minBtn.Text = '-'
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 22
addCorner(minBtn, 8)

-- Close Button (X)
local closeBtn = Instance.new('TextButton', titleBar)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeBtn.Text = 'X'
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
addCorner(closeBtn, 8)

makeDraggable(frame, titleBar)

local closeHint = Instance.new('TextLabel', frame)
closeHint.Size = UDim2.new(1, 0, 0, 20)
closeHint.Position = UDim2.new(0, 0, 0, 40)
closeHint.BackgroundTransparency = 1
closeHint.Text = 'Press [V] to close/open | [F7] or X to destroy'
closeHint.TextColor3 = Color3.fromRGB(180, 180, 180)
closeHint.Font = Enum.Font.Gotham
closeHint.TextSize = 14

-- Mobile Open/Close UI Button
local mobileToggleBtn = Instance.new('TextButton', gui)
mobileToggleBtn.Size = UDim2.new(0, 120, 0, 40)
mobileToggleBtn.Position = UDim2.new(0, 20, 1, -60)
mobileToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
mobileToggleBtn.Text = 'Open/Close UI'
mobileToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
mobileToggleBtn.Font = Enum.Font.GothamBold
mobileToggleBtn.TextSize = 18
addCorner(mobileToggleBtn, 10)

-- Aimbot Toggle Button
local aimbotBtn = Instance.new('TextButton', frame)
aimbotBtn.Size = UDim2.new(0, 120, 0, 40)
aimbotBtn.Position = UDim2.new(0, 20, 0, 80)
aimbotBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
aimbotBtn.Text = 'Aimbot: OFF'
aimbotBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
aimbotBtn.Font = Enum.Font.GothamBold
aimbotBtn.TextSize = 20
addCorner(aimbotBtn, 8)

-- Mobile Aimbot Toggle Button (always on screen)
local mobileAimbotBtn = Instance.new('TextButton', gui)
mobileAimbotBtn.Size = UDim2.new(0, 120, 0, 40)
mobileAimbotBtn.Position = UDim2.new(1, -140, 1, -60)
mobileAimbotBtn.BackgroundColor3 = Color3.fromRGB(80, 200, 80)
mobileAimbotBtn.Text = 'Aimbot: OFF'
mobileAimbotBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
mobileAimbotBtn.Font = Enum.Font.GothamBold
mobileAimbotBtn.TextSize = 18
addCorner(mobileAimbotBtn, 10)

-- Smoothness Slider
local sliderFrame = Instance.new('Frame', frame)
sliderFrame.Size = UDim2.new(0, 180, 0, 30)
sliderFrame.Position = UDim2.new(0, 160, 0, 90)
sliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
addCorner(sliderFrame, 8)

local sliderBar = Instance.new('Frame', sliderFrame)
sliderBar.Size = UDim2.new(1, 0, 0, 8)
sliderBar.Position = UDim2.new(0, 0, 0.5, -4)
sliderBar.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
addCorner(sliderBar, 4)

local sliderKnob = Instance.new('Frame', sliderFrame)
sliderKnob.Size = UDim2.new(0, 18, 0, 18)
sliderKnob.Position = UDim2.new(1, -18, 0.5, -9)
sliderKnob.BackgroundColor3 = Color3.fromRGB(120, 180, 255)
addCorner(sliderKnob, 9)

local sliderLabel = Instance.new('TextLabel', sliderFrame)
sliderLabel.Size = UDim2.new(1, 0, 0, 18)
sliderLabel.Position = UDim2.new(0, 0, 0, -22)
sliderLabel.BackgroundTransparency = 1
sliderLabel.Text = 'Smoothness: 1.00'
sliderLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
sliderLabel.Font = Enum.Font.Gotham
sliderLabel.TextSize = 14

-- Keybind Button
local keybindBtn = Instance.new('TextButton', frame)
keybindBtn.Size = UDim2.new(0, 180, 0, 36)
keybindBtn.Position = UDim2.new(0, 85, 0, 150)
keybindBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
keybindBtn.Text = 'Aimbot Key: MB2'
keybindBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
keybindBtn.Font = Enum.Font.Gotham
keybindBtn.TextSize = 18
addCorner(keybindBtn, 8)

-- Select Part Button (under Keybind Button)
local partBtn = Instance.new('TextButton', frame)
partBtn.Size = UDim2.new(0, 180, 0, 36)
partBtn.Position = UDim2.new(0, 85, 0, 196)
partBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
partBtn.Text = 'Select Part'
partBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
partBtn.Font = Enum.Font.Gotham
partBtn.TextSize = 18
addCorner(partBtn, 8)

-- Part Selector Popup (under Select Part Button)
local partPopup = Instance.new('Frame', gui)
partPopup.Size = UDim2.new(0, 160, 0, 120)
partPopup.Position = UDim2.new(0.5, -5, 0.5, 120)
partPopup.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
partPopup.Visible = false
addCorner(partPopup, 10)

local partTitle = Instance.new('TextLabel', partPopup)
partTitle.Size = UDim2.new(1, 0, 0, 28)
partTitle.BackgroundTransparency = 1
partTitle.Text = 'Select Body Part'
partTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
partTitle.Font = Enum.Font.GothamBold
partTitle.TextSize = 18

makeDraggable(partPopup, partTitle)

local parts = { 'Head', 'HumanoidRootPart', 'UpperTorso', 'LowerTorso' }
local partButtons = {}
for i, name in ipairs(parts) do
    local btn = Instance.new('TextButton', partPopup)
    btn.Size = UDim2.new(1, -20, 0, 20)
    btn.Position = UDim2.new(0, 10, 0, 28 + (i - 1) * 23)
    btn.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    addCorner(btn, 6)
    partButtons[#partButtons + 1] = btn
end

-- Aimbot Toggle/Hold Button
local modeBtn = Instance.new('TextButton', frame)
modeBtn.Size = UDim2.new(0, 180, 0, 36)
modeBtn.Position = UDim2.new(0, 85, 0, 242)
modeBtn.BackgroundColor3 = Color3.fromRGB(100, 80, 120)
modeBtn.Text = 'Aimbot: Toggle/Hold'
modeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
modeBtn.Font = Enum.Font.Gotham
modeBtn.TextSize = 18
addCorner(modeBtn, 8)

-- Mode Selector Popup (under Mode Button)
local modePopup = Instance.new('Frame', gui)
modePopup.Size = UDim2.new(0, 160, 0, 70)
modePopup.Position = UDim2.new(0.5, -5, 0.5, 170)
modePopup.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
modePopup.Visible = false
addCorner(modePopup, 10)

local modeTitle = Instance.new('TextLabel', modePopup)
modeTitle.Size = UDim2.new(1, 0, 0, 28)
modeTitle.BackgroundTransparency = 1
modeTitle.Text = 'Aimbot Mode'
modeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
modeTitle.Font = Enum.Font.GothamBold
modeTitle.TextSize = 18

makeDraggable(modePopup, modeTitle)

local holdBtn = Instance.new('TextButton', modePopup)
holdBtn.Size = UDim2.new(0.5, -15, 0, 28)
holdBtn.Position = UDim2.new(0, 10, 0, 35)
holdBtn.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
holdBtn.Text = 'Hold'
holdBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
holdBtn.Font = Enum.Font.Gotham
holdBtn.TextSize = 16
addCorner(holdBtn, 6)

local toggleBtn = Instance.new('TextButton', modePopup)
toggleBtn.Size = UDim2.new(0.5, -15, 0, 28)
toggleBtn.Position = UDim2.new(0.5, 5, 0, 35)
toggleBtn.BackgroundColor3 = Color3.fromRGB(80, 200, 80)
toggleBtn.Text = 'Toggle'
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.Gotham
toggleBtn.TextSize = 16
addCorner(toggleBtn, 6)

-- FOV Toggle Button
local fovBtn = Instance.new('TextButton', frame)
fovBtn.Size = UDim2.new(0, 120, 0, 36)
fovBtn.Position = UDim2.new(0, 20, 0, 290)
fovBtn.BackgroundColor3 = Color3.fromRGB(120, 120, 80)
fovBtn.Text = 'FOV: OFF'
fovBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
fovBtn.Font = Enum.Font.Gotham
fovBtn.TextSize = 18
addCorner(fovBtn, 8)

-- FOV Slider
local fovSliderFrame = Instance.new('Frame', frame)
fovSliderFrame.Size = UDim2.new(0, 180, 0, 30)
fovSliderFrame.Position = UDim2.new(0, 160, 0, 300)
fovSliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
addCorner(fovSliderFrame, 8)

local fovSliderBar = Instance.new('Frame', fovSliderFrame)
fovSliderBar.Size = UDim2.new(1, 0, 0, 8)
fovSliderBar.Position = UDim2.new(0, 0, 0.5, -4)
fovSliderBar.BackgroundColor3 = Color3.fromRGB(120, 120, 80)
addCorner(fovSliderBar, 4)

local fovSliderKnob = Instance.new('Frame', fovSliderFrame)
fovSliderKnob.Size = UDim2.new(0, 18, 0, 18)
fovSliderKnob.Position = UDim2.new(0, 0, 0.5, -9)
fovSliderKnob.BackgroundColor3 = Color3.fromRGB(200, 200, 80)
addCorner(fovSliderKnob, 9)

local fovSliderLabel = Instance.new('TextLabel', fovSliderFrame)
fovSliderLabel.Size = UDim2.new(1, 0, 0, 18)
fovSliderLabel.Position = UDim2.new(0, 0, 0, -22)
fovSliderLabel.BackgroundTransparency = 1
fovSliderLabel.Text = 'FOV: 1'
fovSliderLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
fovSliderLabel.Font = Enum.Font.Gotham
fovSliderLabel.TextSize = 14

-- FOV Color Button
local fovColorBtn = Instance.new('TextButton', frame)
fovColorBtn.Size = UDim2.new(0, 120, 0, 36)
fovColorBtn.Position = UDim2.new(0, 20, 0, 340)
fovColorBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
fovColorBtn.Text = 'FOV Color'
fovColorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
fovColorBtn.Font = Enum.Font.Gotham
fovColorBtn.TextSize = 18
addCorner(fovColorBtn, 8)

-- FOV Transparency Slider
local fovTransSliderFrame = Instance.new('Frame', frame)
fovTransSliderFrame.Size = UDim2.new(0, 180, 0, 30)
fovTransSliderFrame.Position = UDim2.new(0, 160, 0, 350)
fovTransSliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
addCorner(fovTransSliderFrame, 8)

local fovTransSliderBar = Instance.new('Frame', fovTransSliderFrame)
fovTransSliderBar.Size = UDim2.new(1, 0, 0, 8)
fovTransSliderBar.Position = UDim2.new(0, 0, 0.5, -4)
fovTransSliderBar.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
addCorner(fovTransSliderBar, 4)

local fovTransSliderKnob = Instance.new('Frame', fovTransSliderFrame)
fovTransSliderKnob.Size = UDim2.new(0, 18, 0, 18)
fovTransSliderKnob.Position = UDim2.new(1, -18, 0.5, -9)
fovTransSliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
addCorner(fovTransSliderKnob, 9)

local fovTransSliderLabel = Instance.new('TextLabel', fovTransSliderFrame)
fovTransSliderLabel.Size = UDim2.new(1, 0, 0, 18)
fovTransSliderLabel.Position = UDim2.new(0, 0, 0, -22)
fovTransSliderLabel.BackgroundTransparency = 1
fovTransSliderLabel.Text = 'Transparency: 0'
fovTransSliderLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
fovTransSliderLabel.Font = Enum.Font.Gotham
fovTransSliderLabel.TextSize = 14

-- UI State
local aimbotOn = false
local smoothness = 1
local draggingSlider = false
local draggingFovSlider = false
local draggingFovTransSlider = false
local aimbotKey = 'MouseButton2' -- MB2 default
local listeningForKey = false
local lockPart = 'Head'
local mode = 'Toggle' -- or "Hold"
local fovEnabled = false
local fovSize = 1
local holdingAimbot = false
local fovColor = Color3.fromRGB(255, 0, 0)
local fovTransparency = 0

-- FOV Circle Drawing (follows mouse)
local fovCircle = Drawing and Drawing.new('Circle') or nil
if fovCircle then
    fovCircle.Visible = false
    fovCircle.Thickness = 2
    fovCircle.Filled = false
    fovCircle.Color = fovColor
    fovCircle.Transparency = 1 - fovTransparency / 100
end

-- Sliders
sliderKnob.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingSlider = true
    end
end)
sliderFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingSlider = true
    end
end)
fovSliderKnob.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingFovSlider = true
    end
end)
fovSliderFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingFovSlider = true
    end
end)
fovTransSliderKnob.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingFovTransSlider = true
    end
end)
fovTransSliderFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingFovTransSlider = true
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingSlider = false
        draggingFovSlider = false
        draggingFovTransSlider = false
    end
end)

RS.RenderStepped:Connect(function()
    if draggingSlider then
        local mouse = UIS:GetMouseLocation().X
        local absPos = sliderFrame.AbsolutePosition.X
        local absSize = sliderFrame.AbsoluteSize.X
        local rel = math.clamp((mouse - absPos) / absSize, 0, 1)
        sliderKnob.Position = UDim2.new(rel, -9, 0.5, -9)
        smoothness = tonumber(string.format('%.2f', 1 - rel))
        sliderLabel.Text = 'Smoothness: ' .. string.format('%.2f', smoothness)
        print('Slider changed to:', smoothness)
    end
    if draggingFovSlider then
        local mouse = UIS:GetMouseLocation().X
        local absPos = fovSliderFrame.AbsolutePosition.X
        local absSize = fovSliderFrame.AbsoluteSize.X
        local rel = math.clamp((mouse - absPos) / absSize, 0, 1)
        fovSliderKnob.Position = UDim2.new(rel, -9, 0.5, -9)
        fovSize = math.floor(1 + rel * 499)
        fovSliderLabel.Text = 'FOV: ' .. tostring(fovSize)
        print('FOV slider changed to:', fovSize)
    end
    if draggingFovTransSlider then
        local mouse = UIS:GetMouseLocation().X
        local absPos = fovTransSliderFrame.AbsolutePosition.X
        local absSize = fovTransSliderFrame.AbsoluteSize.X
        local rel = math.clamp((mouse - absPos) / absSize, 0, 1)
        fovTransSliderKnob.Position = UDim2.new(rel, -9, 0.5, -9)
        fovTransparency = math.floor(rel * 100)
        fovTransSliderLabel.Text = 'Transparency: ' .. tostring(fovTransparency)
        print('Transparency slider changed to:', fovTransparency)
        if fovCircle then
            fovCircle.Transparency = 1 - fovTransparency / 100
        end
    end
    -- FOV Circle follows mouse
    if fovCircle then
        fovCircle.Visible = fovEnabled and gui.Enabled
        fovCircle.Color = fovColor
        fovCircle.Transparency = 1 - fovTransparency / 100
        local mouse = UIS:GetMouseLocation()
        fovCircle.Position = Vector2.new(mouse.X, mouse.Y)
        fovCircle.Radius = fovSize
    end
end)

-- FOV Color Button Logic (cycles through colors)
local colorList = {
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(255, 0, 255),
    Color3.fromRGB(0, 255, 255),
    Color3.fromRGB(255, 255, 255),
}
local colorIndex = 1
fovColorBtn.MouseButton1Click:Connect(function()
    colorIndex = colorIndex % #colorList + 1
    fovColor = colorList[colorIndex]
    fovColorBtn.BackgroundColor3 = fovColor
    print('FOV color changed')
end)

-- Aimbot Toggle Logic
aimbotBtn.MouseButton1Click:Connect(function()
    aimbotOn = not aimbotOn
    aimbotBtn.Text = 'Aimbot: ' .. (aimbotOn and 'ON' or 'OFF')
    aimbotBtn.BackgroundColor3 = aimbotOn and Color3.fromRGB(80, 200, 80)
        or Color3.fromRGB(60, 120, 255)
    print('Aimbot toggled:', aimbotOn)
end)

-- Mobile Aimbot Toggle Logic
mobileAimbotBtn.MouseButton1Click:Connect(function()
    aimbotOn = not aimbotOn
    mobileAimbotBtn.Text = 'Aimbot: ' .. (aimbotOn and 'ON' or 'OFF')
    mobileAimbotBtn.BackgroundColor3 = aimbotOn and Color3.fromRGB(80, 200, 80)
        or Color3.fromRGB(200, 60, 60)
    print('Aimbot toggled (mobile):', aimbotOn)
end)

-- Keybind Logic (toggles aimbot)
keybindBtn.MouseButton1Click:Connect(function()
    if listeningForKey then
        return
    end
    listeningForKey = true
    keybindBtn.Text = 'Press a key...'
    local conn
    conn = UIS.InputBegan:Connect(function(input, gpe)
        if gpe then
            return
        end
        local key
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            key = 'MouseButton2'
        elseif input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode.Name ~= 'V' then
                key = input.KeyCode.Name
            end
        end
        if key then
            aimbotKey = key
            keybindBtn.Text = 'Aimbot Key: '
                .. (key == 'MouseButton2' and 'MB2' or key)
            print('Aimbot key set to:', key)
            conn:Disconnect()
            listeningForKey = false
        end
    end)
end)

-- GUI Toggle (V, Minimize, Mobile)
local guiOpen = true
local function setGuiOpen(state)
    guiOpen = state
    frame.Visible = guiOpen
    if fovCircle then
        fovCircle.Visible = guiOpen and fovEnabled
    end
end
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then
        return
    end
    if input.KeyCode == Enum.KeyCode.V then
        setGuiOpen(not guiOpen)
    end
end)
minBtn.MouseButton1Click:Connect(function()
    setGuiOpen(false)
end)
mobileToggleBtn.MouseButton1Click:Connect(function()
    setGuiOpen(not guiOpen)
end)

-- Destroy UI on F7 or X
local function destroyUI()
    gui:Destroy()
    partPopup:Destroy()
    modePopup:Destroy()
    mobileToggleBtn:Destroy()
    mobileAimbotBtn:Destroy()
    if fovCircle then
        fovCircle:Remove()
    end
    print('UI destroyed')
end
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then
        return
    end
    if input.KeyCode == Enum.KeyCode.F7 then
        destroyUI()
    end
end)
closeBtn.MouseButton1Click:Connect(destroyUI)

-- Aimbot Keybind Logic (Toggle/Hold)
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then
        return
    end
    if
        (
            aimbotKey == 'MouseButton2'
            and input.UserInputType == Enum.UserInputType.MouseButton2
        )
        or (
            aimbotKey ~= 'MouseButton2'
            and input.UserInputType == Enum.UserInputType.Keyboard
            and input.KeyCode.Name == aimbotKey
        )
    then
        if mode == 'Toggle' then
            aimbotOn = not aimbotOn
            aimbotBtn.Text = 'Aimbot: ' .. (aimbotOn and 'ON' or 'OFF')
            mobileAimbotBtn.Text = 'Aimbot: ' .. (aimbotOn and 'ON' or 'OFF')
            aimbotBtn.BackgroundColor3 = aimbotOn and Color3.fromRGB(
                80,
                200,
                80
            ) or Color3.fromRGB(60, 120, 255)
            mobileAimbotBtn.BackgroundColor3 = aimbotOn
                    and Color3.fromRGB(80, 200, 80)
                or Color3.fromRGB(200, 60, 60)
            print('Aimbot toggled:', aimbotOn)
        else
            holdingAimbot = true
        end
    end
end)
UIS.InputEnded:Connect(function(input, gpe)
    if gpe then
        return
    end
    if mode == 'Hold' then
        if
            (
                aimbotKey == 'MouseButton2'
                and input.UserInputType == Enum.UserInputType.MouseButton2
            )
            or (
                aimbotKey ~= 'MouseButton2'
                and input.UserInputType == Enum.UserInputType.Keyboard
                and input.KeyCode.Name == aimbotKey
            )
        then
            holdingAimbot = false
        end
    end
end)

-- Part Selector Logic
partBtn.MouseButton1Click:Connect(function()
    partPopup.Visible = not partPopup.Visible
    print('Part selector opened')
end)
for i, btn in ipairs(partButtons) do
    btn.MouseButton1Click:Connect(function()
        lockPart = btn.Text
        partPopup.Visible = false
        partBtn.Text = lockPart
        print('Lock part set to:', lockPart)
    end)
end

-- Mode Selector Logic
modeBtn.MouseButton1Click:Connect(function()
    modePopup.Visible = not modePopup.Visible
    print('Aimbot mode selector opened')
end)
holdBtn.MouseButton1Click:Connect(function()
    mode = 'Hold'
    modePopup.Visible = false
    modeBtn.Text = 'Aimbot: Hold'
    print('Aimbot mode set to: Hold')
end)
toggleBtn.MouseButton1Click:Connect(function()
    mode = 'Toggle'
    modePopup.Visible = false
    modeBtn.Text = 'Aimbot: Toggle'
    print('Aimbot mode set to: Toggle')
end)

-- FOV Toggle Button
fovBtn.MouseButton1Click:Connect(function()
    fovEnabled = not fovEnabled
    fovBtn.Text = 'FOV: ' .. (fovEnabled and 'ON' or 'OFF')
    fovBtn.BackgroundColor3 = fovEnabled and Color3.fromRGB(200, 200, 80)
        or Color3.fromRGB(120, 120, 80)
    print('FOV toggled:', fovEnabled)
    if fovCircle then
        fovCircle.Visible = fovEnabled and guiOpen
    end
end)

-- FOV Color Button Logic (cycles through colors)
local colorList = {
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(255, 0, 255),
    Color3.fromRGB(0, 255, 255),
    Color3.fromRGB(255, 255, 255),
}
local colorIndex = 1
fovColorBtn.MouseButton1Click:Connect(function()
    colorIndex = colorIndex % #colorList + 1
    fovColor = colorList[colorIndex]
    fovColorBtn.BackgroundColor3 = fovColor
    print('FOV color changed')
end)

-- Aimbot Logic
local function getClosestPlayer()
    local char = LP.Character
    if not char or not char:FindFirstChild('Head') then
        return
    end
    local cam = workspace.CurrentCamera
    local closest, dist = nil, math.huge
    local mouse = UIS:GetMouseLocation()
    for _, plr in pairs(Players:GetPlayers()) do
        if
            plr ~= LP
            and plr.Character
            and plr.Character:FindFirstChild(lockPart)
        then
            local pos, onScreen =
                cam:WorldToViewportPoint(plr.Character[lockPart].Position)
            if onScreen then
                local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(
                    mouse.X,
                    mouse.Y
                )).Magnitude
                if (not fovEnabled or mag <= fovSize) and mag < dist then
                    dist = mag
                    closest = plr
                end
            end
        end
    end
    return closest
end

RS.RenderStepped:Connect(function()
    local active = (mode == 'Toggle' and aimbotOn)
        or (mode == 'Hold' and holdingAimbot)
    if active then
        local target = getClosestPlayer()
        if
            target
            and target.Character
            and target.Character:FindFirstChild(lockPart)
        then
            local cam = workspace.CurrentCamera
            local partPos = target.Character[lockPart].Position
            local char = LP.Character
            if char and char:FindFirstChild('Head') then
                if smoothness <= 0.01 then
                    cam.CFrame = CFrame.new(cam.CFrame.Position, partPos)
                else
                    cam.CFrame = cam.CFrame:Lerp(
                        CFrame.new(cam.CFrame.Position, partPos),
                        1 - smoothness
                    )
                end
            end
        end
    end
end)
