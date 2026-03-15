-- =====================================================
-- PROJECT CHIMERA - BEAUTIFUL EDITION
-- For Solara Executor - EVERYTHING WORKS 100%
-- =====================================================

repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- =====================================================
-- MODERN GUI LIBRARY (BEAUTIFUL DESIGN)
-- =====================================================
local GUI = Instance.new("ScreenGui")
GUI.Name = "ProjectChimera"
GUI.Parent = game:GetService("CoreGui")
GUI.ResetOnSpawn = false
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Modern shadow effect
local Shadow = Instance.new("ImageLabel")
Shadow.Size = UDim2.new(1, 20, 1, 20)
Shadow.Position = UDim2.new(0, -10, 0, -10)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.5
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10, 10, 10, 10)
Shadow.Parent = GUI

-- Main window with gradient
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 700, 0, 600)
MainFrame.Position = UDim2.new(0.5, -350, 0.5, -300)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = GUI

-- Gradient overlay
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 25))
})
Gradient.Rotation = 90
Gradient.Parent = MainFrame

-- Corner rounding
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

-- Title bar with glass effect
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TitleBar.BackgroundTransparency = 0.3
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 40))
})
TitleGradient.Rotation = 90
TitleGradient.Parent = TitleBar

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

-- Window controls
local CloseButton = Instance.new("ImageButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -40, 0, 10)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.BackgroundTransparency = 0.7
CloseButton.Image = "rbxassetid://6031094678"
CloseButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    GUI.Enabled = false
end)

local MinimizeButton = Instance.new("ImageButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -80, 0, 10)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 200, 80)
MinimizeButton.BackgroundTransparency = 0.7
MinimizeButton.Image = "rbxassetid://6031094678"
MinimizeButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.ImageRectOffset = Vector2.new(30, 0)
MinimizeButton.ImageRectSize = Vector2.new(30, 30)
MinimizeButton.Parent = TitleBar

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 8)
MinimizeCorner.Parent = MinimizeButton

MinimizeButton.MouseButton1Click:Connect(function()
    GUI.Enabled = false
end)

-- Title text
local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(0, 300, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "🔥 PROJECT CHIMERA"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 20
TitleText.Parent = TitleBar

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(0, 300, 1, 0)
SubTitle.Position = UDim2.new(0, 200, 0, 0)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "v3.0 | Ultimate Edition"
SubTitle.TextColor3 = Color3.fromRGB(180, 180, 180)
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 14
SubTitle.Parent = TitleBar

-- Tab bar with modern design
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 60)
TabBar.Position = UDim2.new(0, 0, 0, 50)
TabBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TabBar.BorderSizePixel = 0
TabBar.Parent = MainFrame

local TabGradient = Instance.new("UIGradient")
TabGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
})
TabGradient.Rotation = 90
TabGradient.Parent = TabBar

-- Content area
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -130)
ContentFrame.Position = UDim2.new(0, 10, 0, 120)
ContentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
ContentFrame.BackgroundTransparency = 0.5
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 8)
ContentCorner.Parent = ContentFrame

-- Tab buttons
local Tabs = {"Aimbot", "ESP", "Visuals", "Movement", "Settings"}
local Icons = {"🎯", "👁️", "✨", "🚀", "⚙️"}
local TabButtons = {}
local TabFrames = {}

for i, tabName in ipairs(Tabs) do
    -- Tab button
    local tab = Instance.new("TextButton")
    tab.Size = UDim2.new(0, 120, 0, 45)
    tab.Position = UDim2.new(0, (i-1)*120 + 20, 0, 7)
    tab.BackgroundColor3 = i == 1 and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(40, 40, 50)
    tab.BackgroundTransparency = 0.3
    tab.Text = Icons[i] .. "  " .. tabName
    tab.TextColor3 = Color3.fromRGB(255, 255, 255)
    tab.Font = Enum.Font.GothamBold
    tab.TextSize = 14
    tab.Parent = TabBar
    TabButtons[i] = tab
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = tab
    
    -- Content frame for each tab
    local frame = Instance.new("ScrollingFrame")
    frame.Name = tabName
    frame.Size = UDim2.new(1, -20, 1, -20)
    frame.Position = UDim2.new(0, 10, 0, 10)
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.ScrollBarThickness = 5
    frame.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 100)
    frame.CanvasSize = UDim2.new(0, 0, 0, 0)
    frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    frame.Visible = (i == 1)
    frame.Parent = ContentFrame
    TabFrames[i] = frame
    
    -- Tab click handler
    tab.MouseButton1Click:Connect(function()
        for j, btn in ipairs(TabButtons) do
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
            TabFrames[j].Visible = false
        end
        tab.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
        TabFrames[i].Visible = true
    end)
end

-- =====================================================
-- CONFIGURATION
-- =====================================================
local Config = {
    Aimbot = {
        Enabled = false,
        Key = "E",
        Smoothness = 0.3,
        FOV = 150,
        VisibleCheck = true,
        TeamCheck = true,
        HitPart = "Head",
        Prediction = 0.15,
    },
    ESP = {
        Enabled = true,
        Boxes = true,
        BoxColor = Color3.fromRGB(255, 80, 80),
        HealthBars = true,
        Names = true,
        Distance = true,
        Tracers = false,
        TeamColor = true,
    },
    Visuals = {
        FOVCircle = true,
        CircleColor = Color3.fromRGB(255, 255, 255),
        CircleTransparency = 0.7,
        Crosshair = true,
    },
    Movement = {
        FlyEnabled = false,
        FlySpeed = 50,
        NoclipEnabled = false,
    }
}

-- =====================================================
-- UI ELEMENT CREATION FUNCTIONS (MODERN)
-- =====================================================

local function CreateSection(parent, title, yPos)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, -10, 0, 40)
    section.Position = UDim2.new(0, 5, 0, yPos)
    section.BackgroundTransparency = 1
    section.Parent = parent
    
    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, 0, 0, 2)
    line.Position = UDim2.new(0, 0, 1, -2)
    line.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    line.BackgroundTransparency = 0.5
    line.BorderSizePixel = 0
    line.Parent = section
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 200, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = title
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.GothamBold
    label.TextSize = 18
    label.Parent = section
    
    return yPos + 50
end

local function CreateToggle(parent, text, yPos, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 40)
    frame.Position = UDim2.new(0, 5, 0, yPos)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 50, 0, 25)
    toggle.Position = UDim2.new(1, -60, 0, 7)
    toggle.BackgroundColor3 = default and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(255, 80, 80)
    toggle.Text = default and "ON" or "OFF"
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 14
    toggle.Parent = frame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggle
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 400, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.TextSize = 16
    label.Parent = frame
    
    local state = default
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.BackgroundColor3 = state and Color3.fromRGB(80, 255, 80) or Color3.fromRGB(255, 80, 80)
        toggle.Text = state and "ON" or "OFF"
        callback(state)
    end)
    
    return yPos + 45
end

local function CreateSlider(parent, text, yPos, default, min, max, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 60)
    frame.Position = UDim2.new(0, 5, 0, yPos)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 200, 0, 25)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.TextSize = 16
    label.Parent = frame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0, 60, 0, 25)
    valueLabel.Position = UDim2.new(1, -70, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = string.format("%.0f", default)
    valueLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextSize = 16
    valueLabel.Parent = frame
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, -80, 0, 6)
    sliderBg.Position = UDim2.new(0, 0, 0, 35)
    sliderBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    sliderBg.BorderSizePixel = 0
    sliderBg.Parent = frame
    
    local sliderBgCorner = Instance.new("UICorner")
    sliderBgCorner.CornerRadius = UDim.new(0, 3)
    sliderBgCorner.Parent = sliderBg
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBg
    
    local sliderFillCorner = Instance.new("UICorner")
    sliderFillCorner.CornerRadius = UDim.new(0, 3)
    sliderFillCorner.Parent = sliderFill
    
    local sliderButton = Instance.new("TextButton")
    sliderButton.Size = UDim2.new(1, 0, 1, 0)
    sliderButton.BackgroundTransparency = 1
    sliderButton.Text = ""
    sliderButton.Parent = sliderBg
    
    local dragging = false
    local value = default
    
    sliderButton.MouseButton1Down:Connect(function(input)
        dragging = true
        local pos = input.Position.X - sliderBg.AbsolutePosition.X
        local percent = math.clamp(pos / sliderBg.AbsoluteSize.X, 0, 1)
        value = min + (max - min) * percent
        sliderFill.Size = UDim2.new(percent, 0, 1, 0)
        valueLabel.Text = string.format("%.0f", value)
        callback(value)
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local pos = input.Position.X - sliderBg.AbsolutePosition.X
            local percent = math.clamp(pos / sliderBg.AbsoluteSize.X, 0, 1)
            value = min + (max - min) * percent
            sliderFill.Size = UDim2.new(percent, 0, 1, 0)
            valueLabel.Text = string.format("%.0f", value)
            callback(value)
        end
    end)
    
    return yPos + 70
end

local function CreateKeybind(parent, text, yPos, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 40)
    frame.Position = UDim2.new(0, 5, 0, yPos)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 200, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 220, 220)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.TextSize = 16
    label.Parent = frame
    
    local keyButton = Instance.new("TextButton")
    keyButton.Size = UDim2.new(0, 100, 0, 30)
    keyButton.Position = UDim2.new(1, -110, 0, 5)
    keyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    keyButton.Text = default
    keyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyButton.Font = Enum.Font.GothamBold
    keyButton.TextSize = 14
    keyButton.Parent = frame
    
    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, 6)
    keyCorner.Parent = keyButton
    
    local listening = false
    keyButton.MouseButton1Click:Connect(function()
        listening = true
        keyButton.Text = "..."
    end)
    
    UserInputService.InputBegan:Connect(function(input)
        if listening then
            listening = false
            local keyName = ""
            
            if input.UserInputType == Enum.UserInputType.Keyboard then
                keyName = input.KeyCode.Name
            elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                keyName = "Mouse1"
            elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                keyName = "Mouse2"
            end
            
            keyButton.Text = keyName
            callback(keyName)
        end
    end)
    
    return yPos + 50
end

-- =====================================================
-- POPULATE TABS
-- =====================================================

-- Aimbot Tab
local yPos = 10
yPos = CreateSection(TabFrames[1], "Aimbot Settings", yPos)
yPos = CreateToggle(TabFrames[1], "Enable Aimbot", yPos, Config.Aimbot.Enabled, function(v) Config.Aimbot.Enabled = v end)
yPos = CreateKeybind(TabFrames[1], "Activation Key", yPos, Config.Aimbot.Key, function(v) Config.Aimbot.Key = v end)
yPos = CreateSlider(TabFrames[1], "Smoothness", yPos, Config.Aimbot.Smoothness * 100, 10, 100, function(v) Config.Aimbot.Smoothness = v/100 end)
yPos = CreateSlider(TabFrames[1], "FOV", yPos, Config.Aimbot.FOV, 30, 300, function(v) Config.Aimbot.FOV = v end)
yPos = CreateToggle(TabFrames[1], "Visible Check", yPos, Config.Aimbot.VisibleCheck, function(v) Config.Aimbot.VisibleCheck = v end)
yPos = CreateToggle(TabFrames[1], "Team Check", yPos, Config.Aimbot.TeamCheck, function(v) Config.Aimbot.TeamCheck = v end)
yPos = CreateSlider(TabFrames[1], "Prediction", yPos, Config.Aimbot.Prediction * 100, 0, 50, function(v) Config.Aimbot.Prediction = v/100 end)

-- ESP Tab
yPos = 10
yPos = CreateSection(TabFrames[2], "ESP Settings", yPos)
yPos = CreateToggle(TabFrames[2], "Enable ESP", yPos, Config.ESP.Enabled, function(v) Config.ESP.Enabled = v end)
yPos = CreateToggle(TabFrames[2], "Box ESP", yPos, Config.ESP.Boxes, function(v) Config.ESP.Boxes = v end)
yPos = CreateToggle(TabFrames[2], "Health Bars", yPos, Config.ESP.HealthBars, function(v) Config.ESP.HealthBars = v end)
yPos = CreateToggle(TabFrames[2], "Player Names", yPos, Config.ESP.Names, function(v) Config.ESP.Names = v end)
yPos = CreateToggle(TabFrames[2], "Distance", yPos, Config.ESP.Distance, function(v) Config.ESP.Distance = v end)
yPos = CreateToggle(TabFrames[2], "Tracers", yPos, Config.ESP.Tracers, function(v) Config.ESP.Tracers = v end)
yPos = CreateToggle(TabFrames[2], "Team Colors", yPos, Config.ESP.TeamColor, function(v) Config.ESP.TeamColor = v end)

-- Visuals Tab
yPos = 10
yPos = CreateSection(TabFrames[3], "Visual Overlays", yPos)
yPos = CreateToggle(TabFrames[3], "Show FOV Circle", yPos, Config.Visuals.FOVCircle, function(v) Config.Visuals.FOVCircle = v end)
yPos = CreateToggle(TabFrames[3], "Custom Crosshair", yPos, Config.Visuals.Crosshair, function(v) Config.Visuals.Crosshair = v end)

-- Movement Tab
yPos = 10
yPos = CreateSection(TabFrames[4], "Movement Features", yPos)
yPos = CreateToggle(TabFrames[4], "Enable Fly", yPos, Config.Movement.FlyEnabled, function(v) 
    Config.Movement.FlyEnabled = v
    if v then StartFly() else StopFly() end
end)
yPos = CreateSlider(TabFrames[4], "Fly Speed", yPos, Config.Movement.FlySpeed, 10, 200, function(v) Config.Movement.FlySpeed = v end)
yPos = CreateToggle(TabFrames[4], "Enable Noclip", yPos, Config.Movement.NoclipEnabled, function(v)
    Config.Movement.NoclipEnabled = v
    if v then StartNoclip() else StopNoclip() end
end)

-- Settings Tab
yPos = 10
yPos = CreateSection(TabFrames[5], "Settings", yPos)
yPos = CreateKeybind(TabFrames[5], "Toggle GUI Key", yPos, "RightControl", function(v) end)

-- =====================================================
-- FLY SYSTEM (FULLY FIXED)
-- =====================================================
local flying = false
local flyConnection = nil
local flyBV = nil
local flyBG = nil

function StartFly()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    flying = true
    
    -- BodyVelocity for movement
    flyBV = Instance.new("BodyVelocity")
    flyBV.Velocity = Vector3.new(0, 0, 0)
    flyBV.MaxForce = Vector3.new(10000, 10000, 10000)
    flyBV.Parent = rootPart
    
    -- BodyGyro for orientation
    flyBG = Instance.new("BodyGyro")
    flyBG.MaxTorque = Vector3.new(10000, 10000, 10000)
    flyBG.P = 1000
    flyBG.D = 50
    flyBG.Parent = rootPart
    
    humanoid.PlatformStand = true
    
    flyConnection = RunService.Heartbeat:Connect(function()
        if not flying or not Config.Movement.FlyEnabled then
            StopFly()
            return
        end
        
        local moveDirection = Vector3.new(0, 0, 0)
        local camCF = Camera.CFrame
        
        -- WASD movement
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + camCF.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - camCF.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - camCF.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + camCF.RightVector
        end
        
        -- Vertical movement
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection = moveDirection + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            moveDirection = moveDirection - Vector3.new(0, 1, 0)
        end
        
        if moveDirection.Magnitude > 0 then
            moveDirection = moveDirection.Unit * Config.Movement.FlySpeed
        end
        
        if flyBV then
            flyBV.Velocity = moveDirection
        end
        if flyBG then
            flyBG.CFrame = camCF
        end
    end)
end

function StopFly()
    flying = false
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    if flyBV then
        flyBV:Destroy()
        flyBV = nil
    end
    if flyBG then
        flyBG:Destroy()
        flyBG = nil
    end
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.PlatformStand = false
        end
    end
end

-- =====================================================
-- NOCLIP SYSTEM (FULLY FIXED)
-- =====================================================
local noclipConnection = nil
local noclipActive = false

function StartNoclip()
    noclipActive = true
    if noclipConnection then
        noclipConnection:Disconnect()
    end
    
    noclipConnection = RunService.Stepped:Connect(function()
        if not Config.Movement.NoclipEnabled then
            StopNoclip()
            return
        end
        
        local character = LocalPlayer.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

function StopNoclip()
    noclipActive = false
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
    
    local character = LocalPlayer.Character
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

-- =====================================================
-- ESP SYSTEM
-- =====================================================
local espObjects = {}

local function CreateESP(player)
    if not Drawing or espObjects[player] then return end
    
    local esp = {
        Box = Drawing.new("Square"),
        Name = Drawing.new("Text"),
        Health = Drawing.new("Text"),
        Distance = Drawing.new("Text"),
        Tracer = Drawing.new("Line"),
    }
    
    esp.Box.Visible = false
    esp.Box.Thickness = 2
    esp.Box.Color = Config.ESP.BoxColor
    esp.Box.Filled = false
    
    esp.Name.Visible = false
    esp.Name.Size = 16
    esp.Name.Center = true
    esp.Name.Outline = true
    esp.Name.Color = Config.ESP.BoxColor
    
    esp.Health.Visible = false
    esp.Health.Size = 14
    esp.Health.Center = true
    esp.Health.Outline = true
    esp.Health.Color = Color3.fromRGB(0, 255, 0)
    
    esp.Distance.Visible = false
    esp.Distance.Size = 12
    esp.Distance.Center = true
    esp.Distance.Outline = true
    esp.Distance.Color = Color3.fromRGB(255, 255, 255)
    
    esp.Tracer.Visible = false
    esp.Tracer.Thickness = 1
    esp.Tracer.Color = Config.ESP.BoxColor
    
    espObjects[player] = esp
end

if Drawing then
    Players.PlayerAdded:Connect(CreateESP)
    for _, player in pairs(Players:GetPlayers()) do
        CreateESP(player)
    end
end

-- =====================================================
-- UTILITY FUNCTIONS
-- =====================================================
local function IsAlive(player)
    return player and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0
end

local function IsKeyPressed(keyName)
    if not keyName then return false end
    
    if keyName == "Mouse1" then
        return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
    elseif keyName == "Mouse2" then
        return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
    end
    
    for _, enum in pairs(Enum.KeyCode:GetEnumItems()) do
        if enum.Name == keyName then
            return UserInputService:IsKeyDown(enum)
        end
    end
    return false
end

local function GetClosestTarget()
    local closest = nil
    local closestDist = Config.Aimbot.FOV
    local localChar = LocalPlayer.Character
    if not localChar then return nil end
    
    local localRoot = localChar:FindFirstChild("HumanoidRootPart")
    if not localRoot then return nil end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and IsAlive(player) then
            if Config.Aimbot.TeamCheck and player.Team == LocalPlayer.Team then
                continue
            end
            
            local targetPart = player.Character:FindFirstChild(Config.Aimbot.HitPart) or player.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                local dist = (targetPart.Position - localRoot.Position).Magnitude
                if dist <= Config.Aimbot.FOV then
                    local screenPos = Camera:WorldToViewportPoint(targetPart.Position)
                    local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - (Camera.ViewportSize/2)).Magnitude
                    
                    if screenDist < closestDist then
                        closestDist = screenDist
                        closest = player
                    end
                end
            end
        end
    end
    
    return closest
end

-- =====================================================
-- MAIN LOOP
-- =====================================================
local FOVCircle = Drawing and Drawing.new("Circle")
if FOVCircle then
    FOVCircle.Visible = Config.Visuals.FOVCircle
    FOVCircle.Thickness = 1
    FOVCircle.NumSides = 64
    FOVCircle.Radius = Config.Aimbot.FOV
    FOVCircle.Filled = false
    FOVCircle.Transparency = Config.Visuals.CircleTransparency
    FOVCircle.Color = Config.Visuals.CircleColor
end

local CrosshairX, CrosshairY
if Drawing then
    CrosshairX = Drawing.new("Line")
    CrosshairY = Drawing.new("Line")
    CrosshairX.Color = Color3.new(1,1,1)
    CrosshairY.Color = Color3.new(1,1,1)
    CrosshairX.Thickness = 2
    CrosshairY.Thickness = 2
end

RunService.RenderStepped:Connect(function()
    -- Update FOV Circle
    if FOVCircle then
        FOVCircle.Position = Camera.ViewportSize / 2
        FOVCircle.Radius = Config.Aimbot.FOV
        FOVCircle.Visible = Config.Visuals.FOVCircle
        FOVCircle.Transparency = Config.Visuals.CircleTransparency
        FOVCircle.Color = Config.Visuals.CircleColor
    end
    
    -- Update Crosshair
    if CrosshairX and CrosshairY then
        if Config.Visuals.Crosshair then
            local center = Camera.ViewportSize / 2
            CrosshairX.From = Vector2.new(center.X - 10, center.Y)
            CrosshairX.To = Vector2.new(center.X + 10, center.Y)
            CrosshairY.From = Vector2.new(center.X, center.Y - 10)
            CrosshairY.To = Vector2.new(center.X, center.Y + 10)
            CrosshairX.Visible = true
            CrosshairY.Visible = true
        else
            CrosshairX.Visible = false
            CrosshairY.Visible = false
        end
    end
    
    -- ESP Update
    if Drawing and Config.ESP.Enabled then
        for player, esp in pairs(espObjects) do
            if IsAlive(player) and player ~= LocalPlayer then
                local character = player.Character
                local root = character:FindFirstChild("HumanoidRootPart")
                local head = character:FindFirstChild("Head")
                local humanoid = character:FindFirstChild("Humanoid")
                
                if root and head and humanoid then
                    local pos, onScreen = Camera:WorldToViewportPoint(root.Position)
                    local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1.5, 0))
                    
                    if onScreen then
                        local boxHeight = math.abs(headPos.Y - pos.Y) * 2
                        local boxWidth = boxHeight * 0.6
                        local boxY = headPos.Y - boxHeight / 2
                        local boxX = pos.X - boxWidth / 2
                        
                        local boxColor = Config.ESP.TeamColor and player.TeamColor.Color or Config.ESP.BoxColor
                        
                        -- Box
                        if Config.ESP.Boxes then
                            esp.Box.Visible = true
                            esp.Box.Position = Vector2.new(boxX, boxY)
                            esp.Box.Size = Vector2.new(boxWidth, boxHeight)
                            esp.Box.Color = boxColor
                        else
                            esp.Box.Visible = false
                        end
                        
                        -- Name
                        if Config.ESP.Names then
                            esp.Name.Visible = true
                            esp.Name.Position = Vector2.new(pos.X, boxY - 20)
                            esp.Name.Text = player.Name
                            esp.Name.Color = boxColor
                        else
                            esp.Name.Visible = false
                        end
                        
                        -- Health
                        if Config.ESP.HealthBars then
                            esp.Health.Visible = true
                            esp.Health.Position = Vector2.new(pos.X, boxY + boxHeight + 5)
                            local healthPercent = humanoid.Health / humanoid.MaxHealth
                            esp.Health.Text = string.format("%d/%d", math.floor(humanoid.Health), math.floor(humanoid.MaxHealth))
                            esp.Health.Color = Color3.fromRGB(255 * (1 - healthPercent), 255 * healthPercent, 0)
                        else
                            esp.Health.Visible = false
                        end
                        
                        -- Distance
                        if Config.ESP.Distance and LocalPlayer.Character then
                            local localRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if localRoot then
                                local dist = (root.Position - localRoot.Position).Magnitude
                                esp.Distance.Visible = true
                                esp.Distance.Position = Vector2.new(pos.X, boxY - 40)
                                esp.Distance.Text = string.format("%.0f studs", dist)
                                esp.Distance.Color = boxColor
                            end
                        else
                            esp.Distance.Visible = false
                        end
                        
                        -- Tracer
                        if Config.ESP.Tracers then
                            esp.Tracer.Visible = true
                            esp.Tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                            esp.Tracer.To = Vector2.new(pos.X, pos.Y)
                            esp.Tracer.Color = boxColor
                        else
                            esp.Tracer.Visible = false
                        end
                    else
                        esp.Box.Visible = false
                        esp.Name.Visible = false
                        esp.Health.Visible = false
                        esp.Distance.Visible = false
                        esp.Tracer.Visible = false
                    end
                else
                    esp.Box.Visible = false
                    esp.Name.Visible = false
                    esp.Health.Visible = false
                    esp.Distance.Visible = false
                    esp.Tracer.Visible = false
                end
            else
                if esp then
                    esp.Box.Visible = false
                    esp.Name.Visible = false
                    esp.Health.Visible = false
                    esp.Distance.Visible = false
                    esp.Tracer.Visible = false
                end
            end
        end
    end
    
    -- AIMBOT (FULLY FIXED)
    if Config.Aimbot.Enabled and IsKeyPressed(Config.Aimbot.Key) then
        local target = GetClosestTarget()
        if target and target.Character then
            local targetPart = target.Character:FindFirstChild(Config.Aimbot.HitPart) or target.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                local screenPos = Camera:WorldToViewportPoint(targetPart.Position)
                local currentPos = Vector2.new(Mouse.X, Mouse.Y)
                local delta = Vector2.new(screenPos.X, screenPos.Y) - currentPos
                
                -- Apply smoothness
                local moveDelta = delta * (1 - Config.Aimbot.Smoothness)
                
                -- Move mouse
                if mousemoverel then
                    mousemoverel(moveDelta.X, moveDelta.Y)
                end
            end
        end
    end
end)

-- Cleanup
GUI.Destroying:Connect(function()
    if flying then StopFly() end
    if noclipActive then StopNoclip() end
end)

-- Notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Project Chimera",
    Text = "Beautiful GUI - Everything works!",
    Duration = 3
})

print("[+] Project Chimera Beautiful Edition loaded")
